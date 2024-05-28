DELETE FROM Authors a
WHERE NOT EXISTS (
    SELECT *
    FROM BooksCatalog b
    WHERE b.AuthorID=a.AuthorID
);
