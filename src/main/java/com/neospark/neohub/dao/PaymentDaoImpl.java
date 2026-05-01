package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.model.Payment;
import com.neospark.neohub.utils.DatabaseConnection;

public class PaymentDaoImpl implements PaymentDao {


    @Override
    public boolean createPayment(Payment payment) {
        String sql = "INSERT INTO payments (order_id, method, transaction_id, amount, status) "
                   + "VALUES (?, ?, ?, ?, ?)";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getMethod());
            ps.setString(3, payment.getTransactionId());
            ps.setDouble(4, payment.getAmount());
            ps.setString(5, payment.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating payment: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }


    @Override
    public Payment getPaymentByOrderId(int orderId) {
        String sql = "SELECT * FROM payments WHERE order_id = ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapPayment(rs);
        } catch (SQLException e) {
            System.out.println("Error getting payment by order ID: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }

    @Override
    public List<Payment> getAllPayments() {
        String sql = "SELECT * FROM payments ORDER BY created_at DESC";
        List<Payment> payments = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) payments.add(mapPayment(rs));
        } catch (SQLException e) {
            System.out.println("Error getting all payments: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return payments;
    }


    @Override
    public boolean updatePaymentStatus(int orderId, String status, String transactionId) {
        String sql = "UPDATE payments SET status = ?, transaction_id = ?, paid_at = ? WHERE order_id = ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, transactionId);
            if ("Completed".equals(status)) {
                ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            } else {
                ps.setNull(3, Types.TIMESTAMP);
            }
            ps.setInt(4, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating payment status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }


    private Payment mapPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment(
            rs.getTimestamp("created_at"),
            rs.getInt("id"),
            rs.getInt("order_id"),
            rs.getString("method"),
            rs.getString("transaction_id"),
            rs.getDouble("amount"),
            rs.getString("status"),
            rs.getTimestamp("paid_at"),
            rs.getTimestamp("updated_at")
        );
        return payment;
    }
}