create database libraryproject;
use libraryproject;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10,2),
    Status VARCHAR(10), -- 'Yes' or 'No'
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust_id INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust_id) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO Branch VALUES
(1, 101, 'Main Street, Kochi', '9876543210'),
(2, 102, 'MG Road, Chennai', '9123456789'),
(3, 103, 'Main Street, Calicut', '987658210'),
(4, 104, 'MG Road, Trivandrum', '9123400789');
INSERT INTO Employee VALUES
(101, 'Amaya Ahmed', 'Manager', 60000, 1),
(102, 'Arthur Merlin', 'Clerk', 40000, 1),
(103, 'Suhara Majid', 'Manager', 55000, 2),
(104, 'Manu Swaminathan', 'Admin', 35000, 1);
INSERT INTO Books VALUES
('ISBN101', 'Data Structures', 'Education', 30.00, 'Yes', 'Mark Allen', 'Pearson'),
('ISBN102', 'History of India', 'History', 40.00, 'No', 'K. S. Lal', 'OUP'),
('ISBN103', 'Python Basics', 'Education', 25.00, 'Yes', 'Paul Barry', 'OUP');
INSERT INTO Customer VALUES
(201, 'Neha Sharma', 'Delhi', '2021-06-15'),
(202, 'Ajay Menon', 'Kerala', '2022-11-10'),
(203, 'Sneha Roy', 'Mumbai', '2020-12-25');
INSERT INTO IssueStatus VALUES
(301, 201, 'Data Structures', '2023-06-10', 'ISBN101'),
(302, 203, 'History of India', '2023-06-15', 'ISBN102');
INSERT INTO ReturnStatus VALUES
(401, 201, 'Data Structures', '2023-07-10', 'ISBN101');

-- Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'Yes';

-- salary of employee
SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books.
SELECT I.Issued_book_name, C.Customer_name FROM IssueStatus I
JOIN Customer C ON I.Issued_cust_id = C.Customer_Id;

-- Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books FROM Books GROUP BY Category;

-- Retrieve the employee details for employees whose salaries are above Rs. 50,000.
SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books.
SELECT C.Customer_name FROM Customer C
LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust_id
WHERE C.Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES (204, 'Indira Menon', 'Chennai', '2020-01-01');
select * from customer;

-- Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT C.Customer_name FROM IssueStatus I
JOIN Customer C ON I.Issued_cust_id = C.Customer_Id
WHERE MONTH(I.Issue_date) = 6 AND YEAR(I.Issue_date) = 2023;

-- Retrieve book_title from Books table containing "history" (case-insensitive).
SELECT Book_title FROM Books
WHERE LOWER(Book_title) LIKE '%history%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee
GROUP BY Branch_no HAVING COUNT(*) > 5;

-- Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_name, B.Branch_address FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;

-- Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT DISTINCT C.Customer_name FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust_id
JOIN Books B ON I.Isbn_book = B.ISBN WHERE B.Rental_Price > 25;















