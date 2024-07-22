create view customerBorrowCount as 
select c.customerId,count(b.borroeId) as borrowCount 
from customers c
join borrows b on c.customerId=b.customerId 
group by c.customerid; 

SELECT 
  round(AVG(borrow_count)) AS AverageBooksBorrowedLastMonth
FROM (
  SELECT 
    b.customerId,
    COUNT(b.BORROEID) AS borrow_count
  FROM 
    BORROWS b
  WHERE 
    b.BORROWDATE >= add_months(SYSDATE,-1)
  GROUP BY 
    b.customerId
)

WITH MaxBooks AS (
  SELECT 
    MAX(borrow.BorrowCount) AS MaxBorrowCount
  FROM 
    CustomerBorrowCount borrow
)

SELECT 
  borrow.customerId,
  borrow.BorrowCount
FROM 
  CustomerBorrowCount borrow
JOIN 
  MaxBooks max_books ON borrow.BorrowCount = max_books.MaxBorrowCount;
  
CREATE VIEW CustomerActivitySummary AS
SELECT 
  c.customerId,
  p.P_NAME,
  COUNT(ba.A_ID) AS TotalActivities,
  SUM(a.COST) AS TotalActivityCost
FROM 
  CUSTOMERS c
JOIN 
  PERSON p ON c.customerId = p.P_ID
JOIN 
  BOOKING b ON c.customerId = b.customerId
JOIN 
  BOOKINGACTIVITIES ba ON b.B_ID = ba.B_ID
JOIN 
  ACTIVITIES a ON ba.A_ID = a.A_ID
GROUP BY 
  c.customerId, p.P_NAME;
  


SELECT 
  c.customerId,
  p.P_NAME
FROM 
  CustomerActivitySummary c
JOIN 
  PERSON p ON c.customerId = p.P_ID
WHERE 
  TotalActivities = 0;
  

WITH AvgActivityCost AS (
  SELECT 
    AVG(TotalActivityCost) AS AvgCost
  FROM 
    CustomerActivitySummary
)

SELECT 
  c.customerId,
  p.P_NAME,
  c.TotalActivityCost
FROM 
  CustomerActivitySummary c
JOIN 
  PERSON p ON c.customerId = p.P_ID
JOIN 
  AvgActivityCost a ON c.TotalActivityCost > a.AvgCost;
