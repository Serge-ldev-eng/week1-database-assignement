-- ============================================
-- Bank Management System Database
-- ============================================

-- Create the database
CREATE DATABASE bank_management;

-- Select the database
USE bank_management;

-- ============================================
-- 1. Branches Table
-- ============================================

CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    location VARCHAR(150) NOT NULL,
    phone VARCHAR(20)
);

-- ============================================
-- 2. Customers Table
-- ============================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(200),
    date_of_birth DATE
);

-- ============================================
-- 3. Accounts Table
-- ============================================

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    date_opened DATE NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- ============================================
-- 4. Transactions Table
-- ============================================

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(200),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

-- ============================================
-- 5. Employees Table
-- ============================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- ============================================
-- Sample Data
-- ============================================

-- Insert branches
INSERT INTO branches (branch_name, location, phone)
VALUES
('Central Branch', 'Nairobi CBD', '020-1234567'),
('Westlands Branch', 'Westlands, Nairobi', '020-7654321');

-- Insert customers
INSERT INTO customers
(first_name, last_name, email, phone, address, date_of_birth)
VALUES
('John', 'Kamau', 'john@example.com', '0712345678',
 'Nairobi, Kenya', '1998-05-15'),

('Mary', 'Wanjiku', 'mary@example.com', '0723456789',
 'Kiambu, Kenya', '1995-09-20');

-- Insert accounts
INSERT INTO accounts
(customer_id, branch_id, account_number, account_type, balance, date_opened)
VALUES
(1, 1, 'ACC100001', 'Savings', 50000.00, '2026-01-10'),
(2, 2, 'ACC100002', 'Checking', 75000.00, '2026-02-15');

-- Insert transactions
INSERT INTO transactions
(account_id, transaction_type, amount, description)
VALUES
(1, 'Deposit', 50000.00, 'Initial deposit'),
(1, 'Withdrawal', 5000.00, 'ATM withdrawal'),
(2, 'Deposit', 75000.00, 'Initial deposit');

-- Insert employees
INSERT INTO employees
(branch_id, first_name, last_name, job_title, email, phone)
VALUES
(1, 'Peter', 'Otieno', 'Bank Manager',
 'peter@example.com', '0734567890'),

(2, 'Jane', 'Achieng', 'Cashier',
 'jane@example.com', '0745678901');
