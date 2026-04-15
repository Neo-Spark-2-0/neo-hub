package com.neospark.neohub.controller.common;

import java.io.IOException;

import com.neospark.neohub.dao.UserDao;
import com.neospark.neohub.dao.UserDaoImpl;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.SessionUtil;

import jakarta.servlet.ServletException;
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
    
}
