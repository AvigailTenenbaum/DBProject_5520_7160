CREATE OR REPLACE PROCEDURE MarkBookAsReturned(
  p_BorrowID NUMERIC,
  p_ReturnDate DATE
) IS
  CURSOR c_BooksToReturn IS
    SELECT BookNumber
    FROM Borrows
    WHERE BorroeId = p_BorrowID;

  v_BookNumber NUMERIC(5);
BEGIN
  OPEN c_BooksToReturn;
  LOOP
    FETCH c_BooksToReturn INTO v_BookNumber;
    EXIT WHEN c_BooksToReturn%NOTFOUND;

    -- Update the BooksToBorrow table
    UPDATE BooksToBorrow
    SET isBorrow = 'N'
    WHERE BookNumber = v_BookNumber;

    -- Update the Borrows table
    UPDATE Borrows
    SET ReturnDate = p_ReturnDate
    WHERE BorroeId = p_BorrowID;
  END LOOP;
  CLOSE c_BooksToReturn;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END MarkBookAsReturned;
/
