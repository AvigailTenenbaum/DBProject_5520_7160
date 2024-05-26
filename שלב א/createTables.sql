CREATE TABLE Customers
(
  CustomerID NUMERIC(5) NOT NULL,
  cName VARCHAR(15),
  Address VARCHAR(15),
  DateOfBirth DATE NOT NULL,
  Phone VARCHAR(10),
  PRIMARY KEY (CustomerID)
);

CREATE TABLE Categories
(
  CategoryID NUMERIC(5) NOT NULL,
  cType VARCHAR(15),
  FromAge INT NOT NULL,
  PRIMARY KEY (CategoryID)
);

CREATE TABLE Librarians
(
  LibraryID NUMERIC(5) NOT NULL,
  lName VARCHAR(15),
  PhoneNumber VARCHAR(10),
  PRIMARY KEY (LibraryID)
);

CREATE TABLE Authors
(
  AuthorID NUMERIC(5) NOT NULL,
  aName VARCHAR(15),
  PRIMARY KEY (AuthorID)
);

CREATE TABLE BooksCatalog
(
  BookID NUMERIC(5) NOT NULL,
  BookName VARCHAR(15),
  Amount INT,
  CategoryID NUMERIC(5),
  AuthorID NUMERIC(5),
  PRIMARY KEY (BookID),
  FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
  FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE BooksToBorrow
(
  BookNumber NUMERIC(5) NOT NULL,
  isBorrow CHAR(1),
  BookID NUMERIC(5) NOT NULL,
  PRIMARY KEY (BookNumber),
  FOREIGN KEY (BookID) REFERENCES BooksCatalog(BookID)
);

CREATE TABLE Borrows
(
  BorroeId NUMERIC(5) NOT NULL,
  ReturnDate DATE,
  BorrowDate DATE,
  BookNumber NUMERIC(5) NOT NULL,
  CustomerID NUMERIC(5) NOT NULL,
  LibraryID NUMERIC(5) NOT NULL,
  PRIMARY KEY (BorroeId),
  FOREIGN KEY (BookNumber) REFERENCES BooksToBorrow(BookNumber),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (LibraryID) REFERENCES Librarians(LibraryID)
);
