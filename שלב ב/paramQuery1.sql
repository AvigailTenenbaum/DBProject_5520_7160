SELECT 
    b.BookID,
    b.BookName,
    b.Amount,
    b.CategoryID,
    b.AuthorID
FROM 
    Customers c
JOIN 
    Borrows br ON c.CustomerID=br.CustomerID
JOIN 
    BooksToBorrow bt ON br.BookNumber=bt.BookNumber
JOIN 
    BooksCatalog b ON bt.BookID=b.BookID
WHERE 
    c.CustomerID=&customerId;
