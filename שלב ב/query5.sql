DELETE FROM Librarians
WHERE LibraryID IN (
    SELECT L.LibraryID
    FROM Librarians L
    LEFT JOIN Borrows B ON L.LibraryID=B.LibraryID
    WHERE B.BorroeId IS NULL
);
