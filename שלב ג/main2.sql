DECLARE
  v_RefCursor SYS_REFCURSOR;
  v_BookID NUMERIC(5);
  v_BookName VARCHAR(15);
  v_Amount INT;
  v_cType VARCHAR(15);
  v_CategoryID NUMERIC(5) :=&<name="categoryId" type=integer>; 
  v_AmountChange INT :=&<name="amount" type=integer>; 
BEGIN
  -- Call the function to get books by category
  v_RefCursor := GetBooksByCategory(p_CategoryID => v_CategoryID);

  LOOP
    FETCH v_RefCursor INTO v_BookID, v_BookName, v_Amount, v_cType;
    EXIT WHEN v_RefCursor%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('BookID: ' || v_BookID || ', BookName: ' || v_BookName || ', Amount: ' || v_Amount || ', Category: ' || v_cType);

    -- Call the procedure to update book amount
    UpdateBookAmount(p_BookID => v_BookID, p_AmountChange => v_AmountChange);
  END LOOP;
  CLOSE v_RefCursor;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
