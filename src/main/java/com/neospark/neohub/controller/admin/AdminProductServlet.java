package com.neospark.neohub.controller.admin;

import java.io.IOException;
import java.util.List;

import com.neospark.neohub.dao.ProductDao;
import com.neospark.neohub.dao.ProductDaoImpl;
import com.neospark.neohub.dao.CategoryDao;
import com.neospark.neohub.dao.CategoryDaoImpl;
import com.neospark.neohub.model.Product;
import com.neospark.neohub.model.Category;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private final ProductDao productDao = new ProductDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admin check(AdminFilter has this)
        User admin = (User) SessionUtil.getAttribute(req, "user");
        if (admin == null || !admin.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        if (action == null) {
            listProducts(req, resp);
        } else {
            switch (action) {
                case "add":
                    showAddForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteProduct(req, resp);
                    break;
                default:
                    listProducts(req, resp);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admin check (AdminFilter has this)
        User admin = (User) SessionUtil.getAttribute(req, "user");
        if (admin == null || !admin.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        switch (action) {
            case "insert":
                insertProduct(req, resp);
                break;
            case "update":
                updateProduct(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                break;
        }
    }

    // 📋 List all products
    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Product> products = productDao.getAllProducts();
        req.setAttribute("productList", products);

        req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);
    }

    // ➕ Show Add Form
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Category> categories = categoryDao.getAllCategories();
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(req, resp);
    }

    // ✏️ Show Edit Form
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productDao.getProductById(id);

        List<Category> categories = categoryDao.getAllCategories();

        req.setAttribute("product", product);
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/WEB-INF/views/admin/edit-product.jsp").forward(req, resp);
    }

    // ➕ Insert Product
    private void insertProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Product product = new Product();

        product.setName(req.getParameter("name"));
        product.setDescription(req.getParameter("description"));
        product.setPrice(Double.parseDouble(req.getParameter("price")));
        product.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        product.setStock(Integer.parseInt(req.getParameter("stock")));
        product.setImage(req.getParameter("image")); // or handle upload later

        productDao.addProduct(product);

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    //Update Product
    private void updateProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Product product = new Product();

        product.setId(Integer.parseInt(req.getParameter("id")));
        product.setName(req.getParameter("name"));
        product.setDescription(req.getParameter("description"));
        product.setPrice(Double.parseDouble(req.getParameter("price")));
        product.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        product.setStock(Integer.parseInt(req.getParameter("stock")));
        product.setImage(req.getParameter("image"));

        productDao.updateProduct(product);

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    //Delete Product
    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        productDao.deleteProduct(id);

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}