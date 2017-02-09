CREATE USER IF NOT EXISTS 'graphite'@'localhost' IDENTIFIED BY 'hello_world';
SELECT 'Create user: graphite with password: hello_world.' AS ' ';
GRANT ALL PRIVILEGES ON * . * TO 'graphite'@'localhost';
SELECT 'Grant privileges to the user: graphite.' AS ' ';
CREATE DATABASE IF NOT EXISTS graphite_backend;
SELECT 'Create database graphite_backend' AS '';
USE mysql;
SELECT user, host FROM user WHERE user = "graphite";