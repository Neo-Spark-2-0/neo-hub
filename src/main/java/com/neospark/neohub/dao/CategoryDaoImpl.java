package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.utils.DatabaseConnection;
import com.neospark.neohub.model.Category;

/**
 * The type Category dao.
 */
public class CategoryDaoImpl implements CategoryDao {

    @Override
    public boolean addCategory(Category category) {
    String sql = "INSERT INTO categories (name, description, image, is_active) VALUES (?, ?, ?, ?)";
    Connection connection = null;
    try {
        connection = DatabaseConnection.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getImage());
            ps.setBoolean(4, category.isActive());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error adding category: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateCategory(Category category) {
    String sql = "UPDATE categories SET name = ?, description = ?, is_active = ? WHERE id = ?";
    Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setBoolean(3, category.isActive());
            ps.setInt(4, category.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating category: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateCategoryImage(int id, String imagePath) {
    String sql = "UPDATE categories SET image = ? WHERE id = ?";
    Connection connection = null;
    try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, imagePath);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating category image: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }


    @Override
    public boolean updateStatus(int id, boolean isActive) {
    String sql = "UPDATE categories SET is_active = ? WHERE id = ?";
    Connection connection = null;
    try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isActive);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating category status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }


    @Override
    public boolean deleteCategory(int id) {
    String sql = "DELETE FROM categories WHERE id = ?";
    Connection connection = null;
    try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting category: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        Connection connection = null;
    try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapCategory(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting category by ID: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }

    @Override
    public Category getCategoryByName(String name) {
        String sql = "SELECT * FROM categories WHERE TRIM (LOWER(name)) = TRIM(LOWER(?))";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapCategory(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting category by name: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }

    @Override
    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM categories ORDER BY created_at DESC";
        List<Category> categories = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(mapCategory(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all categories: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return categories;
    }

    @Override
    public List<Category> getActiveCategories() {
        String sql = "SELECT * FROM categories WHERE is_active = TRUE ORDER BY name ASC";
        List<Category> categories = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(mapCategory(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting active categories: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return categories;
    }


    @Override
    public int getTotalCategoryCount() {
    String sql = "SELECT COUNT(*) FROM categories";
    Connection connection = null;
    try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error getting total category count: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return 0;
    }



    private Category mapCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setDescription(rs.getString("description"));
        category.setImage(rs.getString("image"));
        category.setActive(rs.getBoolean("is_active"));
        category.setCreatedAt(rs.getTimestamp("created_at"));
        category.setUpdatedAt(rs.getTimestamp("updated_at"));
        return category;
    }
}