package com.neospark.neohub.controller.user;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 * The type About us servlet.
 */
@WebServlet("/about")
public class AboutUsServlet extends HttpServlet{
    // do get runs when browser sens get request
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/user/aboutUs.jsp").forward(req, resp);

    }
}
