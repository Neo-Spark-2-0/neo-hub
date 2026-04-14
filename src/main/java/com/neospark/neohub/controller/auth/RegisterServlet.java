package com.neospark.neohub.controller.auth;

import java.io.IOException;
import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    public  final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();

    
        if (fullName.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Input fields cannot be empty.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
        if(password.length() < 6){
            request.setAttribute("error", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
        
        if(userDao.isEmailRegistered(email)){
            request.setAttribute("error", "Email is already registered.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
        String hashedPassword = PasswordUtil.getHashPassword(password);

        User user = new User(fullName, email, phone, hashedPassword);

        boolean success = userDao.registerUser(user);
        if (success){
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
        }
    }
}
