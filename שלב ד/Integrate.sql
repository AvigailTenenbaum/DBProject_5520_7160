alter table customers 
add EMAIL varchar(15) null;


INSERT INTO CUSTOMERS (CUSTOMERID, CNAME, PHONE, EMAIL)
SELECT C_ID, name, PHONE, EMAIL
FROM CUSTOMER 
WHERE CUSTOMER.C_ID NOT IN (SELECT CUSTOMERID FROM CUSTOMERS);

ALTER TABLE booking
DROP CONSTRAINT SYS_C007284;

ALTER TABLE booking
ADD CONSTRAINT fk_customer_new
FOREIGN KEY (customerId)
REFERENCES customers(customerId);


drop table customer

CREATE TABLE PERSON (
    p_id INT NOT NULL,
    p_name VARCHAR(15),
    PRIMARY KEY (p_id)
);

INSERT INTO PERSON (p_id, p_name)
SELECT customerID, cname
FROM CUSTOMERS 

INSERT INTO PERSON (p_id, p_name)
SELECT AUTHORID, ANAME
FROM AUTHORS 
WHERE AUTHORS.AUTHORID NOT IN (SELECT p_id FROM PERSON);

INSERT INTO EMPLOYES (E_ID, name, POSITION)
SELECT LIBRARYID, LNAME, 'LIBRARIAN'
FROM LIBRARIANS 
WHERE LIBRARYID NOT IN (SELECT E_ID FROM EMPLOYES);

INSERT INTO PERSON (p_id, p_name)
SELECT E_ID, name
FROM EMPLOYES 
WHERE EMPLOYES.E_ID NOT IN (SELECT p_id FROM PERSON);

ALTER TABLE customers ADD(p_id INT);

UPDATE customers c set c.p_id=(select p.p_id from person p where p.p_id=c.customerid);
commit;

ALTER TABLE customers ADD constraints fk_pid foreign key(p_id) references person(p_id);

ALTER TABLE booking drop constraint FK_CUSTOMER_NEW;

ALTER TABLE borrows drop constraint SYS_C007064;

ALTER TABLE customers drop primary key;

ALTER TABLE customers ADD primary key(p_id);

ALTER TABLE customers drop column customerId;

ALTER TABLE customers rename column p_id to customerId;

ALTER TABLE booking ADD constraints fk_booking_id foreign key(customerId) references customers(customerId);

ALTER TABLE borrows ADD constraints fk_borrows_id foreign key(customerId) references customers(customerId);

ALTER TABLE customers drop column cName;

ALTER TABLE authors ADD(p_id INT);

UPDATE authors a set a.p_id=(select p.p_id from person p where p.p_id=a.authorId);
commit;

ALTER TABLE authors ADD constraints fk_pid1 foreign key(p_id) references person(p_id);

ALTER TABLE bookscatalog drop constraint SYS_C007053;

ALTER TABLE authors drop primary key;

ALTER TABLE authors ADD primary key(p_id);

ALTER TABLE authors drop column authorId;

ALTER TABLE authors rename column p_id to authorId;

ALTER TABLE Bookscatalog ADD constraints fk_booksCatalogId foreign key(authorId) references authors(authorId);

ALTER TABLE authors drop column aName;

ALTER TABLE work drop constraint SYS_C007307;

ALTER TABLE employes drop primary key;

ALTER TABLE employes ADD constraints fk_pid2 foreign key(e_id) references person(p_id);

ALTER TABLE employes ADD primary key(e_id);

ALTER TABLE employes drop column name;

ALTER TABLE work ADD constraints fk_workId foreign key(e_id) references employes(e_id);

ALTER TABLE borrows drop constraint SYS_C007065;

ALTER TABLE librarians drop primary key;

ALTER TABLE librarians ADD constraint fk_pid3 foreign key(libraryId) references employes(e_id);

ALTER TABLE librarians ADD primary key(libraryId);

ALTER TABLE librarians drop column lName;

ALTER TABLE borrows ADD constraint fk_borrowId foreign key(libraryId) references librarians(libraryId);

