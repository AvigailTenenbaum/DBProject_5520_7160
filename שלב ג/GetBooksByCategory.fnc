CREATE OR REPLACE FUNCTION GetBooksByCategory(p_CategoryID NUMERIC) RETURN SYS_REFCURSOR IS
  v_RefCursor SYS_REFCURSOR;
BEGIN
  OPEN v_RefCursor FOR
    SELECT b.BookID, b.BookName, b.Amount, c.cType
    FROM BooksCatalog b
    JOIN Categories c ON b.CategoryID = c.CategoryID
    WHERE b.CategoryID = p_CategoryID;
  RETURN v_RefCursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'An error occurred: ' || SQLERRM);
END GetBooksByCategory;
/
