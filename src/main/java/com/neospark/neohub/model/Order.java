package com.neospark.neohub.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String orderNumber;     // e.g., "NEO-2024-00001"

    // User
    private int userId;
    private String userName;        // for display purposes

    // Order Items
    private List<OrderItem> orderItems;

    // Payment
    private String paymentMethod;   // "CASH" or "KHALTI"
    private String paymentStatus;   // "PENDING", "PAID", "FAILED", "REFUNDED"
    private String transactionId;   // Khalti transaction ID

    // Order Status
    private String orderStatus;     // "PENDING", "PROCESSING", "SHIPPED", "DELIVERED", "CANCELLED"

    // Pricing
    private double subtotal;
    private double shippingCharge;
    private double discount;        // from reward points
    private double totalAmount;

    // Reward Points
    private int rewardPointsUsed;
    private int rewardPointsEarned;

    // Shipping Address (snapshot at time of order)
    private String shippingAddress;

    // Timestamps
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Constructors
    public Order() {}

    public Order(int id, String orderNumber, int userId, String userName,
                 List<OrderItem> orderItems, String paymentMethod,
                 String paymentStatus, String transactionId, String orderStatus,
                 double subtotal, double shippingCharge, double discount,
                 double totalAmount, int rewardPointsUsed, int rewardPointsEarned,
                 String shippingAddress, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.orderNumber = orderNumber;
        this.userId = userId;
        this.userName = userName;
        this.orderItems = orderItems;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.transactionId = transactionId;
        this.orderStatus = orderStatus;
        this.subtotal = subtotal;
        this.shippingCharge = shippingCharge;
        this.discount = discount;
        this.totalAmount = totalAmount;
        this.rewardPointsUsed = rewardPointsUsed;
        this.rewardPointsEarned = rewardPointsEarned;
        this.shippingAddress = shippingAddress;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

    public double getShippingCharge() { return shippingCharge; }
    public void setShippingCharge(double shippingCharge) { this.shippingCharge = shippingCharge; }

    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public int getRewardPointsUsed() { return rewardPointsUsed; }
    public void setRewardPointsUsed(int rewardPointsUsed) { this.rewardPointsUsed = rewardPointsUsed; }

    public int getRewardPointsEarned() { return rewardPointsEarned; }
    public void setRewardPointsEarned(int rewardPointsEarned) { this.rewardPointsEarned = rewardPointsEarned; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // ✅ Helper Methods
    public boolean isPending() { return "PENDING".equals(orderStatus); }
    public boolean isProcessing() { return "PROCESSING".equals(orderStatus); }
    public boolean isShipped() { return "SHIPPED".equals(orderStatus); }
    public boolean isDelivered() { return "DELIVERED".equals(orderStatus); }
    public boolean isCancelled() { return "CANCELLED".equals(orderStatus); }
    public boolean isPaid() { return "PAID".equals(paymentStatus); }

    @Override
    public String toString() {
        return "Order{id=" + id + ", orderNumber='" + orderNumber +
               "', userId=" + userId + ", orderStatus='" + orderStatus +
               "', totalAmount=" + totalAmount + "}";
    }
}