prompt PL/SQL Developer import file
prompt Created on éåí ùðé 01 éåìé 2024 by èððáåéí
set feedback off
set define off
prompt Creating AUTHORS...
create table AUTHORS
(
  authorid NUMBER(5) not null,
  aname    VARCHAR2(15)
);
alter table AUTHORS
  add primary key (AUTHORID)
  ;
prompt Creating CATEGORIES...
create table CATEGORIES
(
  categoryid NUMBER(5) not null,
  ctype      VARCHAR2(15),
  fromage    INTEGER not null
)
;
alter table CATEGORIES
  add primary key (CATEGORYID)
;
prompt Creating BOOKSCATALOG...
create table BOOKSCATALOG
(
  bookid     NUMBER(5) not null,
  bookname   VARCHAR2(15),
  amount     INTEGER,
  categoryid NUMBER(5),
  authorid   NUMBER(5)
);
alter table BOOKSCATALOG
  add primary key (BOOKID)
  ;
alter table BOOKSCATALOG
  add foreign key (CATEGORYID)
  references CATEGORIES (CATEGORYID);
alter table BOOKSCATALOG
  add foreign key (AUTHORID)
  references AUTHORS (AUTHORID);

prompt Creating BOOKSTOBORROW...
create table BOOKSTOBORROW
(
  booknumber NUMBER(5) not null,
  isborrow   CHAR(1),
  bookid     NUMBER(5) not null
)
;
alter table BOOKSTOBORROW
  add primary key (BOOKNUMBER)
  ;
alter table BOOKSTOBORROW
  add foreign key (BOOKID)
  references BOOKSCATALOG (BOOKID);

prompt Creating CUSTOMERS...
create table CUSTOMERS
(
  customerid  NUMBER(5) not null,
  cname       VARCHAR2(15) not null,
  address     VARCHAR2(15),
  dateofbirth DATE not null,
  phone       VARCHAR2(10)
)
;
alter table CUSTOMERS
  add primary key (CUSTOMERID)
  ;
alter table CUSTOMERS
  add constraint CHK_PHONE_LENGTH
  check (LENGTH(Phone)<=10);

prompt Creating LIBRARIANS...
create table LIBRARIANS
(
  libraryid   NUMBER(5) not null,
  lname       VARCHAR2(15),
  phonenumber VARCHAR2(10)
)
;
alter table LIBRARIANS
  add primary key (LIBRARYID)
  ;
alter table LIBRARIANS
  add constraint CHK2_PHONE_LENGTH
  check (LENGTH(PhoneNumber)<=10);

prompt Creating BORROWS...
create table BORROWS
(
  borroeid   NUMBER(5) not null,
  returndate DATE default ADD_MONTHS(SYSDATE,1),
  borrowdate DATE,
  booknumber NUMBER(5) not null,
  customerid NUMBER(5) not null,
  libraryid  NUMBER(5) not null
)
;
alter table BORROWS
  add primary key (BORROEID)
  ;
alter table BORROWS
  add foreign key (BOOKNUMBER)
  references BOOKSTOBORROW (BOOKNUMBER);
alter table BORROWS
  add foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);
alter table BORROWS
  add foreign key (LIBRARYID)
  references LIBRARIANS (LIBRARYID);

