package com.neospark.neohub.model;

import java.io.Serializable;

public class OrderItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private int orderId;
    private int productId;
    private String productName;   // snapshot at time of order
    private String productImage;  // snapshot at time of order
    private double price;         // snapshot at time of order
    private int quantity;
    private double subtotal;      // price * quantity

    // Constructors
    public OrderItem() {}

    public OrderItem(int id, int orderId, int productId, String productName,
                     String productImage, double price, int quantity, double subtotal) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
        this.price = price;
        this.quantity = quantity;
        this.subtotal = subtotal;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

    @Override
    public String toString() {
        return "OrderItem{id=" + id + ", productName='" + productName +
               "', quantity=" + quantity + ", subtotal=" + subtotal + "}";
    }
}