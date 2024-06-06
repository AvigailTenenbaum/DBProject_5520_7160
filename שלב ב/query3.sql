SELECT 
    l.LibraryID,
    l.lName AS LibrarianName,
    l.PhoneNumber,
    CASE 
        WHEN COUNT(br.BorroeId) > 2 THEN 'Yes'
        ELSE 'No'
    END AS IsEligibleForBonus
FROM 
    Librarians l
LEFT JOIN 
    Borrows br ON l.LibraryID=br.LibraryID
GROUP BY 
    l.LibraryID, l.lName,l.PhoneNumber;
