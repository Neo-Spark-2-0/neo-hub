package com.neospark.neohub.dao;

import com.neospark.neohub.model.Cart;
import com.neospark.neohub.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class CartDaoImpl implements CartDao {
// method to add to cart


    @Override
    public boolean addToCart(Cart cart) {
        String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?) "
                   + "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cart.getUserId());
            ps.setInt(2, cart.getProductId());
            ps.setInt(3, cart.getQuantity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding to cart: " + e.getMessage());
            return false;
        }
    }


    @Override
    public boolean updateQuantity(int userId, int productId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating cart quantity: " + e.getMessage());
            return false;
        }
    }


    @Override
    public List<Cart> getCartByUser(int userId) {
        String sql = "SELECT cart.*, "
                   + "products.name AS product_name, "
                   + "products.image AS product_image, "
                   + "products.price AS product_price, "
                   + "products.discount_price AS product_discount_price, "
                   + "products.stock AS product_stock "
                   + "FROM cart "
                   + "JOIN products ON cart.product_id = products.id "
                   + "WHERE cart.user_id = ? "
                   + "ORDER BY cart.created_at DESC";
        List<Cart> cartItems = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cartItems.add(mapCart(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting cart by user: " + e.getMessage());
        }
        return cartItems;
    }

    @Override
    public boolean removeFromCart(int userId, int productId) {
        String sql = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error removing from cart: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error clearing cart: " + e.getMessage());
            return false;
        }
    }
    @Override
    public int getCartQuantity(int userId, int productId) {
        String sql = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("quantity");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; 
    }



    private Cart mapCart(ResultSet rs) throws SQLException {
        Cart cart = new Cart();
        cart.setId(rs.getInt("id"));
        cart.setUserId(rs.getInt("user_id"));
        cart.setProductId(rs.getInt("product_id"));
        cart.setQuantity(rs.getInt("quantity"));
        cart.setCreatedAt(rs.getTimestamp("created_at"));
        cart.setUpdatedAt(rs.getTimestamp("updated_at"));


        // extra fields from JOINed products table
        cart.setProductName(rs.getString("product_name"));
        cart.setProductImage(rs.getString("product_image"));
        cart.setProductPrice(rs.getDouble("product_price"));
        cart.setProductDiscountPrice(rs.getDouble("product_discount_price"));
        cart.setProductStock(rs.getInt("product_stock"));

        return cart;
    }
}