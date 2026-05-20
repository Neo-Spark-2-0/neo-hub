package com.neospark.neohub.model;

import java.sql.Timestamp;
import java.util.List;

/**
 * The type Order.
 */
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

    

    // get from user table using left join
    private String userFullName;
    private String userPhone;
    private String userAddress;

    // get from promocode table using left join
    private String paymentMethod;
    private String paymentStatus;
    private String transactionId;


    /**
     * Instantiates a new Order.
     */
// constructors
    public Order() {}

    /**
     * Instantiates a new Order.
     *
     * @param id             the id
     * @param subTotalAmount the sub total amount
     * @param shippingCharge the shipping charge
     * @param discountAmount the discount amount
     * @param totalAmount    the total amount
     * @param promoCodeId    the promo code id
     * @param orderStatus    the order status
     * @param userId         the user id
     * @param createdAt      the created at
     * @param updatedAt      the updated at
     * @param orderItems     the order items
     */
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
     * Gets sub total amount.
     *
     * @return the sub total amount
     */
    public double getSubTotalAmount() {
        return subTotalAmount;
    }

    /**
     * Sets sub total amount.
     *
     * @param subTotalAmount the sub total amount
     */
    public void setSubTotalAmount(double subTotalAmount) {
        this.subTotalAmount = subTotalAmount;
    }

    /**
     * Gets shipping charge.
     *
     * @return the shipping charge
     */
    public double getShippingCharge() {
        return shippingCharge;
    }

    /**
     * Sets shipping charge.
     *
     * @param shippingCharge the shipping charge
     */
    public void setShippingCharge(double shippingCharge) {
        this.shippingCharge = shippingCharge;
    }

    /**
     * Gets discount amount.
     *
     * @return the discount amount
     */
    public double getDiscountAmount() {
        return discountAmount;
    }

    /**
     * Sets discount amount.
     *
     * @param discountAmount the discount amount
     */
    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    /**
     * Gets total amount.
     *
     * @return the total amount
     */
    public double getTotalAmount() {
        return totalAmount;
    }

    /**
     * Sets total amount.
     *
     * @param totalAmount the total amount
     */
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    /**
     * Gets promo code id.
     *
     * @return the promo code id
     */
    public Integer getPromoCodeId() {
        return promoCodeId;
    }

    /**
     * Sets promo code id.
     *
     * @param promoCodeId the promo code id
     */
    public void setPromoCodeId(Integer promoCodeId) {
        this.promoCodeId = promoCodeId;
    }

    /**
     * Gets order status.
     *
     * @return the order status
     */
    public String getOrderStatus() {
        return orderStatus;
    }

    /**
     * Sets order status.
     *
     * @param orderStatus the order status
     */
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
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
     * Gets order items.
     *
     * @return the order items
     */
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    /**
     * Sets order items.
     *
     * @param orderItems the order items
     */
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    /**
     * Gets user full name.
     *
     * @return the user full name
     */
    public String getUserFullName() {
        return userFullName;
    }

    /**
     * Sets user full name.
     *
     * @param userFullName the user full name
     */
    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    /**
     * Gets user phone.
     *
     * @return the user phone
     */
    public String getUserPhone() {
        return userPhone;
    }

    /**
     * Sets user phone.
     *
     * @param userPhone the user phone
     */
    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    /**
     * Gets user address.
     *
     * @return the user address
     */
    public String getUserAddress() {
        return userAddress;
    }

    /**
     * Sets user address.
     *
     * @param userAddress the user address
     */
    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    /**
     * Gets payment method.
     *
     * @return the payment method
     */
    public String getPaymentMethod() {
        return paymentMethod;
    }

    /**
     * Sets payment method.
     *
     * @param paymentMethod the payment method
     */
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    /**
     * Gets payment status.
     *
     * @return the payment status
     */
    public String getPaymentStatus() {
        return paymentStatus;
    }

    /**
     * Sets payment status.
     *
     * @param paymentStatus the payment status
     */
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    /**
     * Gets transaction id.
     *
     * @return the transaction id
     */
    public String getTransactionId() {
        return transactionId;
    }

    /**
     * Sets transaction id.
     *
     * @param transactionId the transaction id
     */
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
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
                ", userFullName='" + userFullName + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", userAddress='" + userAddress + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", transactionId='" + transactionId + '\'' +
                '}';
    }
}