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

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        // Handle Flash Messages
        handleFlashMessages(req);

        if ("delete".equals(action)) {
            deleteUser(req, resp);
        } else {
            listUsers(req, resp);
        }
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");
        // Note: Implement getUsersPaginated in UserDao for better performance
        List<User> users = userDao.getAllUsers(); 
        
        req.setAttribute("userList", users);
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User currentUser = (User) SessionUtil.getAttribute(req, "user");

        if ("toggleStatus".equals(action)) {
            int userId = Integer.parseInt(req.getParameter("userId"));
            
            // Prevent admin from banning themselves
            if (userId == currentUser.getId()) {
                req.getSession().setAttribute("error", "You cannot change your own status.");
            } else {
                User u = userDao.getUserById(userId);
                boolean success = userDao.updateStatus(userId, !u.isActive());
                if(success) req.getSession().setAttribute("success", "User status updated.");
            }
        } else if ("delete".equals(action)) {
            deleteUser(req, resp);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        User currentUser = (User) SessionUtil.getAttribute(req, "user");

        if (userId == currentUser.getId()) {
            req.getSession().setAttribute("error", "You cannot delete your own account from here.");
        } else {
            if (userDao.deleteUser(userId)) {
                req.getSession().setAttribute("success", "User deleted successfully.");
            }
        }
    }

    private void handleFlashMessages(HttpServletRequest req) {
        HttpSession session = req.getSession();
        req.setAttribute("success", session.getAttribute("success"));
        req.setAttribute("error", session.getAttribute("error"));
        session.removeAttribute("success");
        session.removeAttribute("error");
    }
}