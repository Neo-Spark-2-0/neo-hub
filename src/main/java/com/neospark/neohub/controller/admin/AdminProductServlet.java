package com.neospark.neohub.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.neospark.neohub.dao.ProductDao;
import com.neospark.neohub.dao.ProductDaoImpl;
import com.neospark.neohub.dao.CategoryDao;
import com.neospark.neohub.dao.CategoryDaoImpl;
import com.neospark.neohub.model.Product;
import com.neospark.neohub.utils.ImageUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/products")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,          // 1 MB threshold before temp file
    maxFileSize = 1024 * 1024 * 5,            // 5 MB max file size
    maxRequestSize = 1024 * 1024 * 10         // 10 MB max request size
)
public class AdminProductServlet extends HttpServlet {

    private final ProductDao productDao = new ProductDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    private static final int PAGE_SIZE = 5;

    // GET
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // FLASH MESSAGES - Read from session and move to request scope
        HttpSession session = req.getSession();
        String successMsg = (String) session.getAttribute("success");
        String errorMsg = (String) session.getAttribute("error");
        
        if (successMsg != null) {
            req.setAttribute("success", successMsg);
            session.removeAttribute("success");
        }
        
        if (errorMsg != null) {
            req.setAttribute("error", errorMsg);
            session.removeAttribute("error");
        }

        // Handle old-style URL flash messages (backwards compatibility)
        if ("added".equals(req.getParameter("success"))) {
            req.setAttribute("success", "Product added successfully!");
        } else if ("updated".equals(req.getParameter("success"))) {
            req.setAttribute("success", "Product updated successfully!");
        } else if ("deleted".equals(req.getParameter("success"))) {
            req.setAttribute("success", "Product deleted successfully!");
        } else if ("true".equals(req.getParameter("error"))) {
            req.setAttribute("error", "An error occurred while processing.");
        }

        if (action == null) {
            listProducts(req, resp);
            return;
        }

        switch (action) {
            case "add":
                showAddForm(req, resp);
                break;
            case "edit":
                try {
                    showEditForm(req, resp);
                } catch (Exception e) {
                    throw new ServletException(e);
                }
                break;
            default:
                listProducts(req, resp);
        }
    }

    // LIST (Pagination + Search)
    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;

        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception ignored) {}

        String keyword = req.getParameter("search");
        int categoryId = 0;

        try {
            categoryId = Integer.parseInt(req.getParameter("categoryId"));
        } catch (Exception ignored) {}

        int offset = (page - 1) * PAGE_SIZE;

        List<Product> products = productDao.getProductsPaginated(offset, PAGE_SIZE, keyword, categoryId, null, null, null, false);
        int totalProducts = productDao.getProductCount(keyword, categoryId, null, null, false);

        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

        req.setAttribute("productList", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("search", keyword);
        req.setAttribute("categoryId", categoryId);
        req.setAttribute("categories", categoryDao.getAllCategories());

        req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);
    }

    // SHOW FORMS
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("categories", categoryDao.getAllCategories());
        req.getRequestDispatcher("/WEB-INF/views/admin/add-products.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = parseInt(req.getParameter("id"));
        
        if (id <= 0) {
            getSessionFlash(req).setAttribute("error", "Invalid product ID.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        Product product = productDao.getProductById(id);

        if (product == null) {
            getSessionFlash(req).setAttribute("error", "Product not found.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        req.setAttribute("product", product);
        req.setAttribute("categories", categoryDao.getAllCategories());
        req.getRequestDispatcher("/WEB-INF/views/admin/edit-product.jsp").forward(req, resp);
    }

    // POST
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("insert".equals(action)) {
                insertProduct(req, resp);
            } else if ("update".equals(action)) {
                updateProduct(req, resp);
            } else if ("delete".equals(action)) {  
                deleteProduct(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            getSessionFlash(req).setAttribute("error", "An error occurred: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    // INSERT
    private void insertProduct(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        Product product = extractProduct(req, null);

        // INPUT VALIDATION
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            req.setAttribute("error", "Product name is required.");
            showAddForm(req, resp);
            return;
        }

        if (product.getPrice() <= 0) {
            req.setAttribute("error", "Price must be greater than zero.");
            showAddForm(req, resp);
            return;
        }

        if (product.getStock() < 0) {
            req.setAttribute("error", "Stock cannot be negative.");
            showAddForm(req, resp);
            return;
        }

        productDao.addProduct(product);
        getSessionFlash(req).setAttribute("success", "Product added successfully!");
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    // UPDATE
    private void updateProduct(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        int id = parseInt(req.getParameter("id"));

        if (id <= 0) {
            getSessionFlash(req).setAttribute("error", "Invalid product ID.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        Product existing = productDao.getProductById(id);

        if (existing == null) {
            getSessionFlash(req).setAttribute("error", "Product not found.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        Product product = extractProduct(req, existing);
        product.setId(id);

        productDao.updateProduct(product);
        getSessionFlash(req).setAttribute("success", "Product updated successfully!");
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    // DELETE 
    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        int id = parseInt(req.getParameter("id"));

        if (id <= 0) {
            getSessionFlash(req).setAttribute("error", "Invalid product ID.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        // Get product info before deletion to delete image file
        Product product = productDao.getProductById(id);
        if (product == null) {
            getSessionFlash(req).setAttribute("error", "Product not found.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        // Delete the image file if it exists
        if (product.getImage() != null && !product.getImage().isEmpty()) {
            String filePath = getServletContext().getRealPath("/" + product.getImage());
            File file = new File(filePath);
            if (file.exists()) {
                file.delete();
            }
        }

        productDao.deleteProduct(id);
        getSessionFlash(req).setAttribute("success", "Product deleted successfully!");
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    // EXTRACT + IMAGE UPLOAD
    private Product extractProduct(HttpServletRequest req, Product existing)
            throws Exception {

        Product product = new Product();

        String name = req.getParameter("name");
        String description = req.getParameter("description");

        product.setName(name != null ? name.trim() : "");
        product.setDescription(description != null ? description.trim() : "");

        product.setPrice(parseDouble(req.getParameter("price")));
        product.setDiscountPrice(parseDouble(req.getParameter("discountPrice")));

        product.setStock(parseInt(req.getParameter("stock")));
        product.setCategoryId(parseInt(req.getParameter("categoryId")));

        product.setBrand(req.getParameter("brand"));
        product.setStockKeepingUnit(req.getParameter("sku"));

        product.setActive(req.getParameter("isActive") != null);
        product.setFeatured(req.getParameter("isFeatured") != null);

        // Image Handling
        Part filePart = req.getPart("image");

        String newImagePath = ImageUploadUtil.uploadImage(filePart, "products");

        if (newImagePath != null) {
            product.setImage(newImagePath);
        } else if (existing != null) {
            product.setImage(existing.getImage()); // Don't lose the old image if no new one is uploaded
        }

        return product;
    }

    // SAFE PARSING HELPERS
    private int parseInt(String val) {
        try {
            return Integer.parseInt(val);
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDouble(String val) {
        try {
            return Double.parseDouble(val);
        } catch (Exception e) {
            return 0.0;
        }
    }


    // HELPER - SESSION ACCESS
    private HttpSession getSessionFlash(HttpServletRequest req) {
        return req.getSession();
    }
}