package com.neospark.neohub.model;

import java.sql.Timestamp;

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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

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
