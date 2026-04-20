package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.Order;

public interface OrderDao {
    // CRUD
    boolean placeOrder(Order order);
    boolean updateOrderStatus(int orderId, String orderStatus);
    
    // Fetch
    Order getOrderById(int id);
    List<Order> getAllOrders();
    List<Order> getOrdersByUser(int userId);
    List<Order> getOrdersByStatus(String orderStatus);
    
    // Dashboard
    int getTotalOrderCount();
    double getTotalRevenue();
    List<Order> getRecentOrders(int limit);
    List<Object[]> getMonthlyRevenue();
}