package com.neospark.neohub.controller.user;

 
import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.Product;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
 
@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {
 
    private final ProductDao productDao = new ProductDaoImpl();
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String idParam = request.getParameter("id");
 
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
 
        int id = Integer.parseInt(idParam);
        Product product = productDao.getProductById(id);
 
        if (product == null || !product.isActive()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
 
        List<Product> relatedProducts = productDao.getProductsByCategory(product.getCategoryId());

        for (Product p : relatedProducts) {
            if (p.getId() == product.getId()) {
                relatedProducts.remove(p);
                break;
            }
        }

 
        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);
 
        request.getRequestDispatcher("/WEB-INF/views/user/productDetail.jsp").forward(request, response);
    }
}