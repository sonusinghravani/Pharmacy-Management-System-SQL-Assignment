# 🏥 Pharmacy Management System – SQL Assignment

This repository contains the **SQL Placement Readiness Assignment** focused on designing and querying a relational database for a pharmacy. The assignment includes schema creation, data manipulation (DML), and analytical queries using MySQL.

---

## 📁 Schema Overview

The database consists of four main tables:

| Table       | Description |
|-------------|-------------|
| **Medicines**   | Stores medicine details like name, type, price, stock, expiry, and manufacturer |
| **Suppliers**   | Contains supplier information including name, phone, and city |
| **Purchases**   | Records purchases from suppliers (linked to Medicines & Suppliers) |
| **Sales**       | Tracks sales transactions with medicine, quantity, date, and total price |

---

## 🛠️ Tasks Implemented

### 🔧 DDL (Data Definition Language)
1. Added `manufacturer` column to `Medicines`.
2. Renamed `contact_number` → `phone` in `Suppliers`.
3. Inserted a new medicine: **Amoxicillin 500mg**.
4. Increased all medicine prices by **10%**.
5. Deleted expired medicines (expiry date < today).

### 📊 Aggregation Queries
6. Total sales revenue per medicine.  
7. Supplier who supplied the maximum quantity.  
8. Total units sold per medicine type.

### 🔍 Subqueries & Advanced Logic
9. Medicines with stock below average.  
10. Medicines never sold.  
11. Suppliers with total supplied quantity > 500.  
12. Medicine types where average price > ₹100.  
13. Full purchase records with medicine & supplier names.  
14. All sales with medicine name and type.  
15. Medicines expiring within next **90 days**.  
16. Number of sales & revenue in the last **30 days**.  

### 🧾 Additional Queries
17. Suppliers whose names start with **'S'**.  
18. Display all medicine names in **UPPERCASE**.  
19. Top 3 best-selling medicines by quantity.  
20. Medicines purchased but **never sold**.

---

## 💻 Sample Code Snippets

### Add Manufacturer Column
```sql
 ALTER TABLE Medicines
 ADD COLUMN manufacturer VARCHAR(100);

## Update Prices by 10%
SET SQL_SAFE_UPDATES = 0;
UPDATE Medicines
SET unit_price = unit_price * 1.10;
SET SQL_SAFE_UPDATES = 1;

## Top 3 Best-Selling Medicines
SELECT
  m.name AS medicine_name,
  m.type,
  SUM(s.quantity) AS total_quantity_sold
FROM Sales s
JOIN Medicines m ON s.medicine_id = m.medicine_id
GROUP BY m.medicine_id, m.name, m.type
ORDER BY total_quantity_sold DESC
LIMIT 3;

 ---

      
