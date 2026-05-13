package com.neospark.neohub.controller.user;

import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.*;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet({"/khalti/initiate", "/khalti/verify"})
public class KhaltiPaymentServlet extends HttpServlet {

    // Use your actual Khalti secret key (test or live)
    private static final String KHALTI_SECRET_KEY = "a215fd035f654fe8bb9cb1ded2ea1c86"; 
    private static final String KHALTI_INITIATE_URL = "https://a.khalti.com/api/v2/epayment/initiate/";
    private static final String KHALTI_LOOKUP_URL   = "https://a.khalti.com/api/v2/epayment/lookup/";

    private final OrderDao orderDao = new OrderDaoImpl();
    private final PaymentDao paymentDao = new PaymentDaoImpl();
    private final ProductDao productDao = new ProductDaoImpl();
    private final CartDao cartDao = new CartDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();

    // -------------------- POST: Initiate Khalti Payment --------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ---- FIX: Read orderId from request attribute (set by PlaceOrderServlet) OR parameter ----
        String orderIdParam = (String) request.getAttribute("orderId");
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            orderIdParam = request.getParameter("orderId");
        }
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=missing_order");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=invalid_order");
            return;
        }

        Order order = orderDao.getOrderById(orderId);
        if (order == null || order.getUserId() != user.getId()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Convert amount to paisa (1 Rs = 100 paisa)
        long amountInPaisa = (long) (order.getTotalAmount() * 100);
        String returnUrl = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort()
                + request.getContextPath() + "/khalti/verify";
        String websiteUrl = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort() + request.getContextPath();

        // Build JSON payload for initiation
        String jsonBody = "{"
                + "\"return_url\": \"" + returnUrl + "\","
                + "\"website_url\": \"" + websiteUrl + "\","
                + "\"amount\": " + amountInPaisa + ","
                + "\"purchase_order_id\": \"ORDER-" + orderId + "\","
                + "\"purchase_order_name\": \"NEO-HUB Order #" + orderId + "\","
                + "\"customer_info\": {"
                + "  \"name\": \"" + escapeJson(user.getFullName()) + "\","
                + "  \"email\": \"" + escapeJson(user.getEmail()) + "\","
                + "  \"phone\": \"" + escapeJson(user.getPhone() != null ? user.getPhone() : "") + "\""
                + "}"
                + "}";

        String khaltiResponse = callKhaltiApi(KHALTI_INITIATE_URL, jsonBody);
        if (khaltiResponse == null) {
            response.sendRedirect(request.getContextPath() + "/order-failure?orderId=" + orderId + "&error=api");
            return;
        }

        String paymentUrl = extractJsonValue(khaltiResponse, "payment_url");
        String pidx = extractJsonValue(khaltiResponse, "pidx");

        if (paymentUrl == null || paymentUrl.isEmpty()) {
            System.err.println("Khalti initiation failed. Response: " + khaltiResponse);
            response.sendRedirect(request.getContextPath() + "/order-failure?orderId=" + orderId + "&error=init");
            return;
        }

        // Store pidx and orderId in session for verification
        request.getSession().setAttribute("khalti_pidx", pidx);
        request.getSession().setAttribute("khalti_orderId", orderId);
        response.sendRedirect(paymentUrl);
    }

    // -------------------- GET: Verify Khalti Payment (Callback) --------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pidx = request.getParameter("pidx");
        String status = request.getParameter("status");
        String transactionId = request.getParameter("transaction_id");
        String purchaseOrderId = request.getParameter("purchase_order_id");

        // Parse orderId from purchase_order_id (most reliable)
        int orderId = -1;
        if (purchaseOrderId != null && purchaseOrderId.startsWith("ORDER-")) {
            try {
                orderId = Integer.parseInt(purchaseOrderId.substring(6));
            } catch (NumberFormatException ignored) {}
        }
        // Fallback to session value
        if (orderId == -1) {
            Integer sessionOrderId = (Integer) request.getSession().getAttribute("khalti_orderId");
            if (sessionOrderId != null) orderId = sessionOrderId;
        }
        if (orderId == -1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Clean session
        request.getSession().removeAttribute("khalti_pidx");
        request.getSession().removeAttribute("khalti_orderId");

        // --- Always verify with Khalti Lookup API (do not trust callback parameters alone) ---
        String lookupBody = "{\"pidx\": \"" + pidx + "\"}";
        String lookupResponse = callKhaltiApi(KHALTI_LOOKUP_URL, lookupBody);
        if (lookupResponse == null) {
            paymentDao.updatePaymentStatus(orderId, "Pending", transactionId);
            response.sendRedirect(request.getContextPath() + "/order-failure?orderId=" + orderId + "&error=verify");
            return;
        }

        String verifiedStatus = extractJsonValue(lookupResponse, "status");
        String verifiedTransactionId = extractJsonValue(lookupResponse, "transaction_id");

        if ("Completed".equalsIgnoreCase(verifiedStatus)) {
            // Payment successful: reduce stock, clear cart, update statuses
            List<OrderItem> items = orderItemDao.getItemsByOrderId(orderId);
            for (OrderItem item : items) {
                productDao.updateStock(item.getProductId(), item.getQuantity());
            }
            Order order = orderDao.getOrderById(orderId);
            if (order != null) {
                cartDao.clearCart(order.getUserId());
            }
            paymentDao.updatePaymentStatus(orderId, "Completed", verifiedTransactionId);
            orderDao.updateOrderStatus(orderId, "Confirmed");
            response.sendRedirect(request.getContextPath() + "/order-success?orderId=" + orderId);
        } else {
            // Payment failed or pending – mark order as cancelled, stock and cart unchanged
            paymentDao.updatePaymentStatus(orderId, "Failed", verifiedTransactionId);
            orderDao.updateOrderStatus(orderId, "Cancelled");
            response.sendRedirect(request.getContextPath() + "/order-failure?orderId=" + orderId);
        }
    }

    // -------------------- Helper: Call Khalti API --------------------
    private String callKhaltiApi(String apiUrl, String jsonBody) {
        HttpURLConnection conn = null;
        try {
            URL url = new URL(apiUrl);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Key " + KHALTI_SECRET_KEY);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);
            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonBody.getBytes(StandardCharsets.UTF_8));
            }
            int responseCode = conn.getResponseCode();
            InputStream is = (responseCode == HttpURLConnection.HTTP_OK)
                    ? conn.getInputStream() : conn.getErrorStream();
            if (is == null) return null;
            StringBuilder sb = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                String line;
                while ((line = br.readLine()) != null) sb.append(line);
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (conn != null) conn.disconnect();
        }
    }

    // -------------------- Helper: Extract a simple JSON value --------------------
    private String extractJsonValue(String json, String key) {
        String search = "\"" + key + "\"";
        int keyIdx = json.indexOf(search);
        if (keyIdx == -1) return null;
        int colonIdx = json.indexOf(":", keyIdx);
        if (colonIdx == -1) return null;
        int start = colonIdx + 1;
        while (start < json.length() && Character.isWhitespace(json.charAt(start))) start++;
        if (json.charAt(start) == '"') {
            int end = json.indexOf("\"", start + 1);
            if (end == -1) return null;
            return json.substring(start + 1, end);
        } else {
            int end = start;
            while (end < json.length() && json.charAt(end) != ',' && json.charAt(end) != '}') end++;
            return json.substring(start, end).trim();
        }
    }

    // -------------------- Helper: Escape JSON strings --------------------
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}