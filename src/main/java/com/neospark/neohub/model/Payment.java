package com.neospark.neohub.model;

import java.sql.Timestamp;

/**
 * The type Payment.
 */
public class Payment {
    private int id;
    private int orderId;
    private String method;
    private String transactionId;
    private double amount;
    private String status;
    private Timestamp paidAt;
    private Timestamp createdAt;
    private Timestamp updated_at;

    /**
     * Instantiates a new Payment.
     */
    public Payment() {}

    /**
     * Instantiates a new Payment.
     *
     * @param createdAt     the created at
     * @param id            the id
     * @param orderId       the order id
     * @param method        the method
     * @param transactionId the transaction id
     * @param amount        the amount
     * @param status        the status
     * @param paidAt        the paid at
     * @param updated_at    the updated at
     */
    public Payment(Timestamp createdAt, int id, int orderId, String method, String transactionId, double amount, String status, Timestamp paidAt, Timestamp updated_at) {
        this.createdAt = createdAt;
        this.id = id;
        this.orderId = orderId;
        this.method = method;
        this.transactionId = transactionId;
        this.amount = amount;
        this.status = status;
        this.paidAt = paidAt;
        this.updated_at = updated_at;
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
     * Gets method.
     *
     * @return the method
     */
    public String getMethod() {
        return method;
    }

    /**
     * Sets method.
     *
     * @param method the method
     */
    public void setMethod(String method) {
        this.method = method;
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

    /**
     * Gets amount.
     *
     * @return the amount
     */
    public double getAmount() {
        return amount;
    }

    /**
     * Sets amount.
     *
     * @param amount the amount
     */
    public void setAmount(double amount) {
        this.amount = amount;
    }

    /**
     * Gets status.
     *
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets status.
     *
     * @param status the status
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Gets paid at.
     *
     * @return the paid at
     */
    public Timestamp getPaidAt() {
        return paidAt;
    }

    /**
     * Sets paid at.
     *
     * @param paidAt the paid at
     */
    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
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
    public Timestamp getUpdated_at() {
        return updated_at;
    }

    /**
     * Sets updated at.
     *
     * @param updated_at the updated at
     */
    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", method='" + method + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", amount=" + amount +
                ", status='" + status + '\'' +
                ", paidAt=" + paidAt +
                ", createdAt=" + createdAt +
                ", updated_at=" + updated_at +
                '}';
    }
}
