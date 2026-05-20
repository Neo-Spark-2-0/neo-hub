package com.neospark.neohub.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * The type Cookie util.
 */
public class CookieUtil {
    /**
     * Add cookie.
     *
     * @param response the response
     * @param name     the name
     * @param value    the value
     * @param maxAge   the max age
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    /**
     * Gets cookie value.
     *
     * @param request the request
     * @param name    the name
     * @return the cookie value
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * Delete cookie.
     *
     * @param response the response
     * @param name     the name
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        //cookie.setPath("/projects");
        cookie.setPath("/"); //Updated:cookie added with path "/" should be deleted with path "/"
        response.addCookie(cookie);
    }
   
}