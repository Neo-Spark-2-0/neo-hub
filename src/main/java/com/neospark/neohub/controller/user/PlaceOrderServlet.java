package com.neospark.neohub.controller.user;

import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.*;
import com.neospark.neohub.utils.EmailService;
import com.neospark.neohub.utils.EmailTemplate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private final CartDao      cartDao      = new CartDaoImpl();
    private final OrderDao     orderDao     = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();
    private final PaymentDao   paymentDao   = new PaymentDaoImpl();
    private final ProductDao   productDao   = new ProductDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod"); // COD or KHALTI

        // ── 1. Get cart ──
        List<Cart> cartItems = cartDao.getCartByUser(user.getId());
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=empty");
            return;
        }

        // ── 2. Calculate pricing ──
        double subTotal = 0.0;
        for (Cart item : cartItems) {
            double price = item.getProductDiscountPrice() > 0
                    ? item.getProductDiscountPrice() : item.getProductPrice();
            subTotal += price * item.getQuantity();
        }

        double shipping      = 100.0;
        double discount      = 0.0;
        Integer promoCodeId  = null;

        PromoCode promo = (PromoCode) session.getAttribute("appliedPromoCode");
        if (promo != null) {
            discount    = subTotal * (promo.getDiscountPercent() / 100.0);
            promoCodeId = promo.getId();
        }

        double total = subTotal + shipping - discount;

        // ── 3. Create order ──
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

        // Get the new order ID (most recent order for this user)
        List<Order> userOrders = orderDao.getOrdersByUser(user.getId());
        int orderId = -1;
        if (userOrders != null && !userOrders.isEmpty()) {
            orderId = userOrders.get(0).getId();
        } else {
            response.sendRedirect(request.getContextPath() + "/checkout?error=orderfailed");
            return;
        }

        // ── 4. Insert order items + reduce stock ──
        List<OrderItem> orderItems = new ArrayList<>();
        for (Cart item : cartItems) {
            OrderItem oi = new OrderItem();
            oi.setOrderId(orderId);
            oi.setProductId(item.getProductId());
            oi.setQuantity(item.getQuantity());
            double unitPrice = item.getProductDiscountPrice() > 0
                    ? item.getProductDiscountPrice() : item.getProductPrice();
            oi.setUnitPrice(unitPrice);
            orderItems.add(oi);
            
            // Reduce stock
            boolean stockUpdated = productDao.updateStock(item.getProductId(), item.getQuantity());
            if (!stockUpdated) {
                // If stock update fails, continue (should handle but log)
                System.out.println("Warning: Could not update stock for product " + item.getProductId());
            }
        }
        orderItemDao.addOrderItems(orderItems);

        // ── 5. Create payment record ──
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setMethod(paymentMethod);
        payment.setAmount(total);
        payment.setStatus("Pending");
        paymentDao.createPayment(payment);

        // ── 6. Clear cart and promo ──
        cartDao.clearCart(user.getId());
        session.removeAttribute("appliedPromoCode");
        
        // Update cart count in session (if you maintain one)
        // session.setAttribute("cartCount", 0);

        // ── 7. Route by payment method ──
        if ("KHALTI".equalsIgnoreCase(paymentMethod)) {
            // Redirect to Khalti payment page
            response.sendRedirect(request.getContextPath() + "/khalti/initiate?orderId=" + orderId);
        } else {
            // COD — confirm order immediately
            orderDao.updateOrderStatus(orderId, "Confirmed");
            
            // Update payment status to Completed for COD
            paymentDao.updatePaymentStatus(orderId, "Completed", null);

            // Build delivery address from user profile
            String address = buildAddress(user);

            // Send confirmation email (run in background to not slow response)
            final String toEmail = user.getEmail();
            final String name = user.getFullName();
            final int finalOrderId = orderId;
            final double finalTotal = total;
            final String finalAddress = address;

            new Thread(() -> {
                try {
                    EmailService.sendOrderConfirmationEmail(toEmail, name, String.valueOf(finalOrderId), String.format("%.2f", finalTotal));
                } catch (Exception e) {
                    System.out.println("Email sending failed: " + e.getMessage());
                }
            }).start();

            response.sendRedirect(request.getContextPath() + "/order-success?orderId=" + orderId);
        }
    }

    private String buildAddress(User user) {
        StringBuilder sb = new StringBuilder();
        if (user.getProvince() != null && !user.getProvince().isEmpty()) sb.append(user.getProvince());
        if (user.getDistrict() != null && !user.getDistrict().isEmpty()) sb.append(user.getDistrict()).append(", ");
        if (user.getCity() != null && !user.getCity().isEmpty()) sb.append(user.getCity()).append(", ");
        if (user.getStreet() != null && !user.getStreet().isEmpty()) sb.append(user.getStreet()).append(", ");
        String result = sb.toString().replaceAll(",\\s*$", "");
        return result.isEmpty() ? "Address not provided" : result;
    }
}