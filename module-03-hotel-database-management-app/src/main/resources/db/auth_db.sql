-- Create database if not exists and use it
CREATE DATABASE IF NOT EXISTS customer_db;
USE customer_db;

-- Roles table: defines account types and permissions
CREATE TABLE IF NOT EXISTS roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    can_edit TINYINT(1) NOT NULL DEFAULT 0
);

-- Accounts table: login accounts linked to roles
CREATE TABLE IF NOT EXISTS accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Seed roles
INSERT INTO roles (code, name, can_edit) VALUES
    ('ADMIN', 'Administrator', 1),
    ('USER', 'User', 0)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    can_edit = VALUES(can_edit);

-- Seed accounts (sample credentials for development)
INSERT INTO accounts (username, password, role_id) VALUES
    ('admin01@codegym.com', 'admin123', (SELECT id FROM roles WHERE code = 'ADMIN')),
    ('admin02', 'admin123', (SELECT id FROM roles WHERE code = 'ADMIN')),
    ('admin03', 'admin123', (SELECT id FROM roles WHERE code = 'ADMIN')),
    ('user01',  'user123',  (SELECT id FROM roles WHERE code = 'USER')),
    ('user02',  'user123',  (SELECT id FROM roles WHERE code = 'USER')),
    ('user03',  'user123',  (SELECT id FROM roles WHERE code = 'USER'))
ON DUPLICATE KEY UPDATE
    password = VALUES(password),
    role_id = VALUES(role_id);
