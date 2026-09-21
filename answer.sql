-- Week 1 - Bank System Assignment
-- answer.sql - at ROOT

DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Branch;

-- 1. Branch Table
CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(100),
    assets DECIMAL(15,2)
);

-- 2. Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_street VARCHAR(100),
    customer_city VARCHAR(100),
    email VARCHAR(100)
);

-- 3. Account Table
CREATE TABLE Account (
    account_number VARCHAR(20) PRIMARY KEY,
    branch_id INT,
    customer_id INT,
    balance DECIMAL(12,2) NOT NULL CHECK (balance >= 0),
    account_type VARCHAR(20),
    opening_date DATE,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 4. Loan Table
CREATE TABLE Loan (
    loan_number VARCHAR(20) PRIMARY KEY,
    branch_id INT,
    customer_id INT,
    amount DECIMAL(12,2),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 5. Transaction Table
CREATE TABLE Depositor_Transaction (
    transaction_id INT PRIMARY KEY,
    account_number VARCHAR(20),
    transaction_type VARCHAR(10) CHECK (transaction_type IN ('Deposit','Withdrawal')),
    amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (account_number) REFERENCES Account(account_number)
);

-- Sample Data
INSERT INTO Branch VALUES (1, 'Kigali Central', 'Kigali', 10000000.00);
INSERT INTO Branch VALUES (2, 'Huye Branch', 'Huye', 5000000.00);

INSERT INTO Customer VALUES (101, 'Serge', 'KG 123 St', 'Kigali', 'serge@bank.rw');
INSERT INTO Customer VALUES (102, 'John Doe', 'KN 456 St', 'Kigali', 'john@bank.rw');

INSERT INTO Account VALUES ('A-101', 1, 101, 500000.00, 'Savings', '2024-01-10');
INSERT INTO Account VALUES ('A-102', 1, 102, 1200000.00, 'Checking', '2024-02-15');

INSERT INTO Loan VALUES ('L-11', 1, 101, 2000000.00);
INSERT INTO Depositor_Transaction VALUES (1, 'A-101', 'Deposit', 100000.00, '2024-02-01');
INSERT INTO Depositor_Transaction VALUES (2, 'A-101', 'Withdrawal', 50000.00, '2024-02-05');

-- Queries
-- Show all customers
SELECT * FROM Customer;

-- Show accounts with balance > 500k
SELECT * FROM Account WHERE balance > 500000;

-- Show customer and their account
SELECT c.customer_name, a.account_number, a.balance 
FROM Customer c JOIN Account a ON c.customer_id = a.customer_id;

-- Total balance per branch
SELECT branch_id, SUM(balance) as total_balance FROM Account GROUP BY branch_id;

-- Customers in Kigali
SELECT * FROM Customer WHERE customer_city = 'Kigali';

-- Order accounts by balance DESC
SELECT * FROM Account ORDER BY balance DESC;
