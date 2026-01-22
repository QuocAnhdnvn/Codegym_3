CREATE DATABASE IF NOT EXISTS customer_db;
USE customer_db;

DROP TABLE IF EXISTS room_bookings;
CREATE TABLE room_bookings (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME NOT NULL,
    order_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

DELIMITER $$
CREATE TRIGGER trg_room_bookings_bi
BEFORE INSERT ON room_bookings
FOR EACH ROW
BEGIN
  DECLARE room_price DECIMAL(10,2);
  DECLARE days_stayed INT;
  SELECT price INTO room_price FROM rooms WHERE id = NEW.room_id;
  SET days_stayed = CEILING(TIMESTAMPDIFF(HOUR, NEW.check_in_time, NEW.check_out_time) / 24);
  IF days_stayed < 1 THEN
    SET days_stayed = 1;
  END IF;
  SET NEW.order_price = room_price * days_stayed;
END$$

CREATE TRIGGER trg_room_bookings_bu
BEFORE UPDATE ON room_bookings
FOR EACH ROW
BEGIN
  DECLARE room_price DECIMAL(10,2);
  DECLARE days_stayed INT;
  SELECT price INTO room_price FROM rooms WHERE id = NEW.room_id;
  SET days_stayed = CEILING(TIMESTAMPDIFF(HOUR, NEW.check_in_time, NEW.check_out_time) / 24);
  IF days_stayed < 1 THEN
    SET days_stayed = 1;
  END IF;
  SET NEW.order_price = room_price * days_stayed;
END$$
DELIMITER ;

INSERT INTO room_bookings (order_id, customer_id, room_id, check_in_time, check_out_time, order_price) VALUES
    (1, 1, 3,  '2026-01-15 14:00:00', '2026-01-17 12:00:00', 0.00),
    (2, 2, 8,  '2026-01-16 16:00:00', '2026-01-18 11:00:00', 0.00),
    (3, 3, 10, '2026-01-20 13:00:00', '2026-01-22 12:00:00', 0.00)
ON DUPLICATE KEY UPDATE
    customer_id = VALUES(customer_id),
    room_id = VALUES(room_id),
    check_in_time = VALUES(check_in_time),
    check_out_time = VALUES(check_out_time),
    order_price = VALUES(order_price);
