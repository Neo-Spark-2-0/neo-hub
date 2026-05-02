package com.neospark.neohub.controller.admin;

import com.neospark.neohub.dao.PromoCodeDao;
import com.neospark.neohub.dao.PromoCodeDaoImpl;
import com.neospark.neohub.model.PromoCode;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/admin/promos")
public class AdminPromoServlet extends HttpServlet {

    private final PromoCodeDao promoCodeDao = new PromoCodeDaoImpl();

    // ── GET ────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        handleFlashMessages(req);
        List<PromoCode> promos = promoCodeDao.getAllPromoCodes();
        req.setAttribute("promoList", promos);
        req.getRequestDispatcher("/WEB-INF/views/admin/promos.jsp")
           .forward(req, resp);
    }

    // ── POST ───────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "insert" -> insertPromo(req);
                case "delete" -> deletePromo(req);
                case "update" -> updatePromo(req);
                case "toggleStatus" -> toggleStatus(req);
                default -> req.getSession()
                              .setAttribute("error", "Unknown action.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error",
                "An error occurred: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/promos");
    }

    // ── INSERT ─────────────────────────────────────────────────────────────
    private void insertPromo(HttpServletRequest req) {

        String code          = req.getParameter("code");
        String discountStr   = req.getParameter("discountPercent");
        String expiryStr     = req.getParameter("expiry");

        // Validation
        if (isNullOrEmpty(code)) {
            req.getSession().setAttribute("error", "Promo code is required.");
            return;
        }

        // Duplicate check
        PromoCode existing = promoCodeDao.getPromoCodeByCode(code.trim());
        if (existing != null) {
            req.getSession().setAttribute("error",
                "Promo code '" + code + "' already exists.");
            return;
        }

        double discountPercent = 0;
        try {
            discountPercent = Double.parseDouble(discountStr);
            if (discountPercent <= 0 || discountPercent > 100) {
                req.getSession().setAttribute("error",
                    "Discount must be between 1 and 100.");
                return;
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error",
                "Invalid discount value.");
            return;
        }

        LocalDate expiryDate;
        try {
            // HTML date input gives "yyyy-MM-dd"
            expiryDate = LocalDate.parse(expiryStr);
            if (expiryDate.isBefore(LocalDate.now())) {
                req.getSession().setAttribute("error",
                    "Expiry date cannot be in the past.");
                return;
            }
        } catch (DateTimeParseException e) {
            req.getSession().setAttribute("error",
                "Invalid expiry date format.");
            return;
        }

        PromoCode promo = new PromoCode();
        promo.setCode(code.trim().toUpperCase());
        promo.setDiscountPercent(discountPercent);
        promo.setExpiryDate(expiryDate);
        promo.setActive(true);

        boolean success = promoCodeDao.addPromoCode(promo);
        req.getSession().setAttribute(
            success ? "success" : "error",
            success ? "Promo code created successfully."
                    : "Failed to create promo code."
        );
    }

    // ── UPDATE ─────────────────────────────────────────────────────────────
    private void updatePromo(HttpServletRequest req) {

        int id = parseId(req.getParameter("id"));
        if (id <= 0) {
            req.getSession().setAttribute("error", "Invalid promo ID.");
            return;
        }

        PromoCode existing = promoCodeDao.getPromoCodeById(id);
        if (existing == null) {
            req.getSession().setAttribute("error", "Promo code not found.");
            return;
        }

        String code        = req.getParameter("code");
        String discountStr = req.getParameter("discountPercent");
        String expiryStr   = req.getParameter("expiry");

        if (isNullOrEmpty(code)) {
            req.getSession().setAttribute("error", "Promo code is required.");
            return;
        }

        // Duplicate check — skip current promo
        PromoCode duplicate = promoCodeDao.getPromoCodeByCode(code.trim());
        if (duplicate != null && duplicate.getId() != id) {
            req.getSession().setAttribute("error",
                "Promo code '" + code + "' already exists.");
            return;
        }

        double discountPercent;
        try {
            discountPercent = Double.parseDouble(discountStr);
            if (discountPercent <= 0 || discountPercent > 100) {
                req.getSession().setAttribute("error",
                    "Discount must be between 1 and 100.");
                return;
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", "Invalid discount value.");
            return;
        }

        LocalDate expiryDate;
        try {
            expiryDate = LocalDate.parse(expiryStr);
        } catch (DateTimeParseException e) {
            req.getSession().setAttribute("error", "Invalid expiry date.");
            return;
        }

        existing.setCode(code.trim().toUpperCase());
        existing.setDiscountPercent(discountPercent);
        existing.setExpiryDate(expiryDate);

        boolean success = promoCodeDao.updatePromoCode(existing);
        req.getSession().setAttribute(
            success ? "success" : "error",
            success ? "Promo code updated successfully."
                    : "Failed to update promo code."
        );
    }

    // ── DELETE ─────────────────────────────────────────────────────────────
    private void deletePromo(HttpServletRequest req) {

        int id = parseId(req.getParameter("id"));
        if (id <= 0) {
            req.getSession().setAttribute("error", "Invalid promo ID.");
            return;
        }

        boolean success = promoCodeDao.deletePromoCode(id);
        req.getSession().setAttribute(
            success ? "success" : "error",
            success ? "Promo code deleted successfully."
                    : "Failed to delete promo code."
        );
    }

    // ── TOGGLE STATUS ──────────────────────────────────────────────────────
    private void toggleStatus(HttpServletRequest req) {

        int id = parseId(req.getParameter("id"));
        if (id <= 0) {
            req.getSession().setAttribute("error", "Invalid promo ID.");
            return;
        }

        PromoCode promo = promoCodeDao.getPromoCodeById(id);
        if (promo == null) {
            req.getSession().setAttribute("error", "Promo code not found.");
            return;
        }

        boolean success = promoCodeDao.updateStatus(id, !promo.isActive());
        req.getSession().setAttribute(
            success ? "success" : "error",
            success ? "Promo status updated."
                    : "Failed to update promo status."
        );
    }

    // ── HELPERS ────────────────────────────────────────────────────────────
    private void handleFlashMessages(HttpServletRequest req) {
        HttpSession session = req.getSession();
        req.setAttribute("success", session.getAttribute("success"));
        req.setAttribute("error",   session.getAttribute("error"));
        session.removeAttribute("success");
        session.removeAttribute("error");
    }

    private int parseId(String val) {
        try { return Integer.parseInt(val); }
        catch (Exception e) { return 0; }
    }

    private boolean isNullOrEmpty(String val) {
        return val == null || val.trim().isEmpty();
    }
}