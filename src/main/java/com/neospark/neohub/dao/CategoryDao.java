package com.neospark.neohub.dao;

import java.util.List;
import com.neospark.neohub.model.Category;

/**
 * The interface Category dao.
 */
public interface CategoryDao {
    /**
     * Add category boolean.
     *
     * @param category the category
     * @return the boolean
     */
// CRUD
    boolean addCategory(Category category);

    /**
     * Update category boolean.
     *
     * @param category the category
     * @return the boolean
     */
    boolean updateCategory(Category category);

    /**
     * Update category image boolean.
     *
     * @param id        the id
     * @param imagePath the image path
     * @return the boolean
     */
    boolean updateCategoryImage(int id, String imagePath);

    /**
     * Update status boolean.
     *
     * @param id       the id
     * @param isActive the is active
     * @return the boolean
     */
    boolean updateStatus(int id, boolean isActive);

    /**
     * Delete category boolean.
     *
     * @param id the id
     * @return the boolean
     */
    boolean deleteCategory(int id);

    /**
     * Gets category by id.
     *
     * @param id the id
     * @return the category by id
     */
// fetch
    Category getCategoryById(int id);

    /**
     * Gets category by name.
     *
     * @param name the name
     * @return the category by name
     */
    Category getCategoryByName(String name);

    /**
     * Gets all categories.
     *
     * @return the all categories
     */
    List<Category> getAllCategories();

    /**
     * Gets active categories.
     *
     * @return the active categories
     */
    List<Category> getActiveCategories();

    /**
     * Gets total category count.
     *
     * @return the total category count
     */
// dashboard to get category count
    int getTotalCategoryCount();
}