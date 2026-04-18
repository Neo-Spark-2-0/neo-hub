package com.neospark.neohub.controller.admin;

import com.neospark.neohub.dao.CategoryDao;
import com.neospark.neohub.dao.CategoryDaoImpl;
import com.neospark.neohub.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5)
public class AdminCategoryServlet extends HttpServlet {
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        handleFlashMessages(req);

        switch (action != null ? action : "") {
            case "add" -> req.getRequestDispatcher("/WEB-INF/views/admin/add-category.jsp").forward(req, resp);
            case "edit" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("category", categoryDao.getCategoryById(id));
                req.getRequestDispatcher("/WEB-INF/views/admin/edit-category.jsp").forward(req, resp);
            }
            default -> {
                req.setAttribute("categoryList", categoryDao.getAllCategories());
                req.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("insert".equals(action)) {
                saveCategory(req, resp, true);
            } else if ("update".equals(action)) {
                saveCategory(req, resp, false);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                categoryDao.deleteCategory(id);
                req.getSession().setAttribute("success", "Category deleted.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }

    private void saveCategory(HttpServletRequest req, HttpServletResponse resp, boolean isNew) throws Exception {
        Category cat = isNew ? new Category() : categoryDao.getCategoryById(Integer.parseInt(req.getParameter("id")));
        
        cat.setName(req.getParameter("name"));
        cat.setDescription(req.getParameter("description"));
        cat.setActive(req.getParameter("isActive") != null);

        Part filePart = req.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String path = getServletContext().getRealPath("/uploads/categories");
            File dir = new File(path);
            if (!dir.exists()) dir.mkdirs();
            filePart.write(path + File.separator + fileName);
            cat.setImage("uploads/categories/" + fileName);
        }

        if (isNew) categoryDao.addCategory(cat); else categoryDao.updateCategory(cat);
        req.getSession().setAttribute("success", "Category " + (isNew ? "added" : "updated"));
    }

    private void handleFlashMessages(HttpServletRequest req) {
        HttpSession session = req.getSession();
        req.setAttribute("success", session.getAttribute("success"));
        req.setAttribute("error", session.getAttribute("error"));
        session.removeAttribute("success");
        session.removeAttribute("error");
    }
}