create database pharmacy;
use pharmacy;

-- Medicines Table
CREATE TABLE Medicines (
    medicine_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(20),          
    unit_price DECIMAL(10,2),
    stock_quantity INT,
    expiry_date DATE

);

-- Suppliers Table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(100),
    contact_number VARCHAR(15),
    city VARCHAR(50)
);

-- Purchases Table
CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY,
    supplier_id INT,
    medicine_id INT,
    quantity INT,
    purchase_date DATE,
    batch_number VARCHAR(50),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);

-- Sales Table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    medicine_id INT,
    quantity INT,
    sale_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);