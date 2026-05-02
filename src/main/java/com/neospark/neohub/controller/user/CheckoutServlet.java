package com.neospark.neohub.controller.user;

import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDao      cartDao      = new CartDaoImpl();
    private final PromoCodeDao promoCodeDao = new PromoCodeDaoImpl();

    // ── GET: show checkout page or remove promo ──
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Cart> cartItems = cartDao.getCartByUser(user.getId());

        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Remove promo code if requested
        if ("true".equals(request.getParameter("removePromo"))) {
            request.getSession().removeAttribute("appliedPromoCode");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        buildCheckoutAttributes(request, user, cartItems);
        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp")
                .forward(request, response);
    }

    // ── POST: apply promo code ──
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Cart> cartItems = cartDao.getCartByUser(user.getId());
        String codeInput = request.getParameter("promoCode");

        if (codeInput != null && !codeInput.trim().isEmpty()) {
            PromoCode promoCode = promoCodeDao.getPromoCodeByCode(codeInput.trim().toUpperCase());

            if (promoCode == null) {
                request.setAttribute("promoError", "Promo code not found.");
            } else if (!promoCode.isActive()) {
                request.setAttribute("promoError", "This promo code is inactive.");
            } else if (promoCode.getExpiryDate().isBefore(LocalDate.now())) {
                request.setAttribute("promoError", "This promo code has expired.");
            } else {
                // Valid — save to session
                request.getSession().setAttribute("appliedPromoCode", promoCode);
                request.setAttribute("promoSuccess",
                        promoCode.getDiscountPercent() + "% discount applied successfully!");
            }
        }

        buildCheckoutAttributes(request, user, cartItems);
        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp")
                .forward(request, response);
    }

    // ── Shared helper — calculates totals and sets request attributes ──
    private void buildCheckoutAttributes(HttpServletRequest request, User user, List<Cart> cartItems) {
        double subTotal = cartItems.stream()
                .mapToDouble(item -> (item.getProductDiscountPrice() > 0
                        ? item.getProductDiscountPrice()
                        : item.getProductPrice()) * item.getQuantity())
                .sum();

        double shippingCharge = 100.00;
        double discountAmount = 0.0;

        PromoCode promoCode = (PromoCode) request.getSession().getAttribute("appliedPromoCode");
        if (promoCode != null) {
            discountAmount = subTotal * (promoCode.getDiscountPercent() / 100);
        }

        double total = subTotal + shippingCharge - discountAmount;

        request.setAttribute("cartItems",      cartItems);
        request.setAttribute("subTotal",       subTotal);
        request.setAttribute("shippingCharge", shippingCharge);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("total",          total);
        request.setAttribute("user",           user);
    }
}