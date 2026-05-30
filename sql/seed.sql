-- =====================================================
-- NEO-HUB – Complete Test Data
-- =====================================================

SET sql_mode = '';
USE neohub;

-- -----------------------------------------------------
-- 1. USERS (1 Admin + 9 Customers)
--    Password for all is "password123"
--    Replace the hash with real BCrypt from your code:
--    PasswordUtil.getHashPassword("password123")
-- -----------------------------------------------------
INSERT INTO users (full_name, email, password, phone, province, district, city, street, role, is_active, is_email_verified) VALUES
('Admin', 'admin@neohub.com', '$2a$10$aCaiJw4Zpmrko9FiWF1AzOUE542GKLfm8vB6JAeHRCYsaYAow8LSK', '9812345678', 'Bagmati', 'Kathmandu', 'Kathmandu', 'Admin Street', 'ADMIN', TRUE, TRUE),
('Ram Sharma', 'ram.sharma@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345670', 'Bagmati', 'Lalitpur', 'Patan', 'Mangal Bazaar', 'USER', TRUE, TRUE),
('Sita Thapa', 'sita.thapa@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345671', 'Bagmati', 'Bhaktapur', 'Bhaktapur', 'Durbar Square', 'USER', TRUE, TRUE),
('Hari Nepal', 'hari.nepal@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345672', 'Province1', 'Jhapa', 'Birtamode', 'Main Road', 'USER', TRUE, TRUE),
('Gita Karki', 'gita.karki@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345673', 'Province2', 'Banke', 'Nepalgunj', 'Bypass', 'USER', TRUE, TRUE),
('Bikram Shrestha', 'bikram@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345674', 'Bagmati', 'Kathmandu', 'Kirtipur', 'Bagbazar', 'USER', TRUE, TRUE),
('Sunita Maharjan', 'sunita@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345675', 'Bagmati', 'Lalitpur', 'Jawalakhel', 'Kumaripati', 'USER', TRUE, TRUE),
('Ramesh Basnet', 'ramesh@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345676', 'Province3', 'Chitwan', 'Bharatpur', 'Lakeside', 'USER', TRUE, TRUE),
('Kavita Adhikari', 'kavita@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345677', 'Province4', 'Kaski', 'Pokhara', 'New Road', 'USER', TRUE, TRUE),
('Prakash Thapa', 'prakash@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mr5vY8qZqZqZqZqZqZqZqZqZq', '9812345678', 'Province5', 'Rupandehi', 'Butwal', 'Traffic Chowk', 'USER', TRUE, TRUE);

-- -----------------------------------------------------
-- 2. CATEGORIES (4 main IoT categories)
-- -----------------------------------------------------
INSERT INTO categories (name, description, image, is_active) VALUES
('Arduino Boards', 'Official and compatible Arduino microcontrollers', NULL, TRUE),
('ESP8266 & ESP32', 'WiFi and Bluetooth enabled development boards', NULL, TRUE),
('Raspberry Pi', 'Single-board computers for advanced IoT', NULL, TRUE),
('Sensors', 'Temperature, motion, gas, humidity sensors', NULL, TRUE);

-- -----------------------------------------------------
-- 3. PRODUCTS (18 products, 4-5 per category)
-- -----------------------------------------------------
INSERT INTO products (name, description, price, discount_price, stock, image, brand, stock_keeping_unit, is_featured, is_active, category_id) VALUES
-- Arduino (cat 1)
('Arduino Uno R3', 'Official Arduino Uno Rev3 – ATmega328P', 3200.00, 2900.00, 45, NULL, 'Arduino', 'UNO-R3', TRUE, TRUE, 1),
('Arduino Mega 2560', 'More memory and I/O pins', 5500.00, 4990.00, 30, NULL, 'Arduino', 'MEGA-2560', TRUE, TRUE, 1),
('Arduino Nano', 'Compact breadboard-friendly board', 2500.00, 2300.00, 60, NULL, 'Arduino', 'NANO-V3', FALSE, TRUE, 1),
('Arduino Leonardo', 'Microcontroller with native USB', 2800.00, NULL, 25, NULL, 'Arduino', 'LEO-R3', FALSE, TRUE, 1),

-- ESP (cat 2)
('ESP32 Dev Board', 'Dual-core WiFi + Bluetooth', 1200.00, 1050.00, 100, NULL, 'Espressif', 'ESP32-DEV', TRUE, TRUE, 2),
('ESP8266 NodeMCU', 'Low-cost WiFi module', 800.00, 750.00, 80, NULL, 'NodeMCU', 'ESP8266-V3', FALSE, TRUE, 2),
('ESP32-CAM', 'ESP32 with camera module', 1300.00, 1200.00, 45, NULL, 'Espressif', 'ESP32-CAM', TRUE, TRUE, 2),
('ESP32-S3', 'Latest generation with AI instructions', 1800.00, 1650.00, 35, NULL, 'Espressif', 'ESP32-S3', FALSE, TRUE, 2),

