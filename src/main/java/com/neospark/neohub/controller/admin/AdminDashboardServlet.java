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

/**
 * The type Admin dashboard servlet.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();
    private final ProductDao productDao = new ProductDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("AdminDashboardServlet: Handling GET request for /admin/dashboard");        
        // Set Attributes - Stats
        req.setAttribute("totalUsers", userDao.getTotalUserCount());
        req.setAttribute("totalProducts", productDao.getTotalProductCount());
        req.setAttribute("totalOrders", orderDao.getTotalOrderCount());
        req.setAttribute("totalCategories", categoryDao.getTotalCategoryCount());
        req.setAttribute("totalRevenue", orderDao.getTotalRevenue());

        // Set Attributes - Order Status
        req.setAttribute("pendingOrders", orderDao.getOrderCountByStatus("Pending"));
        req.setAttribute("processingOrders", orderDao.getOrderCountByStatus("Processing"));
        req.setAttribute("shippedOrders", orderDao.getOrderCountByStatus("Shipped"));
        req.setAttribute("deliveredOrders", orderDao.getOrderCountByStatus("Delivered"));
        req.setAttribute("cancelledOrders", orderDao.getOrderCountByStatus("Cancelled"));

        // Recent Data (latest 5)
        List<Order> recentOrders = orderDao.getRecentOrders(5);
        List<User> recentUsers = userDao.getRecentUsers(5);
        List<Product> lowStockProducts = productDao.getLowStockProducts(5);

        // Set Attributes - Recent Data
        req.setAttribute("recentOrders", recentOrders);
        req.setAttribute("recentUsers", recentUsers);
        req.setAttribute("lowStockProducts", lowStockProducts);

        // Analytics data for charts
        List<Object[]> dailyRevenue      = orderDao.getDailyRevenue(7); // 7-day sparkline
        List<Object[]> monthlyRevenue    = orderDao.getMonthlyRevenue();    // 12-month trend
        List<Object[]> orderStatusData   = orderDao.getOrderStatusBreakdown();
        List<Object[]> topProducts       = productDao.getTopSellingProducts(5);
        List<Object[]> salesByCategory   = productDao.getSalesByCategory();

        req.setAttribute("dailyRevenue",    dailyRevenue);
        req.setAttribute("monthlyRevenue",  monthlyRevenue);
        req.setAttribute("orderStatusData", orderStatusData);
        req.setAttribute("topProducts",     topProducts);
        req.setAttribute("salesByCategory", salesByCategory);

        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}