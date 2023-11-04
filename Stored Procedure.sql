-- Create a new database named "SampleDB"
CREATE DATABASE SampleDB;

-- Switch to the new database
USE SampleDB;

-- Create a new table named "Customers"
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    ContactName VARCHAR(50),
    Country VARCHAR(50)
);

-- Insert some sample data into the Customers table
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country)
VALUES (1, 'Shubham', 'Thakur', 'India'),
       (2, 'Aman ', 'Chopra', 'Australia'),
       (3, 'Naveen', 'Tulasi', 'Sri lanka'),
       (4, 'Aditya', 'Arpan', 'Austria'),
       (5, 'Nishant. Salchichas S.A.', 'Jain', 'Spain');

DELIMITER $$

-- Create a stored procedure named "GetCustomersByCountry"
CREATE PROCEDURE GetCustomersByCountry(IN V_Country VARCHAR(50))
BEGIN
    SELECT CustomerName, ContactName
    FROM Customers
    WHERE Country = V_Country;

    SELECT 'SQL PROCEDURE EXECUTED';
END $$

-- Call the procedure with a specific country value
CALL GetCustomersByCountry('Sri Lanka');
