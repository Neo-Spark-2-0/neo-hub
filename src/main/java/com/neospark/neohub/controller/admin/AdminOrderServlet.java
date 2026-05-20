package com.neospark.neohub.controller.admin;

import com.neospark.neohub.dao.OrderDao;
import com.neospark.neohub.dao.OrderItemDao;
import com.neospark.neohub.dao.OrderDaoImpl;
import com.neospark.neohub.dao.OrderItemDaoImpl;
import com.neospark.neohub.dao.PaymentDao;
import com.neospark.neohub.dao.PaymentDaoImpl;
import com.neospark.neohub.model.Order;
import com.neospark.neohub.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * The type Admin order servlet.
 */
@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();
    private final PaymentDao paymentDao = new PaymentDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        handleFlashMessages(req);

        if ("view".equals(action)) {
            showOrderDetails(req, resp);
        } else {
            listOrders(req, resp);
        }
    }

    private void listOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        List<Order> orders;
        
        if (status != null && !status.isEmpty() && !"ALL".equals(status)) {
            orders = orderDao.getOrdersByStatus(status);
        } else {
            orders = orderDao.getAllOrders();
        }

        req.setAttribute("orderList", orders);
        req.setAttribute("filterStatus", status);
        req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(req, resp);
    }

    private void showOrderDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = parseId(req.getParameter("id"));
        if (id <= 0) {
            req.getSession().setAttribute("error", "Invalid order ID.");
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

        Order order = orderDao.getOrderById(id);
        if (order == null) {
            req.getSession().setAttribute("error", "Order not found.");
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }
        
        List<OrderItem> items = orderItemDao.getItemsByOrderId(id);
        order.setOrderItems(items);

        req.setAttribute("order", order);
        req.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        int orderId = parseId(req.getParameter("orderId"));

        if (orderId <= 0) {
            req.getSession().setAttribute("error", "Invalid order ID.");
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

       try {
            if ("updateStatus".equals(action)) {
                String newStatus = req.getParameter("orderStatus");
                if (newStatus == null || newStatus.isEmpty()) {
                    req.getSession().setAttribute("error", "Please select a valid status.");
                } else if (orderDao.updateOrderStatus(orderId, newStatus)) {
                    req.getSession().setAttribute("success", "Order status updated to " + newStatus + ".");
                } else {
                    req.getSession().setAttribute("error", "Failed to update order status.");
                }

            } else if ("updatePayment".equals(action)) {
                String payStatus = req.getParameter("paymentStatus");
                Order order = orderDao.getOrderById(orderId);
                String txId = (order != null && order.getTransactionId() != null)
                              ? order.getTransactionId() : "";
                if (paymentDao.updatePaymentStatus(orderId, payStatus, txId)) {
                    req.getSession().setAttribute("success", "Payment status updated.");
                } else {
                    req.getSession().setAttribute("error", "Failed to update payment status.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Error: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/orders?action=view&id=" + orderId);
    }

    private void handleFlashMessages(HttpServletRequest req) {
        HttpSession session = req.getSession();
        req.setAttribute("success", session.getAttribute("success"));
        req.setAttribute("error", session.getAttribute("error"));
        session.removeAttribute("success");
        session.removeAttribute("error");
    }

    private int parseId(String val) {
        try { return Integer.parseInt(val); }
        catch (Exception e) { return 0; }
    }
}