package com.neospark.neohub.controller.filter;

import java.io.IOException;

import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * The type Auth filter.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    // public pages anayone can access
    private static final String[] PUBLIC_PAGES = {
        "/", "/home", "/products", "/product-detail", "/about", "/contact",
        "/login", "/register", "/forgot-password", "/reset-password", "/verify-email",
        "/error"
    };

    // user only pages
    private static final String[] USER_PREFIXES = {
        "/cart", "/checkout", "/place-order", "/order-history",
        "/order-success", "/profile", "/khalti/", "/order-failure"
    };

    // checking if the path is in public pages
    private boolean isPublicPage(String path) {
        for (String p : PUBLIC_PAGES) {
            if (p.equals(path)) return true;
        }
        return false;
    }
    // checking if path is user
    private boolean isUserPage(String path) {
        for (String prefix : USER_PREFIXES) {
            if (path.startsWith(prefix)) return true;
        }
        return false;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // allowing static file
        if (path.startsWith("/static/") || path.startsWith("/uploads/") || path.startsWith("/assets/")) {
            chain.doFilter(request, response);
            return;
        }

        // allowing logout page
        if (path.equals("/logout")) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) SessionUtil.getAttribute(req, "user");
        boolean isLoggedIn = (user != null);
        boolean isAdmin = isLoggedIn && user.isAdmin();

        // allowing admin to access admin pages only
        if (isAdmin) {
            if (path.startsWith("/admin/")) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            }
            return;
        }

        // prevent logged  in user to access login and register page
        if (isLoggedIn && (path.equals("/login") || path.equals("/register"))) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // user pages and admin pages require auth
        boolean needsAuth = isUserPage(path) || path.startsWith("/admin/");

        // here not logged in user trying to access user page or admin page
        if (!isLoggedIn && needsAuth) {
            req.getSession().setAttribute("redirectAfterLogin", path);
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (isLoggedIn && path.startsWith("/admin/")) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin area only");
            return;
        }

        if (isPublicPage(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        chain.doFilter(request, response);
    }
}