-- Insert data into Customers table
INSERT INTO Customers(CustomerID,CName,Address,DateOfBirth,Phone)
VALUES(1,'John Doe','123 Elm St',TO_DATE('07.12.2003', 'DD.MM.YYYY'),'5551234567');

INSERT INTO Customers(CustomerID,CName,Address,DateOfBirth,Phone)
VALUES(2,'Jane Smith','456 Oak St',TO_DATE('07.12.2003', 'DD.MM.YYYY'),'5559876543');

SELECT * FROM Categories;
-- Insert data into Categories table
INSERT INTO Categories(CategoryID,CType,FromAge)
VALUES(1,'Fiction',12);

INSERT INTO Categories(CategoryID,CType,FromAge)
VALUES(2,'Non-Fiction',16);

-- Insert data into Librarians table
SELECT * FROM Librarians;
INSERT INTO Librarians(LibraryID,LName,PhoneNumber)
VALUES(1,'Alice Johnson','5551122334');

INSERT INTO Librarians(LibraryID,LName,PhoneNumber)
VALUES(2,'Bob Brown','5552233445');

-- Insert data into Authors table
SELECT * FROM Authors;
INSERT INTO Authors
VALUES(1,'Mark Twain');

INSERT INTO Authors
VALUES(2,'J.K. Rowling');

-- Insert data into BooksCatalog table
SELECT * FROM BooksCatalog;
INSERT INTO BooksCatalog(BookID,BookName,Amount,CategoryID,AuthorID)
VALUES(1,'Tom Sawyer',5,1,1);

INSERT INTO BooksCatalog(BookID,BookName,Amount,CategoryID,AuthorID)
VALUES(2,'Harry Potter',10,1,2);

-- Insert data into BooksToBorrow table
SELECT * FROM BooksToBorrow;
INSERT INTO BooksToBorrow(BookNumber,isBorrow,BookID)
VALUES(1,'N',1);

INSERT INTO BooksToBorrow(BookNumber,isBorrow,BookID)
VALUES(2,'Y',2);

-- Insert data into Borrows table
SELECT * FROM Borrows;
INSERT INTO Borrows(BorroeId,ReturnDate,BorrowDate,BookNumber,CustomerID,LibraryID)
VALUES(1,'2024-06-01','2024-05-01',2,1,1);

INSERT INTO Borrows(BorroeId,ReturnDate,BorrowDate,BookNumber,CustomerID,LibraryID)
VALUES(2,'2024-07-01','2024-06-01',1,2,2);
