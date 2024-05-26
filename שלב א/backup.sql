prompt PL/SQL Developer import file
prompt Created on éåí øàùåï 26 îàé 2024 by èððáåéí
set feedback off
set define off
prompt Creating AUTHORS...
create table AUTHORS
(
  authorid NUMBER(5) not null,
  aname    VARCHAR2(15)
)
  ;
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
)
  ;
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
  add primary key (BOOKNUMBER)  ;
alter table BOOKSTOBORROW
  add foreign key (BOOKID)
  references BOOKSCATALOG (BOOKID);

prompt Creating CUSTOMERS...
create table CUSTOMERS
(
  customerid  NUMBER(5) not null,
  cname       VARCHAR2(15),
  address     VARCHAR2(15),
  dateofbirth DATE not null,
  phone       VARCHAR2(10)
)
  ;
alter table CUSTOMERS
  add primary key (CUSTOMERID)
    ;

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

prompt Creating BORROWS...
create table BORROWS
(
  borroeid   NUMBER(5) not null,
  returndate DATE,
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
values (10, 'Stephen King');
insert into AUTHORS (authorid, aname)
values (11, 'J.K. Rowling');
insert into AUTHORS (authorid, aname)
values (12, 'Agatha Christie');
insert into AUTHORS (authorid, aname)
values (14, 'Jane Austen');
insert into AUTHORS (authorid, aname)
values (15, 'George Orwell');
insert into AUTHORS (authorid, aname)
values (16, 'Mark Twain');
insert into AUTHORS (authorid, aname)
values (18, 'Harper Lee');
insert into AUTHORS (authorid, aname)
values (622, 'Kris');
insert into AUTHORS (authorid, aname)
values (628, 'Kiefer');
insert into AUTHORS (authorid, aname)
values (847, 'Merle');
insert into AUTHORS (authorid, aname)
values (636, 'Wang');
insert into AUTHORS (authorid, aname)
values (509, 'Fionnula');
insert into AUTHORS (authorid, aname)
values (390, 'Maura');
insert into AUTHORS (authorid, aname)
values (202, 'Cuba');
insert into AUTHORS (authorid, aname)
values (933, 'Melba');
insert into AUTHORS (authorid, aname)
values (544, 'Nicole');
insert into AUTHORS (authorid, aname)
values (773, 'Terrence');
insert into AUTHORS (authorid, aname)
values (324, 'Nikki');
insert into AUTHORS (authorid, aname)
values (259, 'Jean-Claude');
insert into AUTHORS (authorid, aname)
values (714, 'Harrison');
insert into AUTHORS (authorid, aname)
values (753, 'Teri');
insert into AUTHORS (authorid, aname)
values (632, 'Lindsay');
insert into AUTHORS (authorid, aname)
values (949, 'Spike');
insert into AUTHORS (authorid, aname)
values (538, 'Bobbi');
insert into AUTHORS (authorid, aname)
values (971, 'Brittany');
insert into AUTHORS (authorid, aname)
values (964, 'Rosanne');
insert into AUTHORS (authorid, aname)
values (204, 'Andrae');
insert into AUTHORS (authorid, aname)
values (645, 'Manu');
insert into AUTHORS (authorid, aname)
values (662, 'Percy');
insert into AUTHORS (authorid, aname)
values (969, 'Horace');
insert into AUTHORS (authorid, aname)
values (666, 'Jessica');
insert into AUTHORS (authorid, aname)
values (393, 'Sam');
insert into AUTHORS (authorid, aname)
values (359, 'Morgan');
insert into AUTHORS (authorid, aname)
values (615, 'Amy');
insert into AUTHORS (authorid, aname)
values (348, 'Emily');
insert into AUTHORS (authorid, aname)
values (354, 'Dave');
insert into AUTHORS (authorid, aname)
values (808, 'Hank');
insert into AUTHORS (authorid, aname)
values (638, 'Mia');
insert into AUTHORS (authorid, aname)
values (801, 'Rebeka');
insert into AUTHORS (authorid, aname)
values (934, 'Laura');
insert into AUTHORS (authorid, aname)
values (694, 'Miki');
insert into AUTHORS (authorid, aname)
values (339, 'Lupe');
insert into AUTHORS (authorid, aname)
values (346, 'Mekhi');
insert into AUTHORS (authorid, aname)
values (762, 'Peabo');
insert into AUTHORS (authorid, aname)
values (307, 'Olga');
insert into AUTHORS (authorid, aname)
values (299, 'Rory');
insert into AUTHORS (authorid, aname)
values (902, 'Al');
insert into AUTHORS (authorid, aname)
values (246, 'Darren');
insert into AUTHORS (authorid, aname)
values (690, 'Kay');
insert into AUTHORS (authorid, aname)
values (485, 'Alana');
insert into AUTHORS (authorid, aname)
values (786, 'Lou');
insert into AUTHORS (authorid, aname)
values (659, 'Fiona');
insert into AUTHORS (authorid, aname)
values (939, 'Spencer');
insert into AUTHORS (authorid, aname)
values (716, 'Joy');
insert into AUTHORS (authorid, aname)
values (214, 'Saul');
insert into AUTHORS (authorid, aname)
values (355, 'Alex');
insert into AUTHORS (authorid, aname)
values (767, 'Samantha');
insert into AUTHORS (authorid, aname)
values (593, 'Holly');
insert into AUTHORS (authorid, aname)
values (216, 'Leelee');
insert into AUTHORS (authorid, aname)
values (937, 'Latin');
insert into AUTHORS (authorid, aname)
values (703, 'Kyra');
insert into AUTHORS (authorid, aname)
values (436, 'Bette');
insert into AUTHORS (authorid, aname)
values (655, 'Chazz');
insert into AUTHORS (authorid, aname)
values (550, 'Billy');
insert into AUTHORS (authorid, aname)
values (954, 'Kenny');
insert into AUTHORS (authorid, aname)
values (744, 'Kathleen');
insert into AUTHORS (authorid, aname)
values (891, 'Sammy');
insert into AUTHORS (authorid, aname)
values (429, 'Wayne');
insert into AUTHORS (authorid, aname)
values (876, 'Liv');
insert into AUTHORS (authorid, aname)
values (527, 'Michael');
insert into AUTHORS (authorid, aname)
values (379, 'Joaquim');
insert into AUTHORS (authorid, aname)
values (869, 'Lennie');
insert into AUTHORS (authorid, aname)
values (595, 'Bob');
insert into AUTHORS (authorid, aname)
values (998, 'Mandy');
insert into AUTHORS (authorid, aname)
values (845, 'Sammy');
insert into AUTHORS (authorid, aname)
values (782, 'Gloria');
insert into AUTHORS (authorid, aname)
values (542, 'Millie');
insert into AUTHORS (authorid, aname)
values (419, 'Thora');
insert into AUTHORS (authorid, aname)
values (435, 'Christine');
insert into AUTHORS (authorid, aname)
values (427, 'Thelma');
insert into AUTHORS (authorid, aname)
values (990, 'Alice');
insert into AUTHORS (authorid, aname)
values (795, 'Avenged');
insert into AUTHORS (authorid, aname)
values (811, 'Lenny');
insert into AUTHORS (authorid, aname)
values (301, 'Sam');
insert into AUTHORS (authorid, aname)
values (599, 'Seann');
insert into AUTHORS (authorid, aname)
values (373, 'Lucy');
insert into AUTHORS (authorid, aname)
values (711, 'Yaphet');
insert into AUTHORS (authorid, aname)
values (472, 'Louise');
insert into AUTHORS (authorid, aname)
values (623, 'Burt');
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
prompt 94 records loaded
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
values (864, 'Hughes', 20, 112, 459);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (539, 'Page', 26, 93, 902);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (638, 'Brooks', 6, 126, 365);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (653, 'Black', 38, 40, 971);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (718, 'Hauer', 4, 112, 638);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (776, 'Hayek', 29, 40, 628);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (984, 'Glenn', 24, 126, 307);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (466, 'DiFranco', 19, 40, 538);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (636, 'McGoohan', 40, 54, 202);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (873, 'Getty', 42, 40, 472);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (521, 'Morales', 47, 112, 485);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (407, 'Franklin', 5, 54, 753);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (419, 'McGinley', 6, 112, 211);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (488, 'Garcia', 20, 137, 645);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (914, 'Rizzo', 17, 112, 782);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (994, 'Farina', 5, 137, 933);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (829, 'Keith', 41, 54, 847);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (662, 'Yankovic', 49, 126, 18);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (887, 'Biel', 22, 126, 801);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (739, 'Hackman', 9, 112, 773);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (514, 'Bullock', 43, 40, 379);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (649, 'Schiavelli', 11, 137, 595);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (732, 'Aiken', 31, 93, 753);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (770, 'Graham', 7, 137, 845);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (618, 'Eldard', 2, 93, 787);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (496, 'Balaban', 28, 40, 785);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (757, 'Leachman', 4, 40, 204);
insert into BOOKSCATALOG (bookid, bookname, amount, categoryid, authorid)
values (654, 'Waite', 4, 126, 694);
commit;
prompt 28 records loaded
prompt Loading BOOKSTOBORROW...
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2067, 'y', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3238, 'y', 662);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (3012, 'n', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (2767, 'n', 654);
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
values (2821, 'n', 864);
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
values (470, 'CarlSchreiber', '293 Warley Stre', to_date('02-03-1985', 'dd-mm-yyyy'), '1289801838');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (596, 'RickLowe', '86 Wiest Road', to_date('20-06-2013', 'dd-mm-yyyy'), '3337933132');
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
values (969, 'GoranSisto', '81 Dortmund Roa', to_date('18-05-2010', 'dd-mm-yyyy'), '1482609749');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (523, 'DaryleBosco', '26 Hannover Roa', to_date('02-12-2000', 'dd-mm-yyyy'), '4163267399');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (535, 'WhoopiWeisberg', '66 Wilkinson Dr', to_date('08-06-1972', 'dd-mm-yyyy'), '2637584488');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (985, 'RosarioCash', '13rd Street', to_date('16-07-1978', 'dd-mm-yyyy'), '2217913753');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (913, 'ScarlettArmatra', '53rd Street', to_date('30-05-1980', 'dd-mm-yyyy'), '855458612');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (434, 'TriniMcFadden', '38 Corey Road', to_date('13-02-1983', 'dd-mm-yyyy'), '2435792554');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (426, 'LoreenaGilley', '24 Raybon Road', to_date('11-04-2002', 'dd-mm-yyyy'), '2223793589');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (512, 'LarryBrooke', '525 Vai Street', to_date('28-06-1989', 'dd-mm-yyyy'), '3540049932');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (621, 'AvrilKoteas', '66 Carrack Road', to_date('11-08-1977', 'dd-mm-yyyy'), '3548291245');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (382, 'SissyMcKellen', '16 Janeane Driv', to_date('18-08-1972', 'dd-mm-yyyy'), '2630033583');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (595, 'TemueraBall', '812 Byrd Street', to_date('15-03-1995', 'dd-mm-yyyy'), '1989015112');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (760, 'HarrietAffleck', '80 Freddie Stre', to_date('21-09-1988', 'dd-mm-yyyy'), '2739317494');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (226, 'CeiliDavis', '98 Garland Stre', to_date('08-12-1982', 'dd-mm-yyyy'), '3181768911');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (540, 'VerucaDickinson', '97 Whitley Stre', to_date('06-12-2007', 'dd-mm-yyyy'), '572588605');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (466, 'CollinCurtis', '59 Kylie Drive', to_date('22-11-2000', 'dd-mm-yyyy'), '3407535473');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (899, 'ViennaDerringer', '31 Heatherly Ro', to_date('12-03-2008', 'dd-mm-yyyy'), '1854187026');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (730, 'GabrielMaxwell', '816 Tooele Stre', to_date('24-11-1994', 'dd-mm-yyyy'), '899641101');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (536, 'HookahIrons', '46 Graham Stree', to_date('02-01-1982', 'dd-mm-yyyy'), '1952741769');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (235, 'GinPhillips', '36 Wong', to_date('10-08-1994', 'dd-mm-yyyy'), '777461587');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (569, 'ThoraSutherland', '32 Liu Ave', to_date('19-03-1988', 'dd-mm-yyyy'), '873095289');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (679, 'Jean-LucKershaw', '62nd Street', to_date('29-05-1995', 'dd-mm-yyyy'), '3875784291');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (745, 'AvengedVassar', '63 Jimmy Street', to_date('18-11-1999', 'dd-mm-yyyy'), '2970090983');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (819, 'ConnieMeniketti', '43 California S', to_date('13-09-2004', 'dd-mm-yyyy'), '1550256603');
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
values (740, 'RoyDooley', '53 Makeba Road', to_date('19-05-2003', 'dd-mm-yyyy'), '1332574820');
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
values (800, 'EugeneAdkins', '14 Dustin Road', to_date('03-11-2018', 'dd-mm-yyyy'), '3656776672');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (739, 'KirkBlossoms', '81 Parsippany R', to_date('17-02-1991', 'dd-mm-yyyy'), '2711321889');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (210, 'NataschaHurley', '22 Arthur Drive', to_date('19-05-2019', 'dd-mm-yyyy'), '21025327');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (371, 'HelenAdams', '645 Aniston Roa', to_date('15-07-1981', 'dd-mm-yyyy'), '1782596247');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (649, 'ParkerDushku', '260 Leslie Stre', to_date('03-08-1972', 'dd-mm-yyyy'), '1639982604');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (239, 'JimmyRamirez', '11 Spike Road', to_date('12-02-2008', 'dd-mm-yyyy'), '1040455812');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (361, 'BobbiBarkin', '44 DiBiasio Str', to_date('31-05-2012', 'dd-mm-yyyy'), '3959391699');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (554, 'HexO''Hara', '96 Leguizamo Ro', to_date('09-09-1978', 'dd-mm-yyyy'), '1435019934');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (950, 'TriniBoothe', '60 Caine Street', to_date('08-04-1999', 'dd-mm-yyyy'), '2498875587');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (942, 'MarcWesterberg', '88 Pfeiffer Str', to_date('21-03-2015', 'dd-mm-yyyy'), '2802556357');
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
values (970, 'ChiHedaya', '91st Street', to_date('10-06-1984', 'dd-mm-yyyy'), '723670881');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (726, 'TommyLevin', '971 Ljubljana R', to_date('27-02-1985', 'dd-mm-yyyy'), '1770749760');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (397, 'ChristianHopper', '70 Doucette Blv', to_date('18-04-1979', 'dd-mm-yyyy'), '2088746194');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (998, 'StanleyCarr', '8 Hank', to_date('16-04-2012', 'dd-mm-yyyy'), '1060624766');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (321, 'KaronMacy', '75 Philip Road', to_date('08-06-1983', 'dd-mm-yyyy'), '2275893281');
insert into CUSTOMERS (customerid, cname, address, dateofbirth, phone)
values (450, 'ToshiroLaBelle', '42nd Street', to_date('09-11-2007', 'dd-mm-yyyy'), '2421783440');
commit;
prompt 83 records loaded
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
values (355, 'LarenzScott', '2445348302');
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
values (643, 'TramaineNolte', '3155149677');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (865, 'WendyRispoli', '3700676284');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (479, 'TalChao', '2709051707');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (252, 'RhonaAglukark', '1875622692');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (439, 'LaraCocker', '2547512730');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (975, 'SaffronTempest', '2381876430');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (718, 'LukeGoldblum', '1280970467');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (218, 'ChantéDavid', '2101385291');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (739, 'MurrayAykroyd', '2101556339');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (661, 'JacksonHynde', '3406840639');
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
values (843, 'EmilyCantrell', '1845285119');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (459, 'TrickBratt', '3032021502');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (942, 'AndyCube', '2415863783');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (881, 'TiaNapolitano', '2267563000');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (220, 'ColeyAykroyd', '2834134387');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (500, 'SonnyHutch', '4219606693');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (588, 'Carrie-AnneChea', '1800904403');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (493, 'JuliannaO''Conno', '990392438');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (790, 'ChelyLoring', '4279486903');
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
values (297, 'AprilNewman', '2736402480');
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
values (858, 'JaredSchwarzene', '602361032');
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
values (944, 'BurtonO''Neal', '525819855');
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
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (231, 'Nicoleurban', '1621023257');
insert into LIBRARIANS (libraryid, lname, phonenumber)
values (215, 'LaurenceKenoly', '597588474');
commit;
prompt 77 records loaded
prompt Loading BORROWS...
prompt Table is empty
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
