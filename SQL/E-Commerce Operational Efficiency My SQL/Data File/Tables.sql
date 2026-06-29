-- 1. إنشاء قاعدة البيانات
CREATE DATABASE IF NOT EXISTS ECommerce_DB;

-- 2. البدء في استخدامها
USE ECommerce_DB;


-- 1. جدول الفئات
CREATE TABLE Categories (
    CategoryID INT NOT NULL AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT,
    PRIMARY KEY (CategoryID)
) ENGINE=InnoDB;

-- 2. جدول العملاء
CREATE TABLE Customers (
    CustomerID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    City VARCHAR(50),
    JoinDate DATE,
    PRIMARY KEY (CustomerID)
) ENGINE=InnoDB;

-- 3. جدول المنتجات
CREATE TABLE Products (
    ProductID INT NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 4. جدول الطلبات
CREATE TABLE Orders (
    OrderID INT NOT NULL AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(20),
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. جدول تفاصيل الطلب
CREATE TABLE OrderDetails (
    OrderDetailID INT NOT NULL AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    PRIMARY KEY (OrderDetailID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. جدول المدفوعات
CREATE TABLE Payments (
    PaymentID INT NOT NULL AUTO_INCREMENT,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7. جدول الشحن
CREATE TABLE Shipping (
    ShippingID INT NOT NULL AUTO_INCREMENT,
    OrderID INT,
    ShippingDate DATE,
    TrackingNumber VARCHAR(100),
    Carrier VARCHAR(50),
    ShippingStatus VARCHAR(20),
    PRIMARY KEY (ShippingID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
) ENGINE=InnoDB;