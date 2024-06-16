ALTER TABLE Librarians
ADD CONSTRAINT chk2_phone_length 
CHECK (LENGTH(PhoneNumber)<=10);
