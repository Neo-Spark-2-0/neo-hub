package com.neospark.neohub.controller.user;

import com.neospark.neohub.dao.*;
import com.neospark.neohub.model.*;
import com.neospark.neohub.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();
    private final PromoCodeDao promoCodeDao = new PromoCodeDaoImpl();

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

        if ("true".equals(request.getParameter("removePromo"))) {
            SessionUtil.removeAttribute(request, "appliedPromoCode");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        buildCheckoutAttributes(request, user, cartItems);
        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp")
                .forward(request, response);
    }

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
                SessionUtil.setAttribute(request, "appliedPromoCode", promoCode);
                request.setAttribute("promoSuccess",
                        promoCode.getDiscountPercent() + "% discount applied successfully!");
            }
        }

        buildCheckoutAttributes(request, user, cartItems);
        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp")
                .forward(request, response);
    }

    private void buildCheckoutAttributes(HttpServletRequest request, User user, List<Cart> cartItems) {
        double subTotal = 0.0;
        for (Cart item : cartItems) {
            double price = item.getProductDiscountPrice() > 0 ? item.getProductDiscountPrice() : item.getProductPrice();
            subTotal += price * item.getQuantity();
        }
        double shippingCharge = 100.00;
        double discountAmount = 0.0;
        PromoCode promoCode = (PromoCode) SessionUtil.getAttribute(request, "appliedPromoCode");
    // validating promocode right or wrong because it should be checked before applying discount everytime
        if (promoCode != null) {
            if (!promoCode.isActive() || promoCode.getExpiryDate().isBefore(LocalDate.now())) {
                SessionUtil.removeAttribute(request, "appliedPromoCode");
                promoCode = null;
            }
        }
        if (promoCode != null) {
            discountAmount = subTotal * (promoCode.getDiscountPercent() / 100);
        }

        double total = subTotal + shippingCharge - discountAmount;

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subTotal", subTotal);
        request.setAttribute("shippingCharge", shippingCharge);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("total", total);
        request.setAttribute("user", user);
    }
}