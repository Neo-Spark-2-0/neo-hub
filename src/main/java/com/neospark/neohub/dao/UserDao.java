package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.User;

public interface UserDao {
    // authentication part
    boolean registerUser(User user);

    User findUserByEmail(String email);

    boolean isEmailRegistered(String email);

    boolean saveEmailToken(String email, String token);

    boolean verifyEmailToken(String token);

    boolean isEmailVerified(String email);

    // crud operations methods
    User getUserById(int userId);

    List<User> getAllUsers();

    boolean updateUser(User user);

    boolean deleteUser(int userId);

    boolean updatePassword(int id, String hashedPassword);

    boolean updateProfileImage(int id, String imagePath);

    // admin
    boolean updateStatus(int userId, boolean isActive);

    int getTotalUserCount(); //Added for dashboard stats

    List<User> getRecentUsers(int limit); //Added for dashboard recent users
    
}
