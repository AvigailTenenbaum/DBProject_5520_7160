SELECT 
    b.BookName,
    COUNT(*) AS BorrowCount
FROM 
    Borrows br
JOIN 
    BooksToBorrow bt ON br.BookNumber=bt.BookNumber
JOIN 
    BooksCatalog b ON bt.BookID=b.BookID
WHERE 
    br.BorrowDate=&<name="myDate" type=date hint="please enter a date less then today">
GROUP BY b.BookName;
