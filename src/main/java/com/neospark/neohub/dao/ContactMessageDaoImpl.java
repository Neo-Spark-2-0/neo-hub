package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.model.ContactMessage;
import com.neospark.neohub.utils.DatabaseConnection;

public class ContactMessageDaoImpl implements ContactMessageDao {
    @Override
    public boolean saveMessage(ContactMessage message) {
        String sql = "INSERT INTO contact_messages (user_id, subject, message, status) VALUES (?, ?, ?, 'Unread')";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, message.getUserId());
            ps.setString(2, message.getSubject());
            ps.setString(3, message.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error saving contact message: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY created_at DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapMessage(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching all messages: " + e.getMessage());
        }
        return list;
    }



    private ContactMessage mapMessage(ResultSet rs) throws SQLException {
        ContactMessage msg = new ContactMessage();
        msg.setId(rs.getInt("id"));
        msg.setUserId(rs.getInt("user_id"));
        msg.setSubject(rs.getString("subject"));
        msg.setMessage(rs.getString("message"));
        msg.setStatus(rs.getString("status"));
        msg.setCreatedAt(rs.getTimestamp("created_at"));
        msg.setUpdatedAt(rs.getTimestamp("updated_at"));
        return msg;
    }
}
