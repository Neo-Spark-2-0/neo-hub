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

        String paymentMethod = request.getParameter("paymentMethod");

        
        List<Cart> cartItems = cartDao.getCartByUser(user.getId());
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=empty");
            return;
        }

        // validating stock again before placing order
        for (Cart item : cartItems) {
            Product product = productDao.getProductById(item.getProductId());
            if (product == null || !product.isActive() || product.getStock() < item.getQuantity()) {
                response.sendRedirect(request.getContextPath() + "/cart?error=stock");
                return;
            }
        }

        // total
        double subTotal = 0.0;
        for (Cart item : cartItems) {
            double price = 0.0;
            if (item.getProductDiscountPrice() > 0) {
                price = item.getProductDiscountPrice();
            } else {
                price = item.getProductPrice();
            }
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


        // Creating order before payment because we need order id for both COD and Khalti to link order items and payment
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

        // getting users orders and picking order id for most recent order
        List<Order> userOrders = orderDao.getOrdersByUser(user.getId());
        int orderId = -1;
        if (userOrders != null && !userOrders.isEmpty()) {
            orderId = userOrders.get(0).getId();
        }
        if (orderId == -1) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=orderfailed");
            return;
        }

        // inserting order items but stock reduced and cart is cleared only after payment success 
        List<OrderItem> orderItems = new ArrayList<>();
        for (Cart item : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setProductId(item.getProductId());
            orderItem.setQuantity(item.getQuantity());
            orderItems.add(orderItem);
            double unitPrice = 0.0; 
            if (item.getProductDiscountPrice() > 0) {
                unitPrice = item.getProductDiscountPrice();
            } else {
                unitPrice = item.getProductPrice();
            }
            orderItem.setUnitPrice(unitPrice);
        }
        orderItemDao.addOrderItems(orderItems);

        // creating payment record
        Payment payment = new Payment();
        payment.setOrderId(orderId);
        payment.setMethod(paymentMethod);
        payment.setAmount(total);
        payment.setStatus("Pending");
        paymentDao.createPayment(payment);

        // removing promocode after order placed
        SessionUtil.removeAttribute(request, "appliedPromoCode");


        // handling khalti and cash on delivery
        if ("KHALTI".equalsIgnoreCase(paymentMethod)) {
            // in khalti stock and cart not cleared here because if payment failed it will be bad 
            // it will be cleared in KhaltiPaymentServlet after payment success 
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/khalti/initiate").forward(request, response);

        } else {
            for (Cart item : cartItems) {
                productDao.updateStock(item.getProductId(), item.getQuantity());
            }
            cartDao.clearCart(user.getId());
            orderDao.updateOrderStatus(orderId, "Confirmed");
            paymentDao.updatePaymentStatus(orderId, "Completed", null);

            // sending mail 

            try {
                EmailService.sendOrderConfirmationEmail(
                        user.getEmail(),
                        user.getFullName(),
                        String.valueOf(orderId),
                        String.format("%.2f", total)
                );
            } catch (Exception e) {
                System.err.println("Order confirmation email failed for order " + orderId + ": " + e.getMessage());
            }


            response.sendRedirect(request.getContextPath() + "/order-success?orderId=" + orderId);
        }
    }
}