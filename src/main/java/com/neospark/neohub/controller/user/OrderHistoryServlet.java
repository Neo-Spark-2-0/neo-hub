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

/**
 * The type Order history servlet.
 */
@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");
        boolean isHTMX = "true".equals(request.getHeader("HX-Request"));

        if ("view".equals(action) && idParam != null && !idParam.isEmpty()) {
            try {
                int orderId = Integer.parseInt(idParam);
                Order order = orderDao.getOrderById(orderId);

                if (order == null || order.getUserId() != user.getId()) {
                    response.sendRedirect(request.getContextPath() + "/order-history");
                    return;
                }

                List<OrderItem> items = orderItemDao.getItemsByOrderId(orderId);
                order.setOrderItems(items);

                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/views/user/orderDetail.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/order-history");
            }
        }
        // this is for showing all orders of the user
        else {
            if (isHTMX) {
                String statusFilter = request.getParameter("status");
                String paymentMethodFilter = request.getParameter("paymentMethod");
                List<Order> orders = orderDao.getOrdersByUserWithFilters(user.getId(), statusFilter, paymentMethodFilter);
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/WEB-INF/views/user/components/order-history-list.jsp").forward(request, response);
                return;
            }
            List<Order> orders = orderDao.getOrdersByUser(user.getId());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/WEB-INF/views/user/orderHistory.jsp").forward(request, response);
        }
    }
}