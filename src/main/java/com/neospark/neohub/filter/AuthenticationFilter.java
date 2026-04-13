package com.neospark.neohub.filter;

import com.neospark.neohub.utils.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/ac/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // Allow static resources (CSS, images, JS) through without login
        if (path.startsWith("/static/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "user") != null;
        boolean isAuthPage = "/login".equals(path) || "/register".equals(path);

        if (!isLoggedIn && !isAuthPage) {
            // Not logged in + trying to access protected page -> go to login
            res.sendRedirect(contextPath + "/login");
            return;
        }

        if (isLoggedIn && isAuthPage) {
            // Already logged in + trying to access login/register -> go to topics
            res.sendRedirect(contextPath + "/topic");
            return;
        }

        // All other cases: allow through
        chain.doFilter(request, response);
    }
}
