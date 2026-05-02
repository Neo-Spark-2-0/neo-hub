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
            String pageParam= request.getParameter("page");
            String sortBy   = request.getParameter("sortBy");
            String minPStr  = request.getParameter("minPrice");
            String maxPStr  = request.getParameter("maxPrice");

            boolean isPartial = "true".equals(request.getParameter("partial"));
 
            if (keyword != null && keyword.trim().isEmpty()) keyword = null;
 
            int categoryId = (catParam  != null && !catParam.isEmpty())  ? Integer.parseInt(catParam)  : 0;
            int page = (pageParam != null && !pageParam.isEmpty())  ? Integer.parseInt(pageParam) : 1;
            if (page < 1) page = 1;
 
            Double minPrice = null, maxPrice = null;
            try { if (minPStr != null && !minPStr.isEmpty()) minPrice = Double.parseDouble(minPStr); } catch (NumberFormatException ignored) {}
            try { if (maxPStr != null && !maxPStr.isEmpty()) maxPrice = Double.parseDouble(maxPStr); } catch (NumberFormatException ignored) {}
 
            int offset = (page - 1) * PAGE_SIZE;

            List<Product>  products = productDao.getProductsPaginated(offset, PAGE_SIZE, keyword, categoryId, sortBy, minPrice, maxPrice);
            int totalProducts = productDao.getProductCount(keyword, categoryId, minPrice, maxPrice);
            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
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
                request.getRequestDispatcher("/WEB-INF/views/user/components/product-grid.jsp")
                        .forward(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/views/user/products.jsp")
                        .forward(request, response);
            }
 
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}