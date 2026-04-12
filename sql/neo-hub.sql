
-- Turning off strict mode
SET sql_mode = '';

CREATE DATABASE IF NOT EXISTS neohub;
USE neohub;

CREATE TABLE users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    -- Personal Information
                        full_name     VARCHAR(100)          NOT NULL,
                        email         VARCHAR(150)          NOT NULL UNIQUE,
                        password      VARCHAR(255)          NOT NULL,
                        phone         VARCHAR(20),

    -- Address
                        province      VARCHAR(100),
                        district      VARCHAR(100),
                        city          VARCHAR(100),
                        ward          VARCHAR(50),
                        street        VARCHAR(255),
                        landmark      VARCHAR(255),
    -- Profile
                        profile_image VARCHAR(255),
                        role          ENUM('USER', 'ADMIN') DEFAULT 'USER',
                        is_active     BOOLEAN               DEFAULT TRUE,
    -- Timestamps
                        created_at    TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
                        updated_at    TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
