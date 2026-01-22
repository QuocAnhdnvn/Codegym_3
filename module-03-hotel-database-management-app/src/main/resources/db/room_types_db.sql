CREATE DATABASE IF NOT EXISTS customer_db;
USE customer_db;

CREATE TABLE IF NOT EXISTS room_types (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255) NOT NULL
);

INSERT INTO room_types (id, name, description) VALUES
    (1, 'Single Room', 'Single room with 1 bed'),
    (2, 'Double Room', 'Room with 2 double beds'),
    (3, 'Deluxe Room', 'Room with 2 double beds'),
    (4, 'Suite', 'Room with a separate living room and 2 double beds'),
    (5, 'Presidential Suite', 'Room with a private pool')
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    description = VALUES(description);
