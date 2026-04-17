package com.neospark.neohub.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String description;
    private double price;
    private double discountPrice;  // 0 if no discount
    private int stock;
    private String image;
    private String brand;
    private String sku;            // Stock Keeping Unit (unique product code)

    // Category
    private int categoryId;
    private String categoryName;   // for display purposes

    // Status
    private boolean isActive;
    private boolean isFeatured;    // show on homepage

    // Timestamps
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Constructors
    public Product() {}

    public Product(int id, String name, String description, double price,
                   double discountPrice, int stock, String image, String brand,
                   String sku, int categoryId, String categoryName,
                   boolean isActive, boolean isFeatured,
                   LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.discountPrice = discountPrice;
        this.stock = stock;
        this.image = image;
        this.brand = brand;
        this.sku = sku;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.isActive = isActive;
        this.isFeatured = isFeatured;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getDiscountPrice() { return discountPrice; }
    public void setDiscountPrice(double discountPrice) { this.discountPrice = discountPrice; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // ✅ Helper Methods
    public boolean isInStock() { return stock > 0; }

    public boolean isOnSale() { return discountPrice > 0 && discountPrice < price; }

    public double getEffectivePrice() {
        return isOnSale() ? discountPrice : price;
    }

    public double getDiscountPercentage() {
        if (isOnSale()) {
            return ((price - discountPrice) / price) * 100;
        }
        return 0;
    }

    public boolean isLowStock() { return stock > 0 && stock <= 5; }

    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', price=" + price +
               ", stock=" + stock + ", isActive=" + isActive + "}";
    }
}