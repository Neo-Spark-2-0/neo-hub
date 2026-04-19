package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.model.PromoCode;
import com.neospark.neohub.utils.DatabaseConnection;

public class PromoCodeDaoImpl implements PromoCodeDao {
    @Override
    public boolean addPromoCode(PromoCode promoCode) {
        String sql = "INSERT INTO promo_codes (code, discount_percent, expiry_date, is_active) VALUES (?, ?, ?, ?)";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, promoCode.getCode());
            ps.setDouble(2, promoCode.getDiscountPercent());
            ps.setDate(3, java.sql.Date.valueOf(promoCode.getExpiryDate()));
            ps.setBoolean(4, promoCode.isActive());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error adding promo code: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }


    @Override
    public PromoCode getPromoCodeById(int id) {
        String sql = "SELECT * FROM promo_codes WHERE id = ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapPromoCode(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting promo code by ID: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }
 
    
    @Override
    public PromoCode getPromoCodeByCode(String code) {
        String sql = "SELECT * FROM promo_codes WHERE LOWER(code) = LOWER(?)";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                 return mapPromoCode(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting promo code by code: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }
 

    @Override
    public List<PromoCode> getAllPromoCodes() {
        String sql = "SELECT * FROM promo_codes ORDER BY created_at DESC";
        List<PromoCode> promoCodes = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                promoCodes.add(mapPromoCode(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all promo codes: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return promoCodes;
    }


    @Override
    public boolean updatePromoCode(PromoCode promoCode) {
        String sql = "UPDATE promo_codes SET code=?, discount_percent=?, expiry_date=?, is_active=? WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, promoCode.getCode());
            ps.setDouble(2, promoCode.getDiscountPercent());
            ps.setDate(3, java.sql.Date.valueOf(promoCode.getExpiryDate()));
            ps.setBoolean(4, promoCode.isActive());
            ps.setInt(5, promoCode.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating promo code: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateStatus(int id, boolean isActive) {
        String sql = "UPDATE promo_codes SET is_active=? WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isActive);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating promo code status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean deletePromoCode(int id) {
        String sql = "DELETE FROM promo_codes WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting promo code: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    private PromoCode mapPromoCode(ResultSet rs) throws SQLException {
        PromoCode promoCode = new PromoCode();
        promoCode.setId(rs.getInt("id"));
        promoCode.setCode(rs.getString("code"));
        promoCode.setDiscountPercent(rs.getDouble("discount_percent"));
        promoCode.setExpiryDate(rs.getDate("expiry_date").toLocalDate());
        promoCode.setActive(rs.getBoolean("is_active"));
        promoCode.setCreatedAt(rs.getTimestamp("created_at"));
        promoCode.setUpdatedAt(rs.getTimestamp("updated_at"));
        return promoCode;
    }
}
