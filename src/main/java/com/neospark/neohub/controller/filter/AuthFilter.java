// package com.neospark.neohub.controller.filter;

// import com.neospark.neohub.model.User;
// import jakarta.servlet.*;
// import jakarta.servlet.annotation.WebFilter;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;
// import jakarta.servlet.http.HttpSession;

// import java.io.IOException;
// import java.util.Set;

// @WebFilter("/*")
// public class AuthFilter implements Filter {

//     /**
//      * Fully public — no login needed at all.
//      * Note: query strings (?id=1) are NOT part of getRequestURI(),
//      * so just list the base path here (e.g. /product-detail, not /product-detail?id=1).
//      */
//     private static final Set<String> PUBLIC_PATHS = Set.of(
//         "", "/", "/home",
//         "/products", "/product-detail",
//         "/about", "/contact",
//         "/login", "/register", "/verify-email",
//         "/cart-count"   // returns 0 for guests, actual count for logged-in users
//     );

//     /**
//      * Prefixes that are always public (static files, uploads, error pages).
//      */
//     private static final Set<String> PUBLIC_PREFIXES = Set.of(
//         "/static/", "/assets/", "/uploads/", "/WEB-INF/", "/error"
//     );

//     /**
//      * USER role only — admin should not access these.
//      */
//     private static final Set<String> USER_ONLY_PATHS = Set.of(
//         "/cart", "/checkout", "/place-order",
//         "/order-history", "/order-success", "/order-failure",
//         "/khalti/initiate", "/khalti/verify"
//     );

//     /**
//      * Prefixes that are USER only (catches /khalti/* and /order-* in one go).
//      */
//     private static final Set<String> USER_ONLY_PREFIXES = Set.of(
//         "/khalti/", "/order-"
//     );

//     /** Admin prefix — ADMIN role only. */
//     private static final String ADMIN_PREFIX = "/admin";

//     /** Accessible by any logged-in user regardless of role. */
//     private static final Set<String> ANY_LOGGED_IN_PATHS = Set.of(
//         "/profile", "/logout"
//     );

//     @Override
//     public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//             throws IOException, ServletException {

//         HttpServletRequest  req  = (HttpServletRequest)  request;
//         HttpServletResponse res  = (HttpServletResponse) response;

//         String contextPath = req.getContextPath();
//         String path        = req.getRequestURI().substring(contextPath.length());

//         // Normalize trailing slash so /home/ == /home
//         if (path.length() > 1 && path.endsWith("/")) {
//             path = path.substring(0, path.length() - 1);
//         }

//         // ── 1. Always allow static resources and public prefixes ─────────────
//         for (String prefix : PUBLIC_PREFIXES) {
//             if (path.startsWith(prefix)) {
//                 chain.doFilter(request, response);
//                 return;
//             }
//         }

//         // ── 2. Always allow fully public paths ───────────────────────────────
//         if (PUBLIC_PATHS.contains(path)) {
//             chain.doFilter(request, response);
//             return;
//         }

//         // ── 3. Resolve session user ──────────────────────────────────────────
//         HttpSession session = req.getSession(false);
//         User user = (session != null) ? (User) session.getAttribute("user") : null;

//         // ── 4. Redirect already-logged-in users away from login/register ─────
//         if (user != null && (path.equals("/login") || path.equals("/register"))) {
//             if ("ADMIN".equals(user.getRole())) {
//                 res.sendRedirect(contextPath + "/admin/dashboard");
//             } else {
//                 res.sendRedirect(contextPath + "/home");
//             }
//             return;
//         }

//         // ── 5. Classify this path ────────────────────────────────────────────
//         boolean isAdminPath    = path.startsWith(ADMIN_PREFIX);
//         boolean isUserOnlyPath = USER_ONLY_PATHS.contains(path)
//                 || USER_ONLY_PREFIXES.stream().anyMatch(path::startsWith);
//         boolean isAnyLoginPath = ANY_LOGGED_IN_PATHS.contains(path);

//         // ── 6. Guest (not logged in) ─────────────────────────────────────────
//         if (user == null) {
//             if (isAdminPath || isUserOnlyPath || isAnyLoginPath) {
//                 // Save intended URL so login can redirect back after auth (optional)
//                 res.sendRedirect(contextPath + "/login");
//                 return;
//             }
//             // Unknown path + guest → 404 is better than silent allow
//             res.sendError(HttpServletResponse.SC_NOT_FOUND);
//             return;
//         }

//         // ── 7. Logged-in: role-based checks ──────────────────────────────────
//         String role = user.getRole(); // "USER" or "ADMIN"

//         // Admin pages
//         if (isAdminPath) {
//             if ("ADMIN".equals(role)) {
//                 chain.doFilter(request, response);
//             } else {
//                 res.sendRedirect(contextPath + "/home");
//             }
//             return;
//         }

//         // User-only pages
//         if (isUserOnlyPath) {
//             if ("USER".equals(role)) {
//                 chain.doFilter(request, response);
//             } else {
//                 // Admin should not use cart/checkout/orders — send to dashboard
//                 res.sendRedirect(contextPath + "/admin/dashboard");
//             }
//             return;
//         }

//         // Shared pages (profile, logout) — any logged-in role
//         if (isAnyLoginPath) {
//             chain.doFilter(request, response);
//             return;
//         }

//         // ── 8. Unknown path + logged-in user → 404, not silent allow ─────────
//         res.sendError(HttpServletResponse.SC_NOT_FOUND);
//     }
// }