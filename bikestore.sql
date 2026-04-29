
DROP DATABASE IF EXISTS bike_store;

# Create the database
CREATE DATABASE bike_store;

# Use the database
USE bike_store;

# Create the customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

# Create the bikes table
CREATE TABLE bikes (
    bike_id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

# Create the suppliers table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact VARCHAR(100)
);

# Create the inventory table
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    bike_id INT,
    supplier_id INT,
    quantity INT NOT NULL,
    date_received DATE NOT NULL,
    FOREIGN KEY (bike_id) REFERENCES bikes(bike_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

# Create the sales table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    bike_id INT,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (bike_id) REFERENCES bikes(bike_id)
);

# Add data into customers
INSERT INTO customers (name, email, phone) VALUES ('Hugo Gonzalez', 'hugogonzalez@gmail.com', '237459000');
INSERT INTO customers (name, email, phone) VALUES ('Daniel Sánchez', 'danielsanchez@gmail.com', '987654321');
INSERT INTO customers (name, email, phone) VALUES ('Susana Gutierrez', 'susanagutierrez@gmail.com', '181518159');

# Add data into bikes
INSERT INTO bikes (brand, model, price) VALUES ('Trek', 'Madone', 7000.00);
INSERT INTO bikes (brand, model, price) VALUES ('Orbea', 'Oiz', 5400.00);
INSERT INTO bikes (brand, model, price) VALUES ('Canyon', 'Aeroad', 9500.00);

# Add data into suppliers
INSERT INTO suppliers (name, contact) VALUES ('Scapa', 'scapa@gmail.com');
INSERT INTO suppliers (name, contact) VALUES ('Bicilab', 'bicilab@gmail.com');

# Add data into inventory
INSERT INTO inventory (bike_id, supplier_id, quantity, date_received) VALUES (1, 1, 10, '2024-03-01');
INSERT INTO inventory (bike_id, supplier_id, quantity, date_received) VALUES (2, 2, 5, '2023-12-05');
INSERT INTO inventory (bike_id, supplier_id, quantity, date_received) VALUES (3, 2, 3, '2024-01-10');

# Add data into sales
INSERT INTO sales (customer_id, bike_id, sale_date, quantity) VALUES (1, 1, '2024-06-02', 1);
INSERT INTO sales (customer_id, bike_id, sale_date, quantity) VALUES (2, 2, '2024-01-18', 3);
INSERT INTO sales (customer_id, bike_id, sale_date, quantity) VALUES (3, 3, '2024-03-19', 2);

# Update data in customers
UPDATE customers SET phone = '000886995' WHERE customer_id = 1;

# Delete data from sales
DELETE FROM sales WHERE sale_id = 2;

# View the total sales by bike brand
SELECT b.brand, SUM(s.quantity) AS total_sales
FROM bikes b
JOIN sales s ON b.bike_id = s.bike_id
GROUP BY b.brand;

# View the total sales per month
SELECT MONTH(sale_date) AS month, SUM(quantity) AS total_sales
FROM sales
GROUP BY MONTH(sale_date);
