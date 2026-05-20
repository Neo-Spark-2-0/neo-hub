package com.neospark.neohub.model;

import java.sql.Timestamp;

/**
 * The type Product.
 */
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

    /**
     * Instantiates a new Product.
     */
// Constructors
    public Product() {}

    /**
     * Instantiates a new Product.
     *
     * @param id               the id
     * @param name             the name
     * @param description      the description
     * @param price            the price
     * @param discountPrice    the discount price
     * @param stock            the stock
     * @param image            the image
     * @param brand            the brand
     * @param stockKeepingUnit the stock keeping unit
     * @param isFeatured       the is featured
     * @param isActive         the is active
     * @param categoryId       the category id
     * @param categoryName     the category name
     * @param createdAt        the created at
     * @param updatedAt        the updated at
     */
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

    /**
     * Is featured boolean.
     *
     * @return the boolean
     */
    public boolean isFeatured() {
        return isFeatured;
    }

    /**
     * Sets featured.
     *
     * @param featured the featured
     */
    public void setFeatured(boolean featured) {
        isFeatured = featured;
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
     * Gets name.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets name.
     *
     * @param name the name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets description.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets description.
     *
     * @param description the description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets price.
     *
     * @return the price
     */
    public double getPrice() {
        return price;
    }

    /**
     * Sets price.
     *
     * @param price the price
     */
    public void setPrice(double price) {
        this.price = price;
    }

    /**
     * Gets discount price.
     *
     * @return the discount price
     */
    public double getDiscountPrice() {
        return discountPrice;
    }

    /**
     * Sets discount price.
     *
     * @param discountPrice the discount price
     */
    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    /**
     * Gets stock.
     *
     * @return the stock
     */
    public int getStock() {
        return stock;
    }

    /**
     * Sets stock.
     *
     * @param stock the stock
     */
    public void setStock(int stock) {
        this.stock = stock;
    }

    /**
     * Gets image.
     *
     * @return the image
     */
    public String getImage() {
        return image;
    }

    /**
     * Sets image.
     *
     * @param image the image
     */
    public void setImage(String image) {
        this.image = image;
    }

    /**
     * Gets brand.
     *
     * @return the brand
     */
    public String getBrand() {
        return brand;
    }

    /**
     * Sets brand.
     *
     * @param brand the brand
     */
    public void setBrand(String brand) {
        this.brand = brand;
    }

    /**
     * Gets stock keeping unit.
     *
     * @return the stock keeping unit
     */
    public String getStockKeepingUnit() {
        return stockKeepingUnit;
    }

    /**
     * Sets stock keeping unit.
     *
     * @param stockKeepingUnit the stock keeping unit
     */
    public void setStockKeepingUnit(String stockKeepingUnit) {
        this.stockKeepingUnit = stockKeepingUnit;
    }

    /**
     * Is active boolean.
     *
     * @return the boolean
     */
    public boolean isActive() {
        return isActive;
    }

    /**
     * Sets active.
     *
     * @param active the active
     */
    public void setActive(boolean active) {
        isActive = active;
    }

    /**
     * Gets category id.
     *
     * @return the category id
     */
    public int getCategoryId() {
        return categoryId;
    }

    /**
     * Sets category id.
     *
     * @param categoryId the category id
     */
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    /**
     * Gets category name.
     *
     * @return the category name
     */
    public String getCategoryName() {
        return categoryName;
    }

    /**
     * Sets category name.
     *
     * @param categoryName the category name
     */
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
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

    /**
     * Is in stock boolean.
     *
     * @return the boolean
     */
    public boolean isInStock() { return stock > 0; }

    /**
     * Is on sale boolean.
     *
     * @return the boolean
     */
    public boolean isOnSale() { return discountPrice > 0 && discountPrice < price; }

    /**
     * Gets effective price.
     *
     * @return the effective price
     */
    public double getEffectivePrice() {
        return isOnSale() ? discountPrice : price;
    }

    /**
     * Gets discount percentage.
     *
     * @return the discount percentage
     */
    public double getDiscountPercentage() {
        if (isOnSale()) {
            return ((price - discountPrice) / price) * 100;
        }
        return 0;
    }

    /**
     * Is low stock boolean.
     *
     * @return the boolean
     */
    public boolean isLowStock() { return stock > 0 && stock <= 5; }

    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', price=" + price + ", stock=" + stock + ", isActive=" + isActive + "}";
    }
}