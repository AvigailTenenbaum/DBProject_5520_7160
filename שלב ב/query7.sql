UPDATE Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Borrows
    GROUP BY CustomerID
    HAVING COUNT(BookNumber) > 2
);
