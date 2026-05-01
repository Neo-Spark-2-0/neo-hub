package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.Product;

public interface ProductDao {
    boolean addProduct(Product product);

    boolean updateProduct(Product product);
    boolean updateProductImage(int id, String imagePath);
    boolean updateFeaturedStatus(int id, boolean isFeatured);
    boolean updateActiveStatus(int id, boolean isActive);
    boolean deleteProduct(int id);
    boolean updateStock(int productId, int quantity);

    
    List<Product> getRecentProducts(int limit);
    int getTotalProductCount();
    int getProductCount(String keyword, int categoryId);
    List<Product> getLowStockProducts(int limit);
    Product getProductById(int id);
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(int categoryId);
    List<Product> getFeaturedProducts();
    List<Product> searchProducts(String keyword);
    List<Product> getProductsByFilter(Integer categoryId, Double minPrice, Double maxPrice, String sortBy);
    List<Product> getProductsPaginated(int offset, int limit, String keyword, int categoryId);
    List<Object[]> getSalesByCategory();
    List<Object[]> getTopSellingProducts(int limit);
}