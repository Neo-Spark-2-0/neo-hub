package com.neospark.neohub.controller.common;

import java.io.IOException;

import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.PasswordUtil;
import com.neospark.neohub.utils.SessionUtil;
import com.neospark.neohub.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
     private final UserDao userDao = new UserDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User sessionUser =(User) SessionUtil.getAttribute(req, "user");
        User user = userDao.getUserById(sessionUser.getId());
        req.setAttribute("user", user);
        req.getRequestDispatcher("/WEB-INF/views/common/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action != null ? action : "") {
            case "updateProfile"  -> handleUpdateProfile(req, resp);
            case "changePassword" -> handleChangePassword(req, resp);
            case "uploadPhoto"    -> handleUploadPhoto(req, resp);
            case "deleteAccount"   -> deleteAccount(req, resp);
            default -> resp.sendRedirect(req.getContextPath() + "/profile");
        }
    }


    public void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User sessionUser = (User) SessionUtil.getAttribute(request, "user");
        String fullName  = request.getParameter("fullName").trim();
        String phone     = request.getParameter("phone").trim();
        String province  = request.getParameter("province").trim();
        String district  = request.getParameter("district").trim();
        String city      = request.getParameter("city").trim();
        String localLevel = request.getParameter("localLevel").trim();
        String ward      = request.getParameter("ward").trim();
        String street    = request.getParameter("street").trim();
        String landmark  = request.getParameter("landmark").trim();
        if(sessionUser.isAdmin()){
            province = "N/A";
            district = "N/A";
            city = "N/A";
            localLevel = "N/A";
            ward = "N/A";
            street = "N/A";
            landmark = "N/A";
        }
        if(ValidationUtil.isAnyEmpty(fullName, phone, province, district, city, localLevel, ward, street, landmark)) {
            setErrorAndForward(request, response, "profileError", "Input fields cannot be empty.");
            return;
        }
        if(!ValidationUtil.isFullName(fullName)){
            setErrorAndForward(request, response, "profileError", "Full name must contain at least 2 words.");
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            setErrorAndForward(request, response, "profileError",
                    "Please enter a valid Nepal phone number.");
            return;
        }

        User user = new User();
        user.setId(sessionUser.getId());
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setProvince(province);
        user.setDistrict(district);
        user.setCity(city);
        user.setLocalLevel(localLevel);
        user.setWard(ward);
        user.setStreet(street);
        user.setLandmark(landmark);

        boolean success = userDao.updateUser(user);

        if (success) {
            User updated = userDao.getUserById(sessionUser.getId());
            SessionUtil.setAttribute(request, "user", updated);
            setSuccessAndForward(request, response, "profileSuccess", "Profile updated successfully.");
        } else {
            setErrorAndForward(request, response, "profileError", "Failed to update profile. Try again.");
        }
    }
    public void handleChangePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) SessionUtil.getAttribute(request, "user");
        String currentPassword = request.getParameter("currentPassword").trim();
        String newPassword = request.getParameter("newPassword").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();

        if(ValidationUtil.isAnyEmpty(currentPassword, newPassword, confirmPassword)) {
            setErrorAndForward(request, response, "passwordError", "Input fields cannot be empty.");
            return;
        }

        // if (!ValidationUtil.isValidPassword(newPassword)) {
        //     setErrorAndForward(request, response, "passwordError",
        //             "Password must be at least 8 characters, include uppercase, lowercase, and a number.");
        //     return;
        // }

        if (!ValidationUtil.isPasswordsMatch(confirmPassword, newPassword)) {
            setErrorAndForward(request, response, "passwordError", "New password and confirmation password do not match.");
            return;
        }
        User dbUser = userDao.getUserById(user.getId());
        if (!PasswordUtil.checkPassword(currentPassword, dbUser.getPassword())) {
            setErrorAndForward(request, response, "passwordError", "Current password is incorrect.");
            return;
        }
        String hashedPassword = PasswordUtil.getHashPassword(newPassword);
        boolean success = userDao.updatePassword(user.getId(), hashedPassword);
        if (success) {
            setSuccessAndForward(request, response, "passwordSuccess", "Password updated successfully.");
        } else {
            setErrorAndForward(request, response, "passwordError", "Failed to update password. Try again.");
        }
    }
    // @MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB)
    public void handleUploadPhoto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // need review as it is copy pasted from ai 
        // User sessionUser = (User) request.getSession().getAttribute("loggedInUser");
        // Part filePart    = request.getPart("profilePhoto");

        // try {
        //     String imagePath = ImageUploadUtil.uploadProfileImage(filePart, request.getServletContext().getRealPath(""));
        //     if (imagePath == null) {
        //         setErrorAndForward(request, response, "photoError", "Please select an image file.");
        //         return;
        //     }
        //     boolean success = userDao.updateProfileImage(sessionUser.getId(), imagePath);
        //     if (success) {
        //         User updated = userDao.getUserById(sessionUser.getId());
        //         request.getSession().setAttribute("loggedInUser", updated);
        //         setSuccessAndForward(request, response, "photoSuccess", "Profile photo updated successfully.");
        //     } else {
        //         setErrorAndForward(request, response, "photoError", "Failed to upload photo. Try again.");
        //     }
        // } catch (IOException e) {
        //     setErrorAndForward(request, response, "photoError", e.getMessage());
        // }
    }


    public void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User sessionUser = (User) SessionUtil.getAttribute(request, "user");
        boolean success = userDao.deleteUser(sessionUser.getId());
        if (success) {
            SessionUtil.invalidateSession(request);
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            setErrorAndForward(request, response, "deleteError", "Failed to delete account. Try again.");
        }

    }

    private void setErrorAndForward(HttpServletRequest request, HttpServletResponse response, String key, String message) throws ServletException, IOException {
        User sessionUser = (User) SessionUtil.getAttribute(request, "user");
        request.setAttribute("user", sessionUser);
        request.setAttribute(key, message);
        request.getRequestDispatcher("/WEB-INF/views/common/profile.jsp").forward(request, response);
    }

     private void setSuccessAndForward(HttpServletRequest request, HttpServletResponse response, String key, String message) throws ServletException, IOException {
        User sessionUser = (User) SessionUtil.getAttribute(request, "user");
        request.setAttribute("user", userDao.getUserById(sessionUser.getId()));
        request.setAttribute(key, message);
        request.getRequestDispatcher("/WEB-INF/views/common/profile.jsp").forward(request, response);
    }
}
