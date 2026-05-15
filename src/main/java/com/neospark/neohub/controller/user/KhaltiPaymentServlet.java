package com.neospark.neohub.controller.user;

import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.*;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.json.JSONObject;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;

// Here I am reusing same servlet for payment and verification
@WebServlet({"/khalti/initiate", "/khalti/verify"})
public class KhaltiPaymentServlet extends HttpServlet {

    private static final String KHALTI_SECRET_KEY   = "a215fd035f654fe8bb9cb1ded2ea1c86";
    private static final String KHALTI_INITIATE_URL = "https://a.khalti.com/api/v2/epayment/initiate/";
    private static final String KHALTI_LOOKUP_URL   = "https://a.khalti.com/api/v2/epayment/lookup/";

    private final HttpClient httpClient = HttpClient.newHttpClient();

    private final OrderDao orderDao = new OrderDaoImpl();
    private final PaymentDao paymentDao = new PaymentDaoImpl();
    private final ProductDao productDao = new ProductDaoImpl();
    private final CartDao cartDao = new CartDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Object orderIdAttr  = request.getAttribute("orderId");
        int orderId = 0; 
        try{
            if(orderIdAttr != null){
                orderId = Integer.parseInt(String.valueOf(orderIdAttr));
                request.setAttribute("orderId", orderId);
            } else {
                response.sendRedirect(request.getContextPath() + "/checkout?error=missing_order");
                return;
            }
        }catch(NumberFormatException e){
            response.sendRedirect(request.getContextPath() + "/checkout?error=invalid_order");
            return;
        }



