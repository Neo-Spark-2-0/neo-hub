package com.neospark.neohub.utils;
import java.util.regex.Pattern;

public class ValidationUtil {
    public static boolean isAnyEmpty(String... values) {
        for (String value : values) {
            if (isNullOrEmpty(value)) return true;
        }
        return false;
    }

    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }

    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }


    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    public static boolean isPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    public static boolean isValidPhone(String phone) {
        if (isNullOrEmpty(phone)) return false;
        return phone.matches("^(98|97|96)[0-9]{8}$");
    }

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
