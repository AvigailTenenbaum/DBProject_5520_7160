CREATE OR REPLACE PROCEDURE UpdateBookAmount(
  p_BookID NUMERIC,
  p_AmountChange INT
) IS
  v_CurrentAmount INT;
BEGIN
  -- Get the current amount of the book
  SELECT Amount INTO v_CurrentAmount
  FROM BooksCatalog
  WHERE BookID = p_BookID;

  -- Update the amount
  v_CurrentAmount := v_CurrentAmount + p_AmountChange;

  -- Update the BooksCatalog table
  UPDATE BooksCatalog
  SET Amount = v_CurrentAmount
  WHERE BookID = p_BookID;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20002, 'An error occurred: ' || SQLERRM);
END UpdateBookAmount;
/
