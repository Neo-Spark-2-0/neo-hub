package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;

import com.neospark.neohub.model.Payment;
import com.neospark.neohub.utils.DatabaseConnection;

/**
 * The type Payment dao.
 */
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