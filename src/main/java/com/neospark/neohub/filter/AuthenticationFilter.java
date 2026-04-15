package com.neospark.neohub.filter;

import java.io.IOException;

import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter("/abc/*")
public class AuthenticationFilter implements Filter {

    private static final String[] PUBLIC_URLS = {
            "/login",
            "/register",
            "/static/",
            "/error/"
    };

    private static final String[] AUTH_URLS = {
            "/login",
            "/register"
    };
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
//     ---------------------  not implented properly ------------------
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());
        boolean isLoggedIn = SessionUtil.isLoggedIn(req);

        if (isLoggedIn && isAuthURL(path)) {
            redirectByRole(req, resp);
            return;
        }

        if (!isLoggedIn && !isPublicURL(path)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        chain.doFilter(req, resp);
    }


    private void redirectByRole(HttpServletRequest req,
                                HttpServletResponse resp) throws IOException {
        String role = SessionUtil.getUserRole(req);
        if ("ADMIN".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    private boolean isPublicURL(String path) {
        for (String url : PUBLIC_URLS) {
            if (path.startsWith(url)) return true;
        }
        return false;
    }

    private boolean isAuthURL(String path) {
        for (String url : AUTH_URLS) {
            if (path.startsWith(url)) return true;
        }
        return false;
    }
}
