CREATE DATABASE IF NOT EXISTS mydb;
CREATE USER 'myuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%';
USE mydb;
CREATE TABLE IF NOT EXISTS students (id INT NOT NULL AUTO_INCREMENT, first_name VARCHAR(100), last_name VARCHAR(100), class_name VARCHAR(10), nationality VARCHAR(100), primary key (id));
