package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.utils.DatabaseConnection;
import com.neospark.neohub.model.Order;
import com.neospark.neohub.model.OrderItem;

public class OrderDaoImpl implements OrderDao {
    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setOrderNumber(rs.getString("order_number"));
        order.setUserId(rs.getInt("user_id"));
        order.setUserName(rs.getString("user_name"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setPaymentStatus(rs.getString("payment_status"));
        order.setOrderStatus(rs.getString("order_status"));
        order.setSubtotal(rs.getDouble("subtotal"));
        order.setShippingCharge(rs.getDouble("shipping_charge"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        order.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return order;
    }

    // ============================================
    // ✅ HELPER - Map ResultSet to OrderItem
    // ============================================
    private OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();
        item.setId(rs.getInt("id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setProductName(rs.getString("product_name"));
        item.setPrice(rs.getDouble("price"));
        item.setQuantity(rs.getInt("quantity"));
        item.setSubtotal(rs.getDouble("subtotal"));
        return item;
    }

    // ============================================
    // ✅ HELPER - Get Order Items by Order ID
    // ============================================
    private List<OrderItem> getOrderItems(int orderId, Connection conn)
            throws SQLException {
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        List<OrderItem> items = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(mapOrderItem(rs));
            }
        }
        return items;
    }

    // ============================================
    // ✅ Place Order (with Transaction)
    // ============================================
    @Override
    public boolean placeOrder(Order order) {
        String orderSql = "INSERT INTO orders (order_number, user_id, payment_method, " +
                          "payment_status, order_status, subtotal, shipping_charge, " +
                          "total_amount, shipping_address) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String itemSql  = "INSERT INTO order_items (order_id, product_id, product_name, " +
                          "price, quantity, subtotal) " +
                          "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection()) {

            // ✅ Start Transaction
            conn.setAutoCommit(false);

            try (PreparedStatement orderStmt = conn.prepareStatement(
                    orderSql, PreparedStatement.RETURN_GENERATED_KEYS)) {

                orderStmt.setString(1, order.getOrderNumber());
                orderStmt.setInt(2, order.getUserId());
                orderStmt.setString(3, order.getPaymentMethod());
                orderStmt.setString(4, order.getPaymentStatus());
                orderStmt.setString(5, order.getOrderStatus());
                orderStmt.setDouble(6, order.getSubtotal());
                orderStmt.setDouble(7, order.getShippingCharge());
                orderStmt.setDouble(8, order.getTotalAmount());
                orderStmt.setString(9, order.getShippingAddress());

                orderStmt.executeUpdate();

                // ✅ Get Generated Order ID
                ResultSet generatedKeys = orderStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int orderId = generatedKeys.getInt(1);

                    // ✅ Insert Order Items
                    try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                        for (OrderItem item : order.getOrderItems()) {
                            itemStmt.setInt(1, orderId);
                            itemStmt.setInt(2, item.getProductId());
                            itemStmt.setString(3, item.getProductName());
                            itemStmt.setDouble(4, item.getPrice());
                            itemStmt.setInt(5, item.getQuantity());
                            itemStmt.setDouble(6, item.getSubtotal());
                            itemStmt.addBatch();
                        }
                        itemStmt.executeBatch();
                    }
                }

                // ✅ Commit Transaction
                conn.commit();
                return true;

            } catch (SQLException e) {
                // ✅ Rollback if error
                conn.rollback();
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ============================================
    // ✅ Update Order Status
    // ============================================
    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ?, " +
                     "updated_at = NOW() WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ============================================
    // ✅ Update Payment Status
    // ============================================
    @Override
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        String sql = "UPDATE orders SET payment_status = ?, " +
                     "updated_at = NOW() WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, paymentStatus);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ============================================
    // ✅ Get Order By ID
    // ============================================
    @Override
    public Order getOrderById(int id) {
        String sql = "SELECT o.*, u.full_name AS user_name " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "WHERE o.id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = mapOrder(rs);
                // ✅ Also fetch order items
                order.setOrderItems(getOrderItems(id, conn));
                return order;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ============================================
    // ✅ Get Order By Order Number
    // ============================================
    @Override
    public Order getOrderByOrderNumber(String orderNumber) {
        String sql = "SELECT o.*, u.full_name AS user_name " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "WHERE o.order_number = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, orderNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = mapOrder(rs);
                order.setOrderItems(getOrderItems(order.getId(), conn));
                return order;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ============================================
    // ✅ Get All Orders
    // ============================================
    @Override
    public List<Order> getAllOrders() {
        String sql = "SELECT o.*, u.full_name AS user_name " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "ORDER BY o.created_at DESC";
        List<Order> orders = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // ============================================
    // ✅ Get Orders By User ID
    // ============================================
    @Override
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT o.*, u.full_name AS user_name " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "WHERE o.user_id = ? " +
                     "ORDER BY o.created_at DESC";
        List<Order> orders = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // ============================================
    // ✅ Get Orders By Status
    // ============================================
    @Override
    public List<Order> getOrdersByStatus(String status) {
        String sql = "SELECT o.*, u.full_name AS user_name " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "WHERE o.order_status = ? " +
                     "ORDER BY o.created_at DESC";
        List<Order> orders = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // ============================================
    // ✅ Get Total Order Count
    // ============================================
    @Override
    public int getTotalOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ============================================
    // ✅ Get Total Revenue (Only PAID orders)
    // ============================================
    @Override
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) " +
                     "FROM orders WHERE payment_status = 'PAID'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // ============================================
    // ✅ Get Order Count By Status
    // ============================================
    @Override
    public int getOrderCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM orders WHERE order_status = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ============================================
    // ✅ Get Recent Orders
    // ============================================
    @Override
    public List<Order> getRecentOrders(int limit) {
        String sql = "SELECT o.*, u.full_name AS user_name " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "ORDER BY o.created_at DESC LIMIT ?";
        List<Order> orders = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}