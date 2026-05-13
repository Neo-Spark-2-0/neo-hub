package com.neospark.neohub.controller.user;

import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.*;
import com.neospark.neohub.utils.EmailService;
import com.neospark.neohub.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// ... (package and imports remain the same) ...
@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();
    private final PaymentDao paymentDao = new PaymentDaoImpl();
    private final ProductDao productDao = new ProductDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod"); // COD or KHALTI

        List<Cart> cartItems = cartDao.getCartByUser(user.getId());
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=empty");
            return;
        }

        // --- Validate stock before creating order ---
        for (Cart item : cartItems) {
            Product product = productDao.getProductById(item.getProductId());
            if (product == null || !product.isActive() || product.getStock() < item.getQuantity()) {
                response.sendRedirect(request.getContextPath() + "/cart?error=stock");
                return;
            }
        }

        // --- Calculate totals ---
        double subTotal = 0.0;
        for (Cart item : cartItems) {
            double price = item.getProductDiscountPrice() > 0
                    ? item.getProductDiscountPrice() : item.getProductPrice();
            subTotal += price * item.getQuantity();
        }

        double shipping = 100.0;
        double discount = 0.0;
        Integer promoCodeId = null;

        PromoCode promo = (PromoCode) SessionUtil.getAttribute(request, "appliedPromoCode");
        if (promo != null) {
            discount = subTotal * (promo.getDiscountPercent() / 100.0);
            promoCodeId = promo.getId();
        }

        double total = subTotal + shipping - discount;

        // --- Create order (status = Pending) ---
        Order order = new Order();
        order.setUserId(user.getId());
        order.setSubTotalAmount(subTotal);
        order.setShippingCharge(shipping);
        order.setDiscountAmount(discount);
        order.setTotalAmount(total);
        order.setPromoCodeId(promoCodeId);
        order.setOrderStatus("Pending");

        boolean placed = orderDao.placeOrder(order);
        if (!placed) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=orderfailed");
            return;
        }

        // --- Get generated order ID ---
        List<Order> userOrders = orderDao.getOrdersByUser(user.getId());
        int orderId = (userOrders != null && !userOrders.isEmpty()) ? userOrders.get(0).getId() : -1;
        if (orderId == -1) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=orderfailed");
            return;
        }

        // --- Insert order items (without reducing stock) ---
        List<OrderItem> orderItems = new ArrayList<>();
        for (Cart item : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setProductId(item.getProductId());
            orderItem.setQuantity(item.getQuantity());
            double unitPrice = item.getProductDiscountPrice() > 0
                    ? item.getProductDiscountPrice() : item.getProductPrice();
            orderItem.setUnitPrice(unitPrice);
            orderItems.add(orderItem);
        }
        orderItemDao.addOrderItems(orderItems);

        // --- Create payment record (status = Pending) ---
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setMethod(paymentMethod);
        payment.setAmount(total);
        payment.setStatus("Pending");
        paymentDao.createPayment(payment);

        // --- Clear promo from session (but NOT cart yet for Khalti) ---
        SessionUtil.removeAttribute(request, "appliedPromoCode");

        // --- Route based on payment method ---
        if ("KHALTI".equalsIgnoreCase(paymentMethod)) {
            // Forward to Khalti initiation servlet
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/khalti/initiate").forward(request, response);
        } else {
            // COD: reduce stock and clear cart immediately
            for (Cart item : cartItems) {
                productDao.updateStock(item.getProductId(), item.getQuantity());
            }
            cartDao.clearCart(user.getId());
            orderDao.updateOrderStatus(orderId, "Confirmed");
            paymentDao.updatePaymentStatus(orderId, "Completed", null);
            try {
                EmailService.sendOrderConfirmationEmail(user.getEmail(), user.getFullName(),
                        String.valueOf(orderId), String.format("%.2f", total));
            } catch (Exception e) {
                System.out.println("Email sending failed: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/order-success?orderId=" + orderId);
        }
    }
}