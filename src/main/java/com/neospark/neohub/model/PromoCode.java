package com.neospark.neohub.model;


import java.sql.Timestamp;
import java.time.LocalDate;

/**
 * The type Promo code.
 */
public class PromoCode {
    private int id;
    private String code;
    private double discountPercent;
    private LocalDate expiryDate;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    /**
     * Instantiates a new Promo code.
     */
    public PromoCode() {}

    /**
     * Instantiates a new Promo code.
     *
     * @param id              the id
     * @param code            the code
     * @param discountPercent the discount percent
     * @param expiryDate      the expiry date
     * @param isActive        the is active
     * @param createdAt       the created at
     * @param updatedAt       the updated at
     */
    public PromoCode(int id, String code, double discountPercent, LocalDate expiryDate, boolean isActive, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.code = code;
        this.discountPercent = discountPercent;
        this.expiryDate = expiryDate;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
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
     * Gets code.
     *
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * Sets code.
     *
     * @param code the code
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * Gets discount percent.
     *
     * @return the discount percent
     */
    public double getDiscountPercent() {
        return discountPercent;
    }

    /**
     * Sets discount percent.
     *
     * @param discountPercent the discount percent
     */
    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    /**
     * Gets expiry date.
     *
     * @return the expiry date
     */
    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    /**
     * Sets expiry date.
     *
     * @param expiryDate the expiry date
     */
    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
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
     * Gets expiry date formatted.
     *
     * @return the expiry date formatted
     */
    public String getExpiryDateFormatted() {
        return expiryDate != null ? expiryDate.toString() : "";
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
