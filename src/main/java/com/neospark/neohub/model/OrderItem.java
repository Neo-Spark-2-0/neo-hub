package com.neospark.neohub.model;


/**
 * The type Order item.
 */
public class OrderItem {

    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private double unitPrice;  
    private String productName;
    private String productImage;

    /**
     * Instantiates a new Order item.
     */
// Constructors
    public OrderItem() {}


    /**
     * Instantiates a new Order item.
     *
     * @param id           the id
     * @param orderId      the order id
     * @param productId    the product id
     * @param quantity     the quantity
     * @param unitPrice    the unit price
     * @param productName  the product name
     * @param productImage the product image
     */
    public OrderItem(int id, int orderId, int productId, int quantity, double unitPrice, String productName, String productImage) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.productName = productName;
        this.productImage = productImage;
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
     * Gets order id.
     *
     * @return the order id
     */
    public int getOrderId() {
        return orderId;
    }

    /**
     * Sets order id.
     *
     * @param orderId the order id
     */
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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
     * Gets unit price.
     *
     * @return the unit price
     */
    public double getUnitPrice() {
        return unitPrice;
    }

    /**
     * Sets unit price.
     *
     * @param unitPrice the unit price
     */
    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
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

    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", productName='" + productName + '\'' +
                ", productImage='" + productImage + '\'' +
                '}';
    }
}