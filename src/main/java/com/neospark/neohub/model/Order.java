package com.neospark.neohub.model;

import java.security.Timestamp;
import java.util.List;

public class Order {


    private int id;
    
    // pricing
    private double subTotalAmount;
    private double shippingCharge;
    private double discountAmount;
    private double totalAmount;
    // promocode 
    private Integer promoCodeId;

    // order 
    private String orderStatus;

    // user
    private int userId;

    // timestamps
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // order items
    private List<OrderItem> orderItems;

    // constructors
    public Order() {}

    public Order(int id, double subTotalAmount, double shippingCharge, double discountAmount, double totalAmount, Integer promoCodeId, String orderStatus, int userId, Timestamp createdAt, Timestamp updatedAt, List<OrderItem> orderItems) {
        this.id = id;
        this.subTotalAmount = subTotalAmount;
        this.shippingCharge = shippingCharge;
        this.discountAmount = discountAmount;
        this.totalAmount = totalAmount;
        this.promoCodeId = promoCodeId;
        this.orderStatus = orderStatus;
        this.userId = userId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.orderItems = orderItems;
    }

//    getter & setter


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getSubTotalAmount() {
        return subTotalAmount;
    }

    public void setSubTotalAmount(double subTotalAmount) {
        this.subTotalAmount = subTotalAmount;
    }

    public double getShippingCharge() {
        return shippingCharge;
    }

    public void setShippingCharge(double shippingCharge) {
        this.shippingCharge = shippingCharge;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Integer getPromoCodeId() {
        return promoCodeId;
    }

    public void setPromoCodeId(Integer promoCodeId) {
        this.promoCodeId = promoCodeId;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }


    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", subTotalAmount=" + subTotalAmount +
                ", shippingCharge=" + shippingCharge +
                ", discountAmount=" + discountAmount +
                ", totalAmount=" + totalAmount +
                ", promoCodeId=" + promoCodeId +
                ", orderStatus='" + orderStatus + '\'' +
                ", userId=" + userId +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", orderItems=" + orderItems +
                '}';
    }
}