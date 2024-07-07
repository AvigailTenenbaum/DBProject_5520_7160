CREATE OR REPLACE PROCEDURE UpdateBooksToBorrow(p_BookID IN NUMERIC)
IS
  v_Amount INT;
  v_BorrowedCount INT;
  v_ToAdd INT;
  v_MaxBookNumber INT;
BEGIN
  SELECT Amount INTO v_Amount
  FROM BooksCatalog
  WHERE BookID = p_BookID;

  SELECT COUNT(*), COALESCE(MAX(BookNumber), 0) INTO v_BorrowedCount, v_MaxBookNumber
  FROM BooksToBorrow
  WHERE BookID = p_BookID;

  v_ToAdd := v_Amount - v_BorrowedCount;

  IF v_ToAdd > 0 THEN
    FOR i IN 1..v_ToAdd LOOP
      v_MaxBookNumber := v_MaxBookNumber + 1;
      INSERT INTO BooksToBorrow (BookNumber, isBorrow, BookID)
      VALUES (v_MaxBookNumber, 'N', p_BookID);
    END LOOP;
  END IF;

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END UpdateBooksToBorrow;
/
