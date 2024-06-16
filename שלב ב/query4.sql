WITH BorrowCounts AS (
    SELECT 
        c.CustomerID,
        c.cName,
        COUNT(b.BorroeId) AS BorrowCount
    FROM 
        Customers c
    JOIN 
        Borrows b ON c.CustomerID = b.CustomerID
    GROUP BY 
        c.CustomerID, c.cName
),
MaxBorrowCount AS (
    SELECT 
        MAX(BorrowCount) AS MaxCount
    FROM 
        BorrowCounts
)
SELECT 
    bc.CustomerID,
    bc.cName,
    bc.BorrowCount
FROM 
    BorrowCounts bc
JOIN 
    MaxBorrowCount mbc ON bc.BorrowCount = mbc.MaxCount;  
