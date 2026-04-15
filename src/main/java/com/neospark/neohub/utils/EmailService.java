package com.neospark.neohub.utils;


import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

// Reference
// https://www.geeksforgeeks.org/java/send-email-using-java-program/
public class EmailService {
    private static final String HOST     = "smtp.gmail.com";
    private static final int    PORT     = 587;
    private static final String FROM     = "neosparknepal@gmail.com";
    private static final String PASSWORD = "ewwa vewq xwyo swyt";

    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };
        Session session = Session.getInstance(props, auth);
        return session;
    }

    public static boolean sendEmail(String toEmail, String subject, String htmlBody) {
        try{
            Message message = new MimeMessage(getSession());
            message.setFrom(new InternetAddress(FROM, "NEO-HUB"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlBody, "text/html; charset=utf-8");
            Transport.send(message);
            System.out.println("Email sent successfully! to " +  toEmail);
            return true;
        }catch (Exception e){
            System.err.println("Email send failed: " + e.getMessage());
            return false;
        }
    }

    public static boolean sendVerificationEmail(String toEmail, String name, String token) {
        String subject = "NEO-HUB - Verify Your Email";
        String link = "http://localhost:8080/neo-hub/verify-email?token=" + token;
        String body = EmailTemplate.verificationEmail(name, link);
        return sendEmail(toEmail, subject, body);
    }

    public static boolean sendOrderConfirmationEmail(String toEmail, String name, String orderId, String total) {
        String subject = "NEO-HUB - Order Confirmed #" + orderId;
        String body = EmailTemplate.orderConfirmationEmail(name, orderId, total);
        return sendEmail(toEmail, subject, body);
    }

}