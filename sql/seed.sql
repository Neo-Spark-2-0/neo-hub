-- =====================================================
-- NEO-HUB – Realistic Test Data (Compact Version)
-- =====================================================

SET sql_mode = '';
USE neohub;

-- -----------------------------------------------------
-- 1. USERS (Admin + 9 Customers)
--    Password for all is 'password123' – you must replace
--    the hash with a real BCrypt hash, e.g. from
--    PasswordUtil.getHashPassword("password123")
-- -----------------------------------------------------
INSERT INTO users (full_name, email, password, phone, province, district, city, street, role, is_active, is_email_verified) VALUES
('Admin', 'admin@neohub.com', '$2a$10$aCaiJw4Zpmrko9FiWF1AzOUE542GKLfm8vB6JAeHRCYsaYAow8LSK', '9812345678', 'Bagmati', 'Kathmandu', 'Kathmandu', 'Admin Street', 'ADMIN', TRUE, TRUE),
('Ram Sharma', 'ram@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345670', 'Bagmati', 'Lalitpur', 'Patan', 'Mangal Bazaar', 'USER', TRUE, TRUE),
('Sita Thapa', 'sita@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345671', 'Bagmati', 'Bhaktapur', 'Bhaktapur', 'Durbar Square', 'USER', TRUE, TRUE),
('Hari Nepal', 'hari@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345672', 'Province1', 'Jhapa', 'Birtamode', 'Main Road', 'USER', TRUE, TRUE),
('Gita Karki', 'gita@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345673', 'Province2', 'Banke', 'Nepalgunj', 'Bypass', 'USER', TRUE, TRUE),
('Bikram Shrestha', 'bikram@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345674', 'Bagmati', 'Kathmandu', 'Kirtipur', 'Bagbazar', 'USER', TRUE, TRUE),
('Sunita Maharjan', 'sunita@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345675', 'Bagmati', 'Lalitpur', 'Jawalakhel', 'Kumaripati', 'USER', TRUE, TRUE),
('Ramesh Basnet', 'ramesh@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345676', 'Province3', 'Chitwan', 'Bharatpur', 'Lakeside', 'USER', TRUE, TRUE),
('Kavita Adhikari', 'kavita@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345677', 'Province4', 'Kaski', 'Pokhara', 'New Road', 'USER', TRUE, TRUE),
('Prakash Thapa', 'prakash@example.com', '$2a$10$replaceWithRealHashForPassword123', '9812345678', 'Province5', 'Rupandehi', 'Butwal', 'Traffic Chowk', 'USER', TRUE, TRUE);

-- -----------------------------------------------------
-- 2. CATEGORIES (8 main IoT categories)
-- -----------------------------------------------------
INSERT INTO categories (name, description, is_active) VALUES
('Arduino Boards', 'Official and compatible Arduino microcontrollers', TRUE),
('ESP8266 & ESP32', 'WiFi and Bluetooth enabled development boards', TRUE),
('Raspberry Pi', 'Single-board computers for advanced IoT', TRUE),
('Sensors', 'Temperature, motion, gas, humidity sensors', TRUE),
('Displays', 'LCD, OLED, and TFT screens', TRUE),
('Motors & Drivers', 'Servo, stepper, DC motors and motor drivers', TRUE),
('IoT Kits', 'Starter kits and bundles', TRUE),
('Power & Batteries', 'Power supplies, solar panels, battery modules', TRUE);

