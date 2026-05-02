package com.neospark.neohub.controller.user;

import java.io.IOException;

import com.neospark.neohub.dao.ContactMessageDao;
import com.neospark.neohub.dao.ContactMessageDaoImpl;
import com.neospark.neohub.model.ContactMessage;
import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.SessionUtil;
import com.neospark.neohub.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/contact")
public class ContactServlet extends HttpServlet{
    ContactMessageDao contactDao = new ContactMessageDaoImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/user/contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(req, "user");

        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        if (ValidationUtil.isNullOrEmpty(subject)) {
            req.setAttribute("contactError", "Subject is required.");
            req.getRequestDispatcher("/WEB-INF/views/user/contact.jsp").forward(req, resp);
            return;
        }
        if (ValidationUtil.isNullOrEmpty(message)) {
            req.setAttribute("contactError", "Message is required.");
            req.getRequestDispatcher("/WEB-INF/views/user/contact.jsp").forward(req, resp);
            return;
        }

        if (subject.trim().length() > 200) {
            req.setAttribute("contactError", "Subject must be under 200 characters.");
            req.getRequestDispatcher("/WEB-INF/views/user/contact.jsp").forward(req, resp);
            return;
        }

        ContactMessage contactMsg = new ContactMessage();
        contactMsg.setUserId(user.getId());
        contactMsg.setSubject(subject.trim());
        contactMsg.setMessage(message.trim());

        boolean saved = contactDao.saveMessage(contactMsg);

        if (saved) {
            req.setAttribute("contactSuccess", "Your message has been sent! We'll get back to you soon.");
        } else {
            req.setAttribute("contactError", "Something went wrong. Please try again.");
        }
        req.getRequestDispatcher("/WEB-INF/views/user/contact.jsp").forward(req, resp);
    }
}
