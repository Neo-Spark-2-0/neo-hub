package com.neospark.neohub.dao;

import java.util.List;
import com.neospark.neohub.model.Product;

public interface ProductDao {
    // CRUD
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(int id);
    
    // Fetch
    Product getProductById(int id);
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(int categoryId);
    List<Product> getFeaturedProducts();
    List<Product> searchProducts(String keyword);
    
    // Dashboard
    int getTotalProductCount();
    List<Product> getLowStockProducts(int limit);
    
    // Stock
    boolean updateStock(int productId, int quantity);
    
    // Status
    boolean toggleProductStatus(int id);

    // Pagination & Filtering
    List<Product> getProductsPaginated(int offset, int limit, String keyword, int categoryId);
    int getProductCount(String keyword, int categoryId);
}