SELECT 
    c.cName AS CustomerName,
    c.CustomerID,
    cb.BorrowCount
FROM 
    Customers c
JOIN 
    (SELECT 
         CustomerID, 
         COUNT(BorroeId) AS BorrowCount
     FROM 
         Borrows
     GROUP BY 
         CustomerID
     ORDER BY 
         BorrowCount DESC) cb
ON 
    c.CustomerID=cb.CustomerID
WHERE ROWNUM=1;
