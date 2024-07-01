create or replace function CalculateLateFees(p_BorrowID in NUMERIC) return number is
v_ReturnDate DATE;
  v_BorrowDate DATE;
  v_FeePerDay NUMBER := 1; -- Fee per day
  v_LateFee NUMBER := 0;
  v_DaysLate NUMBER;
BEGIN
  -- Get BorrowDate and ReturnDate
  SELECT BorrowDate, ReturnDate INTO v_BorrowDate, v_ReturnDate
  FROM Borrows  WHERE BorroeId = p_BorrowID;

  -- Calculate the number of days late
  IF v_ReturnDate IS NOT NULL THEN
    v_DaysLate := TRUNC(v_ReturnDate)-v_BorrowDate;
    IF v_DaysLate > 30 THEN
      v_LateFee := (v_DaysLate-30)*v_FeePerDay;
    END IF;
  END IF;

  RETURN v_LateFee;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
  WHEN OTHERS THEN
    RETURN 0;
END CalculateLateFees;
/
