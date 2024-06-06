SELECT 
    a.AuthorID,
    a.aName AS AuthorName,
    COUNT(b.BookID) AS NumberOfBooks
FROM 
    Authors a
LEFT JOIN 
    BooksCatalog b ON a.AuthorID=b.AuthorID
GROUP BY 
    a.AuthorID,a.aName;
