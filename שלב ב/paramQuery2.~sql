SELECT 
    br.BorrowDate,
    COUNT(br.BorroeId) OVER () AS TotalBorrows
FROM 
    Borrows br
JOIN 
    Librarians l ON br.LibraryID=l.LibraryID
WHERE 
    l.LibraryID=&librarianId
ORDER BY br.BorrowDate;
