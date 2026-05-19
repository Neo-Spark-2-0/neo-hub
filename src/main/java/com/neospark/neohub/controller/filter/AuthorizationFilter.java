// package com.neospark.neohub.controller.filter;

// import java.io.IOException;

// import com.neospark.neohub.utils.SessionUtil;

// import jakarta.servlet.Filter;
// import jakarta.servlet.FilterChain;
// import jakarta.servlet.ServletException;
// import jakarta.servlet.ServletRequest;
// import jakarta.servlet.ServletResponse;
// import jakarta.servlet.annotation.WebFilter;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;

// @WebFilter("/abc/*")
// public class AuthorizationFilter implements Filter {
// //     ---------------------  not implented properly ------------------

//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        HttpServletRequest  req  = (HttpServletRequest)  request;
//        HttpServletResponse resp = (HttpServletResponse) response;

//        String role = SessionUtil.getUserRole(req);

//        if (!"ADMIN".equals(role)) {
//            resp.sendRedirect(req.getContextPath() + "/unauthorized");
//            return;
//        }
//        chain.doFilter(req, resp);
//    }
// }
