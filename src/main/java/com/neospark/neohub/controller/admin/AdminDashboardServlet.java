package com.neospark.neohub.controller.admin;

import java.io.IOException;
import java.util.List;

import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.dao.ProductDao;
import com.neospark.neohub.dao.ProductDaoImpl;
import com.neospark.neohub.dao.OrderDao;
import com.neospark.neohub.dao.OrderDaoImpl;
import com.neospark.neohub.dao.CategoryDao;
import com.neospark.neohub.dao.CategoryDaoImpl;
import com.neospark.neohub.model.User;
import com.neospark.neohub.model.Order;
import com.neospark.neohub.model.Product;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();
    private final ProductDao productDao = (ProductDao) new ProductDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check if user is admin (AdminFilter handles this)
        User admin = (User) SessionUtil.getAttribute(req, "user");
        if (admin == null || !admin.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Count Statistics
        int totalUsers = userDao.getTotalUserCount();
        int totalProducts = productDao.getTotalProductCount();
        int totalOrders = orderDao.getTotalOrderCount();
        int totalCategories = categoryDao.getTotalCategoryCount();
        double totalRevenue = orderDao.getTotalRevenue();

        // Order Status Counts
        List<Order> pendingOrdersList = orderDao.getOrdersByStatus("PENDING");
        int pendingOrders = pendingOrdersList.size();
        List<Order> processingOrdersList = orderDao.getOrdersByStatus("PROCESSING");
        int processingOrders = processingOrdersList.size();
        List<Order> shippedOrdersList = orderDao.getOrdersByStatus("SHIPPED");
        int shippedOrders = shippedOrdersList.size();
        List<Order> deliveredOrdersList = orderDao.getOrdersByStatus("DELIVERED");
        int deliveredOrders = deliveredOrdersList.size();
        List<Order> cancelledOrdersList = orderDao.getOrdersByStatus("CANCELLED");
        int cancelledOrders = cancelledOrdersList.size();
        // Recent Data (latest 5)
        List<Order> recentOrders = orderDao.getRecentOrders(5);
        List<User> recentUsers = userDao.getRecentUsers(5);
        List<Product> lowStockProducts = productDao.getLowStockProducts(5);

        // Set Attributes - Stats
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("totalOrders", totalOrders);
        req.setAttribute("totalCategories", totalCategories);
        req.setAttribute("totalRevenue", totalRevenue);

        // Set Attributes - Order Status
        req.setAttribute("pendingOrders", pendingOrders);
        req.setAttribute("processingOrders", processingOrders);
        req.setAttribute("shippedOrders", shippedOrders);
        req.setAttribute("deliveredOrders", deliveredOrders);
        req.setAttribute("cancelledOrders", cancelledOrders);

        // Set Attributes - Recent Data
        req.setAttribute("recentOrders", recentOrders);
        req.setAttribute("recentUsers", recentUsers);
        req.setAttribute("lowStockProducts", lowStockProducts);

        // Forward to dashboard JSP
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}