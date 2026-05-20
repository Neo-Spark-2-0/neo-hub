package com.neospark.neohub.utils;
import org.mindrot.jbcrypt.BCrypt;

/**
 * The type Password util.
 */
public class PasswordUtil {

    private static final int COST = 10;

    /**
     * Gets hash password.
     *
     * @param inputPassword the input password
     * @return the hash password
     */
    public static String getHashPassword(String inputPassword) {
        String salt = BCrypt.gensalt(COST);
        return BCrypt.hashpw(inputPassword, salt);
    }

    /**
     * Check password boolean.
     *
     * @param passwordTyped  the password typed
     * @param hashedPassword the hashed password
     * @return the boolean
     */
    public static boolean checkPassword(String passwordTyped, String hashedPassword) {
        return BCrypt.checkpw(passwordTyped, hashedPassword);
    }
}

