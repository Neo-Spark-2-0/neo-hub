-- Turning Off Strict Mode
SET sql_mode = '';

USE neohub;

-- Default Admin Account
INSERT INTO users (full_name, email, password, role) VALUES
    ('Admin', 'admin@neohub.com', '$2a$10$aCaiJw4Zpmrko9FiWF1AzOUE542GKLfm8vB6JAeHRCYsaYAow8LSK', 'ADMIN');