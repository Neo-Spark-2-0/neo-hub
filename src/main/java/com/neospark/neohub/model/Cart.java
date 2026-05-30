package com.neospark.neohub.model;

import java.sql.Timestamp;

/**
 * The type Cart.
 */
public class Cart {
    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private String productName;
    private String productImage;
    private double productPrice;
    private double productDiscountPrice;
    private int productStock;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    /**
     * Instantiates a new Cart.
     */
    public Cart(){}

    /**
     * Instantiates a new Cart.
     *
     * @param createdAt the created at
     * @param id        the id
     * @param userId    the user id
     * @param productId the product id
     * @param quantity  the quantity
     * @param updatedAt the updated at
     */
    public Cart(Timestamp createdAt, int id, int userId, int productId, int quantity, Timestamp updatedAt) {
        this.createdAt = createdAt;
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.updatedAt = updatedAt;
    }

    /**
     * Gets id.
     *
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * Sets id.
     *
     * @param id the id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Gets user id.
     *
     * @return the user id
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets user id.
     *
     * @param userId the user id
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Gets product id.
     *
     * @return the product id
     */
    public int getProductId() {
        return productId;
    }

    /**
     * Sets product id.
     *
     * @param productId the product id
     */
    public void setProductId(int productId) {
        this.productId = productId;
    }

    /**
     * Gets quantity.
     *
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Sets quantity.
     *
     * @param quantity the quantity
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * Gets product name.
     *
     * @return the product name
     */
    public String getProductName() {
        return productName;
    }

    /**
     * Sets product name.
     *
     * @param productName the product name
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * Gets product image.
     *
     * @return the product image
     */
    public String getProductImage() {
        return productImage;
    }

    /**
     * Sets product image.
     *
     * @param productImage the product image
     */
    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    /**
     * Gets product price.
     *
     * @return the product price
     */
    public double getProductPrice() {
        return productPrice;
    }

    /**
     * Sets product price.
     *
     * @param productPrice the product price
     */
    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    /**
     * Gets product discount price.
     *
     * @return the product discount price
     */
    public double getProductDiscountPrice() {
        return productDiscountPrice;
    }

    /**
     * Sets product discount price.
     *
     * @param productDiscountPrice the product discount price
     */
    public void setProductDiscountPrice(double productDiscountPrice) {
        this.productDiscountPrice = productDiscountPrice;
    }

    /**
     * Gets product stock.
     *
     * @return the product stock
     */
    public int getProductStock() {
        return productStock;
    }

    /**
     * Sets product stock.
     *
     * @param productStock the product stock
     */
    public void setProductStock(int productStock) {
        this.productStock = productStock;
    }

    /**
     * Gets created at.
     *
     * @return the created at
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets created at.
     *
     * @param createdAt the created at
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Gets updated at.
     *
     * @return the updated at
     */
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    /**
     * Sets updated at.
     *
     * @param updatedAt the updated at
     */
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