-- -----------------------------------------------------
-- 3. PRODUCTS (28 products, 3-6 per category)
-- -----------------------------------------------------
INSERT INTO products (name, description, price, discount_price, stock, image, brand, stock_keeping_unit, is_featured, is_active, category_id) VALUES
-- Arduino Boards (cat 1)
('Arduino Uno R3', 'Official Arduino Uno Rev3 – ATmega328P', 3200.00, 2900.00, 45, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Arduino', 'UNO-R3', TRUE, TRUE, 1),
('Arduino Mega 2560', 'More memory and I/O pins', 5500.00, 4990.00, 30, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Arduino', 'MEGA-2560', TRUE, TRUE, 1),
('Arduino Nano', 'Compact breadboard-friendly board', 2500.00, 2300.00, 60, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Arduino', 'NANO-V3', FALSE, TRUE, 1),

-- ESP8266 & ESP32 (cat 2)
('ESP32 Dev Board', 'Dual-core WiFi + Bluetooth', 1200.00, 1050.00, 100, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Espressif', 'ESP32-DEV', TRUE, TRUE, 2),
('ESP8266 NodeMCU', 'Low-cost WiFi module', 800.00, 750.00, 80, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'NodeMCU', 'ESP8266-V3', FALSE, TRUE, 2),
('ESP32-CAM', 'ESP32 with camera module', 1300.00, 1200.00, 45, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Espressif', 'ESP32-CAM', TRUE, TRUE, 2),

-- Raspberry Pi (cat 3)
('Raspberry Pi 4B 4GB', '1.5GHz quad-core, 4GB RAM', 10500.00, 9999.00, 15, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Raspberry Pi', 'RPI4-4GB', TRUE, TRUE, 3),
('Raspberry Pi Pico W', 'RP2040 with WiFi', 1200.00, 1100.00, 55, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Raspberry Pi', 'PICO-W', FALSE, TRUE, 3),

-- Sensors (cat 4)
('DHT11 Temperature & Humidity', 'Digital sensor', 350.00, 300.00, 200, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'AOSONG', 'DHT11', FALSE, TRUE, 4),
('DHT22 High Precision', 'Better accuracy', 800.00, 750.00, 120, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'AOSONG', 'DHT22', FALSE, TRUE, 4),
('HC-SR04 Ultrasonic', 'Distance measurement', 400.00, 350.00, 150, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'HC', 'HC-SR04', FALSE, TRUE, 4),
('PIR Motion Sensor', 'Passive infrared', 300.00, 280.00, 180, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Generic', 'HC-SR501', FALSE, TRUE, 4),
('MQ-135 Air Quality', 'CO2, smoke, benzene', 750.00, 700.00, 70, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'MQ', 'MQ-135', TRUE, TRUE, 4),

-- Displays (cat 5)
('16x2 LCD with I2C', 'Character display', 450.00, 400.00, 95, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'HD44780', 'LCD1602', FALSE, TRUE, 5),
('0.96" OLED 128x64', 'I2C OLED', 600.00, 550.00, 130, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'SSD1306', 'OLED-096', TRUE, TRUE, 5),

-- Motors & Drivers (cat 6)
('SG90 Micro Servo', '9g servo', 250.00, 220.00, 300, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Tower Pro', 'SG90', FALSE, TRUE, 6),
('L298N Motor Driver', 'Dual H-bridge', 550.00, 500.00, 110, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'ST', 'L298N', FALSE, TRUE, 6),
('28BYJ-48 Stepper + Driver', '5V stepper motor with ULN2003', 500.00, 450.00, 80, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Generic', '28BYJ-48', FALSE, TRUE, 6),

-- IoT Kits (cat 7)
('NodeMCU IoT Starter Kit', 'ESP8266 + sensors + cables', 2500.00, 2200.00, 30, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'NodeMCU', 'KIT-ESP', TRUE, TRUE, 7),
('Arduino Uno Ultimate Kit', 'Over 200 components', 6500.00, 5999.00, 20, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Arduino', 'KIT-UNO', TRUE, TRUE, 7),

-- Power & Batteries (cat 8)
('18650 Li-ion Battery', '3.7V 2000mAh', 500.00, 450.00, 150, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Samsung', '18650-26H', FALSE, TRUE, 8),
('TP4056 Charger Module', '1A Li-ion charging', 150.00, 130.00, 300, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Generic', 'TP4056', FALSE, TRUE, 8),
('5V 1W Solar Panel', 'Mini solar cell', 450.00, 400.00, 60, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600', 'Generic', 'SOL-5V-1W', FALSE, TRUE, 8);

-- -----------------------------------------------------
-- 4. CART (a few active carts)
-- -----------------------------------------------------
INSERT INTO cart (user_id, product_id, quantity) VALUES
(2, 1, 1),   -- Ram has Arduino Uno
(2, 4, 2),   -- Ram also has ESP32
(3, 10, 1),  -- Sita has DHT22
(3, 14, 1),  -- Sita has OLED
(4, 3, 1),   -- Hari has Arduino Nano
(5, 8, 1),   -- Gita has Raspberry Pi 4B
(6, 15, 3),  -- Bikram has SG90 servos
(7, 18, 1);  -- Sunita has NodeMCU kit

-- -----------------------------------------------------
-- 5. PROMO CODES (5 active, 1 expired/inactive example)
-- -----------------------------------------------------
INSERT INTO promo_codes (code, discount_percent, expiry_date, is_active) VALUES
('WELCOME10', 10.00, '2026-12-31', TRUE),
('SAVE20',   20.00, '2026-12-31', TRUE),
('FLAT15',   15.00, '2026-06-30', TRUE),
('NEOHUB5',   5.00, '2026-05-31', TRUE),
('FESTIVAL25',25.00, '2026-10-31', TRUE),
('EXPIRED50',50.00, '2025-01-01', FALSE);   -- expired example

-- -----------------------------------------------------
-- 6. ORDERS (12 orders, varied statuses)
-- -----------------------------------------------------
INSERT INTO orders (sub_total_amount, shipping_charge, discount_amount, total_amount, promo_code_id, order_status, user_id, created_at) VALUES
(3200.00, 100.00, 0.00,   3300.00, NULL, 'Delivered', 2, '2026-03-01 10:00:00'),
(2400.00, 100.00, 240.00, 2260.00, 1,   'Delivered', 3, '2026-03-10 14:30:00'),
(350.00,  100.00, 0.00,   450.00,  NULL, 'Shipped',   4, '2026-03-15 09:15:00'),
(10500.00,100.00, 1050.00,9550.00, 2,   'Processing',5, '2026-03-20 11:20:00'),
(800.00,  100.00, 80.00,  820.00,  3,   'Confirmed', 6, '2026-03-25 16:45:00'),
(550.00,  100.00, 0.00,   650.00,  NULL, 'Pending',   7, '2026-03-28 13:10:00'),
(2500.00, 100.00, 250.00, 2350.00, 4,   'Delivered', 8, '2026-04-02 09:00:00'),
(6500.00, 100.00, 0.00,   6600.00, NULL, 'Cancelled', 9, '2026-04-05 12:30:00'),
(450.00,  100.00, 0.00,   550.00,  NULL, 'Delivered', 2, '2026-04-10 14:15:00'),
(1200.00, 100.00, 120.00, 1180.00, 1,   'Shipped',   3, '2026-04-15 08:45:00'),
(750.00,  100.00, 0.00,   850.00,  NULL, 'Processing',4, '2026-04-20 17:20:00'),
(400.00,  100.00, 0.00,   500.00,  NULL, 'Pending',   5, '2026-04-25 11:00:00');

-- -----------------------------------------------------
-- 7. ORDER ITEMS (matching each order)
-- -----------------------------------------------------
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 3200.00),                         -- Order1: Arduino Uno
(2, 4, 2, 1200.00),                         -- Order2: ESP32 x2
(3, 9, 1, 350.00),                          -- Order3: DHT11
(4, 7, 1, 10500.00),                        -- Order4: Raspberry Pi 4B
(5, 2, 1, 550.00), (5, 5, 1, 250.00),       -- Order5: Arduino Mega + SG90
(6, 3, 1, 2500.00),                         -- Order6: Arduino Nano
(7, 17, 1, 2500.00),                        -- Order7: NodeMCU IoT Kit
(8, 18, 1, 6500.00),                        -- Order8: Arduino Ultimate Kit (cancelled)
(9, 10, 1, 450.00),                         -- Order9: LCD display
(10, 1, 1, 3200.00),                        -- Order10: Arduino Uno
(11, 19, 2, 500.00),                        -- Order11: 18650 battery x2
(12, 16, 1, 400.00);                        -- Order12: Ultrasonic sensor

-- -----------------------------------------------------
-- 8. PAYMENTS (one per order)
-- -----------------------------------------------------
INSERT INTO payments (order_id, method, transaction_id, amount, status, paid_at) VALUES
(1,  'CashOnDelivery', NULL,          3300.00, 'Completed', '2026-03-01 12:00:00'),
(2,  'Khalti',         'KHALTIXYZ001',2260.00, 'Completed', '2026-03-10 15:00:00'),
(3,  'CashOnDelivery', NULL,          450.00,  'Pending',   NULL),
(4,  'Khalti',         'KHALTIXYZ002',9550.00, 'Completed', '2026-03-20 12:00:00'),
(5,  'CashOnDelivery', NULL,          820.00,  'Completed', '2026-03-25 17:30:00'),
(6,  'CashOnDelivery', NULL,          650.00,  'Pending',   NULL),
(7,  'Khalti',         'KHALTIXYZ003',2350.00, 'Completed', '2026-04-02 10:00:00'),
(8,  'CashOnDelivery', NULL,          6600.00, 'Failed',    NULL),          -- cancelled order
(9,  'CashOnDelivery', NULL,          550.00,  'Completed', '2026-04-10 15:00:00'),
(10, 'Khalti',         'KHALTIXYZ004',1180.00, 'Completed', '2026-04-15 09:30:00'),
(11, 'CashOnDelivery', NULL,          850.00,  'Pending',   NULL),
(12, 'CashOnDelivery', NULL,          500.00,  'Pending',   NULL);