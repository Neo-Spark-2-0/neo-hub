package com.neospark.neohub.dao;

import java.util.List;
import com.neospark.neohub.model.Order;

public interface OrderDao {
    // CRUD
    boolean placeOrder(Order order);
    boolean updateOrderStatus(int orderId, String status);
    boolean updatePaymentStatus(int orderId, String paymentStatus);
    
    // Fetch
    Order getOrderById(int id);
    Order getOrderByOrderNumber(String orderNumber);
    List<Order> getAllOrders();
    List<Order> getOrdersByUserId(int userId);
    List<Order> getOrdersByStatus(String status);
    
    // Dashboard
    int getTotalOrderCount();
    double getTotalRevenue();
    int getOrderCountByStatus(String status);
    List<Order> getRecentOrders(int limit);
}