DECLARE
  v_BorrowID NUMERIC:=&<name="BorrowId" type=integer>; 
  v_ReturnDate DATE := SYSDATE;
  v_LateFee NUMBER;
BEGIN
  -- Call the procedure to mark the book as returned
  MarkBookAsReturned(p_BorrowID => v_BorrowID, p_ReturnDate => v_ReturnDate);

  -- Call the function to calculate late fees
  v_LateFee := CalculateLateFees(p_BorrowID => v_BorrowID);

  DBMS_OUTPUT.PUT_LINE('The late fee is: ' || v_LateFee);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
