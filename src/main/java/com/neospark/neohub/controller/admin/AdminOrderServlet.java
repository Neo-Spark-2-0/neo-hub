package com.neospark.neohub.controller.admin;

import com.neospark.neohub.dao.OrderDao;
import com.neospark.neohub.dao.OrderDaoImpl;
import com.neospark.neohub.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDaoImpl();

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
        req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(req, resp);
    }

    private void showOrderDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Order order = orderDao.getOrderById(id);
        req.setAttribute("order", order);
        req.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        int orderId = Integer.parseInt(req.getParameter("orderId"));

        if ("updateStatus".equals(action)) {
            String newStatus = req.getParameter("orderStatus");
            if (orderDao.updateOrderStatus(orderId, newStatus)) {
                req.getSession().setAttribute("success", "Order status updated to " + newStatus);
            }
        } else if ("updatePayment".equals(action)) {
            String payStatus = req.getParameter("paymentStatus");
            if (orderDao.updateOrderStatus(orderId, payStatus)) {
                req.getSession().setAttribute("success", "Payment status updated.");
            }
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
}