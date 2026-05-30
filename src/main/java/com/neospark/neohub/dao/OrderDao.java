package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.Order;

/**
 * The interface Order dao.
 */
public interface OrderDao {
    /**
     * Place order boolean.
     *
     * @param order the order
     * @return the boolean
     */
// CRUD
    boolean placeOrder(Order order);

    /**
     * Update order status boolean.
     *
     * @param orderId     the order id
     * @param orderStatus the order status
     * @return the boolean
     */
    boolean updateOrderStatus(int orderId, String orderStatus);

    /**
     * Gets order by id.
     *
     * @param id the id
     * @return the order by id
     */
// Fetch
    Order getOrderById(int id);

    /**
     * Gets all orders.
     *
     * @return the all orders
     */
    List<Order> getAllOrders();

    /**
     * Gets orders by user.
     *
     * @param userId the user id
     * @return the orders by user
     */
    List<Order> getOrdersByUser(int userId);

    /**
     * Gets orders by status.
     *
     * @param orderStatus the order status
     * @return the orders by status
     */
    List<Order> getOrdersByStatus(String orderStatus);

    /**
     * Gets orders by user with filters.
     *
     * @param userId        the user id
     * @param status        the status
     * @param paymentMethod the payment method
     * @return the orders by user with filters
     */
    List<Order> getOrdersByUserWithFilters(int userId, String status, String paymentMethod);

    /**
     * Gets total order count.
     *
     * @return the total order count
     */
// Dashboard
    int getTotalOrderCount();

    /**
     * Gets order count by status.
     *
     * @param orderStatus the order status
     * @return the order count by status
     */
    int getOrderCountByStatus(String orderStatus);

    /**
     * Gets total revenue.
     *
     * @return the total revenue
     */
    double getTotalRevenue();

    /**
     * Gets recent orders.
     *
     * @param limit the limit
     * @return the recent orders
     */
    List<Order> getRecentOrders(int limit);

    /**
     * Gets monthly revenue.
     *
     * @return the monthly revenue
     */
    List<Object[]> getMonthlyRevenue();

    /**
     * Gets daily revenue.
     *
     * @param days the days
     * @return the daily revenue
     */
// Returns last 7 days revenue as list of Object[]{date_string, revenue_double}
    List<Object[]> getDailyRevenue(int days);

    /**
     * Gets order status breakdown.
     *
     * @return the order status breakdown
     */
// Returns order count grouped by status
    List<Object[]> getOrderStatusBreakdown();

}