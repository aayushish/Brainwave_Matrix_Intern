create database library;
show databases;
 use library;
-- Author Table
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Publisher Table
CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100),
    Address VARCHAR(255),
    ContactNumber VARCHAR(15)
);

-- Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- Book Table
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    ISBN VARCHAR(13),
    AuthorID INT,
    PublisherID INT,
    CategoryID INT,
    YearOfPublication YEAR,
    QuantityAvailable INT,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Member Table
CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    MembershipType VARCHAR(50)
);

-- Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(255)
);

-- BorrowingRecord Table
CREATE TABLE BorrowingRecord (
    RecordID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    StaffID INT,
    IssueDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FineAmount DECIMAL(10, 2),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);


-- Insert Authors
INSERT INTO Author (AuthorID,FirstName, LastName) VALUES (101,'George', 'Orwell');
INSERT INTO Author (AuthorID,FirstName, LastName) VALUES (102,'J.K.', 'Rowling');
INSERT INTO Author (AuthorID,FirstName, LastName) VALUES (103,'J.R.R.', 'Tolkien');
 
#tabel
select * from Author;


-- Insert Publishers
INSERT INTO Publisher (PublisherID,PublisherName, Address, ContactNumber) VALUES (1001,'Penguin Books', '375 Hudson St, New York, NY 10014, USA', '1234567890');
INSERT INTO Publisher (PublisherID,PublisherName, Address, ContactNumber) VALUES (1002,'Bloomsbury', '50 Bedford Square, London, WC1B 3DP, UK', '0987654321');
INSERT INTO Publisher (PublisherID,PublisherName, Address, ContactNumber) VALUES (1003,'HarperCollins', '195 Broadway, New York, NY 10007, USA', '1122334455');

#Publishertable
select * from Publisher;

-- Insert Categories
INSERT INTO Category (CategoryID,CategoryName) VALUES (001,'Fiction');
INSERT INTO Category (CategoryID,CategoryName) VALUES (002,'Fantasy');
INSERT INTO Category (CategoryID,CategoryName) VALUES (003,'Science Fiction');

#categories table
select * from category;

-- Insert Books
INSERT INTO Book (BookID,Title, ISBN, AuthorID, PublisherID, CategoryID, YearOfPublication, QuantityAvailable)
VALUES (201,'1984', '9780451524935', 101, 1001, 001, 1949, 5);
INSERT INTO Book (BookID,Title, ISBN, AuthorID, PublisherID, CategoryID, YearOfPublication, QuantityAvailable)
VALUES (202,'Harry Potter and the Philosopher\'s Stone', '9780747532743', 102, 1002, 002, 1997, 3);
INSERT INTO Book (BookID,Title, ISBN, AuthorID, PublisherID, CategoryID, YearOfPublication, QuantityAvailable)
VALUES (203,'The Hobbit', '9780547928227', 103,1003, 002, 1937, 4);

#booksTables
select * from Book;

-- Insert Members
INSERT INTO Member (MemberID,FirstName, LastName, Address, PhoneNumber, Email, MembershipType)
VALUES (1234,'John', 'Doe', '123 Main St, Springfield, USA', '5551234567', 'john.doe@example.com', 'Standard');
INSERT INTO Member (MemberID,FirstName, LastName, Address, PhoneNumber, Email, MembershipType)
VALUES (1235,'Jane', 'Smith', '456 Elm St, Springfield, USA', '5559876543', 'jane.smith@example.com', 'Premium');

#MembersTable
select * from Member;

-- Insert Staff
INSERT INTO Staff (StaffID,FirstName, LastName, Role, Email, Password)
VALUES (101,'Alice', 'Johnson', 'Librarian', 'alice.johnson@example.com', 'password123');
INSERT INTO Staff (StaffID,FirstName, LastName, Role, Email, Password)
VALUES (102,'Bob', 'Brown', 'Assistant Librarian', 'bob.brown@example.com', 'password456');

#StaffTable
select * from Staff;

-- Insert Borrowing Records
INSERT INTO BorrowingRecord (RecordID,BookID, MemberID, StaffID, IssueDate, DueDate, ReturnDate, FineAmount)
VALUES (1001,201, 1234, 101, '2024-08-01', '2024-08-15', NULL, 0.00);
INSERT INTO BorrowingRecord (RecordID,BookID, MemberID, StaffID, IssueDate, DueDate, ReturnDate, FineAmount)
VALUES (1002,202, 1235, 102, '2024-08-05', '2024-08-19', NULL, 0.00);

#Borrowing Records table
 select * from BorrowingRecord; 
 
 
 
 
 # SOME QURIRES
 
 #Retrieve All Books and Their Authors
SELECT b.Title, a.FirstName, a.LastName, p.PublisherName, c.CategoryName, b.YearOfPublication, b.QuantityAvailable
FROM Book b
JOIN Book ba ON b.BookID = ba.BookID
JOIN Author a ON ba.AuthorID = a.AuthorID
JOIN Publisher p ON b.PublisherID = p.PublisherID
JOIN Category c ON b.CategoryID = c.CategoryID;

#Retrieve All Borrowing Records for a Specific Member
SELECT br.RecordID, b.Title, br.IssueDate, br.DueDate, br.ReturnDate, br.FineAmount
FROM BorrowingRecord br
JOIN Book b ON br.BookID = b.BookID
WHERE br.MemberID = 1; 

-- Set the Return Date for a Borrowing Record
UPDATE BorrowingRecord
SET ReturnDate = '2024-08-26'
WHERE RecordID = 1001;

 select * from BorrowingRecord;

-- Calculate Fine 
UPDATE BorrowingRecord
SET FineAmount = DATEDIFF(ReturnDate, DueDate) * 1
WHERE RecordID = 1001 AND ReturnDate > DueDate;

select * from BorrowingRecord;

#Check Book Availability

SELECT Title, QuantityAvailable
FROM Book
WHERE BookID = 201;

#Add a New Member

INSERT INTO Member (MemberID,FirstName, LastName, Address, PhoneNumber, Email, MembershipType)
VALUES (1237,'Emily', 'Clark', '789 Pine St, Springfield, USA', '5553334444', 'emily.clark@example.com', 'Standard');

select * from Member;

#Delete a Book
DELETE FROM Book
WHERE BookID = 1; 



