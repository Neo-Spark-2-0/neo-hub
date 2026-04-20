package com.neospark.neohub.model;

import java.sql.Timestamp;

public class Product {


    // product details 
    private int id;
    private String name;
    private String description;
    private double price;
    private double discountPrice;  
    private int stock;
    private String image;
    private String brand;
    private String stockKeepingUnit;

    // Status
    private boolean isFeatured;    // used to show on home page
    private boolean isActive;

    // Category
    private int categoryId;
    private String categoryName;

    // Timestamps
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public Product() {}

    public Product(int id, String name, String description, double price, double discountPrice, int stock, String image, String brand, String stockKeepingUnit, boolean isFeatured, boolean isActive, int categoryId, String categoryName, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.discountPrice = discountPrice;
        this.stock = stock;
        this.image = image;
        this.brand = brand;
        this.stockKeepingUnit = stockKeepingUnit;
        this.isFeatured = isFeatured;
        this.isActive = isActive;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getStockKeepingUnit() {
        return stockKeepingUnit;
    }

    public void setStockKeepingUnit(String stockKeepingUnit) {
        this.stockKeepingUnit = stockKeepingUnit;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

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
        return "Product{id=" + id + ", name='" + name + "', price=" + price + ", stock=" + stock + ", isActive=" + isActive + "}";
    }
}