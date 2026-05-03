package com.neospark.neohub.controller.user;

import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.Cart;
import com.neospark.neohub.model.Product;
import com.neospark.neohub.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();
    private final ProductDao productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        List<Cart> cartItems = cartDao.getCartByUser(user.getId());

        double grandTotal = 0.0;
        for (Cart item : cartItems) {
            double price = (item.getProductDiscountPrice() > 0) ? item.getProductDiscountPrice() : item.getProductPrice();
            grandTotal += price * item.getQuantity();
}

        request.setAttribute("cartItems",  cartItems);
        request.setAttribute("grandTotal", grandTotal);

        request.getRequestDispatcher("/WEB-INF/views/user/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        String action = request.getParameter("action");
        boolean isHtmx = "true".equals(request.getHeader("HX-Request"));

        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        if ("add".equals(action)) {
            int quantity = 1;
            try { quantity = Integer.parseInt(request.getParameter("quantity")); } catch (NumberFormatException ignored) {}

            Product product = productDao.getProductById(productId);

            if (product == null || !product.isActive() || product.getStock() < quantity) {
                if (isHtmx) {
                    // Return 422 — HTMX treats non-2xx as failed, JS shows error toast
                    response.setStatus(422);
                } else {
                    response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId + "&error=outofstock");
                }
                return;
            }

            Cart cart = new Cart();
            cart.setUserId(user.getId());
            cart.setProductId(productId);
            cart.setQuantity(quantity);
            cartDao.addToCart(cart);

            if (isHtmx) {
                // Get current quantity in cart to show correct number
                List<Cart> userCart = cartDao.getCartByUser(user.getId());
                int currentQty = userCart.stream()
                        .filter(c -> c.getProductId() == productId)
                        .mapToInt(Cart::getQuantity)
                        .findFirst()
                        .orElse(quantity);

                int maxStock = product.getStock();
                String contextPath = request.getContextPath();

                // Return HTML fragment — HTMX swaps this into #cartArea-{productId}
                response.setContentType("text/html;charset=UTF-8");
                response.setStatus(HttpServletResponse.SC_OK);
                PrintWriter out = response.getWriter();
                out.println(buildQtyControlHtml(productId, currentQty, maxStock, contextPath));
            } else {
                response.sendRedirect(request.getContextPath() + "/cart?success=added");
            }

        } else if ("update".equals(action)) {
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            if (quantity <= 0) {
                cartDao.removeFromCart(user.getId(), productId);

                if (isHtmx) {
                    // Return the original "Add to Cart" button HTML
                    response.setContentType("text/html;charset=UTF-8");
                    response.setStatus(HttpServletResponse.SC_OK);
                    PrintWriter out = response.getWriter();
                    out.println(buildAddToCartHtml(productId, request.getContextPath()));
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart");
                }
            } else {
                cartDao.updateQuantity(user.getId(), productId, quantity);

                if (isHtmx) {
                    Product product = productDao.getProductById(productId);
                    int maxStock = product != null ? product.getStock() : 99;
                    response.setContentType("text/html;charset=UTF-8");
                    response.setStatus(HttpServletResponse.SC_OK);
                    PrintWriter out = response.getWriter();
                    out.println(buildQtyControlHtml(productId, quantity, maxStock, request.getContextPath()));
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart");
                }
            }

        } else if ("remove".equals(action)) {
            cartDao.removeFromCart(user.getId(), productId);
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    // ─────────────────────────────────────────────
    // HTML fragment builders
    // ─────────────────────────────────────────────

    /**
     * Returns the quantity +/- control HTML after product is added to cart.
     * HTMX swaps this into #cartArea-{productId}
     */
    private String buildQtyControlHtml(int productId, int qty, int maxStock, String contextPath) {
        return
            "<div class='flex items-center justify-between gap-1 border border-accent rounded-xl px-2 py-1'>" +
                "<button " +
                    "hx-post='" + contextPath + "/cart' " +
                    "hx-vals='{\"action\":\"update\",\"productId\":\"" + productId + "\",\"quantity\":\"" + (qty - 1) + "\"}' " +
                    "hx-target='#cartArea-" + productId + "' " +
                    "hx-swap='innerHTML' " +
                    "hx-on::after-request='onCartAdded(event)' " +
                    "class='w-7 h-7 rounded-lg bg-gray-100 text-accent font-bold text-base hover:bg-gray-200 transition flex items-center justify-center'>" +
                    "−" +
                "</button>" +
                "<span class='text-xs font-bold text-accent px-1'>" + qty + " in cart</span>" +
                "<button " +
                    (qty >= maxStock ? "disabled " : "") +
                    "hx-post='" + contextPath + "/cart' " +
                    "hx-vals='{\"action\":\"update\",\"productId\":\"" + productId + "\",\"quantity\":\"" + (qty + 1) + "\"}' " +
                    "hx-target='#cartArea-" + productId + "' " +
                    "hx-swap='innerHTML' " +
                    "hx-on::after-request='onCartAdded(event)' " +
                    "class='w-7 h-7 rounded-lg bg-accent text-white font-bold text-base hover:opacity-90 transition flex items-center justify-center" +
                    (qty >= maxStock ? " opacity-40 cursor-not-allowed" : "") + "'>" +
                    "+" +
                "</button>" +
            "</div>";
    }

    /**
     * Returns the original Add to Cart button if quantity goes back to 0.
     */
    private String buildAddToCartHtml(int productId, String contextPath) {
        return
            "<button " +
                "hx-post='" + contextPath + "/cart' " +
                "hx-vals='{\"action\":\"add\",\"productId\":\"" + productId + "\",\"quantity\":\"1\"}' " +
                "hx-target='#cartArea-" + productId + "' " +
                "hx-swap='innerHTML' " +
                "hx-on::after-request='onCartAdded(event)' " +
                "class='w-full bg-accent text-white text-xs font-semibold py-2.5 rounded-xl hover:opacity-90 transition active:scale-95'>" +
                "<i class='fa-solid fa-cart-plus mr-1'></i> Add to Cart" +
            "</button>";
    }
}