prompt Disabling triggers for AUTHORS...
alter table AUTHORS disable all triggers;
prompt Disabling triggers for CATEGORIES...
alter table CATEGORIES disable all triggers;
prompt Disabling triggers for BOOKSCATALOG...
alter table BOOKSCATALOG disable all triggers;
prompt Disabling triggers for BOOKSTOBORROW...
alter table BOOKSTOBORROW disable all triggers;
prompt Disabling triggers for CUSTOMERS...
alter table CUSTOMERS disable all triggers;
prompt Disabling triggers for LIBRARIANS...
alter table LIBRARIANS disable all triggers;
prompt Disabling triggers for BORROWS...
alter table BORROWS disable all triggers;
prompt Disabling foreign key constraints for BOOKSCATALOG...
alter table BOOKSCATALOG disable constraint SYS_C007052;
alter table BOOKSCATALOG disable constraint SYS_C007053;
prompt Disabling foreign key constraints for BOOKSTOBORROW...
alter table BOOKSTOBORROW disable constraint SYS_C007057;
prompt Disabling foreign key constraints for BORROWS...
alter table BORROWS disable constraint SYS_C007063;
alter table BORROWS disable constraint SYS_C007064;
alter table BORROWS disable constraint SYS_C007065;
prompt Deleting BORROWS...
delete from BORROWS;
commit;
prompt Deleting LIBRARIANS...
delete from LIBRARIANS;
commit;
prompt Deleting CUSTOMERS...
delete from CUSTOMERS;
commit;
prompt Deleting BOOKSTOBORROW...
delete from BOOKSTOBORROW;
commit;
prompt Deleting BOOKSCATALOG...
delete from BOOKSCATALOG;
commit;
prompt Deleting CATEGORIES...
delete from CATEGORIES;
commit;
prompt Deleting AUTHORS...
delete from AUTHORS;
commit;
prompt Loading AUTHORS...
insert into AUTHORS (authorid, aname)
values (18, 'Harper Lee');
insert into AUTHORS (authorid, aname)
values (628, 'Kiefer');
insert into AUTHORS (authorid, aname)
values (847, 'Merle');
insert into AUTHORS (authorid, aname)
values (202, 'Cuba');
insert into AUTHORS (authorid, aname)
values (933, 'Melba');
insert into AUTHORS (authorid, aname)
values (773, 'Terrence');
insert into AUTHORS (authorid, aname)
values (753, 'Teri');
insert into AUTHORS (authorid, aname)
values (538, 'Bobbi');
insert into AUTHORS (authorid, aname)
values (971, 'Brittany');
insert into AUTHORS (authorid, aname)
values (204, 'Andrae');
insert into AUTHORS (authorid, aname)
values (645, 'Manu');
insert into AUTHORS (authorid, aname)
values (638, 'Mia');
insert into AUTHORS (authorid, aname)
values (801, 'Rebeka');
insert into AUTHORS (authorid, aname)
values (694, 'Miki');
insert into AUTHORS (authorid, aname)
values (307, 'Olga');
insert into AUTHORS (authorid, aname)
values (902, 'Al');
insert into AUTHORS (authorid, aname)
values (485, 'Alana');
insert into AUTHORS (authorid, aname)
values (379, 'Joaquim');
insert into AUTHORS (authorid, aname)
values (595, 'Bob');
insert into AUTHORS (authorid, aname)
values (845, 'Sammy');
insert into AUTHORS (authorid, aname)
values (782, 'Gloria');
insert into AUTHORS (authorid, aname)
values (472, 'Louise');
insert into AUTHORS (authorid, aname)
values (211, 'Dabney');
insert into AUTHORS (authorid, aname)
values (785, 'Jeanne');
insert into AUTHORS (authorid, aname)
values (365, 'Clarence');
insert into AUTHORS (authorid, aname)
values (787, 'Kay');
insert into AUTHORS (authorid, aname)
values (459, 'Ed');
commit;
prompt 27 records loaded
prompt Loading CATEGORIES...
insert into CATEGORIES (categoryid, ctype, fromage)
values (54, 'inspection', 15);
insert into CATEGORIES (categoryid, ctype, fromage)
values (159, 'romantic', 12);
insert into CATEGORIES (categoryid, ctype, fromage)
values (40, 'science fiction', 19);
insert into CATEGORIES (categoryid, ctype, fromage)
values (137, 'adults', 14);
insert into CATEGORIES (categoryid, ctype, fromage)
values (112, 'crime', 10);
insert into CATEGORIES (categoryid, ctype, fromage)
values (126, 'children', 5);
insert into CATEGORIES (categoryid, ctype, fromage)
values (93, 'comics', 14);
commit;
prompt 7 records loaded
prompt Loading BOOKSCATALOG...
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (864, 'Hughes', 34, 112, 459);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (539, 'Page', 36, 93, 902);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (638, 'Brooks', 34, 126, 365);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (653, 'Black', 34, 40, 971);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (718, 'Hauer', 34, 112, 638);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (776, 'Hayek', 34, 40, 628);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (984, 'Glenn', 34, 126, 307);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (466, 'DiFranco', 34, 40, 538);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (636, 'McGoohan', 40, 54, 202);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (873, 'Getty', 34, 40, 472);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (521, 'Morales', 34, 112, 485);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (407, 'Franklin', 40, 54, 753);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (419, 'McGinley', 34, 112, 211);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (488, 'Garcia', 34, 137, 645);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (914, 'Rizzo', 34, 112, 782);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (994, 'Farina', 34, 137, 933);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (829, 'Keith', 40, 54, 847);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (662, 'Yankovic', 34, 126, 18);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (887, 'Biel', 34, 126, 801);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (739, 'Hackman', 34, 112, 773);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (514, 'Bullock', 34, 40, 379);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (649, 'Schiavelli', 34, 137, 595);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (732, 'Aiken', 34, 93, 753);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (770, 'Graham', 34, 137, 845);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (618, 'Eldard', 34, 93, 787);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (496, 'Balaban', 34, 40, 785);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (757, 'Leachman', 34, 40, 204);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (654, 'Waite', 34, 126, 694);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (2000, 'blabla', 34, 126, 694);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (11111, ' abcd', 34, 112, 459);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (324, ' abcd', 34, 112, 459);
commit;
prompt 31 records loaded
prompt Loading BOOKSTOBORROW...
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2067, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3238, 'y', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3012, 'Y', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2767, 'Y', 654);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4125, 'y', 539);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1565, 'n', 718);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1043, 'y', 407);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3107, 'n', 638);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3516, 'y', 914);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1394, 'n', 407);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4834, 'n', 776);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1586, 'n', 770);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3522, 'n', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3954, 'n', 654);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1380, 'n', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (342, 'y', 653);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4378, 'n', 757);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2045, 'n', 776);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3149, 'n', 407);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2391, 'n', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3605, 'n', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1867, 'y', 653);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3337, 'n', 496);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3699, 'n', 638);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4388, 'n', 732);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1747, 'n', 770);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4631, 'y', 419);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2712, 'n', 618);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (403, 'y', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2151, 'n', 914);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1687, 'y', 407);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1256, 'n', 638);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1205, 'n', 914);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (354, 'n', 407);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (824, 'y', 873);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4820, 'y', 539);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3656, 'y', 496);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4213, 'y', 638);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1820, 'y', 829);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3194, 'n', 914);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4070, 'n', 466);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1941, 'y', 654);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4136, 'y', 466);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2930, 'y', 521);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1194, 'n', 466);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4612, 'y', 521);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2416, 'n', 887);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (936, 'n', 419);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2451, 'n', 718);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1919, 'y', 466);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3045, 'y', 984);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1234, 'y', 739);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4709, 'y', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1962, 'y', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (741, 'n', 419);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4132, 'y', 887);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1969, 'y', 407);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2662, 'y', 994);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1038, 'y', 984);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1686, 'y', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2976, 'y', 653);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2110, 'y', 654);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1768, 'y', 618);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (383, 'n', 984);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (684, 'n', 539);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1204, 'n', 407);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2959, 'n', 994);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3825, 'y', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1157, 'n', 718);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4822, 'n', 770);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2905, 'y', 732);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2224, 'n', 914);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4456, 'y', 514);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (747, 'y', 649);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (471, 'n', 994);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2544, 'y', 496);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (465, 'y', 496);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4850, 'y', 776);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1348, 'n', 654);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2729, 'n', 757);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1462, 'y', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3658, 'n', 649);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3653, 'n', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2608, 'n', 864);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2802, 'y', 649);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2708, 'y', 739);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (559, 'y', 732);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4279, 'y', 539);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4006, 'n', 757);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4752, 'y', 638);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1198, 'y', 994);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2903, 'n', 739);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2760, 'y', 984);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1630, 'n', 654);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1751, 'y', 829);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2960, 'n', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2467, 'y', 873);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3682, 'y', 887);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4344, 'y', 776);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2145, 'y', 419);
commit;
prompt 100 records committed...
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4598, 'y', 419);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4823, 'y', 466);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3898, 'y', 638);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3815, 'y', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (644, 'y', 649);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3515, 'n', 984);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (611, 'y', 873);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2516, 'y', 618);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3081, 'y', 653);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3619, 'y', 776);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2864, 'y', 488);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1133, 'y', 419);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (853, 'n', 887);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4900, 'n', 873);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (672, 'n', 864);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1861, 'y', 653);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3393, 'n', 829);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3749, 'n', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3684, 'n', 653);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4595, 'n', 466);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (532, 'y', 770);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4426, 'n', 653);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2611, 'y', 873);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4916, 'y', 873);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3518, 'y', 829);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4155, 'y', 984);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1498, 'y', 739);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (594, 'n', 864);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2821, 'N', 864);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3799, 'y', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4565, 'y', 466);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (576, 'n', 514);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3959, 'n', 776);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4769, 'y', 829);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1086, 'n', 419);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1312, 'n', 514);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1326, 'n', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3469, 'y', 539);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (306, 'y', 654);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (1164, 'n', 984);
commit;
prompt 140 records loaded
prompt Loading CUSTOMERS...
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (909, 'LeonKilmer', '611 Randall', to_date('18-04-2012', 'dd-mm-yyyy'), '4030386422');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (765, 'ThelmaBailey', '59 Rancho Palos', to_date('10-05-1976', 'dd-mm-yyyy'), '3216529391');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (366, 'BurtonDukakis', '440 Plymouth Me', to_date('04-07-1991', 'dd-mm-yyyy'), '2846129561');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (746, 'RicardoFarrow', '33rd Street', to_date('06-08-2016', 'dd-mm-yyyy'), '2161511996');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (935, 'ChristopherHatc', '82nd Street', to_date('01-03-1988', 'dd-mm-yyyy'), '2316027352');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (256, 'AaronYorn', '74 Leon Ave', to_date('25-08-1990', 'dd-mm-yyyy'), '3604249628');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (891, 'RobbieKimball', '78 Hanley Blvd', to_date('17-07-1984', 'dd-mm-yyyy'), '2211909071');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (470, 'CarlSchreibeA', '293 Warley Stre', to_date('02-03-1985', 'dd-mm-yyyy'), '1289801838');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (596, 'RickLowA', '86 Wiest Road', to_date('20-06-2013', 'dd-mm-yyyy'), '3337933132');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (525, 'StewartDiaz', '79 Martinez Dri', to_date('31-08-1975', 'dd-mm-yyyy'), '2412671461');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (436, 'BreckinTennison', '51st Street', to_date('20-01-2016', 'dd-mm-yyyy'), '3623492062');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (518, 'WangQuaid', '1 Vin Street', to_date('27-09-2008', 'dd-mm-yyyy'), '883316934');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (932, 'JannDeejay', '83 Cooper Ave', to_date('02-12-1998', 'dd-mm-yyyy'), '1257851169');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (254, 'ArmandIrving', '87 Nepean Road', to_date('28-11-1987', 'dd-mm-yyyy'), '3512592343');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (969, 'GoranSistA', '81 Dortmund Roa', to_date('18-05-2010', 'dd-mm-yyyy'), '1482609749');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (523, 'DaryleBosco', '26 Hannover Roa', to_date('02-12-2000', 'dd-mm-yyyy'), '4163267399');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (535, 'WhoopiWeisberA', '66 Wilkinson Dr', to_date('08-06-1972', 'dd-mm-yyyy'), '2637584488');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (985, 'RosarioCash', '13rd Street', to_date('16-07-1978', 'dd-mm-yyyy'), '2217913753');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (913, 'ScarlettArmatra', '53rd Street', to_date('30-05-1980', 'dd-mm-yyyy'), '855458612');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (434, 'TriniMcFadden', '38 Corey Road', to_date('13-02-1983', 'dd-mm-yyyy'), '2435792554');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (426, 'LoreenaGilley', '24 Raybon Road', to_date('11-04-2002', 'dd-mm-yyyy'), '2223793589');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (512, 'LarryBrookA', '525 Vai Street', to_date('28-06-1989', 'dd-mm-yyyy'), '3540049932');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (621, 'AvrilKoteas', '66 Carrack Road', to_date('11-08-1977', 'dd-mm-yyyy'), '3548291245');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (382, 'SissyMcKellen', '16 Janeane Driv', to_date('18-08-1972', 'dd-mm-yyyy'), '2630033583');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (595, 'TemueraBall', '812 Byrd Street', to_date('15-03-1995', 'dd-mm-yyyy'), '1989015112');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (760, 'HarrietAfflecA', '80 Freddie Stre', to_date('21-09-1988', 'dd-mm-yyyy'), '2739317494');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (226, 'CeiliDavis', '98 Garland Stre', to_date('08-12-1982', 'dd-mm-yyyy'), '3181768911');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (540, 'VerucaDickinson', '97 Whitley Stre', to_date('06-12-2007', 'dd-mm-yyyy'), '572588605');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (466, 'CollinCurtis', '59 Kylie Drive', to_date('22-11-2000', 'dd-mm-yyyy'), '3407535473');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (899, 'ViennaDerringer', '31 Heatherly Ro', to_date('12-03-2008', 'dd-mm-yyyy'), '1854187026');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (730, 'GabrielMaxwelA', '816 Tooele Stre', to_date('24-11-1994', 'dd-mm-yyyy'), '899641101');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (536, 'HookahIrons', '46 Graham Stree', to_date('02-01-1982', 'dd-mm-yyyy'), '1952741769');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (235, 'GinPhillipA', '36 Wong', to_date('10-08-1994', 'dd-mm-yyyy'), '777461587');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (569, 'ThoraSutherland', '32 Liu Ave', to_date('19-03-1988', 'dd-mm-yyyy'), '873095289');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (679, 'Jean-LucKershaw', '62nd Street', to_date('29-05-1995', 'dd-mm-yyyy'), '3875784291');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (745, 'AvengedVassar', '63 Jimmy Street', to_date('18-11-1999', 'dd-mm-yyyy'), '2970090983');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (819, 'ConnieMenikettA', '43 California S', to_date('13-09-2004', 'dd-mm-yyyy'), '1550256603');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (940, 'BonnieSuchet', '93rd Street', to_date('08-10-2006', 'dd-mm-yyyy'), '2469193301');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (504, 'WillieWeber', '54 Coughlan Str', to_date('08-06-1986', 'dd-mm-yyyy'), '2857895116');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (903, 'ThinPaige', '100 Carlin Road', to_date('10-10-2004', 'dd-mm-yyyy'), '4135585708');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (642, 'EmmaByrd', '74 Krabbe Drive', to_date('15-09-1997', 'dd-mm-yyyy'), '2858109902');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (762, 'AnneAvital', '6 Remy', to_date('20-08-1971', 'dd-mm-yyyy'), '3729235609');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (978, 'SissyMatarazzo', '83 Stuart Ave', to_date('27-09-1996', 'dd-mm-yyyy'), '1781402236');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (489, 'PaulaVaughan', '53 Herzogenrath', to_date('20-09-1989', 'dd-mm-yyyy'), '3063653890');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (335, 'Bobvon Sydow', '79 Mira Road', to_date('29-10-1972', 'dd-mm-yyyy'), '2337735872');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (740, 'RoyDooleA', '53 Makeba Road', to_date('19-05-2003', 'dd-mm-yyyy'), '1332574820');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (747, 'HankOrlando', '442 Brendan Str', to_date('07-05-1973', 'dd-mm-yyyy'), '3206005590');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (461, 'DiamondFlanagan', '10 Rispoli', to_date('18-05-1974', 'dd-mm-yyyy'), '932039115');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (459, 'MenaTaha', '70 Powell River', to_date('19-07-1978', 'dd-mm-yyyy'), '1509648338');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (836, 'PattyTurturro', '744 Bonneville ', to_date('27-02-2004', 'dd-mm-yyyy'), '3798555392');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (699, 'GranScott', '30 Fort McMurra', to_date('10-03-1989', 'dd-mm-yyyy'), '2635357485');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (357, 'KellyCoughlan', '22 Belles Road', to_date('19-07-2013', 'dd-mm-yyyy'), '1260542523');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (597, 'DebbyNewman', '959 Wiedlin Dri', to_date('30-07-1987', 'dd-mm-yyyy'), '3404591630');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (656, 'RalphWhitman', '82nd Street', to_date('08-09-1983', 'dd-mm-yyyy'), '1191621082');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (800, 'EugeneAdkinA', '14 Dustin Road', to_date('03-11-2018', 'dd-mm-yyyy'), '3656776672');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (739, 'KirkBlossoms', '81 Parsippany R', to_date('17-02-1991', 'dd-mm-yyyy'), '2711321889');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (210, 'NataschaHurley', '22 Arthur Drive', to_date('19-05-2019', 'dd-mm-yyyy'), '21025327');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (371, 'HelenAdamA', '645 Aniston Roa', to_date('15-07-1981', 'dd-mm-yyyy'), '1782596247');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (649, 'ParkerDushku', '260 Leslie Stre', to_date('03-08-1972', 'dd-mm-yyyy'), '1639982604');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (239, 'JimmyRamirez', '11 Spike Road', to_date('12-02-2008', 'dd-mm-yyyy'), '1040455812');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (361, 'BobbiBarkiA', '44 DiBiasio Str', to_date('31-05-2012', 'dd-mm-yyyy'), '3959391699');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (554, 'HexO''HarA', '96 Leguizamo Ro', to_date('09-09-1978', 'dd-mm-yyyy'), '1435019934');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (950, 'TriniBoothe', '60 Caine Street', to_date('08-04-1999', 'dd-mm-yyyy'), '2498875587');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (942, 'MarcWesterberA', '88 Pfeiffer Str', to_date('21-03-2015', 'dd-mm-yyyy'), '2802556357');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (200, 'TerenceAbraham', '92nd Street', to_date('25-03-2007', 'dd-mm-yyyy'), '3357338897');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (688, 'RaulSanders', '71 Remy Ave', to_date('25-01-1990', 'dd-mm-yyyy'), '594420582');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (431, 'JamieBrooks', '304 Josh Road', to_date('27-02-1970', 'dd-mm-yyyy'), '1462899602');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (700, 'SusanHobson', '95 Immenstaad S', to_date('14-05-1974', 'dd-mm-yyyy'), '2890602884');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (710, 'MarleyCetera', '201 Ludbreg Dri', to_date('12-01-1994', 'dd-mm-yyyy'), '2004040862');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (383, 'FredericMiller', '100 League city', to_date('15-01-2005', 'dd-mm-yyyy'), '2875463918');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (718, 'CrispinBloch', '42 Sydney Drive', to_date('22-01-2009', 'dd-mm-yyyy'), '901426801');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (533, 'CevinCrowe', '13rd Street', to_date('22-02-2013', 'dd-mm-yyyy'), '3933171372');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (807, 'JuliannaHuston', '34 Alda Blvd', to_date('02-04-1987', 'dd-mm-yyyy'), '544934730');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (377, 'JuanPony', '22nd Street', to_date('19-12-1989', 'dd-mm-yyyy'), '1582537695');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (590, 'SelmaArmstrong', '92nd Street', to_date('05-02-1978', 'dd-mm-yyyy'), '2266770075');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (261, 'BetteLevy', '81st Street', to_date('17-02-1986', 'dd-mm-yyyy'), '2867721846');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (211, 'KaronBachman', '37 MacLachlan S', to_date('02-02-1973', 'dd-mm-yyyy'), '3178540559');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (970, 'ChiHedayA', '91st Street', to_date('10-06-1984', 'dd-mm-yyyy'), '723670881');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (726, 'TommyLeviA', '971 Ljubljana R', to_date('27-02-1985', 'dd-mm-yyyy'), '1770749760');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (397, 'ChristianHopper', '70 Doucette Blv', to_date('18-04-1979', 'dd-mm-yyyy'), '2088746194');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (998, 'StanleyCarA', '8 Hank', to_date('16-04-2012', 'dd-mm-yyyy'), '1060624766');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (321, 'KaronMacy', '75 Philip Road', to_date('08-06-1983', 'dd-mm-yyyy'), '2275893281');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (450, 'ToshiroLaBelle', '42nd Street', to_date('09-11-2007', 'dd-mm-yyyy'), '2421783440');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (1, 'John Doe', '123 Main St', to_date('01-01-1980', 'dd-mm-yyyy'), '12345');
commit;
prompt 84 records loaded
prompt Loading LIBRARIANS...
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (522, 'WesLoggins', '1822952929');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (273, 'MichaelAli', '855336070');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (446, 'MerilleeRhymes', '1969914302');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (870, 'SethMarshall', '1545690284');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (977, 'PatriciaHobson', '1254977408');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (711, 'DanWinwood', '2041222785');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (814, 'LouPayton', '2769089421');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (454, 'KimMantegna', '1960550408');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (269, 'Jean-ClaudeAssa', '2354760688');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (277, 'BobbyBurns', '3628971427');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (960, 'SheenaBright', '3952093731');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (865, 'WendyRispoli', '3700676284');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (479, 'TalChao', '2709051707');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (252, 'RhonaAglukark', '1875622692');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (975, 'SaffronTempest', '2381876430');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (718, 'LukeGoldblum', '1280970467');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (218, 'ChantéDavid', '2101385291');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (739, 'MurrayAykroyd', '2101556339');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (680, 'DelroyBorden', '2572058709');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (284, 'JasonFiennes', '544577504');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (586, 'JulieFlemyng', '1969625318');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (771, 'NatachaTorn', '1048357220');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (358, 'JuanBell', '3482661399');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (887, 'JoaquimSizemore', '2521715065');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (468, 'TeaFinn', '755713297');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (939, 'JaniceGore', '1710392529');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (459, 'TrickBratt', '3032021502');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (881, 'TiaNapolitano', '2267563000');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (500, 'SonnyHutch', '4219606693');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (588, 'Carrie-AnneChea', '1800904403');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (493, 'JuliannaO''Conno', '990392438');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (867, 'RoscoChestnut', '3058336359');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (385, 'LoisSteenburgen', '1464187541');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (464, 'MollyMattea', '3358075594');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (741, 'NickLizzy', '1366774318');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (338, 'ReeseHornsby', '3301422893');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (911, 'ClaireGayle', '1201380109');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (484, 'RebekaLoggia', '4151869327');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (545, 'JoseDavis', '514570588');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (599, 'MartinMcDonnell', '1604542899');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (422, 'NeilHolland', '3486150328');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (831, 'GrantFlemyng', '3534522594');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (512, 'SaraStowe', '1171737620');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (209, 'KarenDreyfuss', '1063890086');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (997, 'NenehPenders', '4163013106');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (902, 'FrankZahn', '1051049363');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (732, 'VivicaArquette', '3783666090');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (788, 'Kennyvon Sydow', '2814909602');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (558, 'AliciaMann', '3949415267');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (246, 'DenisBergen', '2399781773');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (817, 'RickieBello', '3374694696');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (503, 'TommyDoucette', '3284946845');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (418, 'AdamEpps', '1793010860');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (386, 'TreyLangella', '3044671463');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (766, 'EmersonMcDonald', '676733936');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (852, 'GordKingsley', '3464848730');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (980, 'RoyWeisz', '1691430600');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (715, 'MarleyUnger', '3999374747');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (492, 'CarleneFierstei', '3805448636');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (316, 'BustaRankin', '1963984882');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (362, 'StephanieThewli', '2013035899');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (676, 'BobbiPierce', '2511897625');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (249, 'MollyGunton', '3237057293');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (368, 'GilbertoCoyote', '2745031584');
commit;
prompt 64 records loaded
prompt Loading BORROWS...
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1436, to_date('11-08-2024', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 1133, 335, 599);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1196, to_date('01-07-2024 14:32:51', 'dd-mm-yyyy hh24:mi:ss'), to_date('10-04-2024', 'dd-mm-yyyy'), 2821, 985, 586);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (993, to_date('01-07-2024', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 2067, 730, 284);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (721, to_date('03-09-2024', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 3149, 942, 284);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (946, to_date('23-06-2024 14:46:13', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-01-2024', 'dd-mm-yyyy'), 4822, 909, 977);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (813, to_date('10-07-2024', 'dd-mm-yyyy'), to_date('01-01-2024', 'dd-mm-yyyy'), 2959, 762, 902);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (870, to_date('09-10-2024', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 4822, 740, 771);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (415, to_date('02-11-2024', 'dd-mm-yyyy'), to_date('05-02-2024', 'dd-mm-yyyy'), 1205, 512, 741);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1484, to_date('04-10-2024', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 1038, 461, 711);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1077, to_date('06-09-2024', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 4456, 899, 358);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1628, to_date('13-10-2024', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 3149, 596, 588);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1156, to_date('12-06-2024', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 1205, 466, 817);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1812, to_date('09-10-2024', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 4823, 969, 246);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1802, to_date('19-10-2024', 'dd-mm-yyyy'), to_date('09-01-2024', 'dd-mm-yyyy'), 3393, 335, 464);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (825, to_date('30-05-2024', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 2960, 679, 977);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1345, to_date('29-11-2024', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 1164, 819, 588);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1866, to_date('10-12-2024', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 4125, 540, 865);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1974, to_date('08-11-2024', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 383, 431, 558);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1880, to_date('06-10-2024', 'dd-mm-yyyy'), to_date('10-05-2024', 'dd-mm-yyyy'), 3515, 239, 468);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (821, to_date('27-11-2024', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 342, 649, 316);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1280, to_date('18-09-2024', 'dd-mm-yyyy'), to_date('09-05-2024', 'dd-mm-yyyy'), 1038, 595, 676);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1047, to_date('03-08-2024', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 1326, 621, 788);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1438, to_date('16-08-2024', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 3515, 762, 386);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1540, to_date('21-12-2024', 'dd-mm-yyyy'), to_date('08-05-2024', 'dd-mm-yyyy'), 354, 740, 680);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (995, to_date('17-12-2024', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 306, 450, 512);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1710, to_date('04-07-2024', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 1326, 200, 980);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (718, to_date('25-10-2024', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 3469, 466, 522);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (717, to_date('20-07-2024', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 3515, 932, 484);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1826, to_date('25-06-2024', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 3619, 525, 246);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1498, to_date('11-07-2024', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 4565, 700, 588);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1210, to_date('29-09-2024', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 2416, 970, 492);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1794, to_date('14-06-2024', 'dd-mm-yyyy'), to_date('21-01-2024', 'dd-mm-yyyy'), 2611, 656, 316);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (286, to_date('14-06-2024', 'dd-mm-yyyy'), to_date('07-01-2024', 'dd-mm-yyyy'), 4006, 489, 454);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (934, to_date('04-07-2024', 'dd-mm-yyyy'), to_date('01-05-2024', 'dd-mm-yyyy'), 306, 504, 362);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (675, to_date('25-08-2024', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 2151, 807, 865);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1220, to_date('29-05-2024', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 1686, 800, 273);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (233, to_date('23-06-2024', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 2976, 760, 277);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (271, to_date('30-05-2024', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 532, 536, 500);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1118, to_date('16-09-2024', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'), 644, 261, 814);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1185, to_date('03-06-2024', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 3337, 819, 817);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1791, to_date('16-07-2024', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 4136, 730, 960);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1148, to_date('29-10-2024', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 3469, 899, 316);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1264, to_date('28-09-2024', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 4344, 765, 418);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (745, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 2110, 807, 386);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1176, to_date('23-06-2024 14:46:13', 'dd-mm-yyyy hh24:mi:ss'), to_date('14-02-2024', 'dd-mm-yyyy'), 2712, 909, 484);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1390, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 4426, 739, 939);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (318, to_date('03-11-2024', 'dd-mm-yyyy'), to_date('01-01-2024', 'dd-mm-yyyy'), 3749, 903, 493);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1914, to_date('22-10-2024', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 4132, 535, 468);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1908, to_date('04-06-2024', 'dd-mm-yyyy'), to_date('27-01-2024', 'dd-mm-yyyy'), 403, 950, 887);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (428, to_date('22-07-2024', 'dd-mm-yyyy'), to_date('11-05-2024', 'dd-mm-yyyy'), 2712, 942, 852);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (306, to_date('04-08-2024', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 4132, 200, 558);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (805, to_date('29-08-2024', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 2767, 470, 588);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (802, to_date('13-09-2024', 'dd-mm-yyyy'), to_date('15-02-2024', 'dd-mm-yyyy'), 4279, 226, 867);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1984, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 4136, 760, 446);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (445, to_date('22-06-2024', 'dd-mm-yyyy'), to_date('02-04-2024', 'dd-mm-yyyy'), 3825, 361, 960);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (947, to_date('05-12-2024', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 2930, 998, 766);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (635, to_date('30-11-2024', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 2959, 760, 870);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1097, to_date('23-06-2024 16:03:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('20-01-2024', 'dd-mm-yyyy'), 2930, 235, 911);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1991, to_date('23-06-2024 16:03:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('08-02-2024', 'dd-mm-yyyy'), 936, 235, 512);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1942, to_date('29-06-2024', 'dd-mm-yyyy'), to_date('29-04-2024', 'dd-mm-yyyy'), 3012, 371, 718);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (861, to_date('18-11-2024', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 3605, 718, 209);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (535, to_date('01-07-2024', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'), 3516, 596, 814);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1935, to_date('28-05-2024', 'dd-mm-yyyy'), to_date('31-03-2024', 'dd-mm-yyyy'), 465, 554, 887);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1301, to_date('30-07-2024', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 342, 740, 586);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (597, to_date('25-08-2024', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 4378, 211, 503);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (749, to_date('11-06-2024', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'), 2151, 903, 338);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (779, to_date('15-10-2024', 'dd-mm-yyyy'), to_date('06-05-2024', 'dd-mm-yyyy'), 2608, 512, 368);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (441, to_date('13-06-2024', 'dd-mm-yyyy'), to_date('02-03-2024', 'dd-mm-yyyy'), 1394, 747, 252);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1277, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('02-05-2024', 'dd-mm-yyyy'), 3699, 740, 771);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1203, to_date('22-12-2024', 'dd-mm-yyyy'), to_date('27-04-2024', 'dd-mm-yyyy'), 1861, 800, 468);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (958, to_date('03-12-2024', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'), 1198, 426, 732);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (439, to_date('20-06-2024', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 1038, 470, 385);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1753, to_date('18-12-2024', 'dd-mm-yyyy'), to_date('20-01-2024', 'dd-mm-yyyy'), 2045, 700, 503);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (459, to_date('23-06-2024 16:03:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-04-2024', 'dd-mm-yyyy'), 2391, 235, 715);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1330, to_date('13-06-2024', 'dd-mm-yyyy'), to_date('01-02-2024', 'dd-mm-yyyy'), 936, 450, 711);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1953, to_date('16-10-2024', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'), 1194, 950, 870);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (270, to_date('29-08-2024', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 1204, 800, 459);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (432, to_date('11-06-2024', 'dd-mm-yyyy'), to_date('05-01-2024', 'dd-mm-yyyy'), 1326, 726, 599);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (332, to_date('04-11-2024', 'dd-mm-yyyy'), to_date('07-05-2024', 'dd-mm-yyyy'), 2151, 554, 911);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (297, to_date('23-12-2024', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 853, 800, 503);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1509, to_date('19-10-2024', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 2662, 740, 277);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (399, to_date('25-09-2024', 'dd-mm-yyyy'), to_date('15-04-2024', 'dd-mm-yyyy'), 853, 254, 249);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (598, to_date('18-08-2024', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 4426, 642, 503);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (897, to_date('06-07-2024', 'dd-mm-yyyy'), to_date('25-05-2024', 'dd-mm-yyyy'), 1969, 998, 980);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1669, to_date('10-07-2024', 'dd-mm-yyyy'), to_date('06-01-2024', 'dd-mm-yyyy'), 2767, 533, 249);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (573, to_date('23-12-2024', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 2930, 726, 358);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (633, to_date('05-08-2024', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 1348, 489, 739);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1086, to_date('05-11-2024', 'dd-mm-yyyy'), to_date('08-01-2024', 'dd-mm-yyyy'), 3238, 942, 788);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (237, to_date('27-05-2024', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 1204, 969, 814);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (846, to_date('04-06-2024', 'dd-mm-yyyy'), to_date('11-04-2024', 'dd-mm-yyyy'), 2544, 366, 680);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (558, to_date('24-10-2024', 'dd-mm-yyyy'), to_date('28-02-2024', 'dd-mm-yyyy'), 3684, 970, 338);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1281, to_date('18-09-2024', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 2662, 535, 870);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (613, to_date('07-07-2024', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'), 1498, 226, 887);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1885, to_date('30-08-2024', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 3149, 470, 545);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (308, to_date('30-08-2024', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 2067, 361, 459);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (509, to_date('05-08-2024', 'dd-mm-yyyy'), to_date('08-04-2024', 'dd-mm-yyyy'), 853, 998, 269);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1385, to_date('02-12-2024', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 644, 913, 493);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1397, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'), 1133, 256, 881);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1108, to_date('16-08-2024', 'dd-mm-yyyy'), to_date('08-01-2024', 'dd-mm-yyyy'), 4125, 726, 386);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1508, to_date('05-06-2024', 'dd-mm-yyyy'), to_date('11-05-2024', 'dd-mm-yyyy'), 824, 523, 249);
commit;
prompt 100 records committed...
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1681, to_date('24-12-2024', 'dd-mm-yyyy'), to_date('06-01-2024', 'dd-mm-yyyy'), 4752, 371, 512);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1755, to_date('13-07-2024', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 853, 970, 418);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1189, to_date('06-08-2024', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 2930, 819, 771);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1976, to_date('26-08-2024', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 1205, 679, 209);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (781, to_date('26-06-2024', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 4850, 431, 368);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1982, to_date('14-07-2024', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 383, 739, 997);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1990, to_date('09-08-2024', 'dd-mm-yyyy'), to_date('01-02-2024', 'dd-mm-yyyy'), 684, 836, 680);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (794, to_date('30-07-2024', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 1164, 596, 386);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (987, to_date('23-10-2024', 'dd-mm-yyyy'), to_date('05-05-2024', 'dd-mm-yyyy'), 3605, 382, 249);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1402, to_date('11-12-2024', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 1462, 554, 718);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1159, to_date('04-11-2024', 'dd-mm-yyyy'), to_date('12-02-2024', 'dd-mm-yyyy'), 3149, 746, 284);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (565, to_date('01-07-2024', 'dd-mm-yyyy'), to_date('21-05-2024', 'dd-mm-yyyy'), 2708, 536, 446);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (767, to_date('04-09-2024', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 4900, 726, 218);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (446, to_date('01-06-2024', 'dd-mm-yyyy'), to_date('31-03-2024', 'dd-mm-yyyy'), 1565, 512, 831);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (689, to_date('02-06-2024', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'), 4595, 371, 732);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (734, to_date('25-09-2024', 'dd-mm-yyyy'), to_date('06-04-2024', 'dd-mm-yyyy'), 1969, 535, 739);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1263, to_date('23-06-2024 14:57:28', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-04-2024', 'dd-mm-yyyy'), 4070, 434, 715);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1830, to_date('03-12-2024', 'dd-mm-yyyy'), to_date('29-04-2024', 'dd-mm-yyyy'), 3619, 969, 218);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1440, to_date('25-06-2024', 'dd-mm-yyyy'), to_date('02-05-2024', 'dd-mm-yyyy'), 4155, 730, 586);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1247, to_date('12-08-2024', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 4388, 504, 385);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1388, to_date('31-10-2024', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 4213, 978, 422);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (848, to_date('17-09-2024', 'dd-mm-yyyy'), to_date('16-04-2024', 'dd-mm-yyyy'), 4900, 361, 479);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1525, to_date('04-10-2024', 'dd-mm-yyyy'), to_date('23-03-2024', 'dd-mm-yyyy'), 1194, 760, 503);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (702, to_date('29-11-2024', 'dd-mm-yyyy'), to_date('21-02-2024', 'dd-mm-yyyy'), 3656, 745, 977);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (339, to_date('15-10-2024', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 2760, 726, 975);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (392, to_date('14-07-2024', 'dd-mm-yyyy'), to_date('15-05-2024', 'dd-mm-yyyy'), 1198, 800, 503);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (353, to_date('11-09-2024', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'), 1462, 540, 316);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (269, to_date('20-06-2024', 'dd-mm-yyyy'), to_date('25-05-2024', 'dd-mm-yyyy'), 684, 746, 975);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (1, to_date('01-07-2024 14:22:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-05-2024 18:24:44', 'dd-mm-yyyy hh24:mi:ss'), 2067, 909, 522);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (277, to_date('23-07-2024', 'dd-mm-yyyy'), to_date('23-06-2024', 'dd-mm-yyyy'), 2067, 909, 522);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (344, to_date('23-07-2024', 'dd-mm-yyyy'), to_date('23-06-2024', 'dd-mm-yyyy'), 3012, 909, 522);
insert into BORROWS (borroeid, returndate, borrowdate, booknumber, customerid, libraryid)
values (2333, to_date('23-06-2024 16:03:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-06-2024 16:03:31', 'dd-mm-yyyy hh24:mi:ss'), 2767, 235, 269);
commit;
prompt 132 records loaded
prompt Enabling foreign key constraints for BOOKSCATALOG...
alter table BOOKSCATALOG enable constraint SYS_C007052;
alter table BOOKSCATALOG enable constraint SYS_C007053;
prompt Enabling foreign key constraints for BOOKSTOBORROW...
alter table BOOKSTOBORROW enable constraint SYS_C007057;
prompt Enabling foreign key constraints for BORROWS...
alter table BORROWS enable constraint SYS_C007063;
alter table BORROWS enable constraint SYS_C007064;
alter table BORROWS enable constraint SYS_C007065;
prompt Enabling triggers for AUTHORS...
alter table AUTHORS enable all triggers;
prompt Enabling triggers for CATEGORIES...
alter table CATEGORIES enable all triggers;
prompt Enabling triggers for BOOKSCATALOG...
alter table BOOKSCATALOG enable all triggers;
prompt Enabling triggers for BOOKSTOBORROW...
alter table BOOKSTOBORROW enable all triggers;
prompt Enabling triggers for CUSTOMERS...
alter table CUSTOMERS enable all triggers;
prompt Enabling triggers for LIBRARIANS...
alter table LIBRARIANS enable all triggers;
prompt Enabling triggers for BORROWS...
alter table BORROWS enable all triggers;
set feedback on
set define on
prompt Done.
