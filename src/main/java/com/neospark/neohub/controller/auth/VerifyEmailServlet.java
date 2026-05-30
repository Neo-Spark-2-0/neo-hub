package com.neospark.neohub.controller.auth;

import java.io.IOException;

import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * The type Verify email servlet.
 */
@WebServlet("/verify-email")
public class VerifyEmailServlet extends HttpServlet {
    private final UserDao userDao = new UserDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");

        if (ValidationUtil.isNullOrEmpty(token)) {
            req.setAttribute("verifyStatus", "invalid");
            req.setAttribute("message", "Verification link is invalid or missing.");
            req.getRequestDispatcher("/WEB-INF/views/user/verify-email.jsp").forward(req, resp);
            return;
        }
          boolean verified = userDao.verifyEmailToken(token);

          if (verified) {
            req.setAttribute("verifyStatus", "success");
            req.setAttribute("message", "Your email has been verified! You can now log in.");
        } else {
            req.setAttribute("verifyStatus", "failed");
            req.setAttribute("message", "Invalid or already used verification link.");
        }

        req.getRequestDispatcher("/WEB-INF/views/user/verify-email.jsp").forward(req, resp);
    }
    
}
