package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.model.OrderItem;
import com.neospark.neohub.utils.DatabaseConnection;

/**
 * The type Order item dao.
 */
public class OrderItemDaoImpl implements OrderItemDao {

    @Override
    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getUnitPrice());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding order item: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public List<OrderItem> getItemsByOrderId(int orderId) {
        String sql = "SELECT order_items.*, products.name AS product_name, products.image AS product_image FROM order_items JOIN products ON order_items.product_id = products.id WHERE order_items.order_id = ?";
        List<OrderItem> items = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                items.add(mapOrderItem(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting order items: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return items;
    }

    @Override
    public boolean addOrderItems(List<OrderItem> items) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            connection.setAutoCommit(false);
            PreparedStatement ps = connection.prepareStatement(sql);
 
            for (OrderItem item : items) {
                ps.setInt(1, item.getOrderId());
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getUnitPrice());
                ps.addBatch();
            }
 
            int[] results = ps.executeBatch();
            connection.commit();
 
            for (int r : results) {
                if (r == PreparedStatement.EXECUTE_FAILED) return false;
            }
            return true;
 
        } catch (SQLException e) {
            System.out.println("Error adding order items batch: " + e.getMessage());
            try {
                if (connection != null) connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Error rolling back: " + ex.getMessage());
            }
            return false;
        } finally {
            try {
                if (connection != null) connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Error restoring auto commit: " + e.getMessage());
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    private OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();
        item.setId(rs.getInt("id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnitPrice(rs.getDouble("unit_price"));
        item.setProductName(rs.getString("product_name"));
        item.setProductImage(rs.getString("product_image"));
        return item;
    }
}
