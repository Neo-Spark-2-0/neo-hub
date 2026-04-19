package com.neospark.neohub.model;


import java.sql.Timestamp;
import java.time.LocalDate;

public class PromoCode {
    private int id;
    private String code;
    private double discountPercent;
    private LocalDate expiryDate;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public PromoCode() {}

    public PromoCode(int id, String code, double discountPercent, LocalDate expiryDate, boolean isActive, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.code = code;
        this.discountPercent = discountPercent;
        this.expiryDate = expiryDate;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
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

    @Override
    public String toString() {
        return "PromoCode{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", discountPercent=" + discountPercent +
                ", expiryDate=" + expiryDate +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