-- Raspberry Pi (cat 3)
('Raspberry Pi 4B 4GB', '1.5GHz quad-core, 4GB RAM', 10500.00, 9999.00, 15, NULL, 'Raspberry Pi', 'RPI4-4GB', TRUE, TRUE, 3),
('Raspberry Pi Pico W', 'RP2040 with WiFi', 1200.00, 1100.00, 55, NULL, 'Raspberry Pi', 'PICO-W', FALSE, TRUE, 3),
('Raspberry Pi Zero 2W', 'Small form factor with WiFi', 5800.00, 5500.00, 20, NULL, 'Raspberry Pi', 'ZERO-2W', TRUE, TRUE, 3),

-- Sensors (cat 4)
('DHT11 Temperature & Humidity', 'Digital sensor', 350.00, 300.00, 200, NULL, 'AOSONG', 'DHT11', FALSE, TRUE, 4),
('DHT22 High Precision', 'Better accuracy, wider range', 800.00, 750.00, 120, NULL, 'AOSONG', 'DHT22', FALSE, TRUE, 4),
('HC-SR04 Ultrasonic', 'Distance measurement up to 400cm', 400.00, 350.00, 150, NULL, 'HC', 'HC-SR04', FALSE, TRUE, 4),
('PIR Motion Sensor', 'Passive infrared motion detection', 300.00, 280.00, 180, NULL, 'Generic', 'HC-SR501', FALSE, TRUE, 4),
('MQ-135 Air Quality', 'CO2, smoke, benzene detection', 750.00, 700.00, 70, NULL, 'MQ', 'MQ-135', TRUE, TRUE, 4),
('BMP280 Pressure Sensor', 'Barometric pressure + temperature', 600.00, 550.00, 90, NULL, 'Bosch', 'BMP280', FALSE, TRUE, 4);

-- -----------------------------------------------------
-- 4. CART (12 entries, various users)
-- -----------------------------------------------------
INSERT INTO cart (user_id, product_id, quantity) VALUES
(2, 1, 1),   -- Ram: Arduino Uno
(2, 4, 2),   -- Ram: ESP32 Dev Board
(3, 7, 1),   -- Sita: DHT11
(3, 10, 2),  -- Sita: Raspberry Pi 4B (qty 2)
(4, 5, 1),   -- Hari: ESP8266 NodeMCU
(5, 12, 1),  -- Gita: DHT22
(6, 14, 3),  -- Bikram: PIR Motion Sensor (3)
(7, 2, 1),   -- Sunita: Arduino Mega
(8, 9, 1),   -- Ramesh: ESP32-CAM
(9, 15, 1),  -- Kavita: MQ-135
(10, 3, 1),  -- Prakash: Arduino Nano
(10, 6, 1);  -- Prakash: ESP32-S3

-- -----------------------------------------------------
-- 5. PROMO CODES (5 active, 2 inactive/expired)
-- -----------------------------------------------------
INSERT INTO promo_codes (code, discount_percent, expiry_date, is_active) VALUES
('WELCOME10', 10.00, DATE_ADD(CURDATE(), INTERVAL 6 MONTH), TRUE),
('SAVE20',   20.00, DATE_ADD(CURDATE(), INTERVAL 3 MONTH), TRUE),
('FLAT15',   15.00, DATE_ADD(CURDATE(), INTERVAL 1 MONTH), TRUE),
('NEOHUB5',   5.00, DATE_ADD(CURDATE(), INTERVAL 12 MONTH), TRUE),
('FESTIVAL25',25.00, DATE_ADD(CURDATE(), INTERVAL 2 MONTH), TRUE),
('EXPIRED50',50.00, DATE_SUB(CURDATE(), INTERVAL 1 DAY), FALSE),   -- expired
('DISABLED10',10.00, DATE_ADD(CURDATE(), INTERVAL 6 MONTH), FALSE); -- inactive

-- -----------------------------------------------------
-- 6. ORDERS (10 orders, varied users and statuses)
-- -----------------------------------------------------
INSERT INTO orders (sub_total_amount, shipping_charge, discount_amount, total_amount, promo_code_id, order_status, user_id, created_at) VALUES
(3200.00, 100.00, 0.00,   3300.00, NULL, 'Delivered',   2, DATE_SUB(NOW(), INTERVAL 30 DAY)),
(2400.00, 100.00, 240.00, 2260.00, 1,   'Delivered',   3, DATE_SUB(NOW(), INTERVAL 20 DAY)),
(350.00,  100.00, 0.00,   450.00,  NULL, 'Shipped',     4, DATE_SUB(NOW(), INTERVAL 15 DAY)),
(10500.00,100.00, 1050.00,9550.00, 2,   'Processing',  5, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(800.00,  100.00, 80.00,  820.00,  3,   'Confirmed',   6, DATE_SUB(NOW(), INTERVAL 8 DAY)),
(550.00,  100.00, 0.00,   650.00,  NULL, 'Pending',     7, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2500.00, 100.00, 250.00, 2350.00, 4,   'Delivered',   8, DATE_SUB(NOW(), INTERVAL 12 DAY)),
(6500.00, 100.00, 0.00,   6600.00, NULL, 'Cancelled',   9, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(450.00,  100.00, 0.00,   550.00,  NULL, 'Delivered',   2, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(1200.00, 100.00, 120.00, 1180.00, 1,   'Processing',  3, DATE_SUB(NOW(), INTERVAL 1 DAY));

-- -----------------------------------------------------
-- 7. ORDER ITEMS (matching each order)
-- -----------------------------------------------------
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 3200.00),                         -- Order1: Arduino Uno
(2, 4, 2, 1200.00),                         -- Order2: ESP32 Dev Board x2
(3, 13, 1, 350.00),                         -- Order3: DHT11
(4, 9, 1, 10500.00),                        -- Order4: Raspberry Pi 4B
(5, 2, 1, 550.00), (5, 14, 1, 300.00),      -- Order5: Arduino Mega + PIR sensor
(6, 3, 1, 2500.00),                         -- Order6: Arduino Nano
(7, 7, 1, 2500.00),                         -- Order7: NodeMCU IoT Starter Kit? Actually product_id 7 is ESP32-CAM? Wait product_id mapping: 7=ESP32-CAM (price 1300, discount 1200). But 2500? That’s not matching. Use correct product_id. Let’s adjust to product 1? No, I'll use product 5 (ESP8266 NodeMCU) price 800? Better to use a product with price around 2500. Product 2 is 5500, too high. I'll use product 1 (Arduino Uno) 3200? No. I'll create a new product for kits? Simpler: use product 5 (ESP8266) 800 but need 2500 total. Change quantity. Let's just use product 2 (Arduino Mega) 5500 and set quantity 1? That’s 5500 not 2500. I'll adjust to use product 1 (3200) and set quantity 1 – not 2500. I'll keep the original data consistent: order7 from user8, product? Use product 3 (Arduino Nano 2500) correct. So order7 product_id 3.
(7, 3, 1, 2500.00),                         -- Order7: Arduino Nano
(8, 2, 1, 5500.00),                         -- Order8: Arduino Mega (cancelled order)
(9, 13, 1, 350.00),                         -- Order9: DHT11
(10, 4, 2, 1200.00);                        -- Order10: ESP32 Dev Board x2

-- -----------------------------------------------------
-- 8. PAYMENTS (one per order)
-- -----------------------------------------------------
INSERT INTO payments (order_id, method, transaction_id, amount, status, paid_at) VALUES
(1,  'CashOnDelivery', NULL,          3300.00, 'Completed', DATE_SUB(NOW(), INTERVAL 29 DAY)),
(2,  'Khalti',         'KHALTIXYZ001',2260.00, 'Completed', DATE_SUB(NOW(), INTERVAL 19 DAY)),
(3,  'CashOnDelivery', NULL,          450.00,  'Pending',   NULL),
(4,  'Khalti',         'KHALTIXYZ002',9550.00, 'Completed', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(5,  'CashOnDelivery', NULL,          820.00,  'Completed', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(6,  'CashOnDelivery', NULL,          650.00,  'Pending',   NULL),
(7,  'Khalti',         'KHALTIXYZ003',2350.00, 'Completed', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(8,  'CashOnDelivery', NULL,          6600.00, 'Failed',    NULL),
(9,  'CashOnDelivery', NULL,          550.00,  'Completed', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(10, 'Khalti',         'KHALTIXYZ004',1180.00, 'Completed', DATE_SUB(NOW(), INTERVAL 0 DAY));

-- -----------------------------------------------------
-- 9. CONTACT MESSAGES (5 sample messages)
-- -----------------------------------------------------
INSERT INTO contact_messages (user_id, subject, message, status) VALUES
(2, 'Question about ESP32 stock', 'When will the ESP32 be back in stock?', 'Unread'),
(3, 'Order delivery delay', 'My order #3 hasn’t arrived yet. Please check.', 'Read'),
(4, 'Promo code not working', 'The code WELCOME10 gives error. Please help.', 'Unread'),
(5, 'Product suggestion', 'You should add LoRa modules.', 'Replied'),
(6, 'Feedback', 'Great products, fast shipping!', 'Read');

-- -----------------------------------------------------
-- End of test data
-- -----------------------------------------------------