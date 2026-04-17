package com.neospark.neohub.dao;

import java.util.List;
import com.neospark.neohub.model.Category;

public interface CategoryDao {
    // CRUD
    boolean addCategory(Category category);
    boolean updateCategory(Category category);
    boolean deleteCategory(int id);
    
    // Fetch
    Category getCategoryById(int id);
    List<Category> getAllCategories();
    List<Category> getActiveCategories();
    
    // Dashboard
    int getTotalCategoryCount();
    
    // Check
    boolean isCategoryNameExists(String name);
}