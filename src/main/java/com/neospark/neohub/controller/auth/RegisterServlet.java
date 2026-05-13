package com.neospark.neohub.controller.auth;

import java.io.IOException;
import java.util.UUID;

import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.EmailService;
import com.neospark.neohub.utils.PasswordUtil;
import com.neospark.neohub.utils.SessionUtil;
import com.neospark.neohub.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

        if (ValidationUtil.isAnyEmpty(fullName, email, phone, password, confirmPassword)) {
            request.setAttribute("error", "Input fields cannot be empty.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isFullName(fullName)) {
            request.setAttribute("error", "Full name must contain at least 2 words.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("error", "Please enter a valid Nepal phone number (98/97/96XXXXXXXX).");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
//        if(!ValidationUtil.isValidPassword(password)){
//            request.setAttribute("error", "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.");
//            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
//            return;
//        }
        if (!ValidationUtil.isPasswordsMatch(confirmPassword, password)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }
        if(userDao.isEmailRegistered(email)){
            request.setAttribute("error", "Email is already registered.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }

        // registering
        String hashedPassword = PasswordUtil.getHashPassword(password);
        User user = new User(fullName, email, phone, hashedPassword);
        boolean success = userDao.registerUser(user);

        if (!success){
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/user/registration.jsp").forward(request, response);
            return;
        }

        // Email verification
        String token = UUID.randomUUID().toString();
        userDao.saveEmailToken(email, token);  
        EmailService.sendVerificationEmail(email, fullName, token);

        // storing flash message in session to show in login page
        SessionUtil.setAttribute(request, "registerSuccessFlashMessage", "Registration successful! Please verify your Email.");
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
