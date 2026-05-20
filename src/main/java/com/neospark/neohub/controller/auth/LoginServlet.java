package com.neospark.neohub.controller.auth;

import java.io.IOException;

import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.CookieUtil;
import com.neospark.neohub.utils.PasswordUtil;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * The type Login servlet.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    /**
     * The User dao.
     */
    public final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();

        if (email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(req, resp);
            return;
        }
        User user = userDao.findUserByEmail(email);
        if (user == null) {
            req.setAttribute("error", "Invalid email or password.");
            req.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(req, resp);
            return;
        }

        if (!PasswordUtil.checkPassword(password, user.getPassword())) {
            req.setAttribute("error", "Invalid email or password.");
            req.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(req, resp);
            return;
        }
        if (!user.isActive()) {
            req.setAttribute("error", "Your account has been deactivated. Contact Admin.");
            req.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(req, resp);
            return;
        }
        if (!userDao.isEmailVerified(email)) {
            req.setAttribute("error", "Please verify your email before logging in.");
            req.getRequestDispatcher("/WEB-INF/views/common/login.jsp").forward(req, resp);
            return;
        }
        SessionUtil.setAttribute(req, "user", user);
        CookieUtil.addCookie(resp, "email", user.getEmail(), 7 * 24 * 60 * 60);

        // storing flash message in session to show in login page
        SessionUtil.setAttribute(req, "loginSuccessFlashMessage", "Login successful! Welcome back.");
        if(user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/");

    }
}
