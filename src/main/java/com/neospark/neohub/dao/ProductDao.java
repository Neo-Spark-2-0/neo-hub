package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.Product;

/**
 * The interface Product dao.
 */
public interface ProductDao {
    /**
     * Add product boolean.
     *
     * @param product the product
     * @return the boolean
     */
    boolean addProduct(Product product);

    /**
     * Update product boolean.
     *
     * @param product the product
     * @return the boolean
     */
    boolean updateProduct(Product product);

    /**
     * Update product image boolean.
     *
     * @param id        the id
     * @param imagePath the image path
     * @return the boolean
     */
    boolean updateProductImage(int id, String imagePath);

    /**
     * Delete product boolean.
     *
     * @param id the id
     * @return the boolean
     */
    boolean deleteProduct(int id);

    /**
     * Update stock boolean.
     *
     * @param productId the product id
     * @param quantity  the quantity
     * @return the boolean
     */
    boolean updateStock(int productId, int quantity);


    /**
     * Gets recent products.
     *
     * @param limit the limit
     * @return the recent products
     */
    List<Product> getRecentProducts(int limit);

    /**
     * Gets total product count.
     *
     * @return the total product count
     */
    int getTotalProductCount();

    /**
     * Gets product count.
     *
     * @param keyword    the keyword
     * @param categoryId the category id
     * @param minPrice   the min price
     * @param maxPrice   the max price
     * @param onlyActive the only active
     * @return the product count
     */
    int getProductCount(String keyword, int categoryId, Double minPrice, Double maxPrice, boolean onlyActive);

    /**
     * Gets low stock products.
     *
     * @param limit the limit
     * @return the low stock products
     */
    List<Product> getLowStockProducts(int limit);

    /**
     * Gets product by id.
     *
     * @param id the id
     * @return the product by id
     */
    Product getProductById(int id);

    /**
     * Gets products by category.
     *
     * @param categoryId the category id
     * @return the products by category
     */
    List<Product> getProductsByCategory(int categoryId);

    /**
     * Gets featured products.
     *
     * @return the featured products
     */
    List<Product> getFeaturedProducts();

    /**
     * Gets products paginated.
     *
     * @param offset     the offset
     * @param limit      the limit
     * @param keyword    the keyword
     * @param categoryId the category id
     * @param sortBy     the sort by
     * @param minPrice   the min price
     * @param maxPrice   the max price
     * @param onlyActive the only active
     * @return the products paginated
     */
    List<Product> getProductsPaginated(int offset, int limit, String keyword, int categoryId, String sortBy, Double minPrice, Double maxPrice, boolean onlyActive);

    /**
     * Gets sales by category.
     *
     * @return the sales by category
     */
    List<Object[]> getSalesByCategory();

    /**
     * Gets top selling products.
     *
     * @param limit the limit
     * @return the top selling products
     */
    List<Object[]> getTopSellingProducts(int limit);
}