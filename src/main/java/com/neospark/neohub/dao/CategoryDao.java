package com.neospark.neohub.dao;

import java.util.List;
import com.neospark.neohub.model.Category;

public interface CategoryDao {
    // CRUD
    boolean addCategory(Category category);
    boolean updateCategory(Category category);
    boolean updateCategoryImage(int id, String imagePath);
    boolean updateStatus(int id, boolean isActive);
    boolean deleteCategory(int id);
    
    // fetch
    Category getCategoryById(int id);
    Category getCategoryByName(String name);
    List<Category> getAllCategories();
    List<Category> getActiveCategories();
    
    // dashboard to get category count
    int getTotalCategoryCount();
    
    // checking is category exist
    boolean isCategoryNameExists(String name);
}