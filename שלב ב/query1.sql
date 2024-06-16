SELECT 
    c.cName AS CustomerName,
    c.CustomerID,
    b.BookName,
    TRUNC(SYSDATE - br.BorrowDate) AS DaysBorrowed
FROM 
    Customers c
JOIN 
    Borrows br ON c.CustomerID=br.CustomerID
JOIN 
    BooksToBorrow bt ON br.BookNumber=bt.BookNumber
JOIN 
    BooksCatalog b ON bt.BookID=b.BookID;
