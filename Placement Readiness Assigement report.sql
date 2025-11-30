-- 1. Add a column 'manufacturer' to the Medicines table
create database pharmacy;
use pharmacy;


ALTER TABLE Medicines
ADD COLUMN manufacturer VARCHAR(100);

-- 2. Rename the column 'contact_number' to 'phone' in Suppliers
ALTER TABLE Suppliers
CHANGE COLUMN contact_number phone VARCHAR(15);




-- 3. Insert a new medicine 'Amoxicillin'
-- (Assuming it's a different variant or batch; using a new medicine_id)
INSERT INTO Medicines (medicine_id, name, type, unit_price, stock_quantity, expiry_date, manufacturer)
VALUES (21, 'Amoxicillin 500mg', 'Capsule', 9.50, 200, '2027-06-30', 'MediPharm Ltd.');

-- 4. Update all medicine prices by 10%
SET SQL_SAFE_UPDATES = 0;

UPDATE Medicines
SET unit_price = unit_price * 1.10;

SET SQL_SAFE_UPDATES = 1;
select * from medicines;
-- 5. Delete medicines that are expired (expiry_date is before today)
DELETE FROM Medicines
WHERE expiry_date < CURDATE();


-- 6. Find total sales revenue per medicine
SELECT 
    m.name AS medicine_name,
    SUM(s.total_price) AS total_revenue
FROM Sales s
JOIN Medicines m ON s.medicine_id = m.medicine_id
GROUP BY m.medicine_id, m.name
ORDER BY total_revenue DESC;

-- 7. Find the supplier who provided the maximum quantity
SELECT 
    sup.name AS supplier_name,
    SUM(p.quantity) AS total_quantity_supplied
FROM Purchases p
JOIN Suppliers sup ON p.supplier_id = sup.supplier_id
GROUP BY sup.supplier_id, sup.name
ORDER BY total_quantity_supplied DESC
LIMIT 1;
select * from purchases;
-- 8. Total units sold per medicine type
SELECT 
    m.type AS medicine_type,
    SUM(s.quantity) AS total_units_sold
FROM Sales s
JOIN Medicines m ON s.medicine_id = m.medicine_id
GROUP BY m.type
ORDER BY total_units_sold DESC;

-- 9. Medicines with stock below average
SELECT 
    medicine_id,
    name,
    stock_quantity
FROM Medicines
WHERE stock_quantity < (
    SELECT AVG(stock_quantity)
    FROM Medicines
);

-- 10. Medicines never sold
SELECT 
    medicine_id,
    name
FROM Medicines
WHERE medicine_id NOT IN (
    SELECT DISTINCT medicine_id
    FROM Sales
    WHERE medicine_id IS NOT NULL
);

-- 11. Suppliers with total supplied quantity > 500
SELECT 
    sup.supplier_id,
    sup.name AS supplier_name,
    SUM(p.quantity) AS total_supplied
FROM Suppliers sup
JOIN Purchases p ON sup.supplier_id = p.supplier_id
GROUP BY sup.supplier_id, sup.name
HAVING total_supplied > 500
ORDER BY total_supplied DESC;

-- 12. Medicine types where average price > ₹100
SELECT 
    type AS medicine_type,
    AVG(unit_price) AS average_price
FROM Medicines
GROUP BY type
HAVING average_price > 100
ORDER BY average_price DESC;

-- 13. List all purchase records along with medicine and supplier names
SELECT 
    p.purchase_id,
    p.purchase_date,
    p.batch_number,
    p.quantity,
    m.name AS medicine_name,
    s.name AS supplier_name
FROM Purchases p
JOIN Medicines m ON p.medicine_id = m.medicine_id
JOIN Suppliers s ON p.supplier_id = s.supplier_id
ORDER BY p.purchase_date DESC;

-- 14. Show all sales with corresponding medicine name and type
SELECT 
    sa.sale_id,
    sa.sale_date,
    sa.quantity,
    sa.total_price,
    m.name AS medicine_name,
    m.type AS medicine_type
FROM Sales sa
JOIN Medicines m ON sa.medicine_id = m.medicine_id
ORDER BY sa.sale_date DESC;

-- 15. List medicines that will expire within the next 90 days
SELECT 
    medicine_id,
    name,
    type,
    stock_quantity,
    expiry_date
FROM Medicines
WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 90 DAY)
ORDER BY expiry_date;

-- 16. Count number of sales made in the last 30 days
SELECT 
    COUNT(*) AS sales_count,
    SUM(total_price) AS total_revenue_last_30_days
FROM Sales
WHERE sale_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- 17. List supplier names that start with the letter 'S'
SELECT 
    supplier_id,
    name AS supplier_name,
    phone,
    city
FROM Suppliers
WHERE name LIKE 'S%';

-- 18. Convert all medicine names to uppercase
SELECT 
    medicine_id,
    UPPER(name) AS medicine_name_upper,
    type,
    unit_price,
    stock_quantity,
    expiry_date,
    manufacturer
FROM Medicines;

-- 19. Show the top 3 best-selling medicines by quantity
SELECT 
    m.name AS medicine_name,
    m.type,
    SUM(s.quantity) AS total_quantity_sold
FROM Sales s
JOIN Medicines m ON s.medicine_id = m.medicine_id
GROUP BY m.medicine_id, m.name, m.type
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- 20. List medicines that were purchased but never sold
SELECT 
    m.medicine_id,
    m.name,
    m.type,
    m.stock_quantity
FROM Medicines m
WHERE m.medicine_id IN (
    SELECT DISTINCT p.medicine_id
    FROM Purchases p
)
AND m.medicine_id NOT IN (
    SELECT DISTINCT s.medicine_id
    FROM Sales s
    WHERE s.medicine_id IS NOT NULL
);

