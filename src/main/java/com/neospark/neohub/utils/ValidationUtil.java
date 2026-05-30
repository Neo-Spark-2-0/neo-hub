package com.neospark.neohub.utils;
import java.util.regex.Pattern;

/**
 * The type Validation util.
 */
public class ValidationUtil {
    /**
     * Is any empty boolean.
     *
     * @param values the values
     * @return the boolean
     */
    public static boolean isAnyEmpty(String... values) {
        for (String value : values) {
            if (isNullOrEmpty(value)) return true;
        }
        return false;
    }

    /**
     * Is null or empty boolean.
     *
     * @param value the value
     * @return the boolean
     */
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Is alphanumeric starting with letter boolean.
     *
     * @param value the value
     * @return the boolean
     */
    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }

    /**
     * Is valid email boolean.
     *
     * @param email the email
     * @return the boolean
     */
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }


    /**
     * Is valid password boolean.
     *
     * @param password the password
     * @return the boolean
     */
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    /**
     * Is passwords match boolean.
     *
     * @param password       the password
     * @param retypePassword the retype password
     * @return the boolean
     */
    public static boolean isPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    /**
     * Is valid phone boolean.
     *
     * @param phone the phone
     * @return the boolean
     */
    public static boolean isValidPhone(String phone) {
        if (isNullOrEmpty(phone)) return false;
        return phone.matches("^(98|97|96)[0-9]{8}$");
    }

    /**
     * Is full name boolean.
     *
     * @param username the username
     * @return the boolean
     */
    public static boolean isFullName(String username) {
        if (isNullOrEmpty(username)) return false;

        String[] parts = username.trim().split("\\s+");
        if (parts.length < 2 || parts.length > 3) return false;

            for (String part : parts) {
                if (!part.matches("[a-zA-Z]+")) {
                    return false;
                }
            }
            return true;
        }

}
