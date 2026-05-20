package com.neospark.neohub.controller.admin;

import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * The type Admin user servlet.
 */
@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle Flash Messages
        handleFlashMessages(req);
        listUsers(req, resp); 
    }
    
    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userDao.getAllUsers();  //Note: pagination to be added later
        req.setAttribute("userList", users);
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");
        User currentUser = (User) SessionUtil.getAttribute(req, "user");

        if (currentUser == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try{
        if ("toggleStatus".equals(action)) {
            int userId = parseId(req.getParameter("userId"));
            // Prevent admin from banning themselves and validate userId
            if (userId <= 0) {
                req.getSession().setAttribute("error", "Invalid user ID."); 
            } else if (userId == currentUser.getId()) { 
                req.getSession().setAttribute("error", "You cannot change your own status.");
            } else {
                User target = userDao.getUserById(userId);
                if (target == null){
                    req.getSession().setAttribute("error", "User not found.");
                } else {
                    boolean updated = userDao.updateStatus(userId, !target.isActive());
                    req.getSession().setAttribute("success", updated ? "User status updated." : "Failed to update user status.");
                }
            }
         } else if ("delete".equals(action)) {
            int userId = parseId(req.getParameter("userId"));
                if (userId <= 0) {
                    req.getSession().setAttribute("error", "Invalid user ID.");
                } else if (userId == currentUser.getId()) {
                    req.getSession().setAttribute("error", "You cannot delete admin account.");
                } else {
                    boolean deleted = userDao.deleteUser(userId);
                    req.getSession().setAttribute(
                        deleted ? "success" : "error",
                        deleted ? "User deleted successfully."
                                : "Failed to delete user."
                    );
                }
        }
     } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "An error occurred while processing the request.");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }

    private void handleFlashMessages(HttpServletRequest req) {
        HttpSession session = req.getSession();
        req.setAttribute("success", session.getAttribute("success"));
        req.setAttribute("error", session.getAttribute("error"));
        session.removeAttribute("success");
        session.removeAttribute("error");
    }

    private int parseId(String val) {
        try { return Integer.parseInt(val); }
        catch (Exception e) { return 0; }
    }
}