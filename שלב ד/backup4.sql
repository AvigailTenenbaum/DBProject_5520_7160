prompt PL/SQL Developer import file
prompt Created on יום שישי 19 יולי 2024 by טננבוים
set feedback off
set define off
prompt Creating ACTIVITIES...
create table ACTIVITIES
(
  a_id        INTEGER not null,
  name        VARCHAR2(15) not null,
  description VARCHAR2(15) not null,
  cost        FLOAT not null
)
;
alter table ACTIVITIES
  add primary key (A_ID)
  ;

prompt Creating PERSON...
create table PERSON
(
  p_id   INTEGER not null,
  p_name VARCHAR2(15)
)
;
alter table PERSON
  add primary key (P_ID)
  ;

prompt Creating AUTHORS...
create table AUTHORS
(
  authorid INTEGER not null
)
;
alter table AUTHORS
  add primary key (AUTHORID);
alter table AUTHORS
  add constraint FK_PID1 foreign key (AUTHORID)
  references PERSON (P_ID);

prompt Creating CUSTOMERS...
create table CUSTOMERS
(
  address     VARCHAR2(15),
  dateofbirth DATE not null,
  phone       VARCHAR2(10),
  email       VARCHAR2(15),
  customerid  INTEGER not null
)
;
alter table CUSTOMERS
  add primary key (CUSTOMERID);
alter table CUSTOMERS
  add constraint FK_PID foreign key (CUSTOMERID)
  references PERSON (P_ID);
alter table CUSTOMERS
  add constraint CHK_PHONE_LENGTH
  check (LENGTH(Phone)<=10);

prompt Creating PAYMENT...
create table PAYMENT
(
  p_id         INTEGER not null,
  cost         FLOAT not null,
  payment_date DATE not null
)
;
alter table PAYMENT
  add primary key (P_ID);

prompt Creating BOOKING...
create table BOOKING
(
  b_id       INTEGER not null,
  check_in   DATE not null,
  check_out  DATE not null,
  customerid INTEGER not null,
  p_id       INTEGER not null
)
;
alter table BOOKING
  add primary key (B_ID)
  ;
alter table BOOKING
  add constraint FK_BOOKING_ID foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);
alter table BOOKING
  add foreign key (P_ID)
  references PAYMENT (P_ID);
alter table BOOKING
  add constraint CHECK_DATES
  check (check_in < check_out);

prompt Creating BOOKINGACTIVITIES...
create table BOOKINGACTIVITIES
(
  b_id INTEGER not null,
  a_id INTEGER not null
)
;
alter table BOOKINGACTIVITIES
  add primary key (B_ID, A_ID)
  ;
alter table BOOKINGACTIVITIES
  add foreign key (B_ID)
  references BOOKING (B_ID);
alter table BOOKINGACTIVITIES
  add foreign key (A_ID)
  references ACTIVITIES (A_ID);

prompt Creating ROOMS...
create table ROOMS
(
  r_id      INTEGER not null,
  room_type INTEGER not null,
  floor     INTEGER
)
;
alter table ROOMS
  add primary key (R_ID)
  ;

prompt Creating BOOKINGROOMS...
create table BOOKINGROOMS
(
  r_id INTEGER not null,
  b_id INTEGER not null
)
;
alter table BOOKINGROOMS
  add primary key (R_ID, B_ID);
alter table BOOKINGROOMS
  add foreign key (R_ID)
  references ROOMS (R_ID);
alter table BOOKINGROOMS
  add foreign key (B_ID)
  references BOOKING (B_ID);

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
  add constraint FK_BOOKSCATALOGID foreign key (AUTHORID)
  references AUTHORS (AUTHORID);
alter table BOOKSCATALOG
  add foreign key (CATEGORYID)
  references CATEGORIES (CATEGORYID);

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

prompt Creating EMPLOYES...
create table EMPLOYES
(
  position VARCHAR2(15) default 'Counter Clerk' not null,
  e_id     INTEGER not null,
  salary   NUMBER
)
;
alter table EMPLOYES
  add primary key (E_ID)
  ;
alter table EMPLOYES
  add constraint FK_PID2 foreign key (E_ID)
  references PERSON (P_ID);

prompt Creating LIBRARIANS...
create table LIBRARIANS
(
  libraryid   NUMBER(5) not null,
  phonenumber VARCHAR2(10)
)
;
alter table LIBRARIANS
  add primary key (LIBRARYID)
  ;
alter table LIBRARIANS
  add constraint FK_PID3 foreign key (LIBRARYID)
  references EMPLOYES (E_ID);
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
  add constraint FK_BORROWID foreign key (LIBRARYID)
  references LIBRARIANS (LIBRARYID);
alter table BORROWS
  add constraint FK_BORROWS_ID foreign key (CUSTOMERID)
  references CUSTOMERS (CUSTOMERID);
alter table BORROWS
  add foreign key (BOOKNUMBER)
  references BOOKSTOBORROW (BOOKNUMBER);

prompt Creating WORK...
create table WORK
(
  e_id INTEGER not null,
  a_id INTEGER not null
)
;
alter table WORK
  add primary key (E_ID, A_ID)
  ;
alter table WORK
  add constraint FK_WORKID foreign key (E_ID)
  references EMPLOYES (E_ID);
alter table WORK
  add foreign key (A_ID)
  references ACTIVITIES (A_ID);

