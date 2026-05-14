package com.neospark.neohub.controller.user;


import com.neospark.neohub.dao.OrderDao;
import com.neospark.neohub.dao.OrderDaoImpl;
import com.neospark.neohub.dao.OrderItemDao;
import com.neospark.neohub.dao.OrderItemDaoImpl;
import com.neospark.neohub.model.Order;
import com.neospark.neohub.model.OrderItem;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String idParam = request.getParameter("orderId");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Order order = orderDao.getOrderById(orderId);

        if (order == null || order.getUserId() != user.getId()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        List<OrderItem> items = orderItemDao.getItemsByOrderId(orderId);
        order.setOrderItems(items);

        request.setAttribute("order", order);
        request.getRequestDispatcher("/WEB-INF/views/user/orderSuccess.jsp")
                .forward(request, response);
    }
}