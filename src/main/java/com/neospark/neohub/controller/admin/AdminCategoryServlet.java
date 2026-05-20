package com.neospark.neohub.controller.admin;

import com.neospark.neohub.dao.CategoryDao;
import com.neospark.neohub.dao.CategoryDaoImpl;
import com.neospark.neohub.model.Category;
import com.neospark.neohub.utils.ImageUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * The type Admin category servlet.
 */
@WebServlet("/admin/categories")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)

public class AdminCategoryServlet extends HttpServlet {

    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        handleFlashMessages(req);
switch (action != null ? action : "") {

            case "add" -> {
                req.getRequestDispatcher("/WEB-INF/views/admin/add-category.jsp")
                   .forward(req, resp);
            }

            case "edit" -> {
                int id = parseId(req.getParameter("id"));
                if (id <= 0) {
                    req.getSession().setAttribute("error", "Invalid category ID.");
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                    return;
                }
                Category category = categoryDao.getCategoryById(id);
                if (category == null) {
                    req.getSession().setAttribute("error", "Category not found.");
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                    return;
                }
                req.setAttribute("category", category);
                req.getRequestDispatcher("/WEB-INF/views/admin/edit-category.jsp")
                   .forward(req, resp);
            }

            default -> {
                req.setAttribute("categoryList", categoryDao.getAllCategories());
                req.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp")
                   .forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String action = req.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "insert" -> saveCategory(req, true);
                case "update" -> saveCategory(req, false);
                case "delete" -> {
                    int id = parseId(req.getParameter("id"));
                    if (id <= 0) {
                        req.getSession().setAttribute("error", "Invalid category ID.");
                    } else {
                       
                        Category cat = categoryDao.getCategoryById(id);
                        if (cat != null && cat.getImage() != null && !cat.getImage().isEmpty()) {
                            ImageUploadUtil.deleteImage(cat.getImage());
                        }
                        if (categoryDao.deleteCategory(id)) {
                            req.getSession().setAttribute("success", "Category deleted successfully.");
                        } else {
                            req.getSession().setAttribute("error", "Failed to delete category.");
                        }
                    }
                }
                default -> req.getSession().setAttribute("error", "Unknown action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "An error occurred: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }

    private void saveCategory(HttpServletRequest req, boolean isNew) throws Exception {
        Category cat;
        if (isNew) {
            cat = new Category();
        } else {
            int id = parseId(req.getParameter("id"));
            cat = categoryDao.getCategoryById(id);
            if (cat == null) {
                req.getSession().setAttribute("error", "Category not found.");
                return;
            }
        }

        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            req.getSession().setAttribute("error", "Category name is required.");
            return;
        }

        // Check for duplicate name (skip current category on update)
        Category existing = categoryDao.getCategoryByName(name.trim());
        if (existing != null && (isNew || existing.getId() != cat.getId())) {
            req.getSession().setAttribute("error", "A category with this name already exists.");
            return;
        }
        
        cat.setName(name.trim());
        cat.setDescription(req.getParameter("description"));
        cat.setActive(req.getParameter("isActive") != null);

        // Handle image upload
        String imagePath = ImageUploadUtil.uploadImage(req.getPart("image"), "categories");
        if (imagePath != null) {
            cat.setImage(imagePath);
        } else if (isNew) {
            // New category must have an image
            req.getSession().setAttribute("error", "Valid image is required (jpg, jpeg, png, webp).");
            return;
        }

        boolean success = isNew ? categoryDao.addCategory(cat) : categoryDao.updateCategory(cat);
        req.getSession().setAttribute(
            success ? "success" : "error",
            success ? "Category " + (isNew ? "added" : "updated") + " successfully."
                    : "Failed to " + (isNew ? "add" : "update") + " category."
        );
    }

    private void handleFlashMessages(HttpServletRequest req) {
        HttpSession session = req.getSession();
        req.setAttribute("success", session.getAttribute("success"));
        req.setAttribute("error", session.getAttribute("error"));
        session.removeAttribute("success");
        session.removeAttribute("error");
    }
    
    private int parseId(String val) {
        try { return Integer.parseInt(val); }
        catch (Exception e) { return 0; }
    }
}