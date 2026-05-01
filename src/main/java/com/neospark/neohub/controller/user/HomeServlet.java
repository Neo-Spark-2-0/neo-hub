package com.neospark.neohub.controller.user;

import java.io.IOException;
import java.util.List;

import com.neospark.neohub.dao.CategoryDao;
import com.neospark.neohub.dao.CategoryDaoImpl;
import com.neospark.neohub.dao.ProductDao;
import com.neospark.neohub.dao.ProductDaoImpl;
import com.neospark.neohub.model.Category;
import com.neospark.neohub.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({"/home", "/"})
public class HomeServlet extends HttpServlet{
    private final ProductDao  productDao  = new ProductDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Product>  featuredProducts = productDao.getFeaturedProducts();
        List<Product>  recentProducts = productDao.getRecentProducts(8);
        List<Category> categories = categoryDao.getActiveCategories();
 
        req.setAttribute("featuredProducts", featuredProducts);
        req.setAttribute("recentProducts", recentProducts);
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/WEB-INF/views/user/home.jsp").forward(req, resp);
    }
}
