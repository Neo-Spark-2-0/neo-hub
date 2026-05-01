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

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();
    private final ProductDao productDao = new ProductDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Set Attributes - Stats
        req.setAttribute("totalUsers", userDao.getTotalUserCount());
        req.setAttribute("totalProducts", productDao.getTotalProductCount());
        req.setAttribute("totalOrders", orderDao.getTotalOrderCount());
        req.setAttribute("totalCategories", categoryDao.getTotalCategoryCount());
        req.setAttribute("totalRevenue", orderDao.getTotalRevenue());

        // Set Attributes - Order Status
        req.setAttribute("pendingOrders", orderDao.getOrdersByStatus("PENDING"));
        req.setAttribute("processingOrders", orderDao.getOrdersByStatus("PROCESSING"));
        req.setAttribute("shippedOrders", orderDao.getOrdersByStatus("SHIPPED"));
        req.setAttribute("deliveredOrders", orderDao.getOrdersByStatus("DELIVERED"));
        req.setAttribute("cancelledOrders", orderDao.getOrdersByStatus("CANCELLED"));

        // Recent Data (latest 5)
        List<Order> recentOrders = orderDao.getRecentOrders(5);
        List<User> recentUsers = userDao.getRecentUsers(5);
        List<Product> lowStockProducts = productDao.getLowStockProducts(5);

        // Set Attributes - Recent Data
        req.setAttribute("recentOrders", recentOrders);
        req.setAttribute("recentUsers", recentUsers);
        req.setAttribute("lowStockProducts", lowStockProducts);

        // Forward to dashboard JSP
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}