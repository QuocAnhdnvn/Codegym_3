CREATE DATABASE IF NOT EXISTS customer_db;
USE customer_db;

CREATE TABLE IF NOT EXISTS rooms (
    id INT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES room_types(id)
);

INSERT INTO rooms (id, room_number, price, status, category_id) VALUES
    (1,  '113', 150.00, 'Available',     2),
    (2,  '102', 130.00, 'Available',     1),
    (3,  '103', 125.00, 'Occupied',      1),
    (4,  '104', 130.00, 'Occupied',      1),
    (5,  '105', 126.75, 'Available',     1),
    (6,  '106', 135.00, 'Being cleaned', 1),
    (7,  '201', 185.00, 'Available',     2),
    (8,  '202', 180.00, 'Occupied',      2),
    (9,  '203', 190.00, 'Occupied',      2),
    (10, '301', 220.00, 'Occupied',      3),
    (11, '302', 225.00, 'Available',     4),
    (12, '401', 300.00, 'Being cleaned', 4),
    (13, '501', 320.00, 'Occupied',      4),
    (14, '001', 700.00, 'Available',     5)
ON DUPLICATE KEY UPDATE
    room_number = VALUES(room_number),
    price = VALUES(price),
    status = VALUES(status),
    category_id = VALUES(category_id);
