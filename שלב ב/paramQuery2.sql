SELECT 
    br.BorrowDate,
    COUNT(br.BorroeId) OVER () AS TotalBorrows
FROM 
    Borrows br
JOIN 
    Librarians l ON br.LibraryID=l.LibraryID
WHERE 
    l.LibraryID=&<name="Librarian" list="select LibraryId,LName from Librarians" description="yes">
ORDER BY br.BorrowDate;
