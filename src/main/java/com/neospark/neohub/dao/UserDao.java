package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.User;

/**
 * The interface User dao.
 */
public interface UserDao {
    /**
     * Register user boolean.
     *
     * @param user the user
     * @return the boolean
     */
// authentication part
    boolean registerUser(User user);

    /**
     * Find user by email user.
     *
     * @param email the email
     * @return the user
     */
    User findUserByEmail(String email);

    /**
     * Is email registered boolean.
     *
     * @param email the email
     * @return the boolean
     */
    boolean isEmailRegistered(String email);

    /**
     * Save email token boolean.
     *
     * @param email the email
     * @param token the token
     * @return the boolean
     */
    boolean saveEmailToken(String email, String token);

    /**
     * Verify email token boolean.
     *
     * @param token the token
     * @return the boolean
     */
    boolean verifyEmailToken(String token);

    /**
     * Is email verified boolean.
     *
     * @param email the email
     * @return the boolean
     */
    boolean isEmailVerified(String email);

    /**
     * Gets user by id.
     *
     * @param userId the user id
     * @return the user by id
     */
// crud operations methods
    User getUserById(int userId);

    /**
     * Gets all users.
     *
     * @return the all users
     */
    List<User> getAllUsers();

    /**
     * Update user boolean.
     *
     * @param user the user
     * @return the boolean
     */
    boolean updateUser(User user);

    /**
     * Delete user boolean.
     *
     * @param userId the user id
     * @return the boolean
     */
    boolean deleteUser(int userId);

    /**
     * Update password boolean.
     *
     * @param id             the id
     * @param hashedPassword the hashed password
     * @return the boolean
     */
    boolean updatePassword(int id, String hashedPassword);

    /**
     * Update profile image boolean.
     *
     * @param id        the id
     * @param imagePath the image path
     * @return the boolean
     */
    boolean updateProfileImage(int id, String imagePath);

    /**
     * Update status boolean.
     *
     * @param userId   the user id
     * @param isActive the is active
     * @return the boolean
     */
// admin
    boolean updateStatus(int userId, boolean isActive);

    /**
     * Gets total user count.
     *
     * @return the total user count
     */
    int getTotalUserCount(); //Added for dashboard stats

    /**
     * Gets recent users.
     *
     * @param limit the limit
     * @return the recent users
     */
    List<User> getRecentUsers(int limit); //Added for dashboard recent users
    
}
