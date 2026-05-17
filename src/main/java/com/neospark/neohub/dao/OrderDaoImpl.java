package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.utils.DatabaseConnection;
import com.neospark.neohub.model.Order;

public class OrderDaoImpl implements OrderDao {

    @Override
    public boolean placeOrder(Order order) {
        String sql = "INSERT INTO orders (sub_total_amount, shipping_charge, discount_amount, total_amount, promo_code_id, order_status, user_id) VALUES (?, ?, ?, ?, ?, 'Pending', ?)";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(1, order.getSubTotalAmount());
            ps.setDouble(2, order.getShippingCharge());
            ps.setDouble(3, order.getDiscountAmount());
            ps.setDouble(4, order.getTotalAmount());

            if (order.getPromoCodeId() != null) {
                ps.setInt(5, order.getPromoCodeId());
            } else {
                ps.setNull(5, java.sql.Types.INTEGER);
            }
            ps.setInt(6, order.getUserId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error placing order: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return false;
    }


    @Override
    public boolean updateOrderStatus(int orderId, String orderStatus) {
        String sql = "UPDATE orders SET order_status = ? WHERE id = ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating order status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }


    @Override
    public Order getOrderById(int id) {
        String sql = "SELECT orders.*, users.full_name AS user_full_name, users.phone AS user_phone, users.street, users.city, users.district, users.province, payments.method AS payment_method, payments.status AS payment_status, payments.transaction_id FROM orders LEFT JOIN users   ON orders.user_id  = users.id LEFT JOIN payments ON payments.order_id = orders.id WHERE orders.id = ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapOrder(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting order by ID: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }



     @Override
    public List<Order> getAllOrders() {
        String sql = "SELECT orders.*, users.full_name AS user_full_name, users.phone AS user_phone, users.street, users.city, users.district, users.province, payments.method AS payment_method, payments.status AS payment_status, payments.transaction_id FROM orders LEFT JOIN users ON orders.user_id  = users.id LEFT JOIN payments ON payments.order_id = orders.id ORDER BY orders.created_at DESC";
        List<Order> orders = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all orders: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return orders;
    }
   @Override
    public List<Order> getOrdersByUser(int userId) {
        String sql = "SELECT o.*, "
                   + "u.full_name AS user_full_name, u.phone AS user_phone, "
                   + "u.street, u.city, u.district, u.province, "
                   + "p.method AS payment_method, p.status AS payment_status, p.transaction_id "
                   + "FROM orders o "
                   + "LEFT JOIN users u    ON o.user_id  = u.id "
                   + "LEFT JOIN payments p ON p.order_id = o.id "
                   + "WHERE o.user_id = ? ORDER BY o.created_at DESC";
        List<Order> orders = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.out.println("Error getting orders by user: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return orders;
    }

    @Override
    public List<Order> getOrdersByStatus(String orderStatus) {
        String sql = "SELECT o.*, "
                   + "u.full_name AS user_full_name, u.phone AS user_phone, "
                   + "u.street, u.city, u.district, u.province, "
                   + "p.method AS payment_method, p.status AS payment_status, p.transaction_id "
                   + "FROM orders o "
                   + "LEFT JOIN users u    ON o.user_id  = u.id "
                   + "LEFT JOIN payments p ON p.order_id = o.id "
                   + "WHERE o.order_status = ? ORDER BY o.created_at DESC";
        List<Order> orders = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderStatus);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.out.println("Error getting orders by status: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return orders;
    }

    @Override
    public List<Order> getOrdersByUserWithFilters(int userId, String status, String paymentMethod) {
        boolean filterStatus  = status != null && !"all".equals(status);
        boolean filterPayment = paymentMethod != null && !"all".equals(paymentMethod);
        String sql = "SELECT o.*, u.full_name AS user_full_name, u.phone AS user_phone, "
               + "u.street, u.city, u.district, u.province, "
               + "p.method AS payment_method, p.status AS payment_status, p.transaction_id "
               + "FROM orders o "
               + "LEFT JOIN users u ON o.user_id = u.id "
               + "LEFT JOIN payments p ON p.order_id = o.id "
               + "WHERE o.user_id = ? ";

        if (filterStatus)  sql += "AND LOWER(o.order_status) = LOWER(?) ";
        if (filterPayment) sql += "AND LOWER(p.method) = LOWER(?) ";
        sql += "ORDER BY o.created_at DESC";

        List<Order> orders = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);

            int idx = 1;
            ps.setInt(idx++, userId); // first it set to 1 and increases later
            if (filterStatus)  ps.setString(idx++, status);
            if (filterPayment) ps.setString(idx++, paymentMethod);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting filtered orders: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return orders;
    }


    @Override
    public int getTotalOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error getting total order count: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return 0;
    }
    @Override
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE order_status != 'Cancelled'";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            System.out.println("Error getting total revenue: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return 0.0;
    }

    @Override
    public List<Order> getRecentOrders(int limit) {
        String sql = "SELECT o.*, "
                   + "u.full_name AS user_full_name, u.phone AS user_phone, "
                   + "u.street, u.city, u.district, u.province, "
                   + "p.method AS payment_method, p.status AS payment_status, p.transaction_id "
                   + "FROM orders o "
                   + "LEFT JOIN users u    ON o.user_id  = u.id "
                   + "LEFT JOIN payments p ON p.order_id = o.id "
                   + "ORDER BY o.created_at DESC LIMIT ?";
        List<Order> orders = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) orders.add(mapOrder(rs));
        } catch (SQLException e) {
            System.out.println("Error getting recent orders: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return orders;
    }

    @Override
    public List<Object[]> getMonthlyRevenue() {
        String sql = "SELECT DATE_FORMAT(created_at, '%Y-%m') AS month, "
                + "COALESCE(SUM(total_amount), 0) AS revenue "
                + "FROM orders WHERE order_status != 'Cancelled' "
                + "GROUP BY month ORDER BY month ASC LIMIT 12";
        List<Object[]> result = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Object[]{rs.getString("month"), rs.getDouble("revenue")});
            }
        } catch (SQLException e) {
            System.out.println("Error getting monthly revenue: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return result;
    }

    @Override
    public int getOrderCountByStatus(String orderStatus) {
        String sql = "SELECT COUNT(*) FROM orders WHERE order_status = ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderStatus);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error getting order count by status: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return 0;
    }

       private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setSubTotalAmount(rs.getDouble("sub_total_amount"));
        order.setShippingCharge(rs.getDouble("shipping_charge"));
        order.setDiscountAmount(rs.getDouble("discount_amount"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setOrderStatus(rs.getString("order_status"));
        order.setUserId(rs.getInt("user_id"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
 
        // fk nullable handling for promo_code_id
        int promoCodeId = rs.getInt("promo_code_id");
        order.setPromoCodeId(rs.wasNull() ? null : promoCodeId);
 
        // User details from  left join users table
        order.setUserFullName(rs.getString("user_full_name"));
        order.setUserPhone(rs.getString("user_phone"));
        order.setUserAddress(buildAddress(
            rs.getString("street"), 
            rs.getString("city"),
            rs.getString("district"), 
            rs.getString("province")
        ));
 
        // Payment details from left join payments table
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setPaymentStatus(rs.getString("payment_status"));
        order.setTransactionId(rs.getString("transaction_id"));
 
        return order;
    }

    private String buildAddress(String street, String city, String district, String province) {
            StringBuilder sb = new StringBuilder();
            if (province != null && !province.isEmpty()) sb.append(province);
            if (district != null && !district.isEmpty()) sb.append(district).append(", ");
            if (city     != null && !city.isEmpty())     sb.append(city).append(", ");
            if (street   != null && !street.isEmpty())   sb.append(street).append(", ");
            return sb.toString().replaceAll(",\\s*$", "");
    }
        
    }