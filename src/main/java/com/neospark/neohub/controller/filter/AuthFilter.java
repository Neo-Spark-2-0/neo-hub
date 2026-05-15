package com.neospark.neohub.controller.filter;
import com.neospark.neohub.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // Pages accessible without login (public)
    private static final Set<String> PUBLIC_PAGES = new HashSet<>(Arrays.asList(
        "", "/", "/home", "/products", "/product-detail", "/about", "/contact",
        "/login", "/register", "/verify-email", "/error"
    ));

    // Pages that require login (any logged-in user, regardless of role)
    private static final Set<String> LOGIN_REQUIRED_PAGES = new HashSet<>(Arrays.asList(
        "/cart", "/checkout", "/place-order", "/order-history", "/order-success", 
        "/order-failure", "/profile", "/khalti/initiate", "/khalti/verify"
    ));

    // Admin-only prefix
    private static final String ADMIN_PREFIX = "/admin/";

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // Allow static resources
        if (path.startsWith("/static/") || path.startsWith("/assets/") || path.startsWith("/uploads/")) {
            chain.doFilter(request, response);
            return;
        }

        // 1. Check public pages
        if (PUBLIC_PAGES.contains(path) || path.matches("/product-detail\\?.*")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Get logged-in user
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // 3. If accessing login/register while already logged in, redirect to home
        if (user != null && (path.equals("/login") || path.equals("/register"))) {
            res.sendRedirect(contextPath + "/home");
            return;
        }

        // 4. If not logged in and page requires login, redirect
        boolean requiresLogin = LOGIN_REQUIRED_PAGES.contains(path) || path.startsWith("/khalti/") || path.startsWith("/order-");
        if (user == null && requiresLogin) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        // 5. If logged in, check role-based access
        if (user != null) {
            String role = user.getRole(); // Should be "USER" or "ADMIN" (uppercase)

            // Admin-only pages
            if (path.startsWith(ADMIN_PREFIX)) {
                if ("ADMIN".equals(role)) {
                    chain.doFilter(request, response);
                } else {
                    res.sendRedirect(contextPath + "/home");
                }
                return;
            }

            // User pages (cart, profile, etc.) – allow both USER and ADMIN? Actually admin should NOT access user pages.
            // But profile is common. So we must restrict admin from user-only pages.
            if (requiresLogin && !path.equals("/profile")) {
                // These are user-only pages (cart, checkout, orders, khalti)
                if ("USER".equals(role)) {
                    chain.doFilter(request, response);
                } else {
                    // Admin trying to access user page – redirect to admin dashboard
                    res.sendRedirect(contextPath + "/admin/dashboard");
                }
                return;
            }

            // Profile page allowed for both roles
            if (path.equals("/profile")) {
                chain.doFilter(request, response);
                return;
            }
        }

        // 6. Default: allow (for any other paths not matched)
        chain.doFilter(request, response);
    }
}