prompt Disabling triggers for ACTIVITIES...
alter table ACTIVITIES disable all triggers;
prompt Disabling triggers for PERSON...
alter table PERSON disable all triggers;
prompt Disabling triggers for AUTHORS...
alter table AUTHORS disable all triggers;
prompt Disabling triggers for CUSTOMERS...
alter table CUSTOMERS disable all triggers;
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for BOOKING...
alter table BOOKING disable all triggers;
prompt Disabling triggers for BOOKINGACTIVITIES...
alter table BOOKINGACTIVITIES disable all triggers;
prompt Disabling triggers for ROOMS...
alter table ROOMS disable all triggers;
prompt Disabling triggers for BOOKINGROOMS...
alter table BOOKINGROOMS disable all triggers;
prompt Disabling triggers for CATEGORIES...
alter table CATEGORIES disable all triggers;
prompt Disabling triggers for BOOKSCATALOG...
alter table BOOKSCATALOG disable all triggers;
prompt Disabling triggers for BOOKSTOBORROW...
alter table BOOKSTOBORROW disable all triggers;
prompt Disabling triggers for EMPLOYES...
alter table EMPLOYES disable all triggers;
prompt Disabling triggers for LIBRARIANS...
alter table LIBRARIANS disable all triggers;
prompt Disabling triggers for BORROWS...
alter table BORROWS disable all triggers;
prompt Disabling triggers for WORK...
alter table WORK disable all triggers;
prompt Disabling foreign key constraints for AUTHORS...
alter table AUTHORS disable constraint FK_PID1;
prompt Disabling foreign key constraints for CUSTOMERS...
alter table CUSTOMERS disable constraint FK_PID;
prompt Disabling foreign key constraints for BOOKING...
alter table BOOKING disable constraint FK_BOOKING_ID;
alter table BOOKING disable constraint SYS_C007285;
prompt Disabling foreign key constraints for BOOKINGACTIVITIES...
alter table BOOKINGACTIVITIES disable constraint SYS_C007290;
alter table BOOKINGACTIVITIES disable constraint SYS_C007291;
prompt Disabling foreign key constraints for BOOKINGROOMS...
alter table BOOKINGROOMS disable constraint SYS_C007298;
alter table BOOKINGROOMS disable constraint SYS_C007299;
prompt Disabling foreign key constraints for BOOKSCATALOG...
alter table BOOKSCATALOG disable constraint FK_BOOKSCATALOGID;
alter table BOOKSCATALOG disable constraint SYS_C007052;
prompt Disabling foreign key constraints for BOOKSTOBORROW...
alter table BOOKSTOBORROW disable constraint SYS_C007057;
prompt Disabling foreign key constraints for EMPLOYES...
alter table EMPLOYES disable constraint FK_PID2;
prompt Disabling foreign key constraints for LIBRARIANS...
alter table LIBRARIANS disable constraint FK_PID3;
prompt Disabling foreign key constraints for BORROWS...
alter table BORROWS disable constraint FK_BORROWID;
alter table BORROWS disable constraint FK_BORROWS_ID;
alter table BORROWS disable constraint SYS_C007063;
prompt Disabling foreign key constraints for WORK...
alter table WORK disable constraint FK_WORKID;
alter table WORK disable constraint SYS_C007308;
prompt Deleting WORK...
delete from WORK;
commit;
prompt Deleting BORROWS...
delete from BORROWS;
commit;
prompt Deleting LIBRARIANS...
delete from LIBRARIANS;
commit;
prompt Deleting EMPLOYES...
delete from EMPLOYES;
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
prompt Deleting BOOKINGROOMS...
delete from BOOKINGROOMS;
commit;
prompt Deleting ROOMS...
delete from ROOMS;
commit;
prompt Deleting BOOKINGACTIVITIES...
delete from BOOKINGACTIVITIES;
commit;
prompt Deleting BOOKING...
delete from BOOKING;
commit;
prompt Deleting PAYMENT...
delete from PAYMENT;
commit;
prompt Deleting CUSTOMERS...
delete from CUSTOMERS;
commit;
prompt Deleting AUTHORS...
delete from AUTHORS;
commit;
prompt Deleting PERSON...
delete from PERSON;
commit;
prompt Deleting ACTIVITIES...
delete from ACTIVITIES;
commit;
prompt Loading ACTIVITIES...
insert into ACTIVITIES (a_id, name, description, cost)
values (389, 'pool', 'family', 0);
insert into ACTIVITIES (a_id, name, description, cost)
values (393, 'bar', 'adults', 50);
insert into ACTIVITIES (a_id, name, description, cost)
values (298, 'baooling', 'family', 30);
insert into ACTIVITIES (a_id, name, description, cost)
values (824, 'trip', 'family', 100);
insert into ACTIVITIES (a_id, name, description, cost)
values (552, 'cars', 'family', 150);
insert into ACTIVITIES (a_id, name, description, cost)
values (596, 'art', 'kids', 20);
insert into ACTIVITIES (a_id, name, description, cost)
values (759, 'spa', 'adults', 0);
insert into ACTIVITIES (a_id, name, description, cost)
values (78, 'ijump', 'kids', 40);
insert into ACTIVITIES (a_id, name, description, cost)
values (527, 'jip', 'adults', 80);
insert into ACTIVITIES (a_id, name, description, cost)
values (392, 'gymboree', 'kids', 10);
insert into ACTIVITIES (a_id, name, description, cost)
values (45, 'rooftop party', 'adults', 50);
insert into ACTIVITIES (a_id, name, description, cost)
values (794, 'omega', 'family', 60);
insert into ACTIVITIES (a_id, name, description, cost)
values (502, 'hair style', 'family', 70);
insert into ACTIVITIES (a_id, name, description, cost)
values (20, 'jip', 'adults', 65);
commit;
prompt 14 records loaded
prompt Loading PERSON...
insert into PERSON (p_id, p_name)
values (909, 'LeonKilmer');
insert into PERSON (p_id, p_name)
values (765, 'ThelmaBailey');
insert into PERSON (p_id, p_name)
values (366, 'BurtonDukakis');
insert into PERSON (p_id, p_name)
values (746, 'RicardoFarrow');
insert into PERSON (p_id, p_name)
values (935, 'ChristopherHatc');
insert into PERSON (p_id, p_name)
values (256, 'AaronYorn');
insert into PERSON (p_id, p_name)
values (891, 'RobbieKimball');
insert into PERSON (p_id, p_name)
values (470, 'CarlSchreibeA');
insert into PERSON (p_id, p_name)
values (596, 'RickLowA');
insert into PERSON (p_id, p_name)
values (525, 'StewartDiaz');
insert into PERSON (p_id, p_name)
values (436, 'BreckinTennison');
insert into PERSON (p_id, p_name)
values (518, 'WangQuaid');
insert into PERSON (p_id, p_name)
values (932, 'JannDeejay');
insert into PERSON (p_id, p_name)
values (254, 'ArmandIrving');
insert into PERSON (p_id, p_name)
values (969, 'GoranSistA');
insert into PERSON (p_id, p_name)
values (523, 'DaryleBosco');
insert into PERSON (p_id, p_name)
values (535, 'WhoopiWeisberA');
insert into PERSON (p_id, p_name)
values (985, 'RosarioCash');
insert into PERSON (p_id, p_name)
values (913, 'ScarlettArmatra');
insert into PERSON (p_id, p_name)
values (434, 'TriniMcFadden');
insert into PERSON (p_id, p_name)
values (426, 'LoreenaGilley');
insert into PERSON (p_id, p_name)
values (512, 'LarryBrookA');
insert into PERSON (p_id, p_name)
values (621, 'AvrilKoteas');
insert into PERSON (p_id, p_name)
values (382, 'SissyMcKellen');
insert into PERSON (p_id, p_name)
values (595, 'TemueraBall');
insert into PERSON (p_id, p_name)
values (760, 'HarrietAfflecA');
insert into PERSON (p_id, p_name)
values (226, 'CeiliDavis');
insert into PERSON (p_id, p_name)
values (540, 'VerucaDickinson');
insert into PERSON (p_id, p_name)
values (466, 'CollinCurtis');
insert into PERSON (p_id, p_name)
values (899, 'ViennaDerringer');
insert into PERSON (p_id, p_name)
values (730, 'GabrielMaxwelA');
insert into PERSON (p_id, p_name)
values (536, 'HookahIrons');
insert into PERSON (p_id, p_name)
values (235, 'GinPhillipA');
insert into PERSON (p_id, p_name)
values (569, 'ThoraSutherland');
insert into PERSON (p_id, p_name)
values (679, 'Jean-LucKershaw');
insert into PERSON (p_id, p_name)
values (745, 'AvengedVassar');
insert into PERSON (p_id, p_name)
values (819, 'ConnieMenikettA');
insert into PERSON (p_id, p_name)
values (940, 'BonnieSuchet');
insert into PERSON (p_id, p_name)
values (504, 'WillieWeber');
insert into PERSON (p_id, p_name)
values (903, 'ThinPaige');
insert into PERSON (p_id, p_name)
values (642, 'EmmaByrd');
insert into PERSON (p_id, p_name)
values (762, 'AnneAvital');
insert into PERSON (p_id, p_name)
values (978, 'SissyMatarazzo');
insert into PERSON (p_id, p_name)
values (489, 'PaulaVaughan');
insert into PERSON (p_id, p_name)
values (335, 'Bobvon Sydow');
insert into PERSON (p_id, p_name)
values (740, 'RoyDooleA');
insert into PERSON (p_id, p_name)
values (747, 'HankOrlando');
insert into PERSON (p_id, p_name)
values (461, 'DiamondFlanagan');
insert into PERSON (p_id, p_name)
values (459, 'MenaTaha');
insert into PERSON (p_id, p_name)
values (836, 'PattyTurturro');
insert into PERSON (p_id, p_name)
values (699, 'GranScott');
insert into PERSON (p_id, p_name)
values (357, 'KellyCoughlan');
insert into PERSON (p_id, p_name)
values (597, 'DebbyNewman');
insert into PERSON (p_id, p_name)
values (656, 'RalphWhitman');
insert into PERSON (p_id, p_name)
values (800, 'EugeneAdkinA');
insert into PERSON (p_id, p_name)
values (739, 'KirkBlossoms');
insert into PERSON (p_id, p_name)
values (210, 'NataschaHurley');
insert into PERSON (p_id, p_name)
values (371, 'HelenAdamA');
insert into PERSON (p_id, p_name)
values (649, 'ParkerDushku');
insert into PERSON (p_id, p_name)
values (239, 'JimmyRamirez');
insert into PERSON (p_id, p_name)
values (361, 'BobbiBarkiA');
insert into PERSON (p_id, p_name)
values (554, 'HexO''HarA');
insert into PERSON (p_id, p_name)
values (950, 'TriniBoothe');
insert into PERSON (p_id, p_name)
values (942, 'MarcWesterberA');
insert into PERSON (p_id, p_name)
values (200, 'TerenceAbraham');
insert into PERSON (p_id, p_name)
values (688, 'RaulSanders');
insert into PERSON (p_id, p_name)
values (431, 'JamieBrooks');
insert into PERSON (p_id, p_name)
values (700, 'SusanHobson');
insert into PERSON (p_id, p_name)
values (710, 'MarleyCetera');
insert into PERSON (p_id, p_name)
values (383, 'FredericMiller');
insert into PERSON (p_id, p_name)
values (718, 'CrispinBloch');
insert into PERSON (p_id, p_name)
values (533, 'CevinCrowe');
insert into PERSON (p_id, p_name)
values (807, 'JuliannaHuston');
insert into PERSON (p_id, p_name)
values (377, 'JuanPony');
insert into PERSON (p_id, p_name)
values (590, 'SelmaArmstrong');
insert into PERSON (p_id, p_name)
values (261, 'BetteLevy');
insert into PERSON (p_id, p_name)
values (211, 'KaronBachman');
insert into PERSON (p_id, p_name)
values (970, 'ChiHedayA');
insert into PERSON (p_id, p_name)
values (726, 'TommyLeviA');
insert into PERSON (p_id, p_name)
values (397, 'ChristianHopper');
insert into PERSON (p_id, p_name)
values (998, 'StanleyCarA');
insert into PERSON (p_id, p_name)
values (321, 'KaronMacy');
insert into PERSON (p_id, p_name)
values (450, 'ToshiroLaBelle');
insert into PERSON (p_id, p_name)
values (1, 'John Doe');
insert into PERSON (p_id, p_name)
values (51, 'Adrien-Mazzello');
insert into PERSON (p_id, p_name)
values (418, 'Fats-Reid');
insert into PERSON (p_id, p_name)
values (10, 'Andie-Wincott');
insert into PERSON (p_id, p_name)
values (773, 'Emerson-Mazzell');
insert into PERSON (p_id, p_name)
values (186, 'Dean-Doucette');
insert into PERSON (p_id, p_name)
values (557, 'Ming-Na-Warwick');
insert into PERSON (p_id, p_name)
values (962, 'Cloris-Hersh');
insert into PERSON (p_id, p_name)
values (331, 'Shelby-Vaughn');
insert into PERSON (p_id, p_name)
values (369, 'Celia-Busey');
insert into PERSON (p_id, p_name)
values (780, 'Tyrone-Hobson');
insert into PERSON (p_id, p_name)
values (379, 'Bo-Shearer');
insert into PERSON (p_id, p_name)
values (948, 'Carol-O''Neal');
insert into PERSON (p_id, p_name)
values (279, 'Rutger-Manning');
insert into PERSON (p_id, p_name)
values (64, 'Lucy-Speaks');
insert into PERSON (p_id, p_name)
values (521, 'Vonda-Glover');
insert into PERSON (p_id, p_name)
values (798, 'Sara-Garza');
commit;
prompt 100 records committed...
insert into PERSON (p_id, p_name)
values (22, 'Heath-Dourif');
insert into PERSON (p_id, p_name)
values (695, 'Heath-Quatro');
insert into PERSON (p_id, p_name)
values (284, 'Armand-Hornsby');
insert into PERSON (p_id, p_name)
values (206, 'Domingo-Platt');
insert into PERSON (p_id, p_name)
values (630, 'Don-Witt');
insert into PERSON (p_id, p_name)
values (156, 'Russell-Raye');
insert into PERSON (p_id, p_name)
values (327, 'Shawn-Dale');
insert into PERSON (p_id, p_name)
values (345, 'Rosie-Close');
insert into PERSON (p_id, p_name)
values (761, 'Vince-Sinise');
insert into PERSON (p_id, p_name)
values (355, 'Alfie-Matheson');
insert into PERSON (p_id, p_name)
values (568, 'Bonnie-Wopat');
insert into PERSON (p_id, p_name)
values (996, 'Gena-Blanchett');
insert into PERSON (p_id, p_name)
values (804, 'Clea-Eat World');
insert into PERSON (p_id, p_name)
values (713, 'Lee-Dourif');
insert into PERSON (p_id, p_name)
values (320, 'Edwin-Feliciano');
insert into PERSON (p_id, p_name)
values (848, 'Junior-Sorvino');
insert into PERSON (p_id, p_name)
values (244, 'Kenny-Dalton');
insert into PERSON (p_id, p_name)
values (567, 'Nicolas-Pierce');
insert into PERSON (p_id, p_name)
values (691, 'Kirsten-Osmond');
insert into PERSON (p_id, p_name)
values (340, 'Wendy-Affleck');
insert into PERSON (p_id, p_name)
values (18, 'Colm-Tarantino');
insert into PERSON (p_id, p_name)
values (134, 'Suzi-Crystal');
insert into PERSON (p_id, p_name)
values (122, 'Wally-Hopper');
insert into PERSON (p_id, p_name)
values (363, 'Delroy-Edmunds');
insert into PERSON (p_id, p_name)
values (816, 'Curtis-Van Der ');
insert into PERSON (p_id, p_name)
values (272, 'Mandy-Martinez');
insert into PERSON (p_id, p_name)
values (999, 'Yaphet-Reno');
insert into PERSON (p_id, p_name)
values (295, 'Brad-McCann');
insert into PERSON (p_id, p_name)
values (268, 'Famke-Emmerich');
insert into PERSON (p_id, p_name)
values (455, 'Rachael-Pullman');
insert into PERSON (p_id, p_name)
values (66, 'Meredith-Vinton');
insert into PERSON (p_id, p_name)
values (296, 'Dwight-Bell');
insert into PERSON (p_id, p_name)
values (810, 'Mili-Phillips');
insert into PERSON (p_id, p_name)
values (83, 'Janice-Chaplin');
insert into PERSON (p_id, p_name)
values (118, 'Etta-Curfman');
insert into PERSON (p_id, p_name)
values (224, 'Renee-Goldwyn');
insert into PERSON (p_id, p_name)
values (257, 'Milla-Buscemi');
insert into PERSON (p_id, p_name)
values (910, 'Debbie-Buscemi');
insert into PERSON (p_id, p_name)
values (953, 'Liev-Sedaka');
insert into PERSON (p_id, p_name)
values (728, 'Rutger-Peebles');
insert into PERSON (p_id, p_name)
values (390, 'Jonny Lee-Berry');
insert into PERSON (p_id, p_name)
values (333, 'Thelma-Blanchet');
insert into PERSON (p_id, p_name)
values (817, 'Lloyd-Colton');
insert into PERSON (p_id, p_name)
values (709, 'Vickie-Hanley');
insert into PERSON (p_id, p_name)
values (794, 'Christine-Getty');
insert into PERSON (p_id, p_name)
values (785, 'Domingo-Feore');
insert into PERSON (p_id, p_name)
values (404, 'Dorry-Balaban');
insert into PERSON (p_id, p_name)
values (62, 'Gerald-Butler');
insert into PERSON (p_id, p_name)
values (832, 'Natascha-Anders');
insert into PERSON (p_id, p_name)
values (702, 'Rosanne-Eastwoo');
insert into PERSON (p_id, p_name)
values (52, 'Jennifer-Berkle');
insert into PERSON (p_id, p_name)
values (384, 'Michelle-Fioren');
insert into PERSON (p_id, p_name)
values (356, 'Bette-Ronstadt');
insert into PERSON (p_id, p_name)
values (478, 'Andre-Levert');
insert into PERSON (p_id, p_name)
values (732, 'Busta-McDormand');
insert into PERSON (p_id, p_name)
values (524, 'Laurence-Apple');
insert into PERSON (p_id, p_name)
values (876, 'Bobby-Chaplin');
insert into PERSON (p_id, p_name)
values (844, 'Charlton-Benet');
insert into PERSON (p_id, p_name)
values (758, 'Terry-Dorn');
insert into PERSON (p_id, p_name)
values (110, 'Jarvis-Jones');
insert into PERSON (p_id, p_name)
values (332, 'Steve-Gough');
insert into PERSON (p_id, p_name)
values (964, 'Aimee-Skerritt');
insert into PERSON (p_id, p_name)
values (904, 'Elizabeth-Remar');
insert into PERSON (p_id, p_name)
values (879, 'Henry-Soda');
insert into PERSON (p_id, p_name)
values (650, 'Terence-Dutton');
insert into PERSON (p_id, p_name)
values (59, 'Bo-Blair');
insert into PERSON (p_id, p_name)
values (398, 'Praga-Holliday');
insert into PERSON (p_id, p_name)
values (89, 'Buddy-Broadbent');
insert into PERSON (p_id, p_name)
values (232, 'Maria-Lightfoot');
insert into PERSON (p_id, p_name)
values (491, 'Heather-Sinise');
insert into PERSON (p_id, p_name)
values (522, 'Gene-English');
insert into PERSON (p_id, p_name)
values (937, 'Danni-Steiger');
insert into PERSON (p_id, p_name)
values (547, 'Timothy-Dorff');
insert into PERSON (p_id, p_name)
values (56, 'Arnold-Posener');
insert into PERSON (p_id, p_name)
values (142, 'Machine-Winston');
insert into PERSON (p_id, p_name)
values (888, 'Brent-Phillips');
insert into PERSON (p_id, p_name)
values (442, 'Jimmy-Affleck');
insert into PERSON (p_id, p_name)
values (955, 'Jann-Robards');
insert into PERSON (p_id, p_name)
values (606, 'Jake-Steenburge');
insert into PERSON (p_id, p_name)
values (183, 'Jeanne-Tierney');
insert into PERSON (p_id, p_name)
values (109, 'Alannah-Gandolf');
insert into PERSON (p_id, p_name)
values (318, 'Roddy-Quinlan');
insert into PERSON (p_id, p_name)
values (965, 'Derek-Knight');
insert into PERSON (p_id, p_name)
values (287, 'Vanessa-Ball');
insert into PERSON (p_id, p_name)
values (170, 'Patrick-Gugino');
insert into PERSON (p_id, p_name)
values (290, 'Jackson-Worrell');
insert into PERSON (p_id, p_name)
values (611, 'Teena-Witt');
insert into PERSON (p_id, p_name)
values (918, 'Tommy-Avital');
insert into PERSON (p_id, p_name)
values (833, 'Rik-Irons');
insert into PERSON (p_id, p_name)
values (492, 'Gary-Osment');
insert into PERSON (p_id, p_name)
values (849, 'Kathy-Potter');
insert into PERSON (p_id, p_name)
values (325, 'Anna-Morton');
insert into PERSON (p_id, p_name)
values (646, 'Sonny-Carlton');
insert into PERSON (p_id, p_name)
values (555, 'Seth-Caviezel');
insert into PERSON (p_id, p_name)
values (641, 'Victoria-Bell');
insert into PERSON (p_id, p_name)
values (520, 'Dorry-Lennix');
insert into PERSON (p_id, p_name)
values (526, 'Trey-Ripley');
insert into PERSON (p_id, p_name)
values (281, 'Andre-Crewson');
insert into PERSON (p_id, p_name)
values (288, 'Owen-Lunch');
insert into PERSON (p_id, p_name)
values (93, 'Liquid-Twilley');
commit;
prompt 200 records committed...
insert into PERSON (p_id, p_name)
values (63, 'Ahmad-Boothe');
insert into PERSON (p_id, p_name)
values (781, 'Ethan-Malkovich');
insert into PERSON (p_id, p_name)
values (924, 'Mika-Bryson');
insert into PERSON (p_id, p_name)
values (506, 'Christina-Lewin');
insert into PERSON (p_id, p_name)
values (968, 'Nicolas-Ripley');
insert into PERSON (p_id, p_name)
values (223, 'Chet-Mollard');
insert into PERSON (p_id, p_name)
values (90, 'Darius-LuPone');
insert into PERSON (p_id, p_name)
values (326, 'Melanie-von Syd');
insert into PERSON (p_id, p_name)
values (247, 'Kyle-Rippy');
insert into PERSON (p_id, p_name)
values (553, 'Sigourney-Hauer');
insert into PERSON (p_id, p_name)
values (821, 'John-Steiger');
insert into PERSON (p_id, p_name)
values (759, 'Denzel-Quinlan');
insert into PERSON (p_id, p_name)
values (41, 'Alice-Stevenson');
insert into PERSON (p_id, p_name)
values (446, 'Colleen-Garza');
insert into PERSON (p_id, p_name)
values (527, 'Juliet-McDonald');
insert into PERSON (p_id, p_name)
values (897, 'Hazel-Marsden');
insert into PERSON (p_id, p_name)
values (38, 'Courtney-Sisto');
insert into PERSON (p_id, p_name)
values (453, 'Curtis-DiCaprio');
insert into PERSON (p_id, p_name)
values (769, 'Alan-Oldman');
insert into PERSON (p_id, p_name)
values (868, 'Vertical-Gagnon');
insert into PERSON (p_id, p_name)
values (507, 'Derrick-Gayle');
insert into PERSON (p_id, p_name)
values (365, 'Jann-Cook');
insert into PERSON (p_id, p_name)
values (826, 'Mindy-Rivers');
insert into PERSON (p_id, p_name)
values (865, 'Janice-Brosnan');
insert into PERSON (p_id, p_name)
values (580, 'Colleen-Pony');
insert into PERSON (p_id, p_name)
values (316, 'Bernie-Faithful');
insert into PERSON (p_id, p_name)
values (640, 'Lionel-Heche');
insert into PERSON (p_id, p_name)
values (151, 'Art-Nivola');
insert into PERSON (p_id, p_name)
values (757, 'Barbara-Holiday');
insert into PERSON (p_id, p_name)
values (541, 'Hector-Cook');
insert into PERSON (p_id, p_name)
values (870, 'Wallace-Allison');
insert into PERSON (p_id, p_name)
values (583, 'Jarvis-Berkeley');
insert into PERSON (p_id, p_name)
values (317, 'Ed-Rodriguez');
insert into PERSON (p_id, p_name)
values (271, 'Alex-Ferrer');
insert into PERSON (p_id, p_name)
values (396, 'Kay-Griffin');
insert into PERSON (p_id, p_name)
values (675, 'Mitchell-Ramis');
insert into PERSON (p_id, p_name)
values (187, 'Martin-Hidalgo');
insert into PERSON (p_id, p_name)
values (24, 'Diane-Isaak');
insert into PERSON (p_id, p_name)
values (175, 'Russell-Napolit');
insert into PERSON (p_id, p_name)
values (304, 'Ethan-Rourke');
insert into PERSON (p_id, p_name)
values (976, 'Madeline-Danger');
insert into PERSON (p_id, p_name)
values (487, 'Warren-Sedgwick');
insert into PERSON (p_id, p_name)
values (463, 'Jeanne-Parsons');
insert into PERSON (p_id, p_name)
values (297, 'Mekhi-Palmieri');
insert into PERSON (p_id, p_name)
values (21, 'Ellen-Arjona');
insert into PERSON (p_id, p_name)
values (546, 'Loren-Jane');
insert into PERSON (p_id, p_name)
values (417, 'Taye-Lynch');
insert into PERSON (p_id, p_name)
values (312, 'Julia-Hunter');
insert into PERSON (p_id, p_name)
values (413, 'Franz-Jovovich');
insert into PERSON (p_id, p_name)
values (493, 'Don-Johnson');
insert into PERSON (p_id, p_name)
values (480, 'Fred-Winslet');
insert into PERSON (p_id, p_name)
values (414, 'Miranda-Feuerst');
insert into PERSON (p_id, p_name)
values (19, 'Geoffrey-Shand');
insert into PERSON (p_id, p_name)
values (147, 'Lynette-Jovovic');
insert into PERSON (p_id, p_name)
values (712, 'Dar-Stanley');
insert into PERSON (p_id, p_name)
values (743, 'Ivan-Saucedo');
insert into PERSON (p_id, p_name)
values (294, 'Albert-Malone');
insert into PERSON (p_id, p_name)
values (402, 'Scott-Aykroyd');
insert into PERSON (p_id, p_name)
values (786, 'Susan-Krabbe');
insert into PERSON (p_id, p_name)
values (776, 'Ronny-Rhymes');
insert into PERSON (p_id, p_name)
values (168, 'Kathy-Azaria');
insert into PERSON (p_id, p_name)
values (616, 'Omar-Levert');
insert into PERSON (p_id, p_name)
values (464, 'Harrison-Downie');
insert into PERSON (p_id, p_name)
values (694, 'Richard-Kahn');
insert into PERSON (p_id, p_name)
values (516, 'Roscoe-Benoit');
insert into PERSON (p_id, p_name)
values (137, 'Andrea-Dushku');
insert into PERSON (p_id, p_name)
values (61, 'Tony-Downey');
insert into PERSON (p_id, p_name)
values (359, 'Crystal-Diehl');
insert into PERSON (p_id, p_name)
values (370, 'Dylan-Winter');
insert into PERSON (p_id, p_name)
values (793, 'Peter-Liu');
insert into PERSON (p_id, p_name)
values (192, 'Kenneth-Gambon');
insert into PERSON (p_id, p_name)
values (605, 'Rebecca-Withers');
insert into PERSON (p_id, p_name)
values (116, 'Parker-Romijn-S');
insert into PERSON (p_id, p_name)
values (97, 'Glen-Saucedo');
insert into PERSON (p_id, p_name)
values (169, 'Lennie-Giraldo');
insert into PERSON (p_id, p_name)
values (43, 'Taye-Basinger');
insert into PERSON (p_id, p_name)
values (98, 'Jeff-Hyde');
insert into PERSON (p_id, p_name)
values (896, 'Joey-Suchet');
insert into PERSON (p_id, p_name)
values (20, 'Sheryl-Diehl');
insert into PERSON (p_id, p_name)
values (534, 'Emily-Vaughn');
insert into PERSON (p_id, p_name)
values (490, 'Jennifer-Blackm');
insert into PERSON (p_id, p_name)
values (610, 'Vin-O''Keefe');
insert into PERSON (p_id, p_name)
values (632, 'Bob-Peebles');
insert into PERSON (p_id, p_name)
values (654, 'Garry-Neeson');
insert into PERSON (p_id, p_name)
values (681, 'Diamond-Makowic');
insert into PERSON (p_id, p_name)
values (784, 'Curtis-Quinn');
insert into PERSON (p_id, p_name)
values (27, 'Lorraine-Allen');
insert into PERSON (p_id, p_name)
values (562, 'Jesus-Unger');
insert into PERSON (p_id, p_name)
values (429, 'Sydney-McNeice');
insert into PERSON (p_id, p_name)
values (774, 'Rebeka-Yulin');
insert into PERSON (p_id, p_name)
values (409, 'Frank-Cole');
insert into PERSON (p_id, p_name)
values (707, 'Tommy-Coburn');
insert into PERSON (p_id, p_name)
values (979, 'Pat-Whitman');
insert into PERSON (p_id, p_name)
values (250, 'Boz-Barnett');
insert into PERSON (p_id, p_name)
values (852, 'Gil-Diffie');
insert into PERSON (p_id, p_name)
values (231, 'Chrissie-Glover');
insert into PERSON (p_id, p_name)
values (954, 'Robin-Joli');
insert into PERSON (p_id, p_name)
values (275, 'Gardner');
insert into PERSON (p_id, p_name)
values (625, 'Denis-Hyde');
insert into PERSON (p_id, p_name)
values (305, 'Dani-deyt');
commit;
prompt 300 records committed...
insert into PERSON (p_id, p_name)
values (215, 'Alon-Hyde');
insert into PERSON (p_id, p_name)
values (248, 'Carl-DeLuise');
insert into PERSON (p_id, p_name)
values (867, 'Alannah-Margoly');
insert into PERSON (p_id, p_name)
values (336, 'Max-Hampton');
insert into PERSON (p_id, p_name)
values (859, 'Karon-Burton');
insert into PERSON (p_id, p_name)
values (76, 'Keith-Tempest');
insert into PERSON (p_id, p_name)
values (684, 'Emm-Keeslar');
insert into PERSON (p_id, p_name)
values (693, 'Debra-Eder');
insert into PERSON (p_id, p_name)
values (609, 'Patty-Rea');
insert into PERSON (p_id, p_name)
values (544, 'Cliff-Salonga');
insert into PERSON (p_id, p_name)
values (997, 'King-Winger');
insert into PERSON (p_id, p_name)
values (923, 'Jodie-Feuerstei');
insert into PERSON (p_id, p_name)
values (806, 'Emm-Camp');
insert into PERSON (p_id, p_name)
values (602, 'Zooey-Ledger');
insert into PERSON (p_id, p_name)
values (857, 'Sissy-Buscemi');
insert into PERSON (p_id, p_name)
values (577, 'Jean-Luc-Bell');
insert into PERSON (p_id, p_name)
values (636, 'Tyrone-King');
insert into PERSON (p_id, p_name)
values (756, 'Bonnie-McBride');
insert into PERSON (p_id, p_name)
values (130, 'Tilda-Boone');
insert into PERSON (p_id, p_name)
values (484, 'Robby-Cleary');
insert into PERSON (p_id, p_name)
values (639, 'Nicky-Bush');
insert into PERSON (p_id, p_name)
values (265, 'Stellan-Wine');
insert into PERSON (p_id, p_name)
values (315, 'Angelina-Rivers');
insert into PERSON (p_id, p_name)
values (934, 'Patty-Stampley');
insert into PERSON (p_id, p_name)
values (204, 'Rupert-Bridges');
insert into PERSON (p_id, p_name)
values (126, 'Marty-Def');
insert into PERSON (p_id, p_name)
values (738, 'Carole-Robbins');
insert into PERSON (p_id, p_name)
values (604, 'Andre-Banderas');
insert into PERSON (p_id, p_name)
values (486, 'Mili-Perez');
insert into PERSON (p_id, p_name)
values (668, 'Samuel-Cook');
insert into PERSON (p_id, p_name)
values (94, 'Warren-Feuerste');
insert into PERSON (p_id, p_name)
values (286, 'Antonio-Hamilto');
insert into PERSON (p_id, p_name)
values (399, 'Kim-Zane');
insert into PERSON (p_id, p_name)
values (991, 'Elle-Jolie');
insert into PERSON (p_id, p_name)
values (537, 'Rosie-Blossoms');
insert into PERSON (p_id, p_name)
values (411, 'Sigourney-Holbr');
insert into PERSON (p_id, p_name)
values (878, 'Stevie-Iglesias');
insert into PERSON (p_id, p_name)
values (736, 'Rod-Weber');
insert into PERSON (p_id, p_name)
values (176, 'Tilda-Piven');
insert into PERSON (p_id, p_name)
values (938, 'Bette-Paul');
insert into PERSON (p_id, p_name)
values (663, 'Patricia-Weston');
insert into PERSON (p_id, p_name)
values (303, 'Kenny-Shue');
insert into PERSON (p_id, p_name)
values (509, 'Katie-Katt');
insert into PERSON (p_id, p_name)
values (764, 'Jeroen-Coward');
insert into PERSON (p_id, p_name)
values (475, 'Ike-Craig');
insert into PERSON (p_id, p_name)
values (864, 'Clarence-Leoni');
insert into PERSON (p_id, p_name)
values (944, 'Gaby-Mellencamp');
insert into PERSON (p_id, p_name)
values (591, 'Marie-Garfunkel');
insert into PERSON (p_id, p_name)
values (141, 'Carl-Emmett');
insert into PERSON (p_id, p_name)
values (6, 'Clay-Hector');
insert into PERSON (p_id, p_name)
values (788, 'Daryle-Hutton');
insert into PERSON (p_id, p_name)
values (827, 'Nick-Hirsch');
insert into PERSON (p_id, p_name)
values (199, 'Sarah-Bogguss');
insert into PERSON (p_id, p_name)
values (742, 'Randall-Cazale');
insert into PERSON (p_id, p_name)
values (990, 'Miki-Carrey');
insert into PERSON (p_id, p_name)
values (276, 'Randy-Webb');
insert into PERSON (p_id, p_name)
values (892, 'Darius-Lawrence');
insert into PERSON (p_id, p_name)
values (274, 'Vonda-Owen');
insert into PERSON (p_id, p_name)
values (368, 'Mitchell-Shocke');
insert into PERSON (p_id, p_name)
values (497, 'Franz-Rain');
insert into PERSON (p_id, p_name)
values (587, 'Dustin-Van Damm');
insert into PERSON (p_id, p_name)
values (334, 'Chi-Levin');
insert into PERSON (p_id, p_name)
values (214, 'Christmas-Li');
insert into PERSON (p_id, p_name)
values (982, 'Maggie-Dillon');
insert into PERSON (p_id, p_name)
values (115, 'Nanci-Tinsley');
insert into PERSON (p_id, p_name)
values (772, 'Ani-Greenwood');
insert into PERSON (p_id, p_name)
values (963, 'Carol-Elizondo');
insert into PERSON (p_id, p_name)
values (77, 'Colm-McGregor');
insert into PERSON (p_id, p_name)
values (456, 'Adrien-Jay');
insert into PERSON (p_id, p_name)
values (342, 'Donal-Baldwin');
insert into PERSON (p_id, p_name)
values (550, 'Jim-Pastore');
insert into PERSON (p_id, p_name)
values (427, 'Ewan-Astin');
insert into PERSON (p_id, p_name)
values (931, 'Suzy-Feliciano');
insert into PERSON (p_id, p_name)
values (143, 'Alex-Sanders');
insert into PERSON (p_id, p_name)
values (485, 'Bebe-Collins');
insert into PERSON (p_id, p_name)
values (433, 'Swoosie-Harper');
insert into PERSON (p_id, p_name)
values (85, 'Swoosie-Plimpto');
insert into PERSON (p_id, p_name)
values (538, 'Courtney-Spacek');
insert into PERSON (p_id, p_name)
values (592, 'Hal-Dolenz');
insert into PERSON (p_id, p_name)
values (777, 'Martha-Penders');
insert into PERSON (p_id, p_name)
values (88, 'Terence-Neuwirt');
insert into PERSON (p_id, p_name)
values (880, 'Melanie-Burstyn');
insert into PERSON (p_id, p_name)
values (197, 'Victor-Bachman');
insert into PERSON (p_id, p_name)
values (233, 'Emma-Wariner');
insert into PERSON (p_id, p_name)
values (219, 'Mekhi-Burns');
insert into PERSON (p_id, p_name)
values (589, 'Harry-Church');
insert into PERSON (p_id, p_name)
values (222, 'Rachid-Anderson');
insert into PERSON (p_id, p_name)
values (449, 'Famke-Begley');
insert into PERSON (p_id, p_name)
values (771, 'Vin-Thorton');
insert into PERSON (p_id, p_name)
values (671, 'Collective-Kier');
insert into PERSON (p_id, p_name)
values (863, 'Denny-Weston');
insert into PERSON (p_id, p_name)
values (543, 'Bobby-Sanders');
insert into PERSON (p_id, p_name)
values (319, 'Spencer-Clinton');
insert into PERSON (p_id, p_name)
values (790, 'Garry-Imperioli');
insert into PERSON (p_id, p_name)
values (198, 'Rhona-Barnett');
insert into PERSON (p_id, p_name)
values (995, 'Lynn-Koyana');
insert into PERSON (p_id, p_name)
values (166, 'Boz-Paymer');
insert into PERSON (p_id, p_name)
values (5, 'Solomon-McLachl');
insert into PERSON (p_id, p_name)
values (32, 'Tamala-Weisz');
insert into PERSON (p_id, p_name)
values (902, 'Phil-Makowicz');
commit;
prompt 400 records committed...
insert into PERSON (p_id, p_name)
values (751, 'Richie-Neill');
insert into PERSON (p_id, p_name)
values (306, 'Derek-Norton');
insert into PERSON (p_id, p_name)
values (908, 'Tobey-Gibbons');
insert into PERSON (p_id, p_name)
values (766, 'Sandra-Kurtz');
insert into PERSON (p_id, p_name)
values (737, 'Brittany-Hawtho');
insert into PERSON (p_id, p_name)
values (343, 'Gilbert-Levine');
insert into PERSON (p_id, p_name)
values (851, 'Spike-Bruce');
insert into PERSON (p_id, p_name)
values (285, 'Geena-Mirren');
insert into PERSON (p_id, p_name)
values (966, 'Jarvis-Vannelli');
insert into PERSON (p_id, p_name)
values (519, 'Julia-Chambers');
insert into PERSON (p_id, p_name)
values (637, 'Leo-Mac');
insert into PERSON (p_id, p_name)
values (791, 'Nicole-Burmeste');
insert into PERSON (p_id, p_name)
values (452, 'Tamala-Travers');
insert into PERSON (p_id, p_name)
values (162, 'Randy-O''Hara');
insert into PERSON (p_id, p_name)
values (259, 'Brenda-Blanchet');
insert into PERSON (p_id, p_name)
values (69, 'Woody-Bugnon');
insert into PERSON (p_id, p_name)
values (673, 'Scarlett-Dysart');
insert into PERSON (p_id, p_name)
values (140, 'Trey-Conroy');
insert into PERSON (p_id, p_name)
values (682, 'Miles-Watley');
insert into PERSON (p_id, p_name)
values (171, 'Sophie-Dickinso');
insert into PERSON (p_id, p_name)
values (812, 'Gord-Stuermer');
insert into PERSON (p_id, p_name)
values (155, 'Brendan-Gershon');
insert into PERSON (p_id, p_name)
values (956, 'Carrie-Anne-Tip');
insert into PERSON (p_id, p_name)
values (652, 'Katrin-Moffat');
insert into PERSON (p_id, p_name)
values (947, 'Miranda-Holbroo');
insert into PERSON (p_id, p_name)
values (421, 'Phil-Blanchett');
insert into PERSON (p_id, p_name)
values (720, 'Debra-Soda');
insert into PERSON (p_id, p_name)
values (439, 'Holly-Goodman');
insert into PERSON (p_id, p_name)
values (828, 'Burton-Gallant');
insert into PERSON (p_id, p_name)
values (744, 'Frederic-Mannin');
insert into PERSON (p_id, p_name)
values (26, 'Lisa-Chappelle');
insert into PERSON (p_id, p_name)
values (925, 'Guy-Perrineau');
insert into PERSON (p_id, p_name)
values (428, 'Lois-Orbit');
insert into PERSON (p_id, p_name)
values (860, 'Stockard-Mitra');
insert into PERSON (p_id, p_name)
values (9, 'Jason-Nunn');
insert into PERSON (p_id, p_name)
values (607, 'Pat-Dutton');
insert into PERSON (p_id, p_name)
values (601, 'Maura-Wahlberg');
insert into PERSON (p_id, p_name)
values (644, 'Sara-Peet');
insert into PERSON (p_id, p_name)
values (927, 'Nile-Harry');
insert into PERSON (p_id, p_name)
values (481, 'Brad-Butler');
insert into PERSON (p_id, p_name)
values (465, 'Rebeka-Chapman');
insert into PERSON (p_id, p_name)
values (415, 'Hilton-Moss');
insert into PERSON (p_id, p_name)
values (182, 'Claire-Ronstadt');
insert into PERSON (p_id, p_name)
values (474, 'Larry-Rourke');
insert into PERSON (p_id, p_name)
values (594, 'Joshua-Matthau');
insert into PERSON (p_id, p_name)
values (246, 'Mika-Kurtz');
insert into PERSON (p_id, p_name)
values (29, 'Natasha-Crudup');
insert into PERSON (p_id, p_name)
values (376, 'Giancarlo-Grigg');
insert into PERSON (p_id, p_name)
values (814, 'Anita-Kershaw');
insert into PERSON (p_id, p_name)
values (919, 'Buddy-Thurman');
insert into PERSON (p_id, p_name)
values (628, 'Kiefer');
insert into PERSON (p_id, p_name)
values (847, 'Merle');
insert into PERSON (p_id, p_name)
values (202, 'Cuba');
insert into PERSON (p_id, p_name)
values (933, 'Melba');
insert into PERSON (p_id, p_name)
values (753, 'Teri');
insert into PERSON (p_id, p_name)
values (971, 'Brittany');
insert into PERSON (p_id, p_name)
values (645, 'Manu');
insert into PERSON (p_id, p_name)
values (638, 'Mia');
insert into PERSON (p_id, p_name)
values (801, 'Rebeka');
insert into PERSON (p_id, p_name)
values (307, 'Olga');
insert into PERSON (p_id, p_name)
values (845, 'Sammy');
insert into PERSON (p_id, p_name)
values (782, 'Gloria');
insert into PERSON (p_id, p_name)
values (472, 'Louise');
insert into PERSON (p_id, p_name)
values (787, 'Kay');
insert into PERSON (p_id, p_name)
values (135, ' Noga-Shir');
insert into PERSON (p_id, p_name)
values (75, 'Noga-Shir');
insert into PERSON (p_id, p_name)
values (15, ' Noa-Sir');
insert into PERSON (p_id, p_name)
values (125, ' Amir-Lev');
insert into PERSON (p_id, p_name)
values (725, 'Noga-Shir');
insert into PERSON (p_id, p_name)
values (123, ' Avi-choen');
insert into PERSON (p_id, p_name)
values (258, ' Saar-Roi');
insert into PERSON (p_id, p_name)
values (711, ' Sara-Rot');
insert into PERSON (p_id, p_name)
values (856, ' Noa-Gor');
insert into PERSON (p_id, p_name)
values (748, ' Haim-Tov');
insert into PERSON (p_id, p_name)
values (145, ' Noga-Shir');
insert into PERSON (p_id, p_name)
values (165, ' Noga-Shir');
insert into PERSON (p_id, p_name)
values (273, 'MichaelAli');
insert into PERSON (p_id, p_name)
values (977, 'PatriciaHobson');
insert into PERSON (p_id, p_name)
values (454, 'KimMantegna');
insert into PERSON (p_id, p_name)
values (269, 'Jean-ClaudeAssa');
insert into PERSON (p_id, p_name)
values (277, 'BobbyBurns');
insert into PERSON (p_id, p_name)
values (960, 'SheenaBright');
insert into PERSON (p_id, p_name)
values (479, 'TalChao');
insert into PERSON (p_id, p_name)
values (252, 'RhonaAglukark');
insert into PERSON (p_id, p_name)
values (975, 'SaffronTempest');
insert into PERSON (p_id, p_name)
values (218, 'ChantיDavid');
insert into PERSON (p_id, p_name)
values (680, 'DelroyBorden');
insert into PERSON (p_id, p_name)
values (586, 'JulieFlemyng');
insert into PERSON (p_id, p_name)
values (358, 'JuanBell');
insert into PERSON (p_id, p_name)
values (887, 'JoaquimSizemore');
insert into PERSON (p_id, p_name)
values (468, 'TeaFinn');
insert into PERSON (p_id, p_name)
values (939, 'JaniceGore');
insert into PERSON (p_id, p_name)
values (881, 'TiaNapolitano');
insert into PERSON (p_id, p_name)
values (500, 'SonnyHutch');
insert into PERSON (p_id, p_name)
values (588, 'Carrie-AnneChea');
insert into PERSON (p_id, p_name)
values (385, 'LoisSteenburgen');
insert into PERSON (p_id, p_name)
values (741, 'NickLizzy');
insert into PERSON (p_id, p_name)
values (338, 'ReeseHornsby');
insert into PERSON (p_id, p_name)
values (911, 'ClaireGayle');
insert into PERSON (p_id, p_name)
values (545, 'JoseDavis');
commit;
prompt 500 records committed...
insert into PERSON (p_id, p_name)
values (599, 'MartinMcDonnell');
insert into PERSON (p_id, p_name)
values (422, 'NeilHolland');
insert into PERSON (p_id, p_name)
values (831, 'GrantFlemyng');
insert into PERSON (p_id, p_name)
values (209, 'KarenDreyfuss');
insert into PERSON (p_id, p_name)
values (558, 'AliciaMann');
insert into PERSON (p_id, p_name)
values (503, 'TommyDoucette');
insert into PERSON (p_id, p_name)
values (386, 'TreyLangella');
insert into PERSON (p_id, p_name)
values (980, 'RoyWeisz');
insert into PERSON (p_id, p_name)
values (715, 'MarleyUnger');
insert into PERSON (p_id, p_name)
values (362, 'StephanieThewli');
insert into PERSON (p_id, p_name)
values (676, 'BobbiPierce');
insert into PERSON (p_id, p_name)
values (249, 'MollyGunton');
commit;
prompt 512 records loaded
prompt Loading AUTHORS...
insert into AUTHORS (authorid)
values (18);
insert into AUTHORS (authorid)
values (202);
insert into AUTHORS (authorid)
values (204);
insert into AUTHORS (authorid)
values (211);
insert into AUTHORS (authorid)
values (307);
insert into AUTHORS (authorid)
values (365);
insert into AUTHORS (authorid)
values (379);
insert into AUTHORS (authorid)
values (459);
insert into AUTHORS (authorid)
values (472);
insert into AUTHORS (authorid)
values (485);
insert into AUTHORS (authorid)
values (538);
insert into AUTHORS (authorid)
values (595);
insert into AUTHORS (authorid)
values (628);
insert into AUTHORS (authorid)
values (638);
insert into AUTHORS (authorid)
values (645);
insert into AUTHORS (authorid)
values (694);
insert into AUTHORS (authorid)
values (753);
insert into AUTHORS (authorid)
values (773);
insert into AUTHORS (authorid)
values (782);
insert into AUTHORS (authorid)
values (785);
insert into AUTHORS (authorid)
values (787);
insert into AUTHORS (authorid)
values (801);
insert into AUTHORS (authorid)
values (845);
insert into AUTHORS (authorid)
values (847);
insert into AUTHORS (authorid)
values (902);
insert into AUTHORS (authorid)
values (933);
insert into AUTHORS (authorid)
values (971);
commit;
prompt 27 records loaded
prompt Loading CUSTOMERS...
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('611 Randall', to_date('18-04-2012', 'dd-mm-yyyy'), '4030386422', null, 909);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('59 Rancho Palos', to_date('10-05-1976', 'dd-mm-yyyy'), '3216529391', null, 765);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('440 Plymouth Me', to_date('04-07-1991', 'dd-mm-yyyy'), '2846129561', null, 366);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('33rd Street', to_date('06-08-2016', 'dd-mm-yyyy'), '2161511996', null, 746);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('82nd Street', to_date('01-03-1988', 'dd-mm-yyyy'), '2316027352', null, 935);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('74 Leon Ave', to_date('25-08-1990', 'dd-mm-yyyy'), '3604249628', null, 256);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('78 Hanley Blvd', to_date('17-07-1984', 'dd-mm-yyyy'), '2211909071', null, 891);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('293 Warley Stre', to_date('02-03-1985', 'dd-mm-yyyy'), '1289801838', null, 470);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('86 Wiest Road', to_date('20-06-2013', 'dd-mm-yyyy'), '3337933132', null, 596);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('79 Martinez Dri', to_date('31-08-1975', 'dd-mm-yyyy'), '2412671461', null, 525);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('51st Street', to_date('20-01-2016', 'dd-mm-yyyy'), '3623492062', null, 436);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('1 Vin Street', to_date('27-09-2008', 'dd-mm-yyyy'), '883316934', null, 518);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('83 Cooper Ave', to_date('02-12-1998', 'dd-mm-yyyy'), '1257851169', null, 932);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('87 Nepean Road', to_date('28-11-1987', 'dd-mm-yyyy'), '3512592343', null, 254);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('81 Dortmund Roa', to_date('18-05-2010', 'dd-mm-yyyy'), '1482609749', null, 969);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('26 Hannover Roa', to_date('02-12-2000', 'dd-mm-yyyy'), '4163267399', null, 523);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('66 Wilkinson Dr', to_date('08-06-1972', 'dd-mm-yyyy'), '2637584488', null, 535);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('13rd Street', to_date('16-07-1978', 'dd-mm-yyyy'), '2217913753', null, 985);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('53rd Street', to_date('30-05-1980', 'dd-mm-yyyy'), '855458612', null, 913);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('38 Corey Road', to_date('13-02-1983', 'dd-mm-yyyy'), '2435792554', null, 434);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('24 Raybon Road', to_date('11-04-2002', 'dd-mm-yyyy'), '2223793589', null, 426);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('525 Vai Street', to_date('28-06-1989', 'dd-mm-yyyy'), '3540049932', null, 512);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('66 Carrack Road', to_date('11-08-1977', 'dd-mm-yyyy'), '3548291245', null, 621);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('16 Janeane Driv', to_date('18-08-1972', 'dd-mm-yyyy'), '2630033583', null, 382);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('812 Byrd Street', to_date('15-03-1995', 'dd-mm-yyyy'), '1989015112', null, 595);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('80 Freddie Stre', to_date('21-09-1988', 'dd-mm-yyyy'), '2739317494', null, 760);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('98 Garland Stre', to_date('08-12-1982', 'dd-mm-yyyy'), '3181768911', null, 226);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('97 Whitley Stre', to_date('06-12-2007', 'dd-mm-yyyy'), '572588605', null, 540);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('59 Kylie Drive', to_date('22-11-2000', 'dd-mm-yyyy'), '3407535473', null, 466);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('31 Heatherly Ro', to_date('12-03-2008', 'dd-mm-yyyy'), '1854187026', null, 899);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('816 Tooele Stre', to_date('24-11-1994', 'dd-mm-yyyy'), '899641101', null, 730);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('46 Graham Stree', to_date('02-01-1982', 'dd-mm-yyyy'), '1952741769', null, 536);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('36 Wong', to_date('10-08-1994', 'dd-mm-yyyy'), '777461587', null, 235);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('32 Liu Ave', to_date('19-03-1988', 'dd-mm-yyyy'), '873095289', null, 569);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('62nd Street', to_date('29-05-1995', 'dd-mm-yyyy'), '3875784291', null, 679);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('63 Jimmy Street', to_date('18-11-1999', 'dd-mm-yyyy'), '2970090983', null, 745);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('43 California S', to_date('13-09-2004', 'dd-mm-yyyy'), '1550256603', null, 819);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('93rd Street', to_date('08-10-2006', 'dd-mm-yyyy'), '2469193301', null, 940);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('54 Coughlan Str', to_date('08-06-1986', 'dd-mm-yyyy'), '2857895116', null, 504);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('100 Carlin Road', to_date('10-10-2004', 'dd-mm-yyyy'), '4135585708', null, 903);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('74 Krabbe Drive', to_date('15-09-1997', 'dd-mm-yyyy'), '2858109902', null, 642);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('6 Remy', to_date('20-08-1971', 'dd-mm-yyyy'), '3729235609', null, 762);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('83 Stuart Ave', to_date('27-09-1996', 'dd-mm-yyyy'), '1781402236', null, 978);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('53 Herzogenrath', to_date('20-09-1989', 'dd-mm-yyyy'), '3063653890', null, 489);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('79 Mira Road', to_date('29-10-1972', 'dd-mm-yyyy'), '2337735872', null, 335);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('53 Makeba Road', to_date('19-05-2003', 'dd-mm-yyyy'), '1332574820', null, 740);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('442 Brendan Str', to_date('07-05-1973', 'dd-mm-yyyy'), '3206005590', null, 747);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('10 Rispoli', to_date('18-05-1974', 'dd-mm-yyyy'), '932039115', null, 461);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('70 Powell River', to_date('19-07-1978', 'dd-mm-yyyy'), '1509648338', null, 459);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('744 Bonneville ', to_date('27-02-2004', 'dd-mm-yyyy'), '3798555392', null, 836);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('30 Fort McMurra', to_date('10-03-1989', 'dd-mm-yyyy'), '2635357485', null, 699);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('22 Belles Road', to_date('19-07-2013', 'dd-mm-yyyy'), '1260542523', null, 357);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('959 Wiedlin Dri', to_date('30-07-1987', 'dd-mm-yyyy'), '3404591630', null, 597);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('82nd Street', to_date('08-09-1983', 'dd-mm-yyyy'), '1191621082', null, 656);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('14 Dustin Road', to_date('03-11-2018', 'dd-mm-yyyy'), '3656776672', null, 800);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('81 Parsippany R', to_date('17-02-1991', 'dd-mm-yyyy'), '2711321889', null, 739);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('22 Arthur Drive', to_date('19-05-2019', 'dd-mm-yyyy'), '21025327', null, 210);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('645 Aniston Roa', to_date('15-07-1981', 'dd-mm-yyyy'), '1782596247', null, 371);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('260 Leslie Stre', to_date('03-08-1972', 'dd-mm-yyyy'), '1639982604', null, 649);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('11 Spike Road', to_date('12-02-2008', 'dd-mm-yyyy'), '1040455812', null, 239);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('44 DiBiasio Str', to_date('31-05-2012', 'dd-mm-yyyy'), '3959391699', null, 361);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('96 Leguizamo Ro', to_date('09-09-1978', 'dd-mm-yyyy'), '1435019934', null, 554);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('60 Caine Street', to_date('08-04-1999', 'dd-mm-yyyy'), '2498875587', null, 950);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('88 Pfeiffer Str', to_date('21-03-2015', 'dd-mm-yyyy'), '2802556357', null, 942);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('92nd Street', to_date('25-03-2007', 'dd-mm-yyyy'), '3357338897', null, 200);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('71 Remy Ave', to_date('25-01-1990', 'dd-mm-yyyy'), '594420582', null, 688);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('304 Josh Road', to_date('27-02-1970', 'dd-mm-yyyy'), '1462899602', null, 431);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('95 Immenstaad S', to_date('14-05-1974', 'dd-mm-yyyy'), '2890602884', null, 700);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('201 Ludbreg Dri', to_date('12-01-1994', 'dd-mm-yyyy'), '2004040862', null, 710);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('100 League city', to_date('15-01-2005', 'dd-mm-yyyy'), '2875463918', null, 383);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('42 Sydney Drive', to_date('22-01-2009', 'dd-mm-yyyy'), '901426801', null, 718);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('13rd Street', to_date('22-02-2013', 'dd-mm-yyyy'), '3933171372', null, 533);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('34 Alda Blvd', to_date('02-04-1987', 'dd-mm-yyyy'), '544934730', null, 807);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('22nd Street', to_date('19-12-1989', 'dd-mm-yyyy'), '1582537695', null, 377);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('92nd Street', to_date('05-02-1978', 'dd-mm-yyyy'), '2266770075', null, 590);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('81st Street', to_date('17-02-1986', 'dd-mm-yyyy'), '2867721846', null, 261);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('37 MacLachlan S', to_date('02-02-1973', 'dd-mm-yyyy'), '3178540559', null, 211);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('91st Street', to_date('10-06-1984', 'dd-mm-yyyy'), '723670881', null, 970);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('971 Ljubljana R', to_date('27-02-1985', 'dd-mm-yyyy'), '1770749760', null, 726);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('70 Doucette Blv', to_date('18-04-1979', 'dd-mm-yyyy'), '2088746194', null, 397);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('8 Hank', to_date('16-04-2012', 'dd-mm-yyyy'), '1060624766', null, 998);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('75 Philip Road', to_date('08-06-1983', 'dd-mm-yyyy'), '2275893281', null, 321);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('42nd Street', to_date('09-11-2007', 'dd-mm-yyyy'), '2421783440', null, 450);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('123 Main St', to_date('01-01-1980', 'dd-mm-yyyy'), '12345', null, 1);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566210363', 'Adrien@com', 51);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '514946733', 'freid@gulfmarko', 418);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '597372755', 'andie.wincott@i', 10);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '586266769', 'Emerson@com', 773);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '500468634', 'deand@aoltimewa', 186);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '550385608', 'm.warwick@mathi', 557);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '529501669', 'cloris.hersh@tm', 962);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '528085164', 'shelby.vaughn@p', 331);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '562943580', 'celia.busey@mse', 369);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '522068771', 'tyrone.hobson@f', 780);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '548834565', 'bos@kellogg.au', 379);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '580643797', 'carol@operation', 948);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '550315543', 'rutger.manning@', 279);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '505391683', 'lucy@pscinfogro', 64);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '596258447', 'vonda.glover@gr', 521);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '509054885', 'sara.garza@huds', 798);
commit;
prompt 100 records committed...
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '553866012', 'heath@fmt.de', 22);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '546657501', 'heath.quatro@te', 695);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '544400518', 'armand.hornsby@', 284);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566532025', 'domingo.p@offic', 206);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '584446326', 'don.witt@painte', 630);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '565329024', 'rraye@speakeasy', 156);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '544577892', 's.dale@ssci.uk', 327);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '550039075', 'rosie.close@inn', 345);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '587445070', 'vince.sinise@ca', 761);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '521088992', 'alfie@pioneerda', 355);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '576914464', 'bonnie.wopat@ne', 568);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '558889627', 'gena.b@apexsyst', 996);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '526439088', 'clea.eatworld@a', 804);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '524108554', 'l.dourif@infini', 713);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '586706651', 'edwinf@asa.com', 320);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '514637033', 'junior.s@safeho', 848);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '594643166', 'kenny@abs.com', 244);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '599007423', 'nicolas.pierce@', 567);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '520725745', 'kirsten.osmond@', 691);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '599005659', 'w.affleck@fnb.v', 340);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '565980161', 'colm.tarantino@', 18);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '591668988', 'suzi.crystal@my', 134);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '531776631', 'wally.hopper@tr', 122);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '559712729', 'delroy.edmunds@', 363);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '528479483', 'curtis.v@pulask', 816);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '503286120', 'mandy.martinez@', 272);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '541788737', 'yaphet.reno@kni', 999);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '516396403', 'brad@tripwire.b', 295);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '529634949', 'famkee@solipsys', 268);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '551473364', 'rpullman@health', 455);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '564622237', 'Meredith@com', 66);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '553670508', 'dwight.bell@tot', 296);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '556262443', 'milip@jsa.uk', 810);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566061715', 'janice.chaplin@', 83);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575591942', 'etta@sis.mx', 118);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '526855509', 'renee.goldwyn@l', 224);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '535359080', 'milla.buscemi@a', 257);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '517952566', 'dbuscemi@biorel', 910);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '581094251', 'liev@totalenter', 953);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '506686585', 'rutger.peebles@', 728);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '585463567', 'jonnylee@bis.it', 390);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '539728016', 'thelma.b@als.de', 333);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '526407893', 'lloyd.colton@gc', 817);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '564801986', 'vickie.hanley@b', 709);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '592870380', 'Christine@com', 794);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '501373889', 'dfeore@kingston', 785);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '510841420', 'dorry.balaban@t', 404);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '563736759', 'gerald@ogi.no', 62);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '546147498', 'nataschaa@credi', 832);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '574372259', 'reastwood@egrou', 702);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '561552677', 'Jennifer@com', 52);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '529130533', 'Michelle@com', 384);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '583269588', 'bette.ronstadt@', 356);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '534721499', 'andre.levert@di', 478);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '505193965', 'busta@carbocera', 732);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '537525752', 'laurence.apple@', 524);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '525315563', 'bobby.chaplin@h', 876);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '528325603', 'cbenet@peerless', 844);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '574751121', 'terry.dorn@cold', 758);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '588251574', 'jarvis.jones@ul', 110);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '554907041', 'steve.gough@sec', 332);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '504427858', 'aimees@integram', 964);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '521931936', 'eremar@swp.com', 904);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566342094', 'henrys@whitewav', 879);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '512189610', 'terence.dutton@', 650);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '518323259', 'b.blair@priorit', 59);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '537944782', 'pragah@flavorx.', 398);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '506041835', 'buddy.b@procter', 89);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '588946848', 'maria@serentec.', 232);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '582661700', 'h.sinise@unicru', 491);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575534556', 'genglish@ungert', 522);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '505744076', 'danni@mss.uk', 937);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '553176725', 'timothy.dorff@h', 547);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '568974621', 'arnold.posener@', 56);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '511166054', 'machine.w@healt', 142);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '585420027', 'brent.phillips@', 888);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '599736821', 'j.affleck@verit', 442);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '518672727', 'jann.robards@ca', 955);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '570396035', 'jsteenburgen@sp', 606);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '590949453', 'jeannet@waltdis', 183);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '545811766', 'agandolfini@esc', 109);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '538541753', 'roddy.quinlan@v', 318);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '542496204', 'derek.knight@fa', 965);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '519361698', 'vball@pis.dk', 287);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575750733', 'patrick.gugino@', 170);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '504402670', 'Jackson@com', 290);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '519226943', 'teena.witt@cona', 611);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '528613202', 'tommy.avital@at', 918);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '589010274', 'rirons@parksite', 833);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '580573256', 'gary.osment@vir', 492);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '572639062', 'kathy.potter@ti', 849);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '580642261', 'anna.morton@cyb', 325);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '555088472', 'sonny@hotmail.c', 646);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '551033055', 'seth.c@fam.in', 555);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '526679205', 'vbell@amerisour', 641);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '511932712', 'dorry.lennix@ke', 520);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566894948', 'trey.ripley@nes', 526);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '528654221', 'andre.crewson@h', 281);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '552705988', 'owen.lunch@trop', 288);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '532685254', 'ltwilley@hfg.co', 93);
commit;
prompt 200 records committed...
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '587133092', 'ahmad.boothe@lo', 63);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '511236287', 'ethan.m@aoe.it', 781);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '557891669', 'mika.bryson@cim', 924);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '557571813', 'Christina@com', 506);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '515319424', 'nicolas.ripley@', 968);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '598627790', 'chet.mollard@mw', 223);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '580136821', 'd.lupone@atlant', 90);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '542735122', 'Melanie-von@com', 326);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '521920035', 'krippy@mwp.jp', 247);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '579503319', 'Sigourney@com', 553);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575309736', 'john.steiger@nh', 821);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '560757816', 'denzel.quinlan@', 759);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '540389163', 'alice.s@quicksi', 41);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '551079152', 'colleen.g@fpf.b', 446);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '543453051', 'juliet@american', 527);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '563931946', 'hazel.marsden@p', 897);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '590076900', 'courtney.sisto@', 38);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '543054287', 'curtisd@bps.ch', 453);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '591973292', 'alano@americanp', 769);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '586948276', 'Vertical@com', 868);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '500083436', 'derrick.gayle@m', 507);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '558092335', 'jann@educationa', 365);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '525721811', 'mindy.r@north.d', 826);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '550206406', 'janice.brosnan@', 865);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '565765189', 'colleen.pony@ep', 580);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '509190519', 'b.faithfull@atl', 316);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '586591888', 'lionel.heche@gl', 640);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '590841242', 'art.n@nexxtwork', 151);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '510378742', 'Barbara@com', 757);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '586827280', 'hector.cook@tru', 541);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '589846930', 'Wallace@com', 870);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '579019841', 'jarvis.b@adolph', 583);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575374137', 'ed.rodriguez@pr', 317);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '529912646', 'alex.ferrer@phi', 271);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '582495131', 'kay.g@3tsystems', 396);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '564164934', 'm.ramis@gillett', 675);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '524864873', 'mhidalgo@sandys', 187);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '554992496', 'diane.isaak@avs', 24);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '510913597', 'Russell@com', 175);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '568248062', 'ethan.rourke@se', 304);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '554981582', 'madelined@mre.d', 976);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566000445', 'wsedgwick@ccb.u', 487);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '530345983', 'jeannep@nobrain', 463);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '533387065', 'm.palmieri@apex', 297);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '500779268', 'ellen.arjona@am', 21);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '546463813', 'loren.jane@john', 546);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513533271', 'taye@genextechn', 417);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '525088344', 'j.hunter@ipsadv', 312);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '570051407', 'franzj@carteret', 413);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '589696903', 'djohnson@integr', 493);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '587504139', 'f.winslet@healt', 480);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '526053332', 'Miranda@com', 414);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '592951346', 'g.shand@reckitt', 19);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '555828518', 'Lynette@com', 147);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '559979594', 'dar.stanley@ame', 712);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '561834665', 'ivan.saucedo@in', 743);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513578290', 'albert.malone@c', 294);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '507968086', 'scott.aykroyd@d', 402);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '560166562', 'susan.krabbe@ma', 786);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '519755035', 'ronny.rhymes@ca', 776);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '517231377', 'kathy.a@aristot', 168);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '520234730', 'omar.levert@ufs', 616);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '571164350', 'Harrison@com', 464);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '585328262', 'richard.kahn@ul', 694);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '528162009', 'roscoe.benoit@r', 516);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575579776', 'andrea.dushku@p', 137);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '568996169', 'tony.downey@mss', 61);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '573947631', 'c.diehl@ibm.no', 359);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '597091311', 'dylanw@alohanys', 370);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '579299704', 'peterl@clubone.', 793);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '512668294', 'kenneth@pulaski', 192);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '550463256', 'r.withers@pione', 605);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '507768206', 'p.romijnstamos@', 116);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '500627186', 'glen.saucedo@ca', 97);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '540827609', 'lennie.giraldo@', 169);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '518322002', 'taye.basinger@b', 43);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '544817376', 'jeff.hyde@ultim', 98);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '543857491', 'j.suchet@actech', 896);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '570333613', 'sheryld@operati', 20);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '573420291', 'emily.vaughn@da', 534);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '501607133', 'j.blackmore@hea', 490);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '531125311', 'vin.okeefe@cred', 610);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '561884912', 'b.peebles@world', 632);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '572511097', 'garry.neeson@hu', 654);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '524571623', 'Diamond@com', 681);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '532501482', 'c.quinn@data.ca', 784);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '586950015', 'lallen@ssci.fr', 27);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '596289575', 'jesus.unger@wlt', 562);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '541788962', 'sydney.mcneice@', 429);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '525237665', 'rebekay@tilia.c', 774);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '554435523', 'f.cole@sunstrea', 409);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '560219677', 'tommy.coburn@ne', 707);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '557234706', 'pat.w@adeasolut', 979);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '505096213', 'boz.barnett@jol', 250);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '598639821', 'gil@primussoftw', 852);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '537366482', 'Chrissie@com', 231);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '504986470', 'robin.j@maveric', 954);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '537657682', 'gdixon4@ibm.com', 275);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '590964238', 'dennis@providen', 625);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '592963238', 'dannip@roviden', 305);
commit;
prompt 300 records committed...
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '592364238', 'Al@providen', 215);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '568224961', 'cdeluise@gillet', 248);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '530745998', 'alannahm@faef.f', 867);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '573118938', 'max@quakercityb', 336);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '596416957', 'karon.burton@es', 859);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '518521181', 'ktempest@base.c', 76);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575581935', 'emm.keeslar@inn', 684);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '598544176', 'd.eder@midwestm', 693);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '574660829', 'patty@elitemedi', 609);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '532983589', 'cliff.salonga@l', 544);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '583237122', 'king.winger@pfi', 997);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513590659', 'j.feuerstein@ir', 923);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '598231948', 'emm.camp@envisi', 806);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '590117177', 'zooey.ledger@sf', 602);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '525950765', 'sissyb@iss.ch', 857);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575887170', 'jeanluc.b@at.br', 577);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '568657021', 'tyrone.king@psc', 636);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '599276488', 'bonnie.mcbride@', 756);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575797562', 'tilda.b@digital', 130);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '544919705', 'robbyc@epamsyst', 484);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '593206710', 'nicky.bush@uem.', 639);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '501389613', 'stellan.wine@tr', 265);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '571120124', 'arivers@spectru', 315);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '504200239', 'patty.stampley@', 934);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '516762097', 'rupert.bridges@', 204);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '545703503', 'mdef@officedepo', 126);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '584003900', 'caroler@kimberl', 738);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '557865835', 'andre@grt.com', 604);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '562752887', 'mili.perez@lms.', 486);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '502804837', 'samuel.cook@hil', 668);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513333123', 'warren@dataware', 94);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '538341526', 'a.hamilton@nexx', 286);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '527754587', 'kim.zane@credit', 399);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '532580984', 'elle.jolie@wend', 991);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '579452990', 'rosie.blossoms@', 537);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '541656412', 'Sigourney@com', 411);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '508920245', 'Stevie@com', 878);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '593279482', 'rod.weber@ubp.c', 736);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '527181141', 'tpiven@seafoxbo', 176);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513434710', 'bette.paul@spea', 938);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '592761002', 'Patricia@com', 663);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '552362920', 'kenny.shue@fibe', 303);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '572397755', 'katie.k@questar', 509);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '549285795', 'jeroen.coward@i', 764);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '542069849', 'ike.craig@treke', 475);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '558004085', 'clarence.leoni@', 864);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566031613', 'Gaby@com', 944);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '556023964', 'mgarfunkel@fetc', 591);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '524105071', 'carl.emmett@sha', 141);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '531598923', 'clay.hector@top', 6);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '533040588', 'd.hutton@tigris', 788);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '559047850', 'nick.hirsch@com', 827);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '545122885', 'sarahb@dsp.com', 199);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '539872234', 'randallc@vitaco', 742);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '549009508', 'm.carrey@seafox', 990);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '509782488', 'randy.webb@jma.', 276);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '520635581', 'darius@accessus', 892);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '564559491', 'vonda.owen@info', 274);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '505945946', 'mitchells@pione', 368);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '530214812', 'franz.r@jma.com', 497);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '565812412', 'dvandamme@inter', 587);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '541352094', 'chi.l@eastmanko', 334);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '554345112', 'c.li@outsourceg', 214);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '533497023', 'maggied@daimler', 982);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '585264866', 'nanci.tinsley@m', 115);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '541600057', 'a.greenwood@air', 772);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '510703737', 'carol.elizondo@', 963);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '545214078', 'colm.mcgregor@m', 77);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '561055741', 'a.jay@elitemedi', 456);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '524897096', 'donal.baldwin@g', 342);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '502735664', 'jim.pastore@cap', 550);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '598025764', 'eastin@greene.c', 427);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '503505416', 'suzy.feliciano@', 931);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '532537189', 'alex.sanders@sm', 143);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '526250822', 'bebec@myricom.d', 485);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '576183235', 'swoosie.h@gentr', 433);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '573168263', 'swoosie@thinkta', 85);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '558810541', 'Courtney@com', 538);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '541621168', 'hal.dolenz@ass.', 592);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566289061', 'martha@capstone', 777);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '501507763', 'Terence@com', 88);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '592835602', 'mburstyn@waltdi', 880);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '597024374', 'victor.bachman@', 197);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '583062280', 'ewariner@curagr', 233);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '533839932', 'mekhi@sci.es', 219);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '599297979', 'harry.church@co', 589);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '540868137', 'Rachid@com', 222);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '568825101', 'famke.begley@he', 449);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '545110626', 'vin@walmartstor', 771);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '592753432', 'collectivek@tra', 671);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '570490104', 'd.weston@slt.es', 863);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '576834757', 'bobby.sanders@o', 543);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '525759428', 'Spencer@com', 319);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '575789633', 'garry.i@abs.com', 790);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '547587793', 'rhona@sysconmed', 198);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '526123923', 'lynn@loreal.uk', 995);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '598996799', 'bpaymer@inspira', 166);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '507585364', 'solomon@novarti', 5);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '548469346', 'tamala.weisz@al', 32);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '559925442', 'phil.makowicz@c', 902);
commit;
prompt 400 records committed...
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '587545360', 'richien@glmt.de', 751);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '528516170', 'derek@tmt.de', 306);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '536240506', 'tobey.gibbons@l', 908);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '500188734', 'sandra@marketfi', 766);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '578574662', 'brittany@sds.fr', 737);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '552897779', 'gilbert.levine@', 343);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '581337347', 'spike.bruce@tre', 851);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '578492797', 'gmirren@als.com', 285);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '564345709', 'Jarvis@com', 966);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '512476058', 'julia.chambers@', 519);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '538476123', 'leo.mac@zoneper', 637);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513111827', 'Nicole@com', 791);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '583682056', 'tamala.travers@', 452);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '501949990', 'randy.ohara@sta', 162);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '571999170', 'b.blanchett@mic', 259);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '549431910', 'woody.bugnon@ca', 69);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '553342157', 'scarlettd@ameri', 673);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '522917342', 't.conroy@maveri', 140);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '559584793', 'milesw@lynksyst', 682);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '522851312', 'sophie.d@maveri', 171);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513494449', 'gords@clorox.ca', 812);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '534177579', 'Brendan@com', 155);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '571853738', 'Carrie@com', 956);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '587605944', 'katrin.m@market', 652);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '515576410', 'Miranda@com', 947);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '580885478', 'phil.blanchett@', 421);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '566604365', 'dsoda@pragmatec', 720);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '515497474', 'holly@interface', 439);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '561812178', 'burton.gallant@', 828);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '568476860', 'Frederic@com', 744);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '513381024', 'lisa.chappelle@', 26);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '557754014', 'guy.perrineau@e', 925);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '535883856', 'lois.orbit@y2ma', 428);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '581129918', 'stockard.mitra@', 860);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '552285625', 'jasonn@emt.uk', 9);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '506322839', 'patd@mcdonalds.', 607);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '585053389', 'maura@trm.com', 601);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '552478815', 's.peet@pfizer.c', 644);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '588730599', 'nile@hfn.br', 927);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '580590579', 'bradb@at.com', 481);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '519669502', 'rebekac@yumbran', 465);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '505603021', 'h.moss@at.com', 415);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '578659238', 'Claire@com', 182);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '574281894', 'larry.rourke@fm', 474);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '548754047', 'joshuam@codykra', 594);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '538483961', 'm.kurtz@kwraf.d', 246);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '523066978', 'ncrudup@curagro', 29);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '573085263', 'Giancarlo@com', 376);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '517498812', 'anita.kershaw@p', 814);
insert into CUSTOMERS (address, dateofbirth, phone, email, customerid)
values ('56 RUZIN', to_date('01-01-2012', 'dd-mm-yyyy'), '578944739', 'buddy.thurman@f', 919);
commit;
prompt 450 records loaded
prompt Loading PAYMENT...
insert into PAYMENT (p_id, cost, payment_date)
values (820, 8264, to_date('21-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (725, 1880, to_date('27-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (188, 9949, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (225, 4368, to_date('01-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (292, 9111, to_date('29-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (245, 4417, to_date('05-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (916, 5265, to_date('11-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (532, 1013, to_date('28-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (214, 6925, to_date('15-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (628, 3814, to_date('06-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (11, 9239, to_date('30-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (111, 9395, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (695, 5633, to_date('16-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (277, 4685, to_date('05-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (381, 7689, to_date('23-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (210, 6356, to_date('17-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (420, 3369, to_date('14-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (908, 6973, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (150, 9319, to_date('10-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (762, 5036, to_date('23-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (535, 4695, to_date('15-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (690, 9277, to_date('29-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (817, 3922, to_date('09-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (543, 1418, to_date('13-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (585, 3659, to_date('16-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (810, 3600, to_date('10-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (583, 4040, to_date('21-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (486, 2637, to_date('21-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (156, 6762, to_date('27-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (832, 7707, to_date('24-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (822, 8186, to_date('23-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (658, 1529, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (808, 3621, to_date('31-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (340, 2155, to_date('09-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (827, 3590, to_date('09-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (18, 4734, to_date('02-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (774, 7605, to_date('13-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (605, 6932, to_date('02-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (673, 1994, to_date('21-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (900, 6850, to_date('22-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (726, 8746, to_date('05-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (584, 9532, to_date('27-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (706, 5650, to_date('06-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (208, 2473, to_date('22-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (507, 4459, to_date('16-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (907, 7649, to_date('30-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (815, 3805, to_date('03-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (512, 9933, to_date('01-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (20, 9276, to_date('21-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (459, 8952, to_date('27-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (941, 1081, to_date('11-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (402, 2048, to_date('04-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (724, 1342, to_date('05-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (965, 9814, to_date('09-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (773, 8532, to_date('12-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (113, 5212.717762, to_date('29-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (713, 9908, to_date('17-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (86, 2999, to_date('01-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (41, 9009, to_date('14-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (331, 5634, to_date('17-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (843, 9433, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (390, 6563, to_date('07-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (423, 7772, to_date('08-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (902, 1826, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (275, 2845, to_date('24-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (753, 3431, to_date('17-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (527, 2876, to_date('24-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (181, 4976.623341222, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (873, 3301, to_date('06-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (518, 7140, to_date('22-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (764, 2241, to_date('28-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (633, 3864, to_date('13-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (847, 8744, to_date('06-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (464, 5843, to_date('02-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (937, 7097, to_date('11-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (948, 4890, to_date('03-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (36, 2661, to_date('16-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (235, 2365, to_date('06-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (744, 1504, to_date('07-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (992, 7957, to_date('09-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (648, 4475, to_date('06-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (162, 9960, to_date('20-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (683, 8870.74342, to_date('30-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (219, 8142, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (759, 1704, to_date('30-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (398, 7923, to_date('04-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (588, 4732, to_date('01-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (458, 8547, to_date('21-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (709, 6810, to_date('29-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (445, 1758, to_date('04-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (880, 2436.3122, to_date('08-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (711, 7290, to_date('04-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (92, 5442, to_date('02-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (40, 9734, to_date('24-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (346, 8841, to_date('24-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (479, 8267, to_date('07-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (781, 5508, to_date('19-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (48, 4651, to_date('24-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (526, 9640, to_date('26-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (385, 9147, to_date('08-06-2023', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into PAYMENT (p_id, cost, payment_date)
values (255, 3924, to_date('23-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (42, 5511, to_date('26-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (99, 3293, to_date('09-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (312, 4142, to_date('12-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (189, 8277, to_date('22-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (444, 5196, to_date('14-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (850, 7574, to_date('25-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (376, 4645, to_date('11-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (397, 4980, to_date('06-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (19, 4249, to_date('14-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (496, 4640, to_date('22-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (654, 8114, to_date('31-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (296, 5546, to_date('25-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (327, 9761, to_date('27-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (625, 8631, to_date('18-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (475, 3663, to_date('16-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (901, 8155, to_date('27-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (192, 5703.02, to_date('18-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (983, 9982, to_date('25-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (857, 7952, to_date('08-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (87, 2797, to_date('02-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (285, 2402, to_date('07-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (928, 7001, to_date('25-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (649, 5228, to_date('31-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (211, 1578, to_date('05-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (168, 2131, to_date('08-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (581, 6100, to_date('31-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (473, 7943, to_date('24-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (570, 1246, to_date('08-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (153, 9288, to_date('04-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (805, 1651, to_date('18-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (595, 5493, to_date('07-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (684, 7865, to_date('16-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (891, 5131, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (404, 5451.5895382, to_date('12-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (627, 5058, to_date('07-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (431, 7955.74849202, to_date('24-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (84, 8471, to_date('02-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (395, 5798, to_date('28-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (949, 8516, to_date('27-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (410, 6170, to_date('07-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (257, 5494, to_date('12-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (499, 2478, to_date('02-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (972, 8574, to_date('12-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (804, 7939, to_date('28-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (717, 3344, to_date('09-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (547, 4497, to_date('19-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (794, 6579, to_date('28-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (471, 4047, to_date('27-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (692, 3209, to_date('09-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (170, 8806, to_date('17-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (341, 2724, to_date('01-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (954, 6144, to_date('04-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (422, 6839, to_date('14-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (602, 3662, to_date('19-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (316, 7918, to_date('16-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (314, 9197, to_date('17-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (250, 6886, to_date('05-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (428, 7343, to_date('20-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (388, 5199, to_date('29-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (837, 1453, to_date('24-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (924, 7305, to_date('19-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (313, 6855.499667166482, to_date('25-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (525, 3365, to_date('28-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (248, 7077, to_date('01-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (963, 6064, to_date('14-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (158, 5460, to_date('19-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (994, 8059, to_date('15-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (513, 3555, to_date('04-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (25, 2253, to_date('30-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (615, 1589, to_date('03-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (27, 3511, to_date('13-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (800, 5637, to_date('24-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (414, 9072, to_date('02-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (421, 7409, to_date('21-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (425, 9071, to_date('09-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (703, 5155, to_date('08-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (502, 5338, to_date('12-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (925, 2241, to_date('08-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (674, 2524, to_date('09-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (780, 2078, to_date('09-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (913, 9677, to_date('07-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (596, 6926, to_date('04-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (614, 9644, to_date('06-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (412, 5196, to_date('09-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (621, 9957, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (254, 6988, to_date('04-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (62, 9134, to_date('05-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (626, 6317, to_date('12-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (904, 4295.6856753442, to_date('07-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (730, 8780, to_date('09-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (359, 9861, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (306, 5362, to_date('22-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (318, 8782, to_date('10-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (749, 4159, to_date('31-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (575, 7355, to_date('17-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (571, 6117, to_date('07-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (943, 9308, to_date('24-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (280, 8135, to_date('05-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (95, 3813, to_date('27-05-2023', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into PAYMENT (p_id, cost, payment_date)
values (650, 8116, to_date('19-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (191, 6634, to_date('05-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (791, 1065, to_date('22-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (971, 5933, to_date('06-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (416, 7432, to_date('19-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (392, 1973, to_date('01-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (509, 8041, to_date('04-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (987, 6253, to_date('19-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (903, 7871, to_date('07-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (52, 1794, to_date('08-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (651, 1118, to_date('04-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (10, 9858, to_date('20-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (569, 9404, to_date('16-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (394, 4147, to_date('14-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (932, 9884, to_date('05-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (629, 6446, to_date('26-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (147, 2063, to_date('13-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (640, 8644.45424287862, to_date('07-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (947, 4569, to_date('23-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (165, 7863, to_date('30-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (722, 6034, to_date('20-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (521, 8883, to_date('30-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (133, 6353, to_date('30-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (723, 3156, to_date('11-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (555, 1556, to_date('12-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (154, 1298, to_date('21-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (169, 3610, to_date('19-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (618, 2458, to_date('24-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (276, 1048, to_date('09-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (206, 3777, to_date('07-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (677, 4224, to_date('01-04-2024', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (112, 3021, to_date('23-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (554, 1116, to_date('23-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (953, 9385.102, to_date('02-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (405, 4933, to_date('21-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (623, 7749, to_date('01-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (889, 9190, to_date('15-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (39, 2794, to_date('03-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (120, 5199, to_date('03-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (909, 4363, to_date('06-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (962, 7589, to_date('22-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (387, 1150, to_date('29-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (461, 2598, to_date('12-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (337, 1351, to_date('04-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (923, 8321, to_date('11-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (85, 5513, to_date('18-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (986, 2410, to_date('16-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (691, 9560, to_date('10-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (999, 3189, to_date('06-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (97, 3430, to_date('03-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (789, 7642, to_date('22-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (819, 5096, to_date('09-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (788, 9589, to_date('14-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (311, 7498, to_date('14-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (63, 6732, to_date('07-04-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (647, 8998, to_date('31-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (368, 6624, to_date('07-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (80, 8200, to_date('22-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (655, 1520, to_date('26-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (672, 5710, to_date('21-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (391, 2682, to_date('03-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (98, 3338, to_date('27-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (240, 5776, to_date('24-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (489, 7939, to_date('27-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (952, 2843, to_date('09-05-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (699, 9624, to_date('29-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (329, 5801, to_date('01-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (344, 7180, to_date('30-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (720, 4358, to_date('07-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (573, 7135, to_date('31-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (933, 1804, to_date('12-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (349, 4883, to_date('30-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (474, 8464, to_date('02-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (562, 2756, to_date('06-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (851, 3075, to_date('04-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (942, 7413, to_date('22-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (454, 5914, to_date('26-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (978, 6400, to_date('20-07-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (801, 8242, to_date('25-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (910, 8719, to_date('27-04-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (282, 2382, to_date('24-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (955, 3116, to_date('09-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (841, 2404, to_date('13-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (715, 4294, to_date('07-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (970, 3531, to_date('12-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (985, 4720, to_date('22-12-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (32, 7621, to_date('24-07-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (369, 3525, to_date('05-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (719, 8916, to_date('01-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (472, 9524, to_date('19-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (2, 3415, to_date('07-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (501, 5775, to_date('13-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (918, 8792, to_date('13-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (209, 7660, to_date('07-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (353, 6215, to_date('28-09-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (741, 1948, to_date('06-02-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (148, 7621, to_date('09-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (927, 7636, to_date('30-08-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (959, 6143, to_date('30-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (278, 5595.804, to_date('01-01-2022', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into PAYMENT (p_id, cost, payment_date)
values (366, 2866, to_date('28-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (561, 8896, to_date('22-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (666, 9522, to_date('14-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (973, 2593, to_date('04-05-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (216, 2181, to_date('19-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (418, 3712, to_date('18-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (213, 64513, to_date('14-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (110, 80829, to_date('07-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (760, 91029, to_date('17-11-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (940, 95023, to_date('14-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (310, 95023, to_date('14-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (195, 9162, to_date('11-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (782, 9677, to_date('18-11-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (912, 8372, to_date('11-03-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (57, 4168, to_date('23-08-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (756, 3755, to_date('16-06-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (624, 5803, to_date('05-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (301, 2353, to_date('12-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (281, 2662, to_date('18-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (13, 8210, to_date('09-10-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (660, 9646, to_date('29-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (687, 8157, to_date('23-12-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (175, 7769, to_date('03-03-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (37, 3050, to_date('01-01-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (608, 3051, to_date('20-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (287, 3564, to_date('06-09-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (929, 6822, to_date('08-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (490, 8755, to_date('20-06-2023', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (135, 1092, to_date('06-10-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (670, 6527, to_date('27-02-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (103, 7949, to_date('10-01-2022', 'dd-mm-yyyy'));
insert into PAYMENT (p_id, cost, payment_date)
values (419, 1092, to_date('13-04-2023', 'dd-mm-yyyy'));
commit;
prompt 332 records loaded
prompt Loading BOOKING...
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (251, to_date('28-09-2022', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 786, 84);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (158, to_date('20-05-2022', 'dd-mm-yyyy'), to_date('24-06-2023', 'dd-mm-yyyy'), 927, 937);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (556, to_date('15-09-2022', 'dd-mm-yyyy'), to_date('28-05-2023', 'dd-mm-yyyy'), 507, 912);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (51, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 64, 903);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (392, to_date('30-01-2023', 'dd-mm-yyyy'), to_date('31-01-2023', 'dd-mm-yyyy'), 516, 313);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (778, to_date('09-01-2023', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 431, 80);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (536, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('20-10-2023', 'dd-mm-yyyy'), 968, 900);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (211, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 428, 923);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (820, to_date('31-01-2023', 'dd-mm-yyyy'), to_date('01-04-2023', 'dd-mm-yyyy'), 183, 730);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (893, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 210, 225);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (46, to_date('26-02-2023', 'dd-mm-yyyy'), to_date('27-02-2023', 'dd-mm-yyyy'), 519, 208);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (28, to_date('08-01-2023', 'dd-mm-yyyy'), to_date('09-01-2023', 'dd-mm-yyyy'), 646, 518);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (548, to_date('26-06-2023', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 849, 691);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (667, to_date('14-08-2022', 'dd-mm-yyyy'), to_date('14-03-2023', 'dd-mm-yyyy'), 611, 873);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (473, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('12-02-2023', 'dd-mm-yyyy'), 446, 841);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (736, to_date('28-02-2023', 'dd-mm-yyyy'), to_date('01-03-2023', 'dd-mm-yyyy'), 26, 730);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (515, to_date('13-01-2023', 'dd-mm-yyyy'), to_date('14-01-2023', 'dd-mm-yyyy'), 800, 80);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (570, to_date('11-03-2023', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 464, 891);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (245, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 737, 722);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (981, to_date('23-01-2022', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 771, 39);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (950, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 776, 655);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (709, to_date('22-10-2023', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 702, 672);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (340, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 781, 445);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (933, to_date('23-07-2022', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 143, 978);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (123, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 681, 153);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (920, to_date('07-01-2022', 'dd-mm-yyyy'), to_date('01-04-2023', 'dd-mm-yyyy'), 340, 628);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (573, to_date('09-01-2022', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 587, 912);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (499, to_date('22-08-2023', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 296, 581);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (304, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 997, 913);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (952, to_date('30-03-2023', 'dd-mm-yyyy'), to_date('31-03-2023', 'dd-mm-yyyy'), 997, 376);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (717, to_date('26-05-2023', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 764, 615);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (425, to_date('25-04-2023', 'dd-mm-yyyy'), to_date('26-04-2023', 'dd-mm-yyyy'), 66, 650);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (813, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 654, 366);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (929, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('15-02-2023', 'dd-mm-yyyy'), 345, 602);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (133, to_date('21-12-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 480, 52);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (945, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 640, 923);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (996, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('06-04-2023', 'dd-mm-yyyy'), 785, 499);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (333, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('17-02-2023', 'dd-mm-yyyy'), 497, 987);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (694, to_date('31-07-2023', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 777, 909);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (267, to_date('14-06-2022', 'dd-mm-yyyy'), to_date('18-02-2023', 'dd-mm-yyyy'), 888, 933);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (325, to_date('13-03-2023', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 910, 454);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (165, to_date('12-06-2023', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 751, 473);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (745, to_date('25-10-2023', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 878, 2);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (544, to_date('17-09-2022', 'dd-mm-yyyy'), to_date('19-06-2023', 'dd-mm-yyyy'), 591, 927);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (59, to_date('23-01-2023', 'dd-mm-yyyy'), to_date('24-01-2023', 'dd-mm-yyyy'), 700, 965);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (872, to_date('07-06-2023', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 553, 397);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (10, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 759, 353);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (112, to_date('11-08-2023', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 804, 216);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (565, to_date('01-07-2023', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 21, 318);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (511, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 927, 628);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (132, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 641, 684);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (1, to_date('21-06-2022', 'dd-mm-yyyy'), to_date('03-04-2023', 'dd-mm-yyyy'), 326, 475);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (642, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('17-04-2023', 'dd-mm-yyyy'), 219, 673);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (505, to_date('17-04-2023', 'dd-mm-yyyy'), to_date('29-10-2023', 'dd-mm-yyyy'), 295, 618);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (901, to_date('12-02-2023', 'dd-mm-yyyy'), to_date('13-02-2023', 'dd-mm-yyyy'), 700, 832);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (272, to_date('02-01-2023', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 720, 276);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (653, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 186, 570);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (319, to_date('25-02-2023', 'dd-mm-yyyy'), to_date('26-02-2023', 'dd-mm-yyyy'), 356, 709);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (227, to_date('16-05-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 287, 554);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (682, to_date('26-07-2023', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 404, 431);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (992, to_date('18-05-2023', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 21, 781);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (854, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('20-09-2023', 'dd-mm-yyyy'), 759, 120);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (935, to_date('20-12-2022', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 214, 421);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (437, to_date('10-05-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 295, 327);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (834, to_date('31-05-2022', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 484, 762);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (485, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 740, 95);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (464, to_date('06-07-2022', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 764, 648);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (908, to_date('11-05-2023', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 109, 40);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (239, to_date('19-01-2023', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 650, 618);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (491, to_date('21-07-2022', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 223, 235);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (214, to_date('10-04-2023', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 607, 385);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (420, to_date('09-05-2023', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 271, 963);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (188, to_date('10-03-2023', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 569, 963);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (350, to_date('21-08-2023', 'dd-mm-yyyy'), to_date('15-09-2023', 'dd-mm-yyyy'), 265, 588);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (918, to_date('07-10-2023', 'dd-mm-yyyy'), to_date('22-12-2023', 'dd-mm-yyyy'), 134, 683);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (635, to_date('29-09-2022', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 9, 526);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (546, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 187, 800);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (924, to_date('14-02-2022', 'dd-mm-yyyy'), to_date('23-05-2023', 'dd-mm-yyyy'), 791, 677);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (462, to_date('14-03-2022', 'dd-mm-yyyy'), to_date('12-12-2023', 'dd-mm-yyyy'), 247, 973);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (45, to_date('25-10-2022', 'dd-mm-yyyy'), to_date('19-07-2023', 'dd-mm-yyyy'), 232, 873);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (331, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('19-04-2023', 'dd-mm-yyyy'), 786, 521);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (274, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 170, 18);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (193, to_date('07-05-2023', 'dd-mm-yyyy'), to_date('08-05-2023', 'dd-mm-yyyy'), 681, 225);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (115, to_date('25-03-2022', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 880, 649);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (725, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('25-02-2023', 'dd-mm-yyyy'), 486, 479);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (470, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 918, 756);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (125, to_date('18-03-2023', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 343, 113);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (703, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('01-03-2023', 'dd-mm-yyyy'), 773, 507);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (775, to_date('31-05-2023', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 276, 730);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (414, to_date('20-02-2022', 'dd-mm-yyyy'), to_date('15-02-2023', 'dd-mm-yyyy'), 788, 391);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (219, to_date('28-06-2022', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 64, 473);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (498, to_date('20-08-2022', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 757, 248);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (914, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 691, 963);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (479, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('19-01-2023', 'dd-mm-yyyy'), 21, 627);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (566, to_date('10-03-2023', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 5, 192);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (410, to_date('11-01-2023', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 997, 810);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (639, to_date('08-01-2023', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 317, 640);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (669, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 155, 994);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (80, to_date('28-07-2022', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 996, 994);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (256, to_date('06-05-2023', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 844, 900);
commit;
prompt 100 records committed...
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (136, to_date('05-06-2022', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 965, 499);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (508, to_date('22-12-2023', 'dd-mm-yyyy'), to_date('23-12-2023', 'dd-mm-yyyy'), 568, 614);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (666, to_date('14-04-2023', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 319, 627);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (215, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('17-08-2023', 'dd-mm-yyyy'), 709, 972);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (195, to_date('19-01-2023', 'dd-mm-yyyy'), to_date('20-01-2023', 'dd-mm-yyyy'), 673, 278);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (139, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('05-12-2023', 'dd-mm-yyyy'), 404, 471);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (434, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('22-01-2023', 'dd-mm-yyyy'), 231, 608);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (507, to_date('06-02-2023', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 609, 973);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (810, to_date('21-07-2022', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 431, 720);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (576, to_date('01-08-2023', 'dd-mm-yyyy'), to_date('02-08-2023', 'dd-mm-yyyy'), 954, 527);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (866, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('08-04-2023', 'dd-mm-yyyy'), 69, 711);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (417, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('29-03-2023', 'dd-mm-yyyy'), 899, 583);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (722, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 935, 837);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (395, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 465, 189);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (406, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 938, 225);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (97, to_date('12-03-2023', 'dd-mm-yyyy'), to_date('13-03-2023', 'dd-mm-yyyy'), 764, 133);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (634, to_date('07-08-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 526, 454);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (523, to_date('30-01-2023', 'dd-mm-yyyy'), to_date('16-05-2023', 'dd-mm-yyyy'), 516, 402);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (286, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 317, 210);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (185, to_date('01-03-2023', 'dd-mm-yyyy'), to_date('30-06-2023', 'dd-mm-yyyy'), 602, 626);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (522, to_date('16-05-2023', 'dd-mm-yyyy'), to_date('17-05-2023', 'dd-mm-yyyy'), 991, 153);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (467, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 232, 633);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (312, to_date('28-08-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 878, 80);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (609, to_date('02-04-2023', 'dd-mm-yyyy'), to_date('06-04-2023', 'dd-mm-yyyy'), 379, 394);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (744, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 88, 359);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (812, to_date('31-05-2022', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 290, 660);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (959, to_date('31-07-2022', 'dd-mm-yyyy'), to_date('10-02-2023', 'dd-mm-yyyy'), 285, 285);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (526, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 786, 301);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (230, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 899, 959);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (756, to_date('04-07-2023', 'dd-mm-yyyy'), to_date('13-07-2023', 'dd-mm-yyyy'), 557, 925);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (539, to_date('25-03-2022', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 296, 633);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (427, to_date('23-01-2022', 'dd-mm-yyyy'), to_date('12-03-2023', 'dd-mm-yyyy'), 317, 276);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (691, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('16-01-2023', 'dd-mm-yyyy'), 955, 278);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (496, to_date('05-01-2023', 'dd-mm-yyyy'), to_date('06-01-2023', 'dd-mm-yyyy'), 211, 39);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (174, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 485, 329);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (64, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('09-08-2023', 'dd-mm-yyyy'), 296, 98);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (152, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 342, 331);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (218, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 433, 113);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (21, to_date('10-02-2023', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 794, 154);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (299, to_date('22-06-2023', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 250, 555);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (354, to_date('24-05-2023', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 331, 87);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (418, to_date('15-09-2023', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 170, 986);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (941, to_date('20-04-2023', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 867, 312);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (884, to_date('20-08-2022', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 609, 154);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (563, to_date('16-03-2022', 'dd-mm-yyyy'), to_date('28-03-2023', 'dd-mm-yyyy'), 550, 405);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (431, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 38, 216);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (620, to_date('31-07-2022', 'dd-mm-yyyy'), to_date('25-04-2023', 'dd-mm-yyyy'), 865, 789);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (173, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 233, 349);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (795, to_date('24-02-2023', 'dd-mm-yyyy'), to_date('25-02-2023', 'dd-mm-yyyy'), 274, 414);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (817, to_date('15-01-2023', 'dd-mm-yyyy'), to_date('16-01-2023', 'dd-mm-yyyy'), 524, 341);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (860, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('29-03-2023', 'dd-mm-yyyy'), 596, 280);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (253, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 290, 965);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (22, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 402, 647);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (762, to_date('08-06-2023', 'dd-mm-yyyy'), to_date('09-06-2023', 'dd-mm-yyyy'), 602, 773);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (278, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 192, 695);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (326, to_date('28-09-2023', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 170, 209);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (650, to_date('07-03-2023', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 265, 817);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (547, to_date('23-03-2023', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 118, 555);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (541, to_date('31-03-2023', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 226, 782);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (991, to_date('21-12-2022', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 800, 808);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (577, to_date('28-06-2023', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 870, 306);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (53, to_date('17-01-2023', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 761, 764);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (229, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('22-02-2023', 'dd-mm-yyyy'), 399, 57);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (187, to_date('15-05-2023', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 142, 84);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (177, to_date('06-08-2023', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 709, 257);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (306, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('12-03-2023', 'dd-mm-yyyy'), 654, 282);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (975, to_date('22-08-2022', 'dd-mm-yyyy'), to_date('23-08-2022', 'dd-mm-yyyy'), 409, 359);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (568, to_date('24-04-2022', 'dd-mm-yyyy'), to_date('26-12-2022', 'dd-mm-yyyy'), 587, 99);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (91, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('18-04-2022', 'dd-mm-yyyy'), 279, 683);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (897, to_date('21-10-2022', 'dd-mm-yyyy'), to_date('07-11-2022', 'dd-mm-yyyy'), 232, 923);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (432, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2022', 'dd-mm-yyyy'), 553, 412);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (684, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('21-03-2022', 'dd-mm-yyyy'), 484, 245);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (606, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('09-09-2022', 'dd-mm-yyyy'), 396, 651);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (527, to_date('19-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 59, 195);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (973, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('17-03-2022', 'dd-mm-yyyy'), 671, 376);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (295, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'), 953, 62);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (76, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('12-06-2022', 'dd-mm-yyyy'), 497, 13);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (385, to_date('14-07-2022', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'), 990, 113);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (82, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('19-06-2022', 'dd-mm-yyyy'), 794, 52);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (265, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('10-05-2022', 'dd-mm-yyyy'), 219, 97);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (535, to_date('07-02-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 876, 673);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (233, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2022', 'dd-mm-yyyy'), 738, 474);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (252, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2022', 'dd-mm-yyyy'), 43, 986);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (172, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'), 519, 208);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (719, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('18-03-2022', 'dd-mm-yyyy'), 409, 978);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (503, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('19-11-2022', 'dd-mm-yyyy'), 762, 458);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (835, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('06-06-2022', 'dd-mm-yyyy'), 814, 148);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (118, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('13-12-2022', 'dd-mm-yyyy'), 9, 99);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (685, to_date('10-04-2022', 'dd-mm-yyyy'), to_date('12-11-2022', 'dd-mm-yyyy'), 43, 953);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (455, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('19-02-2022', 'dd-mm-yyyy'), 486, 257);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (374, to_date('09-02-2022', 'dd-mm-yyyy'), to_date('10-02-2022', 'dd-mm-yyyy'), 935, 584);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (855, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('22-11-2022', 'dd-mm-yyyy'), 474, 277);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (181, to_date('20-09-2022', 'dd-mm-yyyy'), to_date('21-09-2022', 'dd-mm-yyyy'), 431, 521);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (288, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('01-11-2022', 'dd-mm-yyyy'), 544, 195);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (194, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('18-11-2022', 'dd-mm-yyyy'), 414, 781);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (533, to_date('06-03-2022', 'dd-mm-yyyy'), to_date('07-03-2022', 'dd-mm-yyyy'), 538, 575);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (972, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('22-09-2022', 'dd-mm-yyyy'), 334, 431);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (167, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('11-03-2022', 'dd-mm-yyyy'), 77, 970);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (391, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('02-02-2022', 'dd-mm-yyyy'), 6, 927);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (588, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('24-02-2022', 'dd-mm-yyyy'), 568, 153);
commit;
prompt 200 records committed...
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (990, to_date('12-03-2022', 'dd-mm-yyyy'), to_date('13-03-2022', 'dd-mm-yyyy'), 421, 219);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (519, to_date('01-01-2022', 'dd-mm-yyyy'), to_date('23-10-2022', 'dd-mm-yyyy'), 640, 329);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (19, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('19-08-2022', 'dd-mm-yyyy'), 673, 340);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (567, to_date('15-08-2022', 'dd-mm-yyyy'), to_date('16-08-2022', 'dd-mm-yyyy'), 143, 715);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (590, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('21-03-2022', 'dd-mm-yyyy'), 919, 650);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (163, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('02-03-2022', 'dd-mm-yyyy'), 589, 924);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (313, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('15-11-2022', 'dd-mm-yyyy'), 541, 391);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (398, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('16-08-2022', 'dd-mm-yyyy'), 304, 39);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (407, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('04-10-2022', 'dd-mm-yyyy'), 506, 720);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (38, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('25-02-2022', 'dd-mm-yyyy'), 761, 709);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (601, to_date('25-01-2022', 'dd-mm-yyyy'), to_date('11-08-2022', 'dd-mm-yyyy'), 934, 670);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (529, to_date('03-12-2022', 'dd-mm-yyyy'), to_date('04-12-2022', 'dd-mm-yyyy'), 480, 98);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (128, to_date('08-07-2022', 'dd-mm-yyyy'), to_date('09-07-2022', 'dd-mm-yyyy'), 116, 633);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (888, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('26-07-2022', 'dd-mm-yyyy'), 272, 257);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (840, to_date('20-06-2022', 'dd-mm-yyyy'), to_date('12-09-2022', 'dd-mm-yyyy'), 543, 672);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (161, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('09-08-2022', 'dd-mm-yyyy'), 702, 929);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (939, to_date('11-03-2022', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'), 521, 924);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (983, to_date('28-10-2022', 'dd-mm-yyyy'), to_date('29-10-2022', 'dd-mm-yyyy'), 557, 454);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (301, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('09-10-2022', 'dd-mm-yyyy'), 340, 410);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (348, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'), 265, 135);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (782, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('04-03-2022', 'dd-mm-yyyy'), 272, 817);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (282, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('30-09-2022', 'dd-mm-yyyy'), 516, 684);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (135, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('25-12-2022', 'dd-mm-yyyy'), 910, 459);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (789, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('23-08-2022', 'dd-mm-yyyy'), 728, 741);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (26, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('10-11-2022', 'dd-mm-yyyy'), 333, 805);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (234, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 478, 916);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (372, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('12-07-2022', 'dd-mm-yyyy'), 235, 902);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (450, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('28-02-2022', 'dd-mm-yyyy'), 62, 42);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (62, to_date('19-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 639, 473);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (366, to_date('26-05-2022', 'dd-mm-yyyy'), to_date('27-05-2022', 'dd-mm-yyyy'), 732, 181);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (708, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('20-07-2022', 'dd-mm-yyyy'), 595, 986);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (902, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 463, 713);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (859, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 429, 762);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (630, to_date('14-04-2022', 'dd-mm-yyyy'), to_date('24-07-2022', 'dd-mm-yyyy'), 21, 873);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (616, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('28-04-2022', 'dd-mm-yyyy'), 27, 963);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (430, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('23-12-2022', 'dd-mm-yyyy'), 409, 471);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (967, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('11-06-2022', 'dd-mm-yyyy'), 56, 561);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (652, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('25-05-2022', 'dd-mm-yyyy'), 606, 569);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (68, to_date('13-04-2022', 'dd-mm-yyyy'), to_date('14-04-2022', 'dd-mm-yyyy'), 520, 691);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (531, to_date('08-11-2022', 'dd-mm-yyyy'), to_date('09-11-2022', 'dd-mm-yyyy'), 257, 422);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (439, to_date('19-01-2022', 'dd-mm-yyyy'), to_date('13-08-2022', 'dd-mm-yyyy'), 219, 954);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (457, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('19-02-2022', 'dd-mm-yyyy'), 712, 889);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (79, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('09-06-2022', 'dd-mm-yyyy'), 610, 800);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (355, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('08-03-2022', 'dd-mm-yyyy'), 368, 255);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (71, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('12-10-2022', 'dd-mm-yyyy'), 742, 41);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (787, to_date('11-04-2022', 'dd-mm-yyyy'), to_date('12-04-2022', 'dd-mm-yyyy'), 414, 410);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (349, to_date('02-05-2022', 'dd-mm-yyyy'), to_date('03-05-2022', 'dd-mm-yyyy'), 827, 214);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (923, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('16-04-2022', 'dd-mm-yyyy'), 816, 624);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (454, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('17-11-2022', 'dd-mm-yyyy'), 784, 158);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (594, to_date('09-08-2022', 'dd-mm-yyyy'), to_date('10-08-2022', 'dd-mm-yyyy'), 297, 13);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (627, to_date('16-04-2022', 'dd-mm-yyyy'), to_date('21-09-2022', 'dd-mm-yyyy'), 751, 527);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (110, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('21-10-2022', 'dd-mm-yyyy'), 77, 585);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (622, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('20-12-2022', 'dd-mm-yyyy'), 376, 672);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (321, to_date('30-01-2022', 'dd-mm-yyyy'), to_date('27-07-2022', 'dd-mm-yyyy'), 774, 918);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (658, to_date('22-04-2022', 'dd-mm-yyyy'), to_date('13-06-2022', 'dd-mm-yyyy'), 461, 412);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (771, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('01-03-2022', 'dd-mm-yyyy'), 431, 331);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (279, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('03-04-2022', 'dd-mm-yyyy'), 287, 987);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (403, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('05-09-2022', 'dd-mm-yyyy'), 175, 313);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (815, to_date('13-07-2022', 'dd-mm-yyyy'), to_date('14-07-2022', 'dd-mm-yyyy'), 20, 985);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (886, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('13-12-2022', 'dd-mm-yyyy'), 694, 626);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (928, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 257, 19);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (637, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('11-03-2022', 'dd-mm-yyyy'), 10, 165);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (144, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('25-07-2022', 'dd-mm-yyyy'), 171, 955);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (184, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('29-12-2022', 'dd-mm-yyyy'), 876, 11);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (78, to_date('16-12-2022', 'dd-mm-yyyy'), to_date('17-12-2022', 'dd-mm-yyyy'), 396, 555);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (394, to_date('26-10-2022', 'dd-mm-yyyy'), to_date('27-10-2022', 'dd-mm-yyyy'), 965, 543);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (409, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('31-10-2022', 'dd-mm-yyyy'), 816, 40);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (11, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('27-09-2022', 'dd-mm-yyyy'), 331, 175);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (315, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('21-11-2022', 'dd-mm-yyyy'), 536, 837);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (714, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('11-06-2022', 'dd-mm-yyyy'), 327, 414);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (514, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('15-09-2022', 'dd-mm-yyyy'), 379, 717);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (704, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('04-08-2022', 'dd-mm-yyyy'), 18, 27);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (452, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('07-11-2022', 'dd-mm-yyyy'), 197, 703);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (501, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('29-05-2022', 'dd-mm-yyyy'), 557, 709);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (832, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('27-10-2022', 'dd-mm-yyyy'), 757, 474);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (948, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('25-07-2022', 'dd-mm-yyyy'), 737, 369);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (5, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('04-02-2022', 'dd-mm-yyyy'), 650, 248);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (48, to_date('07-02-2022', 'dd-mm-yyyy'), to_date('21-06-2022', 'dd-mm-yyyy'), 756, 340);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (595, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('28-03-2022', 'dd-mm-yyyy'), 325, 819);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (919, to_date('06-05-2022', 'dd-mm-yyyy'), to_date('07-05-2022', 'dd-mm-yyyy'), 927, 388);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (4, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('29-04-2022', 'dd-mm-yyyy'), 366, 626);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (615, to_date('15-07-2022', 'dd-mm-yyyy'), to_date('16-07-2022', 'dd-mm-yyyy'), 747, 808);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (538, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('08-11-2022', 'dd-mm-yyyy'), 279, 318);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (871, to_date('19-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 611, 18);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (911, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('02-09-2022', 'dd-mm-yyyy'), 543, 925);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (208, to_date('30-07-2022', 'dd-mm-yyyy'), to_date('31-07-2022', 'dd-mm-yyyy'), 182, 918);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (640, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('11-07-2022', 'dd-mm-yyyy'), 742, 210);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (379, to_date('07-05-2022', 'dd-mm-yyyy'), to_date('08-05-2022', 'dd-mm-yyyy'), 446, 168);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (8, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('27-11-2022', 'dd-mm-yyyy'), 832, 327);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (733, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('23-05-2022', 'dd-mm-yyyy'), 61, 819);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (240, to_date('23-04-2022', 'dd-mm-yyyy'), to_date('24-04-2022', 'dd-mm-yyyy'), 793, 414);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (388, to_date('04-12-2022', 'dd-mm-yyyy'), to_date('05-12-2022', 'dd-mm-yyyy'), 433, 948);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (480, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('04-10-2022', 'dd-mm-yyyy'), 10, 709);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (869, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('10-04-2022', 'dd-mm-yyyy'), 396, 942);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (446, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('02-09-2022', 'dd-mm-yyyy'), 791, 2);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (236, to_date('08-05-2022', 'dd-mm-yyyy'), to_date('09-05-2022', 'dd-mm-yyyy'), 791, 851);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (643, to_date('07-09-2022', 'dd-mm-yyyy'), to_date('08-09-2022', 'dd-mm-yyyy'), 713, 486);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (290, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('21-10-2022', 'dd-mm-yyyy'), 604, 815);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (488, to_date('05-05-2022', 'dd-mm-yyyy'), to_date('06-05-2022', 'dd-mm-yyyy'), 219, 206);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (995, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('02-06-2022', 'dd-mm-yyyy'), 591, 916);
commit;
prompt 300 records committed...
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (974, to_date('16-03-2022', 'dd-mm-yyyy'), to_date('09-12-2022', 'dd-mm-yyyy'), 464, 314);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (792, to_date('23-09-2022', 'dd-mm-yyyy'), to_date('24-09-2022', 'dd-mm-yyyy'), 61, 85);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (593, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('26-04-2022', 'dd-mm-yyyy'), 369, 113);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (336, to_date('23-05-2022', 'dd-mm-yyyy'), to_date('24-05-2022', 'dd-mm-yyyy'), 326, 608);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (284, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('12-11-2022', 'dd-mm-yyyy'), 64, 86);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (29, to_date('08-05-2022', 'dd-mm-yyyy'), to_date('26-09-2022', 'dd-mm-yyyy'), 541, 674);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (294, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('23-03-2022', 'dd-mm-yyyy'), 990, 349);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (74, to_date('26-11-2022', 'dd-mm-yyyy'), to_date('27-11-2022', 'dd-mm-yyyy'), 867, 625);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (277, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('20-07-2022', 'dd-mm-yyyy'), 827, 666);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (749, to_date('28-03-2022', 'dd-mm-yyyy'), to_date('29-03-2022', 'dd-mm-yyyy'), 524, 629);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (204, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('05-10-2022', 'dd-mm-yyyy'), 77, 431);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (168, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('07-09-2022', 'dd-mm-yyyy'), 844, 214);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (309, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('13-12-2022', 'dd-mm-yyyy'), 816, 827);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (96, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('28-07-2022', 'dd-mm-yyyy'), 182, 717);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (199, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('01-04-2022', 'dd-mm-yyyy'), 688, 880);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (647, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('11-08-2022', 'dd-mm-yyyy'), 794, 285);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (663, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('08-06-2022', 'dd-mm-yyyy'), 863, 313);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (693, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('08-06-2022', 'dd-mm-yyyy'), 863, 313);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (393, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('08-06-2022', 'dd-mm-yyyy'), 863, 313);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (839, to_date('21-05-2023', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 279, 744);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (458, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 363, 240);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (681, to_date('08-08-2023', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 699, 847);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (734, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('27-04-2023', 'dd-mm-yyyy'), 557, 791);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (483, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 555, 99);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (700, to_date('13-03-2023', 'dd-mm-yyyy'), to_date('22-04-2023', 'dd-mm-yyyy'), 342, 608);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (373, to_date('29-08-2023', 'dd-mm-yyyy'), to_date('24-11-2023', 'dd-mm-yyyy'), 371, 62);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (209, to_date('26-01-2023', 'dd-mm-yyyy'), to_date('27-01-2023', 'dd-mm-yyyy'), 38, 147);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (103, to_date('23-10-2022', 'dd-mm-yyyy'), to_date('19-04-2023', 'dd-mm-yyyy'), 433, 832);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (968, to_date('06-03-2023', 'dd-mm-yyyy'), to_date('07-03-2023', 'dd-mm-yyyy'), 97, 615);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (604, to_date('12-01-2023', 'dd-mm-yyyy'), to_date('13-01-2023', 'dd-mm-yyyy'), 870, 994);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (989, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 947, 405);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (648, to_date('06-07-2022', 'dd-mm-yyyy'), to_date('03-01-2023', 'dd-mm-yyyy'), 52, 509);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (63, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 41, 292);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (819, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('23-01-2023', 'dd-mm-yyyy'), 880, 499);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (793, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 536, 410);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (842, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('05-07-2023', 'dd-mm-yyyy'), 865, 626);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (532, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 204, 275);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (680, to_date('30-09-2023', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 89, 730);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (697, to_date('28-05-2023', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 143, 512);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (551, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('20-03-2023', 'dd-mm-yyyy'), 116, 188);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (644, to_date('08-09-2023', 'dd-mm-yyyy'), to_date('09-09-2023', 'dd-mm-yyyy'), 904, 907);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (41, to_date('28-09-2023', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 860, 512);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (823, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('21-06-2023', 'dd-mm-yyyy'), 334, 985);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (957, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 464, 952);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (493, to_date('21-03-2023', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 155, 913);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (216, to_date('31-05-2023', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 684, 404);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (626, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 860, 703);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (891, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('06-01-2023', 'dd-mm-yyyy'), 740, 962);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (273, to_date('24-03-2022', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 142, 873);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (289, to_date('28-05-2023', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 537, 880);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (408, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('14-03-2023', 'dd-mm-yyyy'), 910, 314);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (518, to_date('10-07-2023', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 771, 87);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (116, to_date('17-08-2022', 'dd-mm-yyyy'), to_date('17-04-2023', 'dd-mm-yyyy'), 232, 725);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (203, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('14-07-2023', 'dd-mm-yyyy'), 368, 85);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (169, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 493, 585);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (36, to_date('14-07-2023', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 256, 972);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (296, to_date('15-06-2023', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 804, 581);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (360, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('25-01-2023', 'dd-mm-yyyy'), 605, 904);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (903, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('05-04-2023', 'dd-mm-yyyy'), 331, 780);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (451, to_date('23-04-2023', 'dd-mm-yyyy'), to_date('24-04-2023', 'dd-mm-yyyy'), 303, 749);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (61, to_date('07-06-2023', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 492, 169);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (120, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 632, 472);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (779, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('14-07-2023', 'dd-mm-yyyy'), 402, 369);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (555, to_date('02-03-2023', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 334, 804);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (657, to_date('02-06-2023', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 742, 85);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (311, to_date('21-06-2023', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 93, 666);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (517, to_date('05-06-2023', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 306, 623);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (300, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('10-04-2023', 'dd-mm-yyyy'), 644, 602);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (308, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('24-09-2023', 'dd-mm-yyyy'), 602, 210);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (318, to_date('20-09-2023', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 370, 99);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (500, to_date('26-08-2023', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 955, 605);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (57, to_date('06-02-2023', 'dd-mm-yyyy'), to_date('07-02-2023', 'dd-mm-yyyy'), 453, 933);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (925, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 62, 385);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (178, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 326, 366);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (180, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 976, 425);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (777, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('22-01-2023', 'dd-mm-yyyy'), 761, 191);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (559, to_date('14-04-2023', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 553, 296);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (926, to_date('27-06-2023', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 867, 254);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (951, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('13-01-2023', 'dd-mm-yyyy'), 303, 479);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (877, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 304, 425);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (713, to_date('02-01-2023', 'dd-mm-yyyy'), to_date('03-01-2023', 'dd-mm-yyyy'), 776, 815);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (345, to_date('17-06-2023', 'dd-mm-yyyy'), to_date('15-08-2023', 'dd-mm-yyyy'), 940, 759);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (65, to_date('23-01-2023', 'dd-mm-yyyy'), to_date('24-01-2023', 'dd-mm-yyyy'), 379, 359);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (978, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('21-12-2023', 'dd-mm-yyyy'), 720, 741);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (783, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 19, 11);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (156, to_date('12-07-2023', 'dd-mm-yyyy'), to_date('13-07-2023', 'dd-mm-yyyy'), 942, 640);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (287, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 200, 722);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (375, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 288, 431);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (217, to_date('25-06-2023', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 398, 820);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (867, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 168, 404);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (670, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 297, 512);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (943, to_date('19-09-2023', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 371, 841);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (628, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 318, 195);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (665, to_date('09-02-2022', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 421, 573);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (512, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('08-04-2023', 'dd-mm-yyyy'), 265, 80);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (875, to_date('25-04-2023', 'dd-mm-yyyy'), to_date('26-04-2023', 'dd-mm-yyyy'), 587, 827);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (552, to_date('23-05-2023', 'dd-mm-yyyy'), to_date('24-05-2023', 'dd-mm-yyyy'), 10, 952);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (997, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('22-03-2023', 'dd-mm-yyyy'), 771, 391);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (689, to_date('06-05-2023', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 785, 666);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (339, to_date('10-07-2023', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 806, 278);
commit;
prompt 400 records committed...
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (153, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('17-01-2023', 'dd-mm-yyyy'), 368, 817);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (347, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 327, 32);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (137, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('24-06-2023', 'dd-mm-yyyy'), 804, 387);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (718, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 41, 910);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (807, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('24-04-2023', 'dd-mm-yyyy'), 956, 804);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (50, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 507, 674);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (428, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 244, 153);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (766, to_date('27-10-2023', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 616, 900);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (731, to_date('24-04-2023', 'dd-mm-yyyy'), to_date('25-04-2023', 'dd-mm-yyyy'), 90, 507);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (716, to_date('04-09-2023', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 484, 851);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (673, to_date('22-11-2023', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 200, 341);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (826, to_date('12-04-2023', 'dd-mm-yyyy'), to_date('13-04-2023', 'dd-mm-yyyy'), 712, 908);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (198, to_date('05-09-2023', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 616, 219);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (513, to_date('13-06-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 51, 547);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (481, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 166, 475);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (751, to_date('28-04-2023', 'dd-mm-yyyy'), to_date('29-04-2023', 'dd-mm-yyyy'), 130, 986);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (324, to_date('06-05-2023', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 908, 730);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (969, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 937, 458);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (310, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 851, 292);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (824, to_date('06-03-2023', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 317, 822);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (654, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('23-04-2023', 'dd-mm-yyyy'), 327, 255);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (938, to_date('14-12-2022', 'dd-mm-yyyy'), to_date('22-08-2023', 'dd-mm-yyyy'), 366, 254);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (54, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 480, 25);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (207, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 791, 954);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (268, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('01-02-2023', 'dd-mm-yyyy'), 562, 561);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (85, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('31-03-2023', 'dd-mm-yyyy'), 200, 987);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (946, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 433, 431);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (73, to_date('27-03-2023', 'dd-mm-yyyy'), to_date('28-03-2023', 'dd-mm-yyyy'), 286, 625);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (786, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('26-09-2022', 'dd-mm-yyyy'), 909, 48);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (243, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('01-04-2022', 'dd-mm-yyyy'), 997, 627);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (585, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('24-06-2022', 'dd-mm-yyyy'), 171, 52);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (589, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('06-09-2022', 'dd-mm-yyyy'), 276, 764);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (805, to_date('12-02-2022', 'dd-mm-yyyy'), to_date('13-02-2022', 'dd-mm-yyyy'), 632, 98);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (92, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('30-08-2022', 'dd-mm-yyyy'), 897, 331);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (107, to_date('09-10-2022', 'dd-mm-yyyy'), to_date('10-10-2022', 'dd-mm-yyyy'), 93, 225);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (147, to_date('17-06-2022', 'dd-mm-yyyy'), to_date('18-06-2022', 'dd-mm-yyyy'), 918, 422);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (534, to_date('02-07-2022', 'dd-mm-yyyy'), to_date('03-07-2022', 'dd-mm-yyyy'), 790, 282);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (910, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('21-12-2022', 'dd-mm-yyyy'), 19, 805);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (486, to_date('13-12-2022', 'dd-mm-yyyy'), to_date('14-12-2022', 'dd-mm-yyyy'), 411, 618);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (162, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('22-11-2022', 'dd-mm-yyyy'), 516, 723);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (131, to_date('01-04-2022', 'dd-mm-yyyy'), to_date('02-04-2022', 'dd-mm-yyyy'), 800, 985);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (592, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('02-03-2022', 'dd-mm-yyyy'), 41, 983);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (510, to_date('28-08-2022', 'dd-mm-yyyy'), to_date('26-12-2022', 'dd-mm-yyyy'), 544, 86);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (701, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('30-07-2022', 'dd-mm-yyyy'), 43, 933);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (129, to_date('10-04-2022', 'dd-mm-yyyy'), to_date('11-04-2022', 'dd-mm-yyyy'), 899, 941);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (632, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('27-09-2022', 'dd-mm-yyyy'), 484, 2);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (261, to_date('11-12-2022', 'dd-mm-yyyy'), to_date('12-12-2022', 'dd-mm-yyyy'), 151, 416);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (93, to_date('19-02-2022', 'dd-mm-yyyy'), to_date('20-02-2022', 'dd-mm-yyyy'), 908, 431);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (365, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('10-08-2022', 'dd-mm-yyyy'), 214, 188);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (605, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('25-09-2022', 'dd-mm-yyyy'), 541, 928);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (201, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('07-07-2022', 'dd-mm-yyyy'), 908, 257);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (186, to_date('20-02-2022', 'dd-mm-yyyy'), to_date('21-02-2022', 'dd-mm-yyyy'), 493, 175);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (426, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('28-03-2022', 'dd-mm-yyyy'), 516, 827);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (900, to_date('22-05-2022', 'dd-mm-yyyy'), to_date('23-05-2022', 'dd-mm-yyyy'), 171, 192);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (396, to_date('01-08-2022', 'dd-mm-yyyy'), to_date('02-08-2022', 'dd-mm-yyyy'), 331, 999);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (636, to_date('23-03-2022', 'dd-mm-yyyy'), to_date('24-03-2022', 'dd-mm-yyyy'), 860, 412);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (934, to_date('03-05-2022', 'dd-mm-yyyy'), to_date('04-05-2022', 'dd-mm-yyyy'), 650, 2);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (280, to_date('29-06-2022', 'dd-mm-yyyy'), to_date('30-06-2022', 'dd-mm-yyyy'), 484, 947);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (808, to_date('29-09-2022', 'dd-mm-yyyy'), to_date('30-09-2022', 'dd-mm-yyyy'), 899, 717);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (381, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('30-08-2022', 'dd-mm-yyyy'), 876, 986);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (557, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('01-05-2022', 'dd-mm-yyyy'), 736, 953);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (882, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('28-11-2022', 'dd-mm-yyyy'), 948, 722);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (584, to_date('13-06-2022', 'dd-mm-yyyy'), to_date('14-06-2022', 'dd-mm-yyyy'), 527, 658);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (411, to_date('08-02-2022', 'dd-mm-yyyy'), to_date('09-02-2022', 'dd-mm-yyyy'), 707, 282);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (599, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 519, 762);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (138, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 990, 972);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (828, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('23-10-2022', 'dd-mm-yyyy'), 876, 296);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (81, to_date('15-02-2022', 'dd-mm-yyyy'), to_date('16-02-2022', 'dd-mm-yyyy'), 366, 385);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (861, to_date('02-03-2022', 'dd-mm-yyyy'), to_date('03-03-2022', 'dd-mm-yyyy'), 596, 902);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (735, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('29-12-2022', 'dd-mm-yyyy'), 639, 781);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (558, to_date('29-03-2022', 'dd-mm-yyyy'), to_date('26-04-2022', 'dd-mm-yyyy'), 197, 794);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (283, to_date('20-12-2022', 'dd-mm-yyyy'), to_date('21-12-2022', 'dd-mm-yyyy'), 671, 85);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (885, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('07-02-2022', 'dd-mm-yyyy'), 736, 248);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (255, to_date('04-04-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 878, 188);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (484, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('19-09-2022', 'dd-mm-yyyy'), 415, 112);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (811, to_date('16-09-2022', 'dd-mm-yyyy'), to_date('17-09-2022', 'dd-mm-yyyy'), 743, 827);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (564, to_date('26-05-2022', 'dd-mm-yyyy'), to_date('27-05-2022', 'dd-mm-yyyy'), 781, 135);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (342, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-02-2022', 'dd-mm-yyyy'), 340, 368);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (210, to_date('18-10-2022', 'dd-mm-yyyy'), to_date('19-10-2022', 'dd-mm-yyyy'), 200, 841);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (688, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('07-06-2022', 'dd-mm-yyyy'), 77, 850);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (40, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('09-09-2022', 'dd-mm-yyyy'), 64, 301);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (353, to_date('03-07-2022', 'dd-mm-yyyy'), to_date('04-07-2022', 'dd-mm-yyyy'), 757, 285);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (60, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('23-09-2022', 'dd-mm-yyyy'), 909, 547);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (122, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('10-12-2022', 'dd-mm-yyyy'), 281, 526);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (189, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-02-2022', 'dd-mm-yyyy'), 954, 535);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (561, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('07-09-2022', 'dd-mm-yyyy'), 931, 501);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (413, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('31-08-2022', 'dd-mm-yyyy'), 110, 943);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (223, to_date('12-04-2022', 'dd-mm-yyyy'), to_date('13-04-2022', 'dd-mm-yyyy'), 776, 398);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (100, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('06-10-2022', 'dd-mm-yyyy'), 737, 932);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (262, to_date('25-06-2022', 'dd-mm-yyyy'), to_date('21-08-2022', 'dd-mm-yyyy'), 963, 912);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (942, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 942, 189);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (126, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('01-11-2022', 'dd-mm-yyyy'), 334, 95);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (292, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('16-04-2022', 'dd-mm-yyyy'), 804, 985);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (83, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('26-07-2022', 'dd-mm-yyyy'), 772, 248);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (58, to_date('08-03-2022', 'dd-mm-yyyy'), to_date('09-03-2022', 'dd-mm-yyyy'), 744, 924);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (837, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('01-07-2022', 'dd-mm-yyyy'), 402, 312);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (157, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('28-03-2022', 'dd-mm-yyyy'), 947, 422);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (445, to_date('04-06-2022', 'dd-mm-yyyy'), to_date('03-07-2022', 'dd-mm-yyyy'), 966, 789);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (741, to_date('18-07-2022', 'dd-mm-yyyy'), to_date('09-10-2022', 'dd-mm-yyyy'), 461, 416);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (205, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('16-03-2022', 'dd-mm-yyyy'), 595, 410);
commit;
prompt 500 records committed...
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (478, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('30-04-2022', 'dd-mm-yyyy'), 284, 909);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (668, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('18-05-2022', 'dd-mm-yyyy'), 137, 421);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (936, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('12-07-2022', 'dd-mm-yyyy'), 288, 412);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (816, to_date('20-05-2022', 'dd-mm-yyyy'), to_date('01-06-2022', 'dd-mm-yyyy'), 480, 219);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (696, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('23-09-2022', 'dd-mm-yyyy'), 976, 949);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (322, to_date('02-10-2022', 'dd-mm-yyyy'), to_date('03-10-2022', 'dd-mm-yyyy'), 758, 692);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (768, to_date('01-08-2022', 'dd-mm-yyyy'), to_date('02-08-2022', 'dd-mm-yyyy'), 418, 431);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (987, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('19-09-2022', 'dd-mm-yyyy'), 699, 627);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (314, to_date('15-05-2022', 'dd-mm-yyyy'), to_date('18-09-2022', 'dd-mm-yyyy'), 115, 206);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (196, to_date('09-03-2022', 'dd-mm-yyyy'), to_date('10-03-2022', 'dd-mm-yyyy'), 990, 647);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (726, to_date('15-02-2022', 'dd-mm-yyyy'), to_date('08-03-2022', 'dd-mm-yyyy'), 833, 904);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (371, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('07-10-2022', 'dd-mm-yyyy'), 947, 474);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (435, to_date('08-03-2022', 'dd-mm-yyyy'), to_date('09-03-2022', 'dd-mm-yyyy'), 896, 472);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (244, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('22-05-2022', 'dd-mm-yyyy'), 318, 464);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (465, to_date('05-06-2022', 'dd-mm-yyyy'), to_date('12-07-2022', 'dd-mm-yyyy'), 604, 479);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (190, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('14-10-2022', 'dd-mm-yyyy'), 910, 941);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (2, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('27-03-2022', 'dd-mm-yyyy'), 790, 837);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (476, to_date('16-10-2022', 'dd-mm-yyyy'), to_date('17-10-2022', 'dd-mm-yyyy'), 142, 206);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (864, to_date('25-01-2022', 'dd-mm-yyyy'), to_date('02-07-2022', 'dd-mm-yyyy'), 630, 316);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (662, to_date('24-01-2022', 'dd-mm-yyyy'), to_date('02-06-2022', 'dd-mm-yyyy'), 175, 165);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (334, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('01-07-2022', 'dd-mm-yyyy'), 279, 416);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (705, to_date('22-02-2022', 'dd-mm-yyyy'), to_date('23-02-2022', 'dd-mm-yyyy'), 684, 841);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (631, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('30-07-2022', 'dd-mm-yyyy'), 257, 952);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (238, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'), 452, 474);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (404, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('24-02-2022', 'dd-mm-yyyy'), 5, 791);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (111, to_date('12-08-2022', 'dd-mm-yyyy'), to_date('13-08-2022', 'dd-mm-yyyy'), 356, 63);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (655, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('25-07-2022', 'dd-mm-yyyy'), 32, 285);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (37, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-02-2022', 'dd-mm-yyyy'), 814, 36);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (909, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('19-01-2022', 'dd-mm-yyyy'), 215, 310);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (848, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 639, 412);
insert into BOOKING (b_id, check_in, check_out, customerid, p_id)
values (818, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('20-09-2023', 'dd-mm-yyyy'), 639, 412);
commit;
prompt 531 records loaded
prompt Loading BOOKINGACTIVITIES...
insert into BOOKINGACTIVITIES (b_id, a_id)
values (1, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (1, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (4, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (8, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (10, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (19, 298);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (19, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (21, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (22, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (26, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (28, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (36, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (41, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (45, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (46, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (48, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (51, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (53, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (57, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (58, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (59, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (61, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (62, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (63, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (68, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (71, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (73, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (78, 596);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (79, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (80, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (81, 596);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (83, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (91, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (92, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (112, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (115, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (120, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (123, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (125, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (128, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (132, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (133, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (135, 596);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (136, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (136, 794);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (144, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (152, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (156, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (158, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (163, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (165, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (167, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (169, 596);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (173, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (174, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (177, 552);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (180, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (185, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (187, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (188, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (194, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (195, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (199, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (208, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (211, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (214, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (215, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (216, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (217, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (218, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (227, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (229, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (233, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (234, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (238, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (239, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (240, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (244, 824);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (245, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (251, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (252, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (256, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (261, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (262, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (265, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (267, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (268, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (272, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (274, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (278, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (287, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (287, 502);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (288, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (289, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (290, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (295, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (299, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (304, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (310, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (311, 20);
commit;
prompt 100 records committed...
insert into BOOKINGACTIVITIES (b_id, a_id)
values (313, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (314, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (315, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (318, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (319, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (321, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (322, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (324, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (325, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (326, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (333, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (339, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (340, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (347, 552);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (349, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (350, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (354, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (355, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (360, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (366, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (372, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (373, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (375, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (385, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (388, 78);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (391, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (392, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (395, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (398, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (403, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (406, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (407, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (411, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (413, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (414, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (417, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (420, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (425, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (425, 393);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (425, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (428, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (430, 78);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (431, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (434, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (435, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (445, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (450, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (451, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (452, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (454, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (457, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (458, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (462, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (470, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (473, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (473, 759);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (478, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (480, 759);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (483, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (484, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (485, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (491, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (496, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (498, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (499, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (503, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (505, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (507, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (508, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (511, 45);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (513, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (515, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (517, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (522, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (527, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (531, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (532, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (533, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (534, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (535, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (536, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (541, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (544, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (546, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (547, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (548, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (556, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (557, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (561, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (561, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (563, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (565, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (566, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (570, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (573, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (576, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (577, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (584, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (585, 392);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (590, 20);
commit;
prompt 200 records committed...
insert into BOOKINGACTIVITIES (b_id, a_id)
values (593, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (594, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (594, 759);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (595, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (601, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (606, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (609, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (615, 759);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (615, 824);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (616, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (620, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (622, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (628, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (634, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (635, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (637, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (639, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (642, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (643, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (644, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (648, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (652, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (653, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (655, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (658, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (662, 392);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (663, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (663, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (666, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (667, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (668, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (669, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (680, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (681, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (682, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (691, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (694, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (703, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (704, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (708, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (709, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (714, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (717, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (722, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (725, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (726, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (731, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (733, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (736, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (744, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (745, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (751, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (756, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (766, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (768, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (775, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (778, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (786, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (789, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (795, 824);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (807, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (811, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (812, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (813, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (815, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (817, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (820, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (834, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (835, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (837, 794);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (840, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (854, 552);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (855, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (859, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (860, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (866, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (867, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (872, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (872, 596);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (882, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (886, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (888, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (893, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (902, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (908, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (909, 502);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (909, 527);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (909, 794);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (914, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (914, 392);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (918, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (920, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (923, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (924, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (929, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (933, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (935, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (939, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (941, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (945, 20);
commit;
prompt 300 records committed...
insert into BOOKINGACTIVITIES (b_id, a_id)
values (950, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (959, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (967, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (968, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (969, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (972, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (973, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (975, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (978, 78);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (981, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (989, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (990, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (996, 20);
insert into BOOKINGACTIVITIES (b_id, a_id)
values (996, 78);
commit;
prompt 314 records loaded
prompt Loading ROOMS...
insert into ROOMS (r_id, room_type, floor)
values (102, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (103, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (104, 1, 5);
insert into ROOMS (r_id, room_type, floor)
values (105, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (106, 4, 10);
insert into ROOMS (r_id, room_type, floor)
values (107, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (108, 2, 14);
insert into ROOMS (r_id, room_type, floor)
values (109, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (110, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (111, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (112, 2, 2);
insert into ROOMS (r_id, room_type, floor)
values (113, 2, 12);
insert into ROOMS (r_id, room_type, floor)
values (114, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (115, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (116, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (117, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (118, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (119, 4, 4);
insert into ROOMS (r_id, room_type, floor)
values (120, 4, 10);
insert into ROOMS (r_id, room_type, floor)
values (121, 3, 13);
insert into ROOMS (r_id, room_type, floor)
values (122, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (123, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (124, 5, 13);
insert into ROOMS (r_id, room_type, floor)
values (125, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (126, 5, 7);
insert into ROOMS (r_id, room_type, floor)
values (127, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (128, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (129, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (130, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (131, 3, 11);
insert into ROOMS (r_id, room_type, floor)
values (132, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (133, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (134, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (135, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (136, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (137, 5, 10);
insert into ROOMS (r_id, room_type, floor)
values (138, 1, 3);
insert into ROOMS (r_id, room_type, floor)
values (139, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (140, 4, 4);
insert into ROOMS (r_id, room_type, floor)
values (141, 5, 13);
insert into ROOMS (r_id, room_type, floor)
values (142, 2, 2);
insert into ROOMS (r_id, room_type, floor)
values (143, 1, 8);
insert into ROOMS (r_id, room_type, floor)
values (144, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (145, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (146, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (147, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (148, 2, 2);
insert into ROOMS (r_id, room_type, floor)
values (149, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (150, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (151, 1, 6);
insert into ROOMS (r_id, room_type, floor)
values (152, 2, 2);
insert into ROOMS (r_id, room_type, floor)
values (153, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (154, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (155, 5, 7);
insert into ROOMS (r_id, room_type, floor)
values (156, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (157, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (158, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (159, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (160, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (161, 5, 12);
insert into ROOMS (r_id, room_type, floor)
values (162, 3, 6);
insert into ROOMS (r_id, room_type, floor)
values (163, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (164, 5, 14);
insert into ROOMS (r_id, room_type, floor)
values (165, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (166, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (167, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (168, 1, 8);
insert into ROOMS (r_id, room_type, floor)
values (169, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (170, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (171, 5, 13);
insert into ROOMS (r_id, room_type, floor)
values (172, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (173, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (174, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (175, 4, 12);
insert into ROOMS (r_id, room_type, floor)
values (176, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (177, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (178, 2, 9);
insert into ROOMS (r_id, room_type, floor)
values (179, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (180, 2, 11);
insert into ROOMS (r_id, room_type, floor)
values (181, 3, 13);
insert into ROOMS (r_id, room_type, floor)
values (182, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (183, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (184, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (185, 5, 10);
insert into ROOMS (r_id, room_type, floor)
values (186, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (187, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (188, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (189, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (190, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (191, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (192, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (193, 4, 14);
insert into ROOMS (r_id, room_type, floor)
values (194, 5, 7);
insert into ROOMS (r_id, room_type, floor)
values (195, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (196, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (197, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (198, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (199, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (200, 3, 13);
insert into ROOMS (r_id, room_type, floor)
values (201, 3, 8);
commit;
prompt 100 records committed...
insert into ROOMS (r_id, room_type, floor)
values (202, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (203, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (204, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (205, 2, 12);
insert into ROOMS (r_id, room_type, floor)
values (206, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (207, 4, 4);
insert into ROOMS (r_id, room_type, floor)
values (208, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (209, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (210, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (211, 1, 3);
insert into ROOMS (r_id, room_type, floor)
values (212, 4, 12);
insert into ROOMS (r_id, room_type, floor)
values (213, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (214, 3, 13);
insert into ROOMS (r_id, room_type, floor)
values (215, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (216, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (217, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (218, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (219, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (220, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (221, 4, 10);
insert into ROOMS (r_id, room_type, floor)
values (222, 5, 14);
insert into ROOMS (r_id, room_type, floor)
values (223, 5, 10);
insert into ROOMS (r_id, room_type, floor)
values (224, 1, 6);
insert into ROOMS (r_id, room_type, floor)
values (225, 3, 10);
insert into ROOMS (r_id, room_type, floor)
values (226, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (227, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (228, 5, 14);
insert into ROOMS (r_id, room_type, floor)
values (229, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (230, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (231, 1, 4);
insert into ROOMS (r_id, room_type, floor)
values (232, 1, 3);
insert into ROOMS (r_id, room_type, floor)
values (233, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (234, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (235, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (236, 4, 10);
insert into ROOMS (r_id, room_type, floor)
values (237, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (238, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (239, 3, 11);
insert into ROOMS (r_id, room_type, floor)
values (240, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (241, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (242, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (243, 1, 6);
insert into ROOMS (r_id, room_type, floor)
values (244, 3, 8);
insert into ROOMS (r_id, room_type, floor)
values (245, 5, 7);
insert into ROOMS (r_id, room_type, floor)
values (246, 1, 2);
insert into ROOMS (r_id, room_type, floor)
values (247, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (248, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (249, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (250, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (251, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (252, 4, 10);
insert into ROOMS (r_id, room_type, floor)
values (253, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (254, 4, 12);
insert into ROOMS (r_id, room_type, floor)
values (255, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (256, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (257, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (258, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (259, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (260, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (261, 5, 3);
insert into ROOMS (r_id, room_type, floor)
values (262, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (263, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (264, 5, 3);
insert into ROOMS (r_id, room_type, floor)
values (265, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (266, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (267, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (268, 1, 2);
insert into ROOMS (r_id, room_type, floor)
values (269, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (270, 5, 3);
insert into ROOMS (r_id, room_type, floor)
values (271, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (272, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (273, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (274, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (275, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (276, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (277, 4, 9);
insert into ROOMS (r_id, room_type, floor)
values (278, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (279, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (280, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (281, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (282, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (283, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (284, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (285, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (286, 5, 10);
insert into ROOMS (r_id, room_type, floor)
values (287, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (288, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (289, 5, 13);
insert into ROOMS (r_id, room_type, floor)
values (290, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (291, 3, 8);
insert into ROOMS (r_id, room_type, floor)
values (292, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (293, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (294, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (295, 3, 6);
insert into ROOMS (r_id, room_type, floor)
values (296, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (297, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (298, 1, 6);
insert into ROOMS (r_id, room_type, floor)
values (299, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (300, 3, 13);
insert into ROOMS (r_id, room_type, floor)
values (301, 2, 7);
commit;
prompt 200 records committed...
insert into ROOMS (r_id, room_type, floor)
values (302, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (303, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (304, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (305, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (306, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (307, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (308, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (309, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (310, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (311, 3, 8);
insert into ROOMS (r_id, room_type, floor)
values (312, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (313, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (314, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (315, 2, 9);
insert into ROOMS (r_id, room_type, floor)
values (316, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (317, 1, 8);
insert into ROOMS (r_id, room_type, floor)
values (318, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (319, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (320, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (321, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (322, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (323, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (324, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (325, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (326, 5, 4);
insert into ROOMS (r_id, room_type, floor)
values (327, 4, 9);
insert into ROOMS (r_id, room_type, floor)
values (328, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (329, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (330, 5, 14);
insert into ROOMS (r_id, room_type, floor)
values (331, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (332, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (333, 5, 10);
insert into ROOMS (r_id, room_type, floor)
values (334, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (335, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (336, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (337, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (338, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (339, 1, 6);
insert into ROOMS (r_id, room_type, floor)
values (340, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (341, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (342, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (343, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (344, 3, 11);
insert into ROOMS (r_id, room_type, floor)
values (345, 5, 7);
insert into ROOMS (r_id, room_type, floor)
values (346, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (347, 5, 4);
insert into ROOMS (r_id, room_type, floor)
values (348, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (349, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (350, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (351, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (352, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (353, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (354, 5, 14);
insert into ROOMS (r_id, room_type, floor)
values (355, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (356, 2, 12);
insert into ROOMS (r_id, room_type, floor)
values (357, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (358, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (359, 5, 7);
insert into ROOMS (r_id, room_type, floor)
values (360, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (361, 5, 12);
insert into ROOMS (r_id, room_type, floor)
values (362, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (363, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (364, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (365, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (366, 2, 11);
insert into ROOMS (r_id, room_type, floor)
values (367, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (368, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (369, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (370, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (371, 1, 2);
insert into ROOMS (r_id, room_type, floor)
values (372, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (373, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (374, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (375, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (376, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (377, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (378, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (379, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (380, 3, 8);
insert into ROOMS (r_id, room_type, floor)
values (381, 3, 10);
insert into ROOMS (r_id, room_type, floor)
values (382, 1, 2);
insert into ROOMS (r_id, room_type, floor)
values (383, 2, 12);
insert into ROOMS (r_id, room_type, floor)
values (384, 1, 13);
insert into ROOMS (r_id, room_type, floor)
values (385, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (386, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (387, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (388, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (389, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (390, 3, 11);
insert into ROOMS (r_id, room_type, floor)
values (391, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (392, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (393, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (394, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (395, 5, 4);
insert into ROOMS (r_id, room_type, floor)
values (396, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (397, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (398, 5, 4);
insert into ROOMS (r_id, room_type, floor)
values (399, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (400, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (401, 1, 12);
commit;
prompt 300 records committed...
insert into ROOMS (r_id, room_type, floor)
values (402, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (403, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (404, 1, 3);
insert into ROOMS (r_id, room_type, floor)
values (405, 2, 12);
insert into ROOMS (r_id, room_type, floor)
values (406, 4, 4);
insert into ROOMS (r_id, room_type, floor)
values (407, 4, 5);
insert into ROOMS (r_id, room_type, floor)
values (408, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (409, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (410, 3, 8);
insert into ROOMS (r_id, room_type, floor)
values (411, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (412, 5, 7);
insert into ROOMS (r_id, room_type, floor)
values (413, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (414, 3, 6);
insert into ROOMS (r_id, room_type, floor)
values (415, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (416, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (417, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (418, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (419, 5, 12);
insert into ROOMS (r_id, room_type, floor)
values (420, 4, 10);
insert into ROOMS (r_id, room_type, floor)
values (421, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (422, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (423, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (424, 1, 8);
insert into ROOMS (r_id, room_type, floor)
values (425, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (426, 4, 9);
insert into ROOMS (r_id, room_type, floor)
values (427, 2, 2);
insert into ROOMS (r_id, room_type, floor)
values (428, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (429, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (430, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (431, 4, 10);
insert into ROOMS (r_id, room_type, floor)
values (432, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (433, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (434, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (435, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (436, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (437, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (438, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (439, 2, 10);
insert into ROOMS (r_id, room_type, floor)
values (440, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (441, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (442, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (443, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (444, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (445, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (446, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (447, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (448, 5, 4);
insert into ROOMS (r_id, room_type, floor)
values (449, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (450, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (451, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (452, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (453, 5, 12);
insert into ROOMS (r_id, room_type, floor)
values (454, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (455, 3, 14);
insert into ROOMS (r_id, room_type, floor)
values (456, 2, 6);
insert into ROOMS (r_id, room_type, floor)
values (457, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (458, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (459, 3, 11);
insert into ROOMS (r_id, room_type, floor)
values (460, 3, 6);
insert into ROOMS (r_id, room_type, floor)
values (461, 3, 11);
insert into ROOMS (r_id, room_type, floor)
values (462, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (463, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (464, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (465, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (466, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (467, 3, 6);
insert into ROOMS (r_id, room_type, floor)
values (468, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (469, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (470, 4, 13);
insert into ROOMS (r_id, room_type, floor)
values (471, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (472, 3, 10);
insert into ROOMS (r_id, room_type, floor)
values (473, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (474, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (475, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (476, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (477, 5, 12);
insert into ROOMS (r_id, room_type, floor)
values (478, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (479, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (480, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (481, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (482, 3, 7);
insert into ROOMS (r_id, room_type, floor)
values (483, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (484, 5, 12);
insert into ROOMS (r_id, room_type, floor)
values (485, 1, 6);
insert into ROOMS (r_id, room_type, floor)
values (486, 4, 12);
insert into ROOMS (r_id, room_type, floor)
values (487, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (488, 1, 5);
insert into ROOMS (r_id, room_type, floor)
values (489, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (490, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (491, 4, 14);
insert into ROOMS (r_id, room_type, floor)
values (492, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (493, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (494, 1, 3);
insert into ROOMS (r_id, room_type, floor)
values (495, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (496, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (497, 4, 12);
insert into ROOMS (r_id, room_type, floor)
values (498, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (499, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (500, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (1, 2, 6);
commit;
prompt 400 records committed...
insert into ROOMS (r_id, room_type, floor)
values (2, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (3, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (4, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (5, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (6, 1, 5);
insert into ROOMS (r_id, room_type, floor)
values (7, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (8, 3, 5);
insert into ROOMS (r_id, room_type, floor)
values (9, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (10, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (11, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (12, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (13, 2, 11);
insert into ROOMS (r_id, room_type, floor)
values (14, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (15, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (16, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (17, 3, 4);
insert into ROOMS (r_id, room_type, floor)
values (18, 3, 13);
insert into ROOMS (r_id, room_type, floor)
values (19, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (20, 5, 13);
insert into ROOMS (r_id, room_type, floor)
values (21, 1, 3);
insert into ROOMS (r_id, room_type, floor)
values (22, 3, 8);
insert into ROOMS (r_id, room_type, floor)
values (23, 5, 13);
insert into ROOMS (r_id, room_type, floor)
values (24, 1, 5);
insert into ROOMS (r_id, room_type, floor)
values (25, 3, 6);
insert into ROOMS (r_id, room_type, floor)
values (26, 1, 14);
insert into ROOMS (r_id, room_type, floor)
values (27, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (28, 1, 4);
insert into ROOMS (r_id, room_type, floor)
values (29, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (30, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (31, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (32, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (33, 1, 5);
insert into ROOMS (r_id, room_type, floor)
values (34, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (35, 1, 3);
insert into ROOMS (r_id, room_type, floor)
values (36, 2, 11);
insert into ROOMS (r_id, room_type, floor)
values (37, 1, 2);
insert into ROOMS (r_id, room_type, floor)
values (38, 2, 11);
insert into ROOMS (r_id, room_type, floor)
values (39, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (40, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (41, 3, 10);
insert into ROOMS (r_id, room_type, floor)
values (42, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (43, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (44, 1, 10);
insert into ROOMS (r_id, room_type, floor)
values (45, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (46, 2, 7);
insert into ROOMS (r_id, room_type, floor)
values (47, 5, 9);
insert into ROOMS (r_id, room_type, floor)
values (48, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (49, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (50, 4, 12);
insert into ROOMS (r_id, room_type, floor)
values (51, 1, 4);
insert into ROOMS (r_id, room_type, floor)
values (52, 5, 8);
insert into ROOMS (r_id, room_type, floor)
values (53, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (54, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (55, 1, 6);
insert into ROOMS (r_id, room_type, floor)
values (56, 3, 13);
insert into ROOMS (r_id, room_type, floor)
values (57, 3, 10);
insert into ROOMS (r_id, room_type, floor)
values (58, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (59, 3, 9);
insert into ROOMS (r_id, room_type, floor)
values (60, 5, 12);
insert into ROOMS (r_id, room_type, floor)
values (61, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (62, 2, 12);
insert into ROOMS (r_id, room_type, floor)
values (63, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (64, 2, 4);
insert into ROOMS (r_id, room_type, floor)
values (65, 1, 12);
insert into ROOMS (r_id, room_type, floor)
values (66, 4, 11);
insert into ROOMS (r_id, room_type, floor)
values (67, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (68, 3, 11);
insert into ROOMS (r_id, room_type, floor)
values (69, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (70, 4, 2);
insert into ROOMS (r_id, room_type, floor)
values (71, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (72, 4, 7);
insert into ROOMS (r_id, room_type, floor)
values (73, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (74, 2, 3);
insert into ROOMS (r_id, room_type, floor)
values (75, 4, 3);
insert into ROOMS (r_id, room_type, floor)
values (76, 1, 11);
insert into ROOMS (r_id, room_type, floor)
values (77, 1, 8);
insert into ROOMS (r_id, room_type, floor)
values (78, 5, 6);
insert into ROOMS (r_id, room_type, floor)
values (79, 2, 5);
insert into ROOMS (r_id, room_type, floor)
values (80, 4, 8);
insert into ROOMS (r_id, room_type, floor)
values (81, 2, 12);
insert into ROOMS (r_id, room_type, floor)
values (82, 3, 12);
insert into ROOMS (r_id, room_type, floor)
values (83, 2, 13);
insert into ROOMS (r_id, room_type, floor)
values (84, 1, 7);
insert into ROOMS (r_id, room_type, floor)
values (85, 5, 11);
insert into ROOMS (r_id, room_type, floor)
values (86, 3, 6);
insert into ROOMS (r_id, room_type, floor)
values (87, 4, 14);
insert into ROOMS (r_id, room_type, floor)
values (88, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (89, 5, 2);
insert into ROOMS (r_id, room_type, floor)
values (90, 4, 6);
insert into ROOMS (r_id, room_type, floor)
values (91, 2, 9);
insert into ROOMS (r_id, room_type, floor)
values (92, 3, 2);
insert into ROOMS (r_id, room_type, floor)
values (93, 2, 8);
insert into ROOMS (r_id, room_type, floor)
values (94, 2, 9);
insert into ROOMS (r_id, room_type, floor)
values (95, 5, 3);
insert into ROOMS (r_id, room_type, floor)
values (96, 3, 3);
insert into ROOMS (r_id, room_type, floor)
values (97, 1, 9);
insert into ROOMS (r_id, room_type, floor)
values (98, 4, 4);
insert into ROOMS (r_id, room_type, floor)
values (99, 4, 4);
insert into ROOMS (r_id, room_type, floor)
values (100, 5, 5);
insert into ROOMS (r_id, room_type, floor)
values (101, 3, 10);
commit;
prompt 500 records committed...
insert into ROOMS (r_id, room_type, floor)
values (818, 2, null);
insert into ROOMS (r_id, room_type, floor)
values (999, 3, null);
insert into ROOMS (r_id, room_type, floor)
values (980, 3, null);
commit;
prompt 503 records loaded
prompt Loading BOOKINGROOMS...
insert into BOOKINGROOMS (r_id, b_id)
values (2, 451);
insert into BOOKINGROOMS (r_id, b_id)
values (2, 585);
insert into BOOKINGROOMS (r_id, b_id)
values (8, 428);
insert into BOOKINGROOMS (r_id, b_id)
values (10, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (13, 207);
insert into BOOKINGROOMS (r_id, b_id)
values (13, 211);
insert into BOOKINGROOMS (r_id, b_id)
values (13, 564);
insert into BOOKINGROOMS (r_id, b_id)
values (19, 300);
insert into BOOKINGROOMS (r_id, b_id)
values (19, 731);
insert into BOOKINGROOMS (r_id, b_id)
values (22, 408);
insert into BOOKINGROOMS (r_id, b_id)
values (23, 322);
insert into BOOKINGROOMS (r_id, b_id)
values (24, 122);
insert into BOOKINGROOMS (r_id, b_id)
values (28, 848);
insert into BOOKINGROOMS (r_id, b_id)
values (32, 493);
insert into BOOKINGROOMS (r_id, b_id)
values (47, 342);
insert into BOOKINGROOMS (r_id, b_id)
values (48, 308);
insert into BOOKINGROOMS (r_id, b_id)
values (55, 41);
insert into BOOKINGROOMS (r_id, b_id)
values (55, 786);
insert into BOOKINGROOMS (r_id, b_id)
values (61, 425);
insert into BOOKINGROOMS (r_id, b_id)
values (64, 499);
insert into BOOKINGROOMS (r_id, b_id)
values (69, 40);
insert into BOOKINGROOMS (r_id, b_id)
values (71, 665);
insert into BOOKINGROOMS (r_id, b_id)
values (74, 295);
insert into BOOKINGROOMS (r_id, b_id)
values (76, 476);
insert into BOOKINGROOMS (r_id, b_id)
values (76, 867);
insert into BOOKINGROOMS (r_id, b_id)
values (77, 194);
insert into BOOKINGROOMS (r_id, b_id)
values (89, 536);
insert into BOOKINGROOMS (r_id, b_id)
values (89, 786);
insert into BOOKINGROOMS (r_id, b_id)
values (90, 719);
insert into BOOKINGROOMS (r_id, b_id)
values (93, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (100, 745);
insert into BOOKINGROOMS (r_id, b_id)
values (102, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (103, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (104, 133);
insert into BOOKINGROOMS (r_id, b_id)
values (104, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (105, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (109, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (109, 882);
insert into BOOKINGROOMS (r_id, b_id)
values (118, 556);
insert into BOOKINGROOMS (r_id, b_id)
values (118, 934);
insert into BOOKINGROOMS (r_id, b_id)
values (126, 668);
insert into BOOKINGROOMS (r_id, b_id)
values (134, 719);
insert into BOOKINGROOMS (r_id, b_id)
values (135, 137);
insert into BOOKINGROOMS (r_id, b_id)
values (135, 934);
insert into BOOKINGROOMS (r_id, b_id)
values (138, 118);
insert into BOOKINGROOMS (r_id, b_id)
values (143, 210);
insert into BOOKINGROOMS (r_id, b_id)
values (144, 374);
insert into BOOKINGROOMS (r_id, b_id)
values (144, 689);
insert into BOOKINGROOMS (r_id, b_id)
values (150, 339);
insert into BOOKINGROOMS (r_id, b_id)
values (153, 934);
insert into BOOKINGROOMS (r_id, b_id)
values (156, 251);
insert into BOOKINGROOMS (r_id, b_id)
values (158, 178);
insert into BOOKINGROOMS (r_id, b_id)
values (159, 555);
insert into BOOKINGROOMS (r_id, b_id)
values (159, 872);
insert into BOOKINGROOMS (r_id, b_id)
values (160, 872);
insert into BOOKINGROOMS (r_id, b_id)
values (161, 872);
insert into BOOKINGROOMS (r_id, b_id)
values (162, 872);
insert into BOOKINGROOMS (r_id, b_id)
values (164, 28);
insert into BOOKINGROOMS (r_id, b_id)
values (167, 697);
insert into BOOKINGROOMS (r_id, b_id)
values (168, 36);
insert into BOOKINGROOMS (r_id, b_id)
values (170, 839);
insert into BOOKINGROOMS (r_id, b_id)
values (175, 40);
insert into BOOKINGROOMS (r_id, b_id)
values (177, 128);
insert into BOOKINGROOMS (r_id, b_id)
values (179, 570);
insert into BOOKINGROOMS (r_id, b_id)
values (180, 1);
insert into BOOKINGROOMS (r_id, b_id)
values (180, 107);
insert into BOOKINGROOMS (r_id, b_id)
values (182, 872);
insert into BOOKINGROOMS (r_id, b_id)
values (184, 667);
insert into BOOKINGROOMS (r_id, b_id)
values (189, 872);
insert into BOOKINGROOMS (r_id, b_id)
values (193, 783);
insert into BOOKINGROOMS (r_id, b_id)
values (194, 644);
insert into BOOKINGROOMS (r_id, b_id)
values (197, 903);
insert into BOOKINGROOMS (r_id, b_id)
values (207, 500);
insert into BOOKINGROOMS (r_id, b_id)
values (207, 900);
insert into BOOKINGROOMS (r_id, b_id)
values (208, 808);
insert into BOOKINGROOMS (r_id, b_id)
values (208, 818);
insert into BOOKINGROOMS (r_id, b_id)
values (210, 777);
insert into BOOKINGROOMS (r_id, b_id)
values (211, 987);
insert into BOOKINGROOMS (r_id, b_id)
values (212, 428);
insert into BOOKINGROOMS (r_id, b_id)
values (213, 867);
insert into BOOKINGROOMS (r_id, b_id)
values (216, 567);
insert into BOOKINGROOMS (r_id, b_id)
values (218, 19);
insert into BOOKINGROOMS (r_id, b_id)
values (218, 818);
insert into BOOKINGROOMS (r_id, b_id)
values (219, 283);
insert into BOOKINGROOMS (r_id, b_id)
values (219, 648);
insert into BOOKINGROOMS (r_id, b_id)
values (221, 552);
insert into BOOKINGROOMS (r_id, b_id)
values (222, 805);
insert into BOOKINGROOMS (r_id, b_id)
values (226, 900);
insert into BOOKINGROOMS (r_id, b_id)
values (226, 934);
insert into BOOKINGROOMS (r_id, b_id)
values (234, 245);
insert into BOOKINGROOMS (r_id, b_id)
values (239, 644);
insert into BOOKINGROOMS (r_id, b_id)
values (241, 716);
insert into BOOKINGROOMS (r_id, b_id)
values (243, 632);
insert into BOOKINGROOMS (r_id, b_id)
values (249, 811);
insert into BOOKINGROOMS (r_id, b_id)
values (250, 181);
insert into BOOKINGROOMS (r_id, b_id)
values (250, 398);
insert into BOOKINGROOMS (r_id, b_id)
values (253, 207);
insert into BOOKINGROOMS (r_id, b_id)
values (257, 552);
insert into BOOKINGROOMS (r_id, b_id)
values (258, 900);
insert into BOOKINGROOMS (r_id, b_id)
values (262, 19);
commit;
prompt 100 records committed...
insert into BOOKINGROOMS (r_id, b_id)
values (264, 766);
insert into BOOKINGROOMS (r_id, b_id)
values (268, 837);
insert into BOOKINGROOMS (r_id, b_id)
values (270, 735);
insert into BOOKINGROOMS (r_id, b_id)
values (281, 408);
insert into BOOKINGROOMS (r_id, b_id)
values (288, 938);
insert into BOOKINGROOMS (r_id, b_id)
values (292, 605);
insert into BOOKINGROOMS (r_id, b_id)
values (296, 513);
insert into BOOKINGROOMS (r_id, b_id)
values (298, 584);
insert into BOOKINGROOMS (r_id, b_id)
values (305, 946);
insert into BOOKINGROOMS (r_id, b_id)
values (310, 828);
insert into BOOKINGROOMS (r_id, b_id)
values (312, 670);
insert into BOOKINGROOMS (r_id, b_id)
values (316, 38);
insert into BOOKINGROOMS (r_id, b_id)
values (319, 736);
insert into BOOKINGROOMS (r_id, b_id)
values (328, 719);
insert into BOOKINGROOMS (r_id, b_id)
values (330, 589);
insert into BOOKINGROOMS (r_id, b_id)
values (336, 180);
insert into BOOKINGROOMS (r_id, b_id)
values (336, 997);
insert into BOOKINGROOMS (r_id, b_id)
values (338, 408);
insert into BOOKINGROOMS (r_id, b_id)
values (339, 735);
insert into BOOKINGROOMS (r_id, b_id)
values (347, 289);
insert into BOOKINGROOMS (r_id, b_id)
values (350, 534);
insert into BOOKINGROOMS (r_id, b_id)
values (352, 945);
insert into BOOKINGROOMS (r_id, b_id)
values (359, 103);
insert into BOOKINGROOMS (r_id, b_id)
values (361, 701);
insert into BOOKINGROOMS (r_id, b_id)
values (361, 805);
insert into BOOKINGROOMS (r_id, b_id)
values (369, 120);
insert into BOOKINGROOMS (r_id, b_id)
values (370, 820);
insert into BOOKINGROOMS (r_id, b_id)
values (373, 662);
insert into BOOKINGROOMS (r_id, b_id)
values (374, 900);
insert into BOOKINGROOMS (r_id, b_id)
values (386, 513);
insert into BOOKINGROOMS (r_id, b_id)
values (391, 808);
insert into BOOKINGROOMS (r_id, b_id)
values (402, 644);
insert into BOOKINGROOMS (r_id, b_id)
values (403, 719);
insert into BOOKINGROOMS (r_id, b_id)
values (404, 189);
insert into BOOKINGROOMS (r_id, b_id)
values (409, 126);
insert into BOOKINGROOMS (r_id, b_id)
values (413, 339);
insert into BOOKINGROOMS (r_id, b_id)
values (413, 648);
insert into BOOKINGROOMS (r_id, b_id)
values (414, 500);
insert into BOOKINGROOMS (r_id, b_id)
values (415, 251);
insert into BOOKINGROOMS (r_id, b_id)
values (419, 590);
insert into BOOKINGROOMS (r_id, b_id)
values (422, 766);
insert into BOOKINGROOMS (r_id, b_id)
values (429, 65);
insert into BOOKINGROOMS (r_id, b_id)
values (432, 76);
insert into BOOKINGROOMS (r_id, b_id)
values (435, 169);
insert into BOOKINGROOMS (r_id, b_id)
values (435, 694);
insert into BOOKINGROOMS (r_id, b_id)
values (440, 165);
insert into BOOKINGROOMS (r_id, b_id)
values (450, 882);
insert into BOOKINGROOMS (r_id, b_id)
values (452, 59);
insert into BOOKINGROOMS (r_id, b_id)
values (456, 513);
insert into BOOKINGROOMS (r_id, b_id)
values (465, 426);
insert into BOOKINGROOMS (r_id, b_id)
values (472, 589);
insert into BOOKINGROOMS (r_id, b_id)
values (474, 942);
insert into BOOKINGROOMS (r_id, b_id)
values (479, 289);
insert into BOOKINGROOMS (r_id, b_id)
values (480, 828);
insert into BOOKINGROOMS (r_id, b_id)
values (481, 123);
insert into BOOKINGROOMS (r_id, b_id)
values (483, 59);
insert into BOOKINGROOMS (r_id, b_id)
values (484, 371);
insert into BOOKINGROOMS (r_id, b_id)
values (492, 734);
insert into BOOKINGROOMS (r_id, b_id)
values (493, 805);
insert into BOOKINGROOMS (r_id, b_id)
values (495, 217);
insert into BOOKINGROOMS (r_id, b_id)
values (499, 196);
insert into BOOKINGROOMS (r_id, b_id)
values (818, 818);
insert into BOOKINGROOMS (r_id, b_id)
values (980, 744);
insert into BOOKINGROOMS (r_id, b_id)
values (999, 45);
commit;
prompt 164 records loaded
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
values (636, 'McGoohan', 12, 54, 202);
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
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4917, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4918, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4919, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4920, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4921, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4922, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4923, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4924, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4925, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4926, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4927, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4928, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4929, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4930, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4931, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4932, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4933, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4934, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4935, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4936, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4937, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4938, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4939, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4940, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4941, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4942, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4943, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4944, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4945, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4946, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4710, 'N', 636);
insert into BOOKSTOBORROW (booknumber, isborrow, bookid)
values (4711, 'N', 636);
commit;
prompt 172 records loaded
prompt Loading EMPLOYES...
insert into EMPLOYES (position, e_id, salary)
values (' ', 135, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Counter Clerk', 785, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Counter Clerk', 75, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Driver', 15, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Driver', 155, 4177.248169415651);
insert into EMPLOYES (position, e_id, salary)
values ('Driver', 125, 4177.248169415651);
insert into EMPLOYES (position, e_id, salary)
values ('Counter Clerk', 725, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Shift Manager', 123, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Bartender', 258, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Driver', 332, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('child operator', 711, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('lifeguard', 369, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('Internal driver', 856, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('lifeguard', 748, 1331);
insert into EMPLOYES (position, e_id, salary)
values ('Driver', 145, 1100);
insert into EMPLOYES (position, e_id, salary)
values (' ', 165, 1000);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 522, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 273, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 446, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 870, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 977, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 814, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 454, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 269, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 277, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 960, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 865, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 479, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 252, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 975, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 718, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 218, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 739, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 680, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 284, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 586, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 771, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 358, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 887, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 468, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 939, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 459, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 881, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 500, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 588, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 493, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 867, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 385, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 464, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 741, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 338, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 911, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 484, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 545, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 599, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 422, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 831, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 512, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 209, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 997, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 902, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 732, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 788, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 558, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 246, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 817, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 503, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 418, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 386, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 766, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 852, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 980, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 715, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 492, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 316, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 362, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 676, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 249, null);
insert into EMPLOYES (position, e_id, salary)
values ('LIBRARIAN', 368, null);
commit;
prompt 79 records loaded
prompt Loading LIBRARIANS...
insert into LIBRARIANS (libraryid, phonenumber)
values (522, '1822952929');
insert into LIBRARIANS (libraryid, phonenumber)
values (273, '855336070');
insert into LIBRARIANS (libraryid, phonenumber)
values (446, '1969914302');
insert into LIBRARIANS (libraryid, phonenumber)
values (870, '1545690284');
insert into LIBRARIANS (libraryid, phonenumber)
values (977, '1254977408');
insert into LIBRARIANS (libraryid, phonenumber)
values (711, '2041222785');
insert into LIBRARIANS (libraryid, phonenumber)
values (814, '2769089421');
insert into LIBRARIANS (libraryid, phonenumber)
values (454, '1960550408');
insert into LIBRARIANS (libraryid, phonenumber)
values (269, '2354760688');
insert into LIBRARIANS (libraryid, phonenumber)
values (277, '3628971427');
insert into LIBRARIANS (libraryid, phonenumber)
values (960, '3952093731');
insert into LIBRARIANS (libraryid, phonenumber)
values (865, '3700676284');
insert into LIBRARIANS (libraryid, phonenumber)
values (479, '2709051707');
insert into LIBRARIANS (libraryid, phonenumber)
values (252, '1875622692');
insert into LIBRARIANS (libraryid, phonenumber)
values (975, '2381876430');
insert into LIBRARIANS (libraryid, phonenumber)
values (718, '1280970467');
insert into LIBRARIANS (libraryid, phonenumber)
values (218, '2101385291');
insert into LIBRARIANS (libraryid, phonenumber)
values (739, '2101556339');
insert into LIBRARIANS (libraryid, phonenumber)
values (680, '2572058709');
insert into LIBRARIANS (libraryid, phonenumber)
values (284, '544577504');
insert into LIBRARIANS (libraryid, phonenumber)
values (586, '1969625318');
insert into LIBRARIANS (libraryid, phonenumber)
values (771, '1048357220');
insert into LIBRARIANS (libraryid, phonenumber)
values (358, '3482661399');
insert into LIBRARIANS (libraryid, phonenumber)
values (887, '2521715065');
insert into LIBRARIANS (libraryid, phonenumber)
values (468, '755713297');
insert into LIBRARIANS (libraryid, phonenumber)
values (939, '1710392529');
insert into LIBRARIANS (libraryid, phonenumber)
values (459, '3032021502');
insert into LIBRARIANS (libraryid, phonenumber)
values (881, '2267563000');
insert into LIBRARIANS (libraryid, phonenumber)
values (500, '4219606693');
insert into LIBRARIANS (libraryid, phonenumber)
values (588, '1800904403');
insert into LIBRARIANS (libraryid, phonenumber)
values (493, '990392438');
insert into LIBRARIANS (libraryid, phonenumber)
values (867, '3058336359');
insert into LIBRARIANS (libraryid, phonenumber)
values (385, '1464187541');
insert into LIBRARIANS (libraryid, phonenumber)
values (464, '3358075594');
insert into LIBRARIANS (libraryid, phonenumber)
values (741, '1366774318');
insert into LIBRARIANS (libraryid, phonenumber)
values (338, '3301422893');
insert into LIBRARIANS (libraryid, phonenumber)
values (911, '1201380109');
insert into LIBRARIANS (libraryid, phonenumber)
values (484, '4151869327');
insert into LIBRARIANS (libraryid, phonenumber)
values (545, '514570588');
insert into LIBRARIANS (libraryid, phonenumber)
values (599, '1604542899');
insert into LIBRARIANS (libraryid, phonenumber)
values (422, '3486150328');
insert into LIBRARIANS (libraryid, phonenumber)
values (831, '3534522594');
insert into LIBRARIANS (libraryid, phonenumber)
values (512, '1171737620');
insert into LIBRARIANS (libraryid, phonenumber)
values (209, '1063890086');
insert into LIBRARIANS (libraryid, phonenumber)
values (997, '4163013106');
insert into LIBRARIANS (libraryid, phonenumber)
values (902, '1051049363');
insert into LIBRARIANS (libraryid, phonenumber)
values (732, '3783666090');
insert into LIBRARIANS (libraryid, phonenumber)
values (788, '2814909602');
insert into LIBRARIANS (libraryid, phonenumber)
values (558, '3949415267');
insert into LIBRARIANS (libraryid, phonenumber)
values (246, '2399781773');
insert into LIBRARIANS (libraryid, phonenumber)
values (817, '3374694696');
insert into LIBRARIANS (libraryid, phonenumber)
values (503, '3284946845');
insert into LIBRARIANS (libraryid, phonenumber)
values (418, '1793010860');
insert into LIBRARIANS (libraryid, phonenumber)
values (386, '3044671463');
insert into LIBRARIANS (libraryid, phonenumber)
values (766, '676733936');
insert into LIBRARIANS (libraryid, phonenumber)
values (852, '3464848730');
insert into LIBRARIANS (libraryid, phonenumber)
values (980, '1691430600');
insert into LIBRARIANS (libraryid, phonenumber)
values (715, '3999374747');
insert into LIBRARIANS (libraryid, phonenumber)
values (492, '3805448636');
insert into LIBRARIANS (libraryid, phonenumber)
values (316, '1963984882');
insert into LIBRARIANS (libraryid, phonenumber)
values (362, '2013035899');
insert into LIBRARIANS (libraryid, phonenumber)
values (676, '2511897625');
insert into LIBRARIANS (libraryid, phonenumber)
values (249, '3237057293');
insert into LIBRARIANS (libraryid, phonenumber)
values (368, '2745031584');
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
prompt Loading WORK...
insert into WORK (e_id, a_id)
values (123, 78);
insert into WORK (e_id, a_id)
values (123, 596);
insert into WORK (e_id, a_id)
values (125, 20);
insert into WORK (e_id, a_id)
values (145, 78);
insert into WORK (e_id, a_id)
values (145, 393);
insert into WORK (e_id, a_id)
values (155, 20);
insert into WORK (e_id, a_id)
values (258, 824);
insert into WORK (e_id, a_id)
values (369, 389);
insert into WORK (e_id, a_id)
values (711, 45);
insert into WORK (e_id, a_id)
values (711, 389);
insert into WORK (e_id, a_id)
values (748, 45);
insert into WORK (e_id, a_id)
values (748, 78);
insert into WORK (e_id, a_id)
values (748, 298);
insert into WORK (e_id, a_id)
values (748, 389);
insert into WORK (e_id, a_id)
values (748, 392);
insert into WORK (e_id, a_id)
values (748, 393);
insert into WORK (e_id, a_id)
values (748, 502);
insert into WORK (e_id, a_id)
values (748, 527);
insert into WORK (e_id, a_id)
values (748, 552);
insert into WORK (e_id, a_id)
values (748, 596);
insert into WORK (e_id, a_id)
values (748, 759);
insert into WORK (e_id, a_id)
values (748, 794);
insert into WORK (e_id, a_id)
values (748, 824);
insert into WORK (e_id, a_id)
values (856, 552);
commit;
prompt 24 records loaded
prompt Enabling foreign key constraints for AUTHORS...
alter table AUTHORS enable constraint FK_PID1;
prompt Enabling foreign key constraints for CUSTOMERS...
alter table CUSTOMERS enable constraint FK_PID;
prompt Enabling foreign key constraints for BOOKING...
alter table BOOKING enable constraint FK_BOOKING_ID;
alter table BOOKING enable constraint SYS_C007285;
prompt Enabling foreign key constraints for BOOKINGACTIVITIES...
alter table BOOKINGACTIVITIES enable constraint SYS_C007290;
alter table BOOKINGACTIVITIES enable constraint SYS_C007291;
prompt Enabling foreign key constraints for BOOKINGROOMS...
alter table BOOKINGROOMS enable constraint SYS_C007298;
alter table BOOKINGROOMS enable constraint SYS_C007299;
prompt Enabling foreign key constraints for BOOKSCATALOG...
alter table BOOKSCATALOG enable constraint FK_BOOKSCATALOGID;
alter table BOOKSCATALOG enable constraint SYS_C007052;
prompt Enabling foreign key constraints for BOOKSTOBORROW...
alter table BOOKSTOBORROW enable constraint SYS_C007057;
prompt Enabling foreign key constraints for EMPLOYES...
alter table EMPLOYES enable constraint FK_PID2;
prompt Enabling foreign key constraints for LIBRARIANS...
alter table LIBRARIANS enable constraint FK_PID3;
prompt Enabling foreign key constraints for BORROWS...
alter table BORROWS enable constraint FK_BORROWID;
alter table BORROWS enable constraint FK_BORROWS_ID;
alter table BORROWS enable constraint SYS_C007063;
prompt Enabling foreign key constraints for WORK...
alter table WORK enable constraint FK_WORKID;
alter table WORK enable constraint SYS_C007308;
prompt Enabling triggers for ACTIVITIES...
alter table ACTIVITIES enable all triggers;
prompt Enabling triggers for PERSON...
alter table PERSON enable all triggers;
prompt Enabling triggers for AUTHORS...
alter table AUTHORS enable all triggers;
prompt Enabling triggers for CUSTOMERS...
alter table CUSTOMERS enable all triggers;
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for BOOKING...
alter table BOOKING enable all triggers;
prompt Enabling triggers for BOOKINGACTIVITIES...
alter table BOOKINGACTIVITIES enable all triggers;
prompt Enabling triggers for ROOMS...
alter table ROOMS enable all triggers;
prompt Enabling triggers for BOOKINGROOMS...
alter table BOOKINGROOMS enable all triggers;
prompt Enabling triggers for CATEGORIES...
alter table CATEGORIES enable all triggers;
prompt Enabling triggers for BOOKSCATALOG...
alter table BOOKSCATALOG enable all triggers;
prompt Enabling triggers for BOOKSTOBORROW...
alter table BOOKSTOBORROW enable all triggers;
prompt Enabling triggers for EMPLOYES...
alter table EMPLOYES enable all triggers;
prompt Enabling triggers for LIBRARIANS...
alter table LIBRARIANS enable all triggers;
prompt Enabling triggers for BORROWS...
alter table BORROWS enable all triggers;
prompt Enabling triggers for WORK...
alter table WORK enable all triggers;
set feedback on
set define on
prompt Done.
