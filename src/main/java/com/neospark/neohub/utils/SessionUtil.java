package com.neospark.neohub.utils;

import com.neospark.neohub.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * The type Session util.
 */
public class SessionUtil {

    /**
     * Sets attribute.
     *
     * @param request the request
     * @param key     the key
     * @param value   the value
     */
    public static void setAttribute(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(30 * 60);
        session.setAttribute(key, value);
    }

    /**
     * Gets attribute.
     *
     * @param request the request
     * @param key     the key
     * @return the attribute
     */
    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute(key);
        }
        return null;
    }

    /**
     * Invalidate session.
     *
     * @param request the request
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * Remove attribute.
     *
     * @param request the request
     * @param key     the key
     */
    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
      }

    /**
     * Is logged in boolean.
     *
     * @param req the req
     * @return the boolean
     */
    public static boolean isLoggedIn(HttpServletRequest req) {
        return getAttribute(req, "user") != null;
    }

    /**
     * Gets user role.
     *
     * @param req the req
     * @return the user role
     */
    public static String getUserRole(HttpServletRequest req) {
        User user = (User) getAttribute(req, "user");
        if (user != null) {
            return user.getRole();
        }
        return null;
    }
}
