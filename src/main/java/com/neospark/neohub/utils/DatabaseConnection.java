package com.neospark.neohub.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * The type Database connection.
 */
public class DatabaseConnection {

    private static final String DB_URL = "jdbc:mysql://ballast.proxy.rlwy.net:41576/railway";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "fVuepOIdNBGyDWudLBLyKXBTLBEcsKBY";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    /**
     * Gets connection.
     *
     * @return the connection
     * @throws SQLException the sql exception
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * Close connection.
     *
     * @param connection the connection
     */
    public static void closeConnection(Connection connection) {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
}
