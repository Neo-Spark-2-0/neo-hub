package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.neospark.neohub.utils.DatabaseConnection;
import com.neospark.neohub.model.Product;

public class ProductDaoImpl implements ProductDao {

    @Override
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, description, price, discount_price, stock, image, brand, stock_keeping_unit, is_featured, is_active, category_id) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setDouble(4, product.getDiscountPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getImage());
            ps.setString(7, product.getBrand());
            ps.setString(8, product.getStockKeepingUnit());
            ps.setBoolean(9, product.isFeatured());
            ps.setBoolean(10, product.isActive());
            ps.setInt(11, product.getCategoryId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error adding product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name=?, description=?, price=?, discount_price=?, stock=?, brand=?, stock_keeping_unit=?, is_featured=?, is_active=?, category_id=? WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setDouble(4, product.getDiscountPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getBrand());
            ps.setString(7, product.getStockKeepingUnit());
            ps.setBoolean(8, product.isFeatured());
            ps.setBoolean(9, product.isActive());
            ps.setInt(10, product.getCategoryId());
            ps.setInt(11, product.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateProductImage(int id, String imagePath) {
        String sql = "UPDATE products SET image=? WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, imagePath);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating product image: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting product: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public Product getProductById(int id) {
        String sql = "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.id = ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapProduct(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting product by ID: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }

    @Override
    public List<Product> getAllProducts() {
        String sql = "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id ORDER BY products.created_at DESC";
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting all products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }

    @Override
    public List<Product> getProductsByCategory(int categoryId) {
        String sql = "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.category_id = ? AND products.is_active = TRUE ORDER BY products.created_at DESC";

        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting products by category: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }


    @Override
    public List<Product> getFeaturedProducts() {
        String sql = "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.is_featured = TRUE AND products.is_active = TRUE ORDER BY products.created_at DESC";
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting featured products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }


    @Override
    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.is_active = TRUE AND (products.name LIKE ? OR products.description LIKE ? OR products.brand LIKE ?) ORDER BY products.name ASC";
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            String searchTerm = "%" + keyword + "%";
            ps.setString(1, searchTerm);
            ps.setString(2, searchTerm);
            ps.setString(3, searchTerm);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error searching products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }


    @Override
    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM products";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error getting total product count: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return 0;
    }


    @Override
    public List<Product> getLowStockProducts(int threshold) {
        String sql = "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.stock <= ? AND products.is_active = TRUE ORDER BY products.stock ASC";
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, threshold);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting low stock products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }

    @Override
    public List<Product> getRecentProducts(int limit) {
        String sql = "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.is_active = TRUE ORDER BY products.created_at DESC LIMIT ?";
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting recent products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }

    @Override
    public boolean updateStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating stock: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateFeaturedStatus(int id, boolean isFeatured) {
        String sql = "UPDATE products SET is_featured=? WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isFeatured);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating featured status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateActiveStatus(int id, boolean isActive) {
        String sql = "UPDATE products SET is_active=? WHERE id=?";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isActive);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating active status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    // needs review
    @Override
    public List<Product> getProductsPaginated(int offset, int limit, String keyword, int categoryId) {
        StringBuilder sql = new StringBuilder(
            "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.is_active = TRUE"
        );

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (products.name LIKE ? OR products.description LIKE ?)");
        }
        if (categoryId > 0) {
            sql.append(" AND products.category_id = ?");
        }
        sql.append(" ORDER BY products.created_at DESC LIMIT ? OFFSET ?");

        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int index = 1;
            if (keyword != null && !keyword.isEmpty()) {
                String search = "%" + keyword + "%";
                ps.setString(index++, search);
                ps.setString(index++, search);
            }
            if (categoryId > 0) {
                ps.setInt(index++, categoryId);
            }
            ps.setInt(index++, limit);
            ps.setInt(index, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting paginated products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }

    // needs review
    @Override
    public List<Product> getProductsByFilter(Integer categoryId, Double minPrice, Double maxPrice, String sortBy) {
        StringBuilder sql = new StringBuilder(
            "SELECT products.*, categories.name AS category_name FROM products LEFT JOIN categories ON products.category_id = categories.id WHERE products.is_active = TRUE"
        );
 
        if (categoryId != null){
            sql.append(" AND products.category_id = ?");
        }
        if (minPrice != null){
            sql.append(" AND products.price >= ?");
        }
        if (maxPrice != null){
            sql.append(" AND products.price <= ?");
        }
        if ("price_asc".equals(sortBy)){
            sql.append(" ORDER BY products.price ASC");
        } else if ("price_desc".equals(sortBy)){
            sql.append(" ORDER BY products.price DESC");
        } else if ("name_asc".equals(sortBy)){
            sql.append(" ORDER BY products.name ASC");
        } else {
            sql.append(" ORDER BY products.created_at DESC");
        }

        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int index = 1;
            if (categoryId != null){
                ps.setInt(index++, categoryId);
            }
            if (minPrice != null){
                ps.setDouble(index++, minPrice);
            }
            if (maxPrice != null){
                ps.setDouble(index++, maxPrice);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error filtering products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return products;
    }

    // needs review
    @Override
    public List<Object[]> getTopSellingProducts(int limit) {
        String sql = "SELECT products.name, SUM(order_items.quantity) AS total_sold FROM order_items JOIN products ON order_items.product_id = products.id GROUP BY products.id, products.name ORDER BY total_sold DESC LIMIT ?";
        List<Object[]> result = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Object[]{rs.getString("name"), rs.getInt("total_sold")});
            }
        } catch (SQLException e) {
            System.out.println("Error getting top selling products: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return result;
    }
    // needs review
    @Override
    public List<Object[]> getSalesByCategory() {
        String sql = "SELECT categories.name, SUM(order_items.quantity) AS total_sold FROM order_items JOIN products ON order_items.product_id = products.id JOIN categories ON products.category_id = categories.id GROUP BY categories.id, categories.name ORDER BY total_sold DESC";
        List<Object[]> result = new ArrayList<>();
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Object[]{rs.getString("name"), rs.getInt("total_sold")});
            }
        } catch (SQLException e) {
            System.out.println("Error getting sales by category: " + e.getMessage());
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
        return result;
    }


    // helper method to map ResultSet to Product object
    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setDiscountPrice(rs.getDouble("discount_price"));
        product.setStock(rs.getInt("stock"));
        product.setImage(rs.getString("image"));
        product.setBrand(rs.getString("brand"));
        product.setStockKeepingUnit(rs.getString("stock_keeping_unit"));
        product.setFeatured(rs.getBoolean("is_featured"));
        product.setActive(rs.getBoolean("is_active"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setCategoryName(rs.getString("category_name"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));
        return product; 
    }
}