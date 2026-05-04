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
 
@WebServlet("/products")
public class ProductServlet extends HttpServlet {
 
    private final ProductDao  productDao  = new ProductDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();
    private static final int PAGE_SIZE = 9;
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        try {
            String keyword  = request.getParameter("keyword");
            String catParam = request.getParameter("categoryId");
            String pageParam = request.getParameter("page");
            String sortBy = request.getParameter("sortBy");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            String partialParam = request.getParameter("partial");
            boolean isPartial;
            if (partialParam != null && partialParam.equalsIgnoreCase("true")) {
                isPartial = true;
            } else {
                isPartial = false;
            }

            // we make null because empty string can cause issues in SQL queries, and we want to treat it as no filter and if null then sql query will ignore it and give all products
            // if we pass null to sql query then it will ignore that filter and give all products but if we pass empty string then it will try to find products with empty name which will return no products
            if (keyword != null && keyword.trim().isEmpty()) {
                keyword = null;
            }

            int categoryId;
            if (catParam != null && !catParam.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(catParam);
                } catch (NumberFormatException e) {
                    categoryId = 0;
                }
            } else {
                categoryId = 0;
            }

            int page;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            } else {
                page = 1;
            }

            if (page < 1) page = 1;
 
            Double minPrice = null, maxPrice = null;
            try { 
                if (minPriceStr != null && !minPriceStr.isEmpty()){
                    minPrice = Double.parseDouble(minPriceStr); 
                }     
            } catch (NumberFormatException ignored) {
                // not setting again because it is already null and we want to treat it as no filter
            }

            try { 
                if (maxPriceStr != null && !maxPriceStr.isEmpty()){
                    maxPrice = Double.parseDouble(maxPriceStr); 
                }
            } catch (NumberFormatException ignored) {
                // not setting again because it is already null and we want to treat it as no filter
            }
 
            // calculating offset for pagination, for page 1 offset will be 0, for page 2 offset will be 9 and so on, because we are showing 9 products per page
            // if offset if 1, then it will skip 1 and start from 2 
            int offset = (page - 1) * PAGE_SIZE;

            List<Product>  products = productDao.getProductsPaginated(offset, PAGE_SIZE, keyword, categoryId, sortBy, minPrice, maxPrice,false);

            int totalProducts = productDao.getProductCount(keyword, categoryId, minPrice, maxPrice,false);

            int totalPages = totalProducts / PAGE_SIZE;
            if (totalProducts % PAGE_SIZE != 0) {
                totalPages++;
            }

            List<Category> categories = categoryDao.getActiveCategories();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("keyword", keyword);
            request.setAttribute("categoryId", categoryId);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);

            if (isPartial) {
                request.getRequestDispatcher("/WEB-INF/views/user/components/product-grid.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/views/user/products.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}