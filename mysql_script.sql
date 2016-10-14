CREATE USER 'my_graphite'@'localhost' IDENTIFIED BY 'hello_world';
SELECT 'Create user: my_graphite with password: hello_world.' AS ' ';
GRANT ALL PRIVILEGES ON * . * TO 'my_graphite'@'localhost';
SELECT 'Grant privileges to the user: my_graphite.' AS ' ';
CREATE DATABASE graphite_backend;
SELECT 'Create database graphite_backend' AS '';
USE mysql;
SELECT user, host FROM user WHERE user = "my_graphite";