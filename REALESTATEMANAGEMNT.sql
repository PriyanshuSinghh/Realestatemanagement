-- Step 1: Create the database
CREATE DATABASE RealEstateManagementSystem;
USE RealEstateManagementSystem;

-- Step 2: Create the Properties table
CREATE TABLE Properties (
    PropertyID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    PropertyType VARCHAR(50),
    Rent DECIMAL(10, 2) NOT NULL,
    Available BOOLEAN DEFAULT TRUE,  -- TRUE if available for rent
    Owner VARCHAR(100)
);

-- Step 3: Create the Tenants table
CREATE TABLE Tenants (
    TenantID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255),
    Email VARCHAR(100),
    DateOfBirth DATE
);

-- Step 4: Create the Leases table
CREATE TABLE Leases (
    LeaseID INT AUTO_INCREMENT PRIMARY KEY,
    TenantID INT NOT NULL,
    PropertyID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    RentAmount DECIMAL(10, 2) NOT NULL,
    LeaseStatus VARCHAR(50) DEFAULT 'Active',  -- Active, Completed, Terminated
    FOREIGN KEY (TenantID) REFERENCES Tenants(TenantID),
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID)
);

-- Step 5: Create the Payments table (linked to Lease)
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    LeaseID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50),  -- E.g., Credit Card, Bank Transfer
    FOREIGN KEY (LeaseID) REFERENCES Leases(LeaseID)
);

-- Step 6: Create the Maintenance Requests table
CREATE TABLE MaintenanceRequests (
    MaintenanceRequestID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT NOT NULL,
    TenantID INT NOT NULL,
    IssueDescription TEXT NOT NULL,
    RequestDate DATE NOT NULL,
    Status VARCHAR(50) DEFAULT 'Pending',  -- Pending, In Progress, Resolved
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (TenantID) REFERENCES Tenants(TenantID)
);

-- Step 7: Insert Sample Data

-- Insert properties (mark available TRUE for those with no tenant)
INSERT INTO Properties (Address, PropertyType, Rent, Owner, Available) VALUES
('123 Main St, City', 'Apartment', 1200.00, 'John Doe', FALSE),
('456 Elm St, City', 'House', 1500.00, 'Jane Smith', FALSE),
('789 Oak St, City', 'Condo', 1000.00, 'Alice Johnson', FALSE),
('101 Pine St, City', 'Villa', 2000.00, 'Michael Brown', FALSE),
('202 Maple St, City', 'Apartment', 900.00, 'Susan Clark', TRUE);

-- Insert tenants
INSERT INTO Tenants (Name, ContactInfo, Email, DateOfBirth) VALUES
('Tom Harris', '123-456-7890', 'tom.harris@example.com', '1990-06-15'),
('Emma Lee', '987-654-3210', 'emma.lee@example.com', '1985-02-20'),
('John Green', '456-789-1230', 'john.green@example.com', '1987-07-10'),
('Sarah Brown', '789-123-4560', 'sarah.brown@example.com', '1992-11-30');

-- Insert leases (assigned tenants to properties, making them unavailable)
INSERT INTO Leases (TenantID, PropertyID, StartDate, EndDate, RentAmount) VALUES
(1, 1, '2024-01-01', '2025-01-01', 1200.00),
(2, 2, '2024-05-01', '2025-05-01', 1500.00),
(3, 3, '2024-03-01', '2025-03-01', 1000.00),
(4, 4, '2024-06-01', '2025-06-01', 2000.00);

-- Insert payments
INSERT INTO Payments (LeaseID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2024-01-05', 1200.00, 'Credit Card'),
(2, '2024-05-10', 1500.00, 'Bank Transfer'),
(3, '2024-03-15', 1000.00, 'Debit Card'),
(4, '2024-06-10', 2000.00, 'Bank Transfer');

-- Insert maintenance requests
INSERT INTO MaintenanceRequests (PropertyID, TenantID, IssueDescription, RequestDate) VALUES
(1, 1, 'Leaking faucet in the kitchen', '2024-06-15'),
(2, 2, 'Broken air conditioning unit', '2024-06-20'),
(3, 3, 'Faulty plumbing in the bathroom', '2024-07-05'),
(4, 4, 'Pest infestation in the kitchen', '2024-07-10');