        // checking that order belongs to the logged in user or not
        Order order = orderDao.getOrderById(orderId);
        if (order == null || order.getUserId() != user.getId()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // converting rupees to paisa as khalti requies
        long amountInPaisa = (long) (order.getTotalAmount() * 100);

        // this is website and return url which khalti needs 
        String returnUrl = "http://localhost:" + request.getServerPort() + request.getContextPath() + "/khalti/verify";
        String websiteUrl = "http://localhost:" + request.getServerPort() + request.getContextPath();

        // Building a JSON payload using dependency "JSON" 
        JSONObject customerInfo = new JSONObject();
        customerInfo.put("name", user.getFullName());
        customerInfo.put("email", user.getEmail());
        customerInfo.put("phone", user.getPhone() != null ? user.getPhone() : "");

        JSONObject payload = new JSONObject();
        payload.put("return_url", returnUrl);
        payload.put("website_url", websiteUrl);
        payload.put("amount", amountInPaisa);
        payload.put("purchase_order_id", "ORDER-" + orderId);
        payload.put("purchase_order_name", "NEO-HUB Order #" + orderId);
        payload.put("customer_info", customerInfo);



        // calling khalti backend api and get payment url and pidx in response 
        JSONObject khaltiResponse = callKhaltiApi(KHALTI_INITIATE_URL, payload.toString());

        if (khaltiResponse == null) {
            System.out.println("Error: Khalti API unreachable for order " + orderId);
            orderDao.updateOrderStatus(orderId, "Cancelled");
            paymentDao.updatePaymentStatus(orderId, "Failed", null);
            response.sendRedirect(request.getContextPath()
                    + "/order-failure?orderId=" + orderId + "&error=api");
            return;
        }

        // getting payment url and pidx from response 
        String paymentUrl = khaltiResponse.optString("payment_url", null);
        String pidx = khaltiResponse.optString("pidx", null);

        if (paymentUrl == null || paymentUrl.trim().isEmpty()) {
            System.out.println("Error: Khalti initiation failed for order " + orderId + ". Response: " + khaltiResponse);

            orderDao.updateOrderStatus(orderId, "Cancelled");
            paymentDao.updatePaymentStatus(orderId, "Failed", null);
            response.sendRedirect(request.getContextPath()
                    + "/order-failure?orderId=" + orderId + "&error=init");
            return;
        }

        // Store pidx and orderId in session as fallback for doGet verification
        // storing pidx and order id in session so that we can use it in doGet method when khalti redirects back to us after payment
        SessionUtil.setAttribute(request, "khalti_pidx", pidx);
        SessionUtil.setAttribute(request, "khalti_orderId", orderId);

        // redirecting to khalti payment page
        response.sendRedirect(paymentUrl);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pidx = request.getParameter("pidx");
        String transactionId = request.getParameter("transaction_id");
        String purchaseOrderId = request.getParameter("purchase_order_id");

    
        int orderId = -1;
        if (purchaseOrderId != null && purchaseOrderId.startsWith("ORDER-")) {
            try {
                orderId = Integer.parseInt(purchaseOrderId.substring(6));
            } catch (NumberFormatException e) {}
        }

        if (orderId == -1) {
            Object sessionOrderId = request.getSession().getAttribute("khalti_orderId");
            if (sessionOrderId != null) {
                try {
                    orderId = Integer.parseInt(String.valueOf(sessionOrderId));
                } catch (NumberFormatException e) {}
            }
        }

        SessionUtil.removeAttribute(request, "khalti_pidx");
        SessionUtil.removeAttribute(request, "khalti_orderId");

        if (orderId == -1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        JSONObject lookupPayload = new JSONObject();
        lookupPayload.put("pidx", pidx != null ? pidx : "");

        JSONObject lookupResponse = callKhaltiApi(KHALTI_LOOKUP_URL, lookupPayload.toString());

        if (lookupResponse == null) {
            System.err.println("Khalti lookup API unreachable for order " + orderId);
            paymentDao.updatePaymentStatus(orderId, "Pending", transactionId);
            response.sendRedirect(request.getContextPath()
                    + "/order-failure?orderId=" + orderId + "&error=verify");
            return;
        }

        // Parse verified status and transaction_id using JSONObject
        String verifiedStatus        = lookupResponse.optString("status", "");
        String verifiedTransactionId = lookupResponse.optString("transaction_id", null);

        if ("Completed".equals(verifiedStatus)) {
            List<OrderItem> items = orderItemDao.getItemsByOrderId(orderId);
            for (OrderItem item : items) {
                productDao.updateStock(item.getProductId(), item.getQuantity());
            }

            Order completedOrder = orderDao.getOrderById(orderId);
            if (completedOrder != null) {
                cartDao.clearCart(completedOrder.getUserId());
            }

            paymentDao.updatePaymentStatus(orderId, "Completed", verifiedTransactionId);
            orderDao.updateOrderStatus(orderId, "Confirmed");

            response.sendRedirect(request.getContextPath() + "/order-success?orderId=" + orderId);

        } else {
            System.out.println("Khalti payment not completed for order " + orderId
                    + ". Verified status: " + verifiedStatus);

            paymentDao.updatePaymentStatus(orderId, "Failed", verifiedTransactionId);
            orderDao.updateOrderStatus(orderId, "Cancelled");

            response.sendRedirect(request.getContextPath()
                    + "/order-failure?orderId=" + orderId + "&error=payment_failed");
        }
    }



    // helper method to call khalti api 
    private JSONObject callKhaltiApi(String apiUrl, String jsonBody) {
        try {
            HttpRequest httpRequest = HttpRequest.newBuilder()
                    .uri(URI.create(apiUrl))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Key " + KHALTI_SECRET_KEY)
                    .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                    .build();

            HttpResponse<String> httpResponse = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());

            String responseBody = httpResponse.body();
            int statusCode   = httpResponse.statusCode();

            if (statusCode == 200) {
                return new JSONObject(responseBody);
            } else {
                System.err.println("Khalti API error " + statusCode + ": " + responseBody);
                return null;
            }

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            System.err.println("Khalti API call interrupted: " + e.getMessage());
            return null;
        } catch (Exception e) {
            System.err.println("Khalti API call failed: " + e.getMessage());
            return null;
        }
    }
}