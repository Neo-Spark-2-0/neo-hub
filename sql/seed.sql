-- Turning Off Strict Mode
SET sql_mode = '';

USE neohub;

-- Default Admin Account
INSERT INTO users (full_name, email, password, role) VALUES
    ('Admin', 'admin@neohub.com', 'HASHED_PASSWORD_HERE', 'ADMIN');