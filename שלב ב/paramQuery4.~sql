SELECT 
    c.CustomerID,
    c.cName,
    br.BorrowDate
FROM 
    Customers c
JOIN 
    Borrows br ON c.CustomerID=br.CustomerID
JOIN 
    BooksToBorrow bt ON br.BookNumber=bt.BookNumber
JOIN 
    BooksCatalog b ON bt.BookID=b.BookID
WHERE 
    b.BookName=&<name="bookName" list="select BookName from BooksCatalog" type="string">
    AND br.BorrowDate>=ADD_MONTHS(SYSDATE,-1)
ORDER BY br.BorrowDate DESC;
