package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.utils.DatabaseConnection;
import com.neospark.neohub.model.Product;

public class ProductDaoImpl implements ProductDao {

    // ✅ Helper - Map ResultSet to Product
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
        product.setSku(rs.getString("sku"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setCategoryName(rs.getString("category_name"));
        product.setActive(rs.getBoolean("is_active"));
        product.setFeatured(rs.getBoolean("is_featured"));
        product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        product.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return product;
    }

    // ✅ Add Product
    @Override
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, description, price, discount_price, stock, " +
                     "image, brand, sku, category_id, is_active, is_featured) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setDouble(4, product.getDiscountPrice());
            stmt.setInt(5, product.getStock());
            stmt.setString(6, product.getImage());
            stmt.setString(7, product.getBrand());
            stmt.setString(8, product.getSku());
            stmt.setInt(9, product.getCategoryId());
            stmt.setBoolean(10, product.isActive());
            stmt.setBoolean(11, product.isFeatured());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Update Product
    @Override
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name=?, description=?, price=?, discount_price=?, " +
                     "stock=?, image=?, brand=?, sku=?, category_id=?, is_active=?, " +
                     "is_featured=?, updated_at=NOW() WHERE id=?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setDouble(4, product.getDiscountPrice());
            stmt.setInt(5, product.getStock());
            stmt.setString(6, product.getImage());
            stmt.setString(7, product.getBrand());
            stmt.setString(8, product.getSku());
            stmt.setInt(9, product.getCategoryId());
            stmt.setBoolean(10, product.isActive());
            stmt.setBoolean(11, product.isFeatured());
            stmt.setInt(12, product.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete Product
    @Override
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id=?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get Product By Id
    @Override
    public Product getProductById(int id) {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.id=?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapProduct(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get All Products
    @Override
    public List<Product> getAllProducts() {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // ✅ Get Products By Category
    @Override
    public List<Product> getProductsByCategory(int categoryId) {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.category_id=? AND p.is_active=true " +
                     "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // ✅ Get Featured Products
    @Override
    public List<Product> getFeaturedProducts() {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_featured=true AND p.is_active=true " +
                     "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // ✅ Search Products
    @Override
    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active=true AND " +
                     "(p.name LIKE ? OR p.description LIKE ? OR p.brand LIKE ?) " +
                     "ORDER BY p.created_at DESC";
        List<Product> products = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // ✅ Get Total Product Count
    @Override
    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM products";

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

    // ✅ Get Low Stock Products
    @Override
    public List<Product> getLowStockProducts(int limit) {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.stock <= 5 AND p.is_active=true " +
                     "ORDER BY p.stock ASC LIMIT ?";
        List<Product> products = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // ✅ Update Stock
    @Override
    public boolean updateStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock = stock - ?, updated_at=NOW() WHERE id=? AND stock >= ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Toggle Product Status
    @Override
    public boolean toggleProductStatus(int id) {
        String sql = "UPDATE products SET is_active = NOT is_active, updated_at=NOW() WHERE id=?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}