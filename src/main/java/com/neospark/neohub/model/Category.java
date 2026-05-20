package com.neospark.neohub.model;

import java.sql.Timestamp;

/**
 * The type Category.
 */
public class Category {


    private int id;
    private String name;
    private String description;
    private String image;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    /**
     * Instantiates a new Category.
     */
// Constructors
    public Category() {}

    /**
     * Instantiates a new Category.
     *
     * @param id          the id
     * @param name        the name
     * @param description the description
     * @param image       the image
     * @param isActive    the is active
     * @param createdAt   the created at
     * @param updatedAt   the updated at
     */
    public Category(int id, String name, String description, String image, boolean isActive, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    /**
     * Gets id.
     *
     * @return the id
     */
// Getters & Setters
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

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", image='" + image + '\'' +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
