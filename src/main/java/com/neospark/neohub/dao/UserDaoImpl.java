package com.neospark.neohub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.neospark.neohub.model.User;
import com.neospark.neohub.utils.DatabaseConnection;

public class UserDaoImpl implements UserDao {
    @Override
    public boolean registerUser(User user){
        String sql = "INSERT INTO users (full_name, email, password, phone, role) " + "VALUES (?, ?, ?, ?, 'USER')";
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getFullName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getPhone());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error registering user: " + e.getMessage());
            return false;
        }finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public User findUserByEmail(String email) {
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("province"),
                        rs.getString("district"),
                        rs.getString("city"),
                        rs.getString("ward"),
                        rs.getString("street"),
                        rs.getString("landmark"),
                        rs.getString("profile_image"),
                        rs.getString("role"),
                        rs.getBoolean("is_active"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        }catch (SQLException e) {
            System.out.println("Error finding user by email: " + e.getMessage());
            return null;
        }finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }

    @Override
    public boolean isEmailRegistered(String email) {
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT id FROM users WHERE TRIM(LOWER(email)) = TRIM(LOWER(?))";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking email registration: " + e.getMessage());
            return false;
        }finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public User getUserById(int userId) {
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("province"),
                        rs.getString("district"),
                        rs.getString("city"),
                        rs.getString("ward"),
                        rs.getString("street"),
                        rs.getString("landmark"),
                        rs.getString("profile_image"),
                        rs.getString("role"),
                        rs.getBoolean("is_active"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        }catch (SQLException e) {
            System.out.println("Error finding user by ID: " + e.getMessage());
            return null;
        }finally {
            DatabaseConnection.closeConnection(connection);
        }
        return null;
    }

    @Override
    public List<User> getAllUsers() {
        Connection connection = null;
        List<User> users = new ArrayList<>();
        try { 
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users ORDER BY created_at DESC";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("province"),
                        rs.getString("district"),
                        rs.getString("city"),
                        rs.getString("ward"),
                        rs.getString("street"),
                        rs.getString("landmark"),
                        rs.getString("profile_image"),
                        rs.getString("role"),
                        rs.getBoolean("is_active"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                ));
            }
            return users;
        } catch (SQLException e) {
            System.out.println("Error getting all users: " + e.getMessage());
            return null;
        }finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateUser(User user) {
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            String sql = "UPDATE users SET full_name = ?, email = ?, phone = ?, province = ?, district = ?, city = ?, ward = ?, street = ?, landmark = ?, profile_image = ?, role = ?, is_active = ? WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getProvince());
            ps.setString(5, user.getDistrict());
            ps.setString(6, user.getCity());
            ps.setString(7, user.getWard());
            ps.setString(8, user.getStreet());
            ps.setString(9, user.getLandmark());
            ps.setString(10, user.getProfileImage());
            ps.setString(11, user.getRole());
            ps.setBoolean(12, user.isActive());
            ps.setInt(13, user.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating user: " + e.getMessage());
            return false;
        }finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean deleteUser(int userId) {
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            String sql = "DELETE FROM users WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting user: " + e.getMessage());
            return false;
        }finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updatePassword(int id, String hashedPassword) {
        Connection connection = null;
        String sql = "UPDATE users SET password=? WHERE id=?";
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hashedPassword);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating password: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateProfileImage(int id, String imagePath) {
        Connection connection = null;
        String sql = "UPDATE users SET profile_image=? WHERE id=?";
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, imagePath);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating profile image: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean updateStatus(int userId, boolean isActive) {
        Connection connection = null;
        String sql = "UPDATE users SET is_active=? WHERE id=?";
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isActive);
            ps.setInt(2, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating status: " + e.getMessage());
            return false;
        } finally {
            DatabaseConnection.closeConnection(connection);
        }    
    }

    @Override
    public boolean saveEmailToken(String email, String token) {
    String sql = "UPDATE users SET email_token = ? WHERE email = ?";
    Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, token);
            ps.setString(2, email);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("Error saving email token: " + e.getMessage());
        return false;
    } finally {
        DatabaseConnection.closeConnection(connection);
    }
}

@Override
public boolean verifyEmailToken(String token) {
    String sql = "UPDATE users SET is_email_verified = TRUE, email_token = NULL " + "WHERE email_token = ? AND is_email_verified = FALSE";
    Connection connection = null;
    try {
        connection = DatabaseConnection.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, token);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("Error verifying email token: " + e.getMessage());
        return false;
    } finally {
        DatabaseConnection.closeConnection(connection);
    }
}

@Override
public boolean isEmailVerified(String email) {
    String sql = "SELECT is_email_verified FROM users WHERE email = ?";
    Connection connection = null;
    try {
        connection = DatabaseConnection.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()){
            return rs.getBoolean("is_email_verified");
        }
    } catch (SQLException e) {
        System.out.println("Error checking email verification: " + e.getMessage());
    } finally {
        DatabaseConnection.closeConnection(connection);
    }
    return false;
}

}