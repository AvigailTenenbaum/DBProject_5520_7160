prompt PL/SQL Developer Export Tables for user HOTEL@XE
prompt Created by linoy on Sunday, June 30, 2024
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVITIES
  add primary key (A_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CUSTOMER...
create table CUSTOMER
(
  c_id  INTEGER not null,
  name  VARCHAR2(15) not null,
  email VARCHAR2(15) not null,
  phone INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMER
  add primary key (C_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CUSTOMER
  add constraint CHECK_EMAIL_FORMAT
  check (INSTR(email, '@') > 0);
alter table CUSTOMER
  add constraint CHECK_PHONE_FORMAT
  check (REGEXP_LIKE(phone, '^[0-9]+$'));

prompt Creating PAYMENT...
create table PAYMENT
(
  p_id         INTEGER not null,
  cost         FLOAT not null,
  payment_date DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PAYMENT
  add primary key (P_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating BOOKING...
create table BOOKING
(
  b_id      INTEGER not null,
  check_in  DATE not null,
  check_out DATE not null,
  c_id      INTEGER not null,
  p_id      INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BOOKING
  add primary key (B_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BOOKING
  add foreign key (C_ID)
  references CUSTOMER (C_ID);
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BOOKINGACTIVITIES
  add primary key (B_ID, A_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOMS
  add primary key (R_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating BOOKINGROOMS...
create table BOOKINGROOMS
(
  r_id INTEGER not null,
  b_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BOOKINGROOMS
  add primary key (R_ID, B_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BOOKINGROOMS
  add foreign key (R_ID)
  references ROOMS (R_ID);
alter table BOOKINGROOMS
  add foreign key (B_ID)
  references BOOKING (B_ID);

prompt Creating EMPLOYES...
create table EMPLOYES
(
  position VARCHAR2(15) default 'Counter Clerk' not null,
  e_id     INTEGER not null,
  name     VARCHAR2(15) not null,
  salary   NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYES
  add primary key (E_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating WORK...
create table WORK
(
  e_id INTEGER not null,
  a_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WORK
  add primary key (E_ID, A_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table WORK
  add foreign key (E_ID)
  references EMPLOYES (E_ID);
alter table WORK
  add foreign key (A_ID)
  references ACTIVITIES (A_ID);

prompt Disabling triggers for ACTIVITIES...
alter table ACTIVITIES disable all triggers;
prompt Disabling triggers for CUSTOMER...
alter table CUSTOMER disable all triggers;
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
prompt Disabling triggers for EMPLOYES...
alter table EMPLOYES disable all triggers;
prompt Disabling triggers for WORK...
alter table WORK disable all triggers;
prompt Disabling foreign key constraints for BOOKING...
alter table BOOKING disable constraint SYS_C007176;
alter table BOOKING disable constraint SYS_C007177;
prompt Disabling foreign key constraints for BOOKINGACTIVITIES...
alter table BOOKINGACTIVITIES disable constraint SYS_C007198;
alter table BOOKINGACTIVITIES disable constraint SYS_C007199;
prompt Disabling foreign key constraints for BOOKINGROOMS...
alter table BOOKINGROOMS disable constraint SYS_C007181;
alter table BOOKINGROOMS disable constraint SYS_C007182;
prompt Disabling foreign key constraints for WORK...
alter table WORK disable constraint SYS_C007203;
alter table WORK disable constraint SYS_C007204;
prompt Deleting WORK...
delete from WORK;
commit;
prompt Deleting EMPLOYES...
delete from EMPLOYES;
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
prompt Deleting CUSTOMER...
delete from CUSTOMER;
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
prompt Loading CUSTOMER...
insert into CUSTOMER (c_id, name, email, phone)
values (51, 'Adrien-Mazzello', 'Adrien@com', 566210363);
insert into CUSTOMER (c_id, name, email, phone)
values (418, 'Fats-Reid', 'freid@gulfmarko', 514946733);
insert into CUSTOMER (c_id, name, email, phone)
values (10, 'Andie-Wincott', 'andie.wincott@i', 597372755);
insert into CUSTOMER (c_id, name, email, phone)
values (773, 'Emerson-Mazzell', 'Emerson@com', 586266769);
insert into CUSTOMER (c_id, name, email, phone)
values (461, 'Julie-MacNeil', 'julie@hardwoodw', 563243255);
insert into CUSTOMER (c_id, name, email, phone)
values (186, 'Dean-Doucette', 'deand@aoltimewa', 500468634);
insert into CUSTOMER (c_id, name, email, phone)
values (557, 'Ming-Na-Warwick', 'm.warwick@mathi', 550385608);
insert into CUSTOMER (c_id, name, email, phone)
values (962, 'Cloris-Hersh', 'cloris.hersh@tm', 529501669);
insert into CUSTOMER (c_id, name, email, phone)
values (331, 'Shelby-Vaughn', 'shelby.vaughn@p', 528085164);
insert into CUSTOMER (c_id, name, email, phone)
values (369, 'Celia-Busey', 'celia.busey@mse', 562943580);
insert into CUSTOMER (c_id, name, email, phone)
values (431, 'Rade-Copeland', 'rade@reckittben', 526644244);
insert into CUSTOMER (c_id, name, email, phone)
values (780, 'Tyrone-Hobson', 'tyrone.hobson@f', 522068771);
insert into CUSTOMER (c_id, name, email, phone)
values (379, 'Bo-Shearer', 'bos@kellogg.au', 548834565);
insert into CUSTOMER (c_id, name, email, phone)
values (948, 'Carol-O''Neal', 'carol@operation', 580643797);
insert into CUSTOMER (c_id, name, email, phone)
values (279, 'Rutger-Manning', 'rutger.manning@', 550315543);
insert into CUSTOMER (c_id, name, email, phone)
values (64, 'Lucy-Speaks', 'lucy@pscinfogro', 505391683);
insert into CUSTOMER (c_id, name, email, phone)
values (521, 'Vonda-Glover', 'vonda.glover@gr', 596258447);
insert into CUSTOMER (c_id, name, email, phone)
values (798, 'Sara-Garza', 'sara.garza@huds', 509054885);
insert into CUSTOMER (c_id, name, email, phone)
values (22, 'Heath-Dourif', 'heath@fmt.de', 553866012);
insert into CUSTOMER (c_id, name, email, phone)
values (695, 'Heath-Quatro', 'heath.quatro@te', 546657501);
insert into CUSTOMER (c_id, name, email, phone)
values (284, 'Armand-Hornsby', 'armand.hornsby@', 544400518);
insert into CUSTOMER (c_id, name, email, phone)
values (206, 'Domingo-Platt', 'domingo.p@offic', 566532025);
insert into CUSTOMER (c_id, name, email, phone)
values (630, 'Don-Witt', 'don.witt@painte', 584446326);
insert into CUSTOMER (c_id, name, email, phone)
values (156, 'Russell-Raye', 'rraye@speakeasy', 565329024);
insert into CUSTOMER (c_id, name, email, phone)
values (327, 'Shawn-Dale', 's.dale@ssci.uk', 544577892);
insert into CUSTOMER (c_id, name, email, phone)
values (345, 'Rosie-Close', 'rosie.close@inn', 550039075);
insert into CUSTOMER (c_id, name, email, phone)
values (761, 'Vince-Sinise', 'vince.sinise@ca', 587445070);
insert into CUSTOMER (c_id, name, email, phone)
values (355, 'Alfie-Matheson', 'alfie@pioneerda', 521088992);
insert into CUSTOMER (c_id, name, email, phone)
values (568, 'Bonnie-Wopat', 'bonnie.wopat@ne', 576914464);
insert into CUSTOMER (c_id, name, email, phone)
values (996, 'Gena-Blanchett', 'gena.b@apexsyst', 558889627);
insert into CUSTOMER (c_id, name, email, phone)
values (804, 'Clea-Eat World', 'clea.eatworld@a', 526439088);
insert into CUSTOMER (c_id, name, email, phone)
values (713, 'Lee-Dourif', 'l.dourif@infini', 524108554);
insert into CUSTOMER (c_id, name, email, phone)
values (320, 'Edwin-Feliciano', 'edwinf@asa.com', 586706651);
insert into CUSTOMER (c_id, name, email, phone)
values (848, 'Junior-Sorvino', 'junior.s@safeho', 514637033);
insert into CUSTOMER (c_id, name, email, phone)
values (244, 'Kenny-Dalton', 'kenny@abs.com', 594643166);
insert into CUSTOMER (c_id, name, email, phone)
values (567, 'Nicolas-Pierce', 'nicolas.pierce@', 599007423);
insert into CUSTOMER (c_id, name, email, phone)
values (691, 'Kirsten-Osmond', 'kirsten.osmond@', 520725745);
insert into CUSTOMER (c_id, name, email, phone)
values (340, 'Wendy-Affleck', 'w.affleck@fnb.v', 599005659);
insert into CUSTOMER (c_id, name, email, phone)
values (18, 'Colm-Tarantino', 'colm.tarantino@', 565980161);
insert into CUSTOMER (c_id, name, email, phone)
values (134, 'Suzi-Crystal', 'suzi.crystal@my', 591668988);
insert into CUSTOMER (c_id, name, email, phone)
values (122, 'Wally-Hopper', 'wally.hopper@tr', 531776631);
insert into CUSTOMER (c_id, name, email, phone)
values (363, 'Delroy-Edmunds', 'delroy.edmunds@', 559712729);
insert into CUSTOMER (c_id, name, email, phone)
values (816, 'Curtis-Van Der ', 'curtis.v@pulask', 528479483);
insert into CUSTOMER (c_id, name, email, phone)
values (942, 'Johnny-Brolin', 'j.brolin@perfec', 519183181);
insert into CUSTOMER (c_id, name, email, phone)
values (272, 'Mandy-Martinez', 'mandy.martinez@', 503286120);
insert into CUSTOMER (c_id, name, email, phone)
values (999, 'Yaphet-Reno', 'yaphet.reno@kni', 541788737);
insert into CUSTOMER (c_id, name, email, phone)
values (295, 'Brad-McCann', 'brad@tripwire.b', 516396403);
insert into CUSTOMER (c_id, name, email, phone)
values (268, 'Famke-Emmerich', 'famkee@solipsys', 529634949);
insert into CUSTOMER (c_id, name, email, phone)
values (455, 'Rachael-Pullman', 'rpullman@health', 551473364);
insert into CUSTOMER (c_id, name, email, phone)
values (66, 'Meredith-Vinton', 'Meredith@com', 564622237);
insert into CUSTOMER (c_id, name, email, phone)
values (296, 'Dwight-Bell', 'dwight.bell@tot', 553670508);
insert into CUSTOMER (c_id, name, email, phone)
values (810, 'Mili-Phillips', 'milip@jsa.uk', 556262443);
insert into CUSTOMER (c_id, name, email, phone)
values (256, 'Kathleen-Biggs', 'kathleen.b@tlss', 590347346);
insert into CUSTOMER (c_id, name, email, phone)
values (83, 'Janice-Chaplin', 'janice.chaplin@', 566061715);
insert into CUSTOMER (c_id, name, email, phone)
values (118, 'Etta-Curfman', 'etta@sis.mx', 575591942);
insert into CUSTOMER (c_id, name, email, phone)
values (224, 'Renee-Goldwyn', 'renee.goldwyn@l', 526855509);
insert into CUSTOMER (c_id, name, email, phone)
values (257, 'Milla-Buscemi', 'milla.buscemi@a', 535359080);
insert into CUSTOMER (c_id, name, email, phone)
values (910, 'Debbie-Buscemi', 'dbuscemi@biorel', 517952566);
insert into CUSTOMER (c_id, name, email, phone)
values (953, 'Liev-Sedaka', 'liev@totalenter', 581094251);
insert into CUSTOMER (c_id, name, email, phone)
values (728, 'Rutger-Peebles', 'rutger.peebles@', 506686585);
insert into CUSTOMER (c_id, name, email, phone)
values (390, 'Jonny Lee-Berry', 'jonnylee@bis.it', 585463567);
insert into CUSTOMER (c_id, name, email, phone)
values (333, 'Thelma-Blanchet', 'thelma.b@als.de', 539728016);
insert into CUSTOMER (c_id, name, email, phone)
values (817, 'Lloyd-Colton', 'lloyd.colton@gc', 526407893);
insert into CUSTOMER (c_id, name, email, phone)
values (709, 'Vickie-Hanley', 'vickie.hanley@b', 564801986);
insert into CUSTOMER (c_id, name, email, phone)
values (794, 'Christine-Getty', 'Christine@com', 592870380);
insert into CUSTOMER (c_id, name, email, phone)
values (785, 'Domingo-Feore', 'dfeore@kingston', 501373889);
insert into CUSTOMER (c_id, name, email, phone)
values (940, 'Mae-Hewett', 'mae.hewett@newt', 522239499);
insert into CUSTOMER (c_id, name, email, phone)
values (404, 'Dorry-Balaban', 'dorry.balaban@t', 510841420);
insert into CUSTOMER (c_id, name, email, phone)
values (62, 'Gerald-Butler', 'gerald@ogi.no', 563736759);
insert into CUSTOMER (c_id, name, email, phone)
values (832, 'Natascha-Anders', 'nataschaa@credi', 546147498);
insert into CUSTOMER (c_id, name, email, phone)
values (702, 'Rosanne-Eastwoo', 'reastwood@egrou', 574372259);
insert into CUSTOMER (c_id, name, email, phone)
values (52, 'Jennifer-Berkle', 'Jennifer@com', 561552677);
insert into CUSTOMER (c_id, name, email, phone)
values (384, 'Michelle-Fioren', 'Michelle@com', 529130533);
insert into CUSTOMER (c_id, name, email, phone)
values (356, 'Bette-Ronstadt', 'bette.ronstadt@', 583269588);
insert into CUSTOMER (c_id, name, email, phone)
values (512, 'Sydney-Buckingh', 'Sydney@com', 532392687);
insert into CUSTOMER (c_id, name, email, phone)
values (478, 'Andre-Levert', 'andre.levert@di', 534721499);
insert into CUSTOMER (c_id, name, email, phone)
values (732, 'Busta-McDormand', 'busta@carbocera', 505193965);
insert into CUSTOMER (c_id, name, email, phone)
values (524, 'Laurence-Apple', 'laurence.apple@', 537525752);
insert into CUSTOMER (c_id, name, email, phone)
values (876, 'Bobby-Chaplin', 'bobby.chaplin@h', 525315563);
insert into CUSTOMER (c_id, name, email, phone)
values (844, 'Charlton-Benet', 'cbenet@peerless', 528325603);
insert into CUSTOMER (c_id, name, email, phone)
values (758, 'Terry-Dorn', 'terry.dorn@cold', 574751121);
insert into CUSTOMER (c_id, name, email, phone)
values (110, 'Jarvis-Jones', 'jarvis.jones@ul', 588251574);
insert into CUSTOMER (c_id, name, email, phone)
values (332, 'Steve-Gough', 'steve.gough@sec', 554907041);
insert into CUSTOMER (c_id, name, email, phone)
values (964, 'Aimee-Skerritt', 'aimees@integram', 504427858);
insert into CUSTOMER (c_id, name, email, phone)
values (904, 'Elizabeth-Remar', 'eremar@swp.com', 521931936);
insert into CUSTOMER (c_id, name, email, phone)
values (879, 'Henry-Soda', 'henrys@whitewav', 566342094);
insert into CUSTOMER (c_id, name, email, phone)
values (650, 'Terence-Dutton', 'terence.dutton@', 512189610);
insert into CUSTOMER (c_id, name, email, phone)
values (59, 'Bo-Blair', 'b.blair@priorit', 518323259);
insert into CUSTOMER (c_id, name, email, phone)
values (398, 'Praga-Holliday', 'pragah@flavorx.', 537944782);
insert into CUSTOMER (c_id, name, email, phone)
values (89, 'Buddy-Broadbent', 'buddy.b@procter', 506041835);
insert into CUSTOMER (c_id, name, email, phone)
values (232, 'Maria-Lightfoot', 'maria@serentec.', 588946848);
insert into CUSTOMER (c_id, name, email, phone)
values (491, 'Heather-Sinise', 'h.sinise@unicru', 582661700);
insert into CUSTOMER (c_id, name, email, phone)
values (522, 'Gene-English', 'genglish@ungert', 575534556);
insert into CUSTOMER (c_id, name, email, phone)
values (937, 'Danni-Steiger', 'danni@mss.uk', 505744076);
insert into CUSTOMER (c_id, name, email, phone)
values (547, 'Timothy-Dorff', 'timothy.dorff@h', 553176725);
insert into CUSTOMER (c_id, name, email, phone)
values (56, 'Arnold-Posener', 'arnold.posener@', 568974621);
insert into CUSTOMER (c_id, name, email, phone)
values (142, 'Machine-Winston', 'machine.w@healt', 511166054);
insert into CUSTOMER (c_id, name, email, phone)
values (888, 'Brent-Phillips', 'brent.phillips@', 585420027);
insert into CUSTOMER (c_id, name, email, phone)
values (442, 'Jimmy-Affleck', 'j.affleck@verit', 599736821);
insert into CUSTOMER (c_id, name, email, phone)
values (955, 'Jann-Robards', 'jann.robards@ca', 518672727);
commit;
prompt 100 records committed...
insert into CUSTOMER (c_id, name, email, phone)
values (606, 'Jake-Steenburge', 'jsteenburgen@sp', 570396035);
insert into CUSTOMER (c_id, name, email, phone)
values (183, 'Jeanne-Tierney', 'jeannet@waltdis', 590949453);
insert into CUSTOMER (c_id, name, email, phone)
values (109, 'Alannah-Gandolf', 'agandolfini@esc', 545811766);
insert into CUSTOMER (c_id, name, email, phone)
values (318, 'Roddy-Quinlan', 'roddy.quinlan@v', 538541753);
insert into CUSTOMER (c_id, name, email, phone)
values (965, 'Derek-Knight', 'derek.knight@fa', 542496204);
insert into CUSTOMER (c_id, name, email, phone)
values (287, 'Vanessa-Ball', 'vball@pis.dk', 519361698);
insert into CUSTOMER (c_id, name, email, phone)
values (170, 'Patrick-Gugino', 'patrick.gugino@', 575750733);
insert into CUSTOMER (c_id, name, email, phone)
values (290, 'Jackson-Worrell', 'Jackson@com', 504402670);
insert into CUSTOMER (c_id, name, email, phone)
values (611, 'Teena-Witt', 'teena.witt@cona', 519226943);
insert into CUSTOMER (c_id, name, email, phone)
values (935, 'Ron-Leigh', 'ron.leigh@pib.c', 518185863);
insert into CUSTOMER (c_id, name, email, phone)
values (918, 'Tommy-Avital', 'tommy.avital@at', 528613202);
insert into CUSTOMER (c_id, name, email, phone)
values (833, 'Rik-Irons', 'rirons@parksite', 589010274);
insert into CUSTOMER (c_id, name, email, phone)
values (492, 'Gary-Osment', 'gary.osment@vir', 580573256);
insert into CUSTOMER (c_id, name, email, phone)
values (849, 'Kathy-Potter', 'kathy.potter@ti', 572639062);
insert into CUSTOMER (c_id, name, email, phone)
values (325, 'Anna-Morton', 'anna.morton@cyb', 580642261);
insert into CUSTOMER (c_id, name, email, phone)
values (646, 'Sonny-Carlton', 'sonny@hotmail.c', 555088472);
insert into CUSTOMER (c_id, name, email, phone)
values (536, 'Nora-Shepherd', 'nora.shepherd@a', 528595525);
insert into CUSTOMER (c_id, name, email, phone)
values (555, 'Seth-Caviezel', 'seth.c@fam.in', 551033055);
insert into CUSTOMER (c_id, name, email, phone)
values (641, 'Victoria-Bell', 'vbell@amerisour', 526679205);
insert into CUSTOMER (c_id, name, email, phone)
values (520, 'Dorry-Lennix', 'dorry.lennix@ke', 511932712);
insert into CUSTOMER (c_id, name, email, phone)
values (526, 'Trey-Ripley', 'trey.ripley@nes', 566894948);
insert into CUSTOMER (c_id, name, email, phone)
values (281, 'Andre-Crewson', 'andre.crewson@h', 528654221);
insert into CUSTOMER (c_id, name, email, phone)
values (288, 'Owen-Lunch', 'owen.lunch@trop', 552705988);
insert into CUSTOMER (c_id, name, email, phone)
values (93, 'Liquid-Twilley', 'ltwilley@hfg.co', 532685254);
insert into CUSTOMER (c_id, name, email, phone)
values (63, 'Ahmad-Boothe', 'ahmad.boothe@lo', 587133092);
insert into CUSTOMER (c_id, name, email, phone)
values (781, 'Ethan-Malkovich', 'ethan.m@aoe.it', 511236287);
insert into CUSTOMER (c_id, name, email, phone)
values (700, 'Barry-Cobbs', 'barry.cobbs@swp', 553318309);
insert into CUSTOMER (c_id, name, email, phone)
values (924, 'Mika-Bryson', 'mika.bryson@cim', 557891669);
insert into CUSTOMER (c_id, name, email, phone)
values (506, 'Christina-Lewin', 'Christina@com', 557571813);
insert into CUSTOMER (c_id, name, email, phone)
values (968, 'Nicolas-Ripley', 'nicolas.ripley@', 515319424);
insert into CUSTOMER (c_id, name, email, phone)
values (223, 'Chet-Mollard', 'chet.mollard@mw', 598627790);
insert into CUSTOMER (c_id, name, email, phone)
values (90, 'Darius-LuPone', 'd.lupone@atlant', 580136821);
insert into CUSTOMER (c_id, name, email, phone)
values (326, 'Melanie-von Syd', 'Melanie-von@com', 542735122);
insert into CUSTOMER (c_id, name, email, phone)
values (247, 'Kyle-Rippy', 'krippy@mwp.jp', 521920035);
insert into CUSTOMER (c_id, name, email, phone)
values (553, 'Sigourney-Hauer', 'Sigourney@com', 579503319);
insert into CUSTOMER (c_id, name, email, phone)
values (821, 'John-Steiger', 'john.steiger@nh', 575309736);
insert into CUSTOMER (c_id, name, email, phone)
values (759, 'Denzel-Quinlan', 'denzel.quinlan@', 560757816);
insert into CUSTOMER (c_id, name, email, phone)
values (41, 'Alice-Stevenson', 'alice.s@quicksi', 540389163);
insert into CUSTOMER (c_id, name, email, phone)
values (446, 'Colleen-Garza', 'colleen.g@fpf.b', 551079152);
insert into CUSTOMER (c_id, name, email, phone)
values (527, 'Juliet-McDonald', 'juliet@american', 543453051);
insert into CUSTOMER (c_id, name, email, phone)
values (897, 'Hazel-Marsden', 'hazel.marsden@p', 563931946);
insert into CUSTOMER (c_id, name, email, phone)
values (38, 'Courtney-Sisto', 'courtney.sisto@', 590076900);
insert into CUSTOMER (c_id, name, email, phone)
values (453, 'Curtis-DiCaprio', 'curtisd@bps.ch', 543054287);
insert into CUSTOMER (c_id, name, email, phone)
values (769, 'Alan-Oldman', 'alano@americanp', 591973292);
insert into CUSTOMER (c_id, name, email, phone)
values (868, 'Vertical-Gagnon', 'Vertical@com', 586948276);
insert into CUSTOMER (c_id, name, email, phone)
values (507, 'Derrick-Gayle', 'derrick.gayle@m', 500083436);
insert into CUSTOMER (c_id, name, email, phone)
values (365, 'Jann-Cook', 'jann@educationa', 558092335);
insert into CUSTOMER (c_id, name, email, phone)
values (826, 'Mindy-Rivers', 'mindy.r@north.d', 525721811);
insert into CUSTOMER (c_id, name, email, phone)
values (865, 'Janice-Brosnan', 'janice.brosnan@', 550206406);
insert into CUSTOMER (c_id, name, email, phone)
values (580, 'Colleen-Pony', 'colleen.pony@ep', 565765189);
insert into CUSTOMER (c_id, name, email, phone)
values (316, 'Bernie-Faithful', 'b.faithfull@atl', 509190519);
insert into CUSTOMER (c_id, name, email, phone)
values (640, 'Lionel-Heche', 'lionel.heche@gl', 586591888);
insert into CUSTOMER (c_id, name, email, phone)
values (151, 'Art-Nivola', 'art.n@nexxtwork', 590841242);
insert into CUSTOMER (c_id, name, email, phone)
values (757, 'Barbara-Holiday', 'Barbara@com', 510378742);
insert into CUSTOMER (c_id, name, email, phone)
values (541, 'Hector-Cook', 'hector.cook@tru', 586827280);
insert into CUSTOMER (c_id, name, email, phone)
values (870, 'Wallace-Allison', 'Wallace@com', 589846930);
insert into CUSTOMER (c_id, name, email, phone)
values (583, 'Jarvis-Berkeley', 'jarvis.b@adolph', 579019841);
insert into CUSTOMER (c_id, name, email, phone)
values (317, 'Ed-Rodriguez', 'ed.rodriguez@pr', 575374137);
insert into CUSTOMER (c_id, name, email, phone)
values (642, 'Caroline-Flack', 'carolinef@codyk', 584419682);
insert into CUSTOMER (c_id, name, email, phone)
values (271, 'Alex-Ferrer', 'alex.ferrer@phi', 529912646);
insert into CUSTOMER (c_id, name, email, phone)
values (396, 'Kay-Griffin', 'kay.g@3tsystems', 582495131);
insert into CUSTOMER (c_id, name, email, phone)
values (675, 'Mitchell-Ramis', 'm.ramis@gillett', 564164934);
insert into CUSTOMER (c_id, name, email, phone)
values (187, 'Martin-Hidalgo', 'mhidalgo@sandys', 524864873);
insert into CUSTOMER (c_id, name, email, phone)
values (24, 'Diane-Isaak', 'diane.isaak@avs', 554992496);
insert into CUSTOMER (c_id, name, email, phone)
values (175, 'Russell-Napolit', 'Russell@com', 510913597);
insert into CUSTOMER (c_id, name, email, phone)
values (304, 'Ethan-Rourke', 'ethan.rourke@se', 568248062);
insert into CUSTOMER (c_id, name, email, phone)
values (976, 'Madeline-Danger', 'madelined@mre.d', 554981582);
insert into CUSTOMER (c_id, name, email, phone)
values (487, 'Warren-Sedgwick', 'wsedgwick@ccb.u', 566000445);
insert into CUSTOMER (c_id, name, email, phone)
values (463, 'Jeanne-Parsons', 'jeannep@nobrain', 530345983);
insert into CUSTOMER (c_id, name, email, phone)
values (297, 'Mekhi-Palmieri', 'm.palmieri@apex', 533387065);
insert into CUSTOMER (c_id, name, email, phone)
values (21, 'Ellen-Arjona', 'ellen.arjona@am', 500779268);
insert into CUSTOMER (c_id, name, email, phone)
values (261, 'Franco-O''Neal', 'franco.oneal@fa', 558610569);
insert into CUSTOMER (c_id, name, email, phone)
values (546, 'Loren-Jane', 'loren.jane@john', 546463813);
insert into CUSTOMER (c_id, name, email, phone)
values (417, 'Taye-Lynch', 'taye@genextechn', 513533271);
insert into CUSTOMER (c_id, name, email, phone)
values (312, 'Julia-Hunter', 'j.hunter@ipsadv', 525088344);
insert into CUSTOMER (c_id, name, email, phone)
values (413, 'Franz-Jovovich', 'franzj@carteret', 570051407);
insert into CUSTOMER (c_id, name, email, phone)
values (493, 'Don-Johnson', 'djohnson@integr', 589696903);
insert into CUSTOMER (c_id, name, email, phone)
values (480, 'Fred-Winslet', 'f.winslet@healt', 587504139);
insert into CUSTOMER (c_id, name, email, phone)
values (414, 'Miranda-Feuerst', 'Miranda@com', 526053332);
insert into CUSTOMER (c_id, name, email, phone)
values (19, 'Geoffrey-Shand', 'g.shand@reckitt', 592951346);
insert into CUSTOMER (c_id, name, email, phone)
values (147, 'Lynette-Jovovic', 'Lynette@com', 555828518);
insert into CUSTOMER (c_id, name, email, phone)
values (712, 'Dar-Stanley', 'dar.stanley@ame', 559979594);
insert into CUSTOMER (c_id, name, email, phone)
values (743, 'Ivan-Saucedo', 'ivan.saucedo@in', 561834665);
insert into CUSTOMER (c_id, name, email, phone)
values (211, 'Eddie-Lauper', 'eddie@hewlettpa', 575691103);
insert into CUSTOMER (c_id, name, email, phone)
values (294, 'Albert-Malone', 'albert.malone@c', 513578290);
insert into CUSTOMER (c_id, name, email, phone)
values (402, 'Scott-Aykroyd', 'scott.aykroyd@d', 507968086);
insert into CUSTOMER (c_id, name, email, phone)
values (786, 'Susan-Krabbe', 'susan.krabbe@ma', 560166562);
insert into CUSTOMER (c_id, name, email, phone)
values (776, 'Ronny-Rhymes', 'ronny.rhymes@ca', 519755035);
insert into CUSTOMER (c_id, name, email, phone)
values (200, 'Franco-Crewson', 'francoc@ach.com', 547699492);
insert into CUSTOMER (c_id, name, email, phone)
values (210, 'Stellan-Lerner', 'stellan.l@white', 520734690);
insert into CUSTOMER (c_id, name, email, phone)
values (168, 'Kathy-Azaria', 'kathy.a@aristot', 517231377);
insert into CUSTOMER (c_id, name, email, phone)
values (616, 'Omar-Levert', 'omar.levert@ufs', 520234730);
insert into CUSTOMER (c_id, name, email, phone)
values (464, 'Harrison-Downie', 'Harrison@com', 571164350);
insert into CUSTOMER (c_id, name, email, phone)
values (909, 'Fionnula-Jenkin', 'Fionnula@com', 584967804);
insert into CUSTOMER (c_id, name, email, phone)
values (694, 'Richard-Kahn', 'richard.kahn@ul', 585328262);
insert into CUSTOMER (c_id, name, email, phone)
values (516, 'Roscoe-Benoit', 'roscoe.benoit@r', 528162009);
insert into CUSTOMER (c_id, name, email, phone)
values (137, 'Andrea-Dushku', 'andrea.dushku@p', 575579776);
insert into CUSTOMER (c_id, name, email, phone)
values (61, 'Tony-Downey', 'tony.downey@mss', 568996169);
insert into CUSTOMER (c_id, name, email, phone)
values (366, 'Rade-Herrmann', 'rade.herrmann@s', 552924773);
insert into CUSTOMER (c_id, name, email, phone)
values (359, 'Crystal-Diehl', 'c.diehl@ibm.no', 573947631);
commit;
prompt 200 records committed...
insert into CUSTOMER (c_id, name, email, phone)
values (370, 'Dylan-Winter', 'dylanw@alohanys', 597091311);
insert into CUSTOMER (c_id, name, email, phone)
values (793, 'Peter-Liu', 'peterl@clubone.', 579299704);
insert into CUSTOMER (c_id, name, email, phone)
values (192, 'Kenneth-Gambon', 'kenneth@pulaski', 512668294);
insert into CUSTOMER (c_id, name, email, phone)
values (605, 'Rebecca-Withers', 'r.withers@pione', 550463256);
insert into CUSTOMER (c_id, name, email, phone)
values (116, 'Parker-Romijn-S', 'p.romijnstamos@', 507768206);
insert into CUSTOMER (c_id, name, email, phone)
values (97, 'Glen-Saucedo', 'glen.saucedo@ca', 500627186);
insert into CUSTOMER (c_id, name, email, phone)
values (169, 'Lennie-Giraldo', 'lennie.giraldo@', 540827609);
insert into CUSTOMER (c_id, name, email, phone)
values (43, 'Taye-Basinger', 'taye.basinger@b', 518322002);
insert into CUSTOMER (c_id, name, email, phone)
values (98, 'Jeff-Hyde', 'jeff.hyde@ultim', 544817376);
insert into CUSTOMER (c_id, name, email, phone)
values (896, 'Joey-Suchet', 'j.suchet@actech', 543857491);
insert into CUSTOMER (c_id, name, email, phone)
values (20, 'Sheryl-Diehl', 'sheryld@operati', 570333613);
insert into CUSTOMER (c_id, name, email, phone)
values (534, 'Emily-Vaughn', 'emily.vaughn@da', 573420291);
insert into CUSTOMER (c_id, name, email, phone)
values (490, 'Jennifer-Blackm', 'j.blackmore@hea', 501607133);
insert into CUSTOMER (c_id, name, email, phone)
values (610, 'Vin-O''Keefe', 'vin.okeefe@cred', 531125311);
insert into CUSTOMER (c_id, name, email, phone)
values (632, 'Bob-Peebles', 'b.peebles@world', 561884912);
insert into CUSTOMER (c_id, name, email, phone)
values (654, 'Garry-Neeson', 'garry.neeson@hu', 572511097);
insert into CUSTOMER (c_id, name, email, phone)
values (681, 'Diamond-Makowic', 'Diamond@com', 524571623);
insert into CUSTOMER (c_id, name, email, phone)
values (784, 'Curtis-Quinn', 'c.quinn@data.ca', 532501482);
insert into CUSTOMER (c_id, name, email, phone)
values (27, 'Lorraine-Allen', 'lallen@ssci.fr', 586950015);
insert into CUSTOMER (c_id, name, email, phone)
values (562, 'Jesus-Unger', 'jesus.unger@wlt', 596289575);
insert into CUSTOMER (c_id, name, email, phone)
values (429, 'Sydney-McNeice', 'sydney.mcneice@', 541788962);
insert into CUSTOMER (c_id, name, email, phone)
values (774, 'Rebeka-Yulin', 'rebekay@tilia.c', 525237665);
insert into CUSTOMER (c_id, name, email, phone)
values (409, 'Frank-Cole', 'f.cole@sunstrea', 554435523);
insert into CUSTOMER (c_id, name, email, phone)
values (707, 'Tommy-Coburn', 'tommy.coburn@ne', 560219677);
insert into CUSTOMER (c_id, name, email, phone)
values (979, 'Pat-Whitman', 'pat.w@adeasolut', 557234706);
insert into CUSTOMER (c_id, name, email, phone)
values (250, 'Boz-Barnett', 'boz.barnett@jol', 505096213);
insert into CUSTOMER (c_id, name, email, phone)
values (852, 'Gil-Diffie', 'gil@primussoftw', 598639821);
insert into CUSTOMER (c_id, name, email, phone)
values (595, 'Alan-McKean', 'alan.mckean@stu', 532201403);
insert into CUSTOMER (c_id, name, email, phone)
values (762, 'Lindsay-Luongo', 'lindsay.luongo@', 554514368);
insert into CUSTOMER (c_id, name, email, phone)
values (231, 'Chrissie-Glover', 'Chrissie@com', 537366482);
insert into CUSTOMER (c_id, name, email, phone)
values (954, 'Robin-Joli', 'robin.j@maveric', 504986470);
insert into CUSTOMER (c_id, name, email, phone)
values (899, 'Remy-Curtis-Hal', 'Remy@com', 573230584);
insert into CUSTOMER (c_id, name, email, phone)
values (275, 'Gardner', 'gdixon4@ibm.com', 537657682);
insert into CUSTOMER (c_id, name, email, phone)
values (625, 'Denis-Hyde', 'dennis@providen', 590964238);
insert into CUSTOMER (c_id, name, email, phone)
values (305, 'Dani-deyt', 'dannip@roviden', 592963238);
insert into CUSTOMER (c_id, name, email, phone)
values (215, 'Alon-Hyde', 'Al@providen', 592364238);
insert into CUSTOMER (c_id, name, email, phone)
values (248, 'Carl-DeLuise', 'cdeluise@gillet', 568224961);
insert into CUSTOMER (c_id, name, email, phone)
values (867, 'Alannah-Margoly', 'alannahm@faef.f', 530745998);
insert into CUSTOMER (c_id, name, email, phone)
values (336, 'Max-Hampton', 'max@quakercityb', 573118938);
insert into CUSTOMER (c_id, name, email, phone)
values (859, 'Karon-Burton', 'karon.burton@es', 596416957);
insert into CUSTOMER (c_id, name, email, phone)
values (76, 'Keith-Tempest', 'ktempest@base.c', 518521181);
insert into CUSTOMER (c_id, name, email, phone)
values (684, 'Emm-Keeslar', 'emm.keeslar@inn', 575581935);
insert into CUSTOMER (c_id, name, email, phone)
values (693, 'Debra-Eder', 'd.eder@midwestm', 598544176);
insert into CUSTOMER (c_id, name, email, phone)
values (609, 'Patty-Rea', 'patty@elitemedi', 574660829);
insert into CUSTOMER (c_id, name, email, phone)
values (544, 'Cliff-Salonga', 'cliff.salonga@l', 532983589);
insert into CUSTOMER (c_id, name, email, phone)
values (997, 'King-Winger', 'king.winger@pfi', 583237122);
insert into CUSTOMER (c_id, name, email, phone)
values (923, 'Jodie-Feuerstei', 'j.feuerstein@ir', 513590659);
insert into CUSTOMER (c_id, name, email, phone)
values (806, 'Emm-Camp', 'emm.camp@envisi', 598231948);
insert into CUSTOMER (c_id, name, email, phone)
values (740, 'Ahmad-Jolie', 'ahmadj@marathon', 507269268);
insert into CUSTOMER (c_id, name, email, phone)
values (602, 'Zooey-Ledger', 'zooey.ledger@sf', 590117177);
insert into CUSTOMER (c_id, name, email, phone)
values (857, 'Sissy-Buscemi', 'sissyb@iss.ch', 525950765);
insert into CUSTOMER (c_id, name, email, phone)
values (577, 'Jean-Luc-Bell', 'jeanluc.b@at.br', 575887170);
insert into CUSTOMER (c_id, name, email, phone)
values (636, 'Tyrone-King', 'tyrone.king@psc', 568657021);
insert into CUSTOMER (c_id, name, email, phone)
values (756, 'Bonnie-McBride', 'bonnie.mcbride@', 599276488);
insert into CUSTOMER (c_id, name, email, phone)
values (130, 'Tilda-Boone', 'tilda.b@digital', 575797562);
insert into CUSTOMER (c_id, name, email, phone)
values (484, 'Robby-Cleary', 'robbyc@epamsyst', 544919705);
insert into CUSTOMER (c_id, name, email, phone)
values (639, 'Nicky-Bush', 'nicky.bush@uem.', 593206710);
insert into CUSTOMER (c_id, name, email, phone)
values (265, 'Stellan-Wine', 'stellan.wine@tr', 501389613);
insert into CUSTOMER (c_id, name, email, phone)
values (315, 'Angelina-Rivers', 'arivers@spectru', 571120124);
insert into CUSTOMER (c_id, name, email, phone)
values (934, 'Patty-Stampley', 'patty.stampley@', 504200239);
insert into CUSTOMER (c_id, name, email, phone)
values (204, 'Rupert-Bridges', 'rupert.bridges@', 516762097);
insert into CUSTOMER (c_id, name, email, phone)
values (126, 'Marty-Def', 'mdef@officedepo', 545703503);
insert into CUSTOMER (c_id, name, email, phone)
values (738, 'Carole-Robbins', 'caroler@kimberl', 584003900);
insert into CUSTOMER (c_id, name, email, phone)
values (604, 'Andre-Banderas', 'andre@grt.com', 557865835);
insert into CUSTOMER (c_id, name, email, phone)
values (486, 'Mili-Perez', 'mili.perez@lms.', 562752887);
insert into CUSTOMER (c_id, name, email, phone)
values (668, 'Samuel-Cook', 'samuel.cook@hil', 502804837);
insert into CUSTOMER (c_id, name, email, phone)
values (94, 'Warren-Feuerste', 'warren@dataware', 513333123);
insert into CUSTOMER (c_id, name, email, phone)
values (286, 'Antonio-Hamilto', 'a.hamilton@nexx', 538341526);
insert into CUSTOMER (c_id, name, email, phone)
values (399, 'Kim-Zane', 'kim.zane@credit', 527754587);
insert into CUSTOMER (c_id, name, email, phone)
values (504, 'Patty-Stevenson', 'patty@terrafirm', 543616455);
insert into CUSTOMER (c_id, name, email, phone)
values (991, 'Elle-Jolie', 'elle.jolie@wend', 532580984);
insert into CUSTOMER (c_id, name, email, phone)
values (537, 'Rosie-Blossoms', 'rosie.blossoms@', 579452990);
insert into CUSTOMER (c_id, name, email, phone)
values (411, 'Sigourney-Holbr', 'Sigourney@com', 541656412);
insert into CUSTOMER (c_id, name, email, phone)
values (878, 'Stevie-Iglesias', 'Stevie@com', 508920245);
insert into CUSTOMER (c_id, name, email, phone)
values (736, 'Rod-Weber', 'rod.weber@ubp.c', 593279482);
insert into CUSTOMER (c_id, name, email, phone)
values (176, 'Tilda-Piven', 'tpiven@seafoxbo', 527181141);
insert into CUSTOMER (c_id, name, email, phone)
values (938, 'Bette-Paul', 'bette.paul@spea', 513434710);
insert into CUSTOMER (c_id, name, email, phone)
values (663, 'Patricia-Weston', 'Patricia@com', 592761002);
insert into CUSTOMER (c_id, name, email, phone)
values (303, 'Kenny-Shue', 'kenny.shue@fibe', 552362920);
insert into CUSTOMER (c_id, name, email, phone)
values (509, 'Katie-Katt', 'katie.k@questar', 572397755);
insert into CUSTOMER (c_id, name, email, phone)
values (764, 'Jeroen-Coward', 'jeroen.coward@i', 549285795);
insert into CUSTOMER (c_id, name, email, phone)
values (475, 'Ike-Craig', 'ike.craig@treke', 542069849);
insert into CUSTOMER (c_id, name, email, phone)
values (864, 'Clarence-Leoni', 'clarence.leoni@', 558004085);
insert into CUSTOMER (c_id, name, email, phone)
values (944, 'Gaby-Mellencamp', 'Gaby@com', 566031613);
insert into CUSTOMER (c_id, name, email, phone)
values (591, 'Marie-Garfunkel', 'mgarfunkel@fetc', 556023964);
insert into CUSTOMER (c_id, name, email, phone)
values (141, 'Carl-Emmett', 'carl.emmett@sha', 524105071);
insert into CUSTOMER (c_id, name, email, phone)
values (6, 'Clay-Hector', 'clay.hector@top', 531598923);
insert into CUSTOMER (c_id, name, email, phone)
values (788, 'Daryle-Hutton', 'd.hutton@tigris', 533040588);
insert into CUSTOMER (c_id, name, email, phone)
values (226, 'Annie-Paymer', 'apaymer@keith.c', 574366552);
insert into CUSTOMER (c_id, name, email, phone)
values (827, 'Nick-Hirsch', 'nick.hirsch@com', 559047850);
insert into CUSTOMER (c_id, name, email, phone)
values (199, 'Sarah-Bogguss', 'sarahb@dsp.com', 545122885);
insert into CUSTOMER (c_id, name, email, phone)
values (742, 'Randall-Cazale', 'randallc@vitaco', 539872234);
insert into CUSTOMER (c_id, name, email, phone)
values (990, 'Miki-Carrey', 'm.carrey@seafox', 549009508);
insert into CUSTOMER (c_id, name, email, phone)
values (276, 'Randy-Webb', 'randy.webb@jma.', 509782488);
insert into CUSTOMER (c_id, name, email, phone)
values (892, 'Darius-Lawrence', 'darius@accessus', 520635581);
insert into CUSTOMER (c_id, name, email, phone)
values (274, 'Vonda-Owen', 'vonda.owen@info', 564559491);
insert into CUSTOMER (c_id, name, email, phone)
values (368, 'Mitchell-Shocke', 'mitchells@pione', 505945946);
insert into CUSTOMER (c_id, name, email, phone)
values (497, 'Franz-Rain', 'franz.r@jma.com', 530214812);
insert into CUSTOMER (c_id, name, email, phone)
values (587, 'Dustin-Van Damm', 'dvandamme@inter', 565812412);
insert into CUSTOMER (c_id, name, email, phone)
values (334, 'Chi-Levin', 'chi.l@eastmanko', 541352094);
commit;
prompt 300 records committed...
insert into CUSTOMER (c_id, name, email, phone)
values (214, 'Christmas-Li', 'c.li@outsourceg', 554345112);
insert into CUSTOMER (c_id, name, email, phone)
values (982, 'Maggie-Dillon', 'maggied@daimler', 533497023);
insert into CUSTOMER (c_id, name, email, phone)
values (115, 'Nanci-Tinsley', 'nanci.tinsley@m', 585264866);
insert into CUSTOMER (c_id, name, email, phone)
values (772, 'Ani-Greenwood', 'a.greenwood@air', 541600057);
insert into CUSTOMER (c_id, name, email, phone)
values (963, 'Carol-Elizondo', 'carol.elizondo@', 510703737);
insert into CUSTOMER (c_id, name, email, phone)
values (77, 'Colm-McGregor', 'colm.mcgregor@m', 545214078);
insert into CUSTOMER (c_id, name, email, phone)
values (456, 'Adrien-Jay', 'a.jay@elitemedi', 561055741);
insert into CUSTOMER (c_id, name, email, phone)
values (342, 'Donal-Baldwin', 'donal.baldwin@g', 524897096);
insert into CUSTOMER (c_id, name, email, phone)
values (550, 'Jim-Pastore', 'jim.pastore@cap', 502735664);
insert into CUSTOMER (c_id, name, email, phone)
values (427, 'Ewan-Astin', 'eastin@greene.c', 598025764);
insert into CUSTOMER (c_id, name, email, phone)
values (931, 'Suzy-Feliciano', 'suzy.feliciano@', 503505416);
insert into CUSTOMER (c_id, name, email, phone)
values (143, 'Alex-Sanders', 'alex.sanders@sm', 532537189);
insert into CUSTOMER (c_id, name, email, phone)
values (485, 'Bebe-Collins', 'bebec@myricom.d', 526250822);
insert into CUSTOMER (c_id, name, email, phone)
values (433, 'Swoosie-Harper', 'swoosie.h@gentr', 576183235);
insert into CUSTOMER (c_id, name, email, phone)
values (85, 'Swoosie-Plimpto', 'swoosie@thinkta', 573168263);
insert into CUSTOMER (c_id, name, email, phone)
values (538, 'Courtney-Spacek', 'Courtney@com', 558810541);
insert into CUSTOMER (c_id, name, email, phone)
values (592, 'Hal-Dolenz', 'hal.dolenz@ass.', 541621168);
insert into CUSTOMER (c_id, name, email, phone)
values (777, 'Martha-Penders', 'martha@capstone', 566289061);
insert into CUSTOMER (c_id, name, email, phone)
values (88, 'Terence-Neuwirt', 'Terence@com', 501507763);
insert into CUSTOMER (c_id, name, email, phone)
values (880, 'Melanie-Burstyn', 'mburstyn@waltdi', 592835602);
insert into CUSTOMER (c_id, name, email, phone)
values (197, 'Victor-Bachman', 'victor.bachman@', 597024374);
insert into CUSTOMER (c_id, name, email, phone)
values (699, 'Collin-Rollins', 'collin@telechem', 573302742);
insert into CUSTOMER (c_id, name, email, phone)
values (235, 'Sal-Weston', 'sal.weston@accu', 531623601);
insert into CUSTOMER (c_id, name, email, phone)
values (233, 'Emma-Wariner', 'ewariner@curagr', 583062280);
insert into CUSTOMER (c_id, name, email, phone)
values (219, 'Mekhi-Burns', 'mekhi@sci.es', 533839932);
insert into CUSTOMER (c_id, name, email, phone)
values (589, 'Harry-Church', 'harry.church@co', 599297979);
insert into CUSTOMER (c_id, name, email, phone)
values (222, 'Rachid-Anderson', 'Rachid@com', 540868137);
insert into CUSTOMER (c_id, name, email, phone)
values (449, 'Famke-Begley', 'famke.begley@he', 568825101);
insert into CUSTOMER (c_id, name, email, phone)
values (596, 'Fionnula-Idle', 'fionnula.idle@a', 568696035);
insert into CUSTOMER (c_id, name, email, phone)
values (771, 'Vin-Thorton', 'vin@walmartstor', 545110626);
insert into CUSTOMER (c_id, name, email, phone)
values (671, 'Collective-Kier', 'collectivek@tra', 592753432);
insert into CUSTOMER (c_id, name, email, phone)
values (371, 'Wayman-Cruise', 'wayman.cruise@b', 572667960);
insert into CUSTOMER (c_id, name, email, phone)
values (863, 'Denny-Weston', 'd.weston@slt.es', 570490104);
insert into CUSTOMER (c_id, name, email, phone)
values (543, 'Bobby-Sanders', 'bobby.sanders@o', 576834757);
insert into CUSTOMER (c_id, name, email, phone)
values (319, 'Spencer-Clinton', 'Spencer@com', 525759428);
insert into CUSTOMER (c_id, name, email, phone)
values (790, 'Garry-Imperioli', 'garry.i@abs.com', 575789633);
insert into CUSTOMER (c_id, name, email, phone)
values (198, 'Rhona-Barnett', 'rhona@sysconmed', 547587793);
insert into CUSTOMER (c_id, name, email, phone)
values (995, 'Lynn-Koyana', 'lynn@loreal.uk', 526123923);
insert into CUSTOMER (c_id, name, email, phone)
values (166, 'Boz-Paymer', 'bpaymer@inspira', 598996799);
insert into CUSTOMER (c_id, name, email, phone)
values (5, 'Solomon-McLachl', 'solomon@novarti', 507585364);
insert into CUSTOMER (c_id, name, email, phone)
values (32, 'Tamala-Weisz', 'tamala.weisz@al', 548469346);
insert into CUSTOMER (c_id, name, email, phone)
values (902, 'Phil-Makowicz', 'phil.makowicz@c', 559925442);
insert into CUSTOMER (c_id, name, email, phone)
values (751, 'Richie-Neill', 'richien@glmt.de', 587545360);
insert into CUSTOMER (c_id, name, email, phone)
values (306, 'Derek-Norton', 'derek@tmt.de', 528516170);
insert into CUSTOMER (c_id, name, email, phone)
values (908, 'Tobey-Gibbons', 'tobey.gibbons@l', 536240506);
insert into CUSTOMER (c_id, name, email, phone)
values (766, 'Sandra-Kurtz', 'sandra@marketfi', 500188734);
insert into CUSTOMER (c_id, name, email, phone)
values (737, 'Brittany-Hawtho', 'brittany@sds.fr', 578574662);
insert into CUSTOMER (c_id, name, email, phone)
values (343, 'Gilbert-Levine', 'gilbert.levine@', 552897779);
insert into CUSTOMER (c_id, name, email, phone)
values (851, 'Spike-Bruce', 'spike.bruce@tre', 581337347);
insert into CUSTOMER (c_id, name, email, phone)
values (285, 'Geena-Mirren', 'gmirren@als.com', 578492797);
insert into CUSTOMER (c_id, name, email, phone)
values (966, 'Jarvis-Vannelli', 'Jarvis@com', 564345709);
insert into CUSTOMER (c_id, name, email, phone)
values (688, 'Victoria-Carlyl', 'victoria.c@hite', 584297444);
insert into CUSTOMER (c_id, name, email, phone)
values (519, 'Julia-Chambers', 'julia.chambers@', 512476058);
insert into CUSTOMER (c_id, name, email, phone)
values (637, 'Leo-Mac', 'leo.mac@zoneper', 538476123);
insert into CUSTOMER (c_id, name, email, phone)
values (791, 'Nicole-Burmeste', 'Nicole@com', 513111827);
insert into CUSTOMER (c_id, name, email, phone)
values (452, 'Tamala-Travers', 'tamala.travers@', 583682056);
insert into CUSTOMER (c_id, name, email, phone)
values (162, 'Randy-O''Hara', 'randy.ohara@sta', 501949990);
insert into CUSTOMER (c_id, name, email, phone)
values (259, 'Brenda-Blanchet', 'b.blanchett@mic', 571999170);
insert into CUSTOMER (c_id, name, email, phone)
values (69, 'Woody-Bugnon', 'woody.bugnon@ca', 549431910);
insert into CUSTOMER (c_id, name, email, phone)
values (673, 'Scarlett-Dysart', 'scarlettd@ameri', 553342157);
insert into CUSTOMER (c_id, name, email, phone)
values (140, 'Trey-Conroy', 't.conroy@maveri', 522917342);
insert into CUSTOMER (c_id, name, email, phone)
values (682, 'Miles-Watley', 'milesw@lynksyst', 559584793);
insert into CUSTOMER (c_id, name, email, phone)
values (171, 'Sophie-Dickinso', 'sophie.d@maveri', 522851312);
insert into CUSTOMER (c_id, name, email, phone)
values (812, 'Gord-Stuermer', 'gords@clorox.ca', 513494449);
insert into CUSTOMER (c_id, name, email, phone)
values (155, 'Brendan-Gershon', 'Brendan@com', 534177579);
insert into CUSTOMER (c_id, name, email, phone)
values (569, 'Hikaru-Dempsey', 'hikaru.dempsey@', 587418015);
insert into CUSTOMER (c_id, name, email, phone)
values (956, 'Carrie-Anne-Tip', 'Carrie@com', 571853738);
insert into CUSTOMER (c_id, name, email, phone)
values (652, 'Katrin-Moffat', 'katrin.m@market', 587605944);
insert into CUSTOMER (c_id, name, email, phone)
values (947, 'Miranda-Holbroo', 'Miranda@com', 515576410);
insert into CUSTOMER (c_id, name, email, phone)
values (421, 'Phil-Blanchett', 'phil.blanchett@', 580885478);
insert into CUSTOMER (c_id, name, email, phone)
values (720, 'Debra-Soda', 'dsoda@pragmatec', 566604365);
insert into CUSTOMER (c_id, name, email, phone)
values (439, 'Holly-Goodman', 'holly@interface', 515497474);
insert into CUSTOMER (c_id, name, email, phone)
values (828, 'Burton-Gallant', 'burton.gallant@', 561812178);
insert into CUSTOMER (c_id, name, email, phone)
values (744, 'Frederic-Mannin', 'Frederic@com', 568476860);
insert into CUSTOMER (c_id, name, email, phone)
values (26, 'Lisa-Chappelle', 'lisa.chappelle@', 513381024);
insert into CUSTOMER (c_id, name, email, phone)
values (925, 'Guy-Perrineau', 'guy.perrineau@e', 557754014);
insert into CUSTOMER (c_id, name, email, phone)
values (428, 'Lois-Orbit', 'lois.orbit@y2ma', 535883856);
insert into CUSTOMER (c_id, name, email, phone)
values (860, 'Stockard-Mitra', 'stockard.mitra@', 581129918);
insert into CUSTOMER (c_id, name, email, phone)
values (9, 'Jason-Nunn', 'jasonn@emt.uk', 552285625);
insert into CUSTOMER (c_id, name, email, phone)
values (607, 'Pat-Dutton', 'patd@mcdonalds.', 506322839);
insert into CUSTOMER (c_id, name, email, phone)
values (601, 'Maura-Wahlberg', 'maura@trm.com', 585053389);
insert into CUSTOMER (c_id, name, email, phone)
values (644, 'Sara-Peet', 's.peet@pfizer.c', 552478815);
insert into CUSTOMER (c_id, name, email, phone)
values (927, 'Nile-Harry', 'nile@hfn.br', 588730599);
insert into CUSTOMER (c_id, name, email, phone)
values (481, 'Brad-Butler', 'bradb@at.com', 580590579);
insert into CUSTOMER (c_id, name, email, phone)
values (465, 'Rebeka-Chapman', 'rebekac@yumbran', 519669502);
insert into CUSTOMER (c_id, name, email, phone)
values (415, 'Hilton-Moss', 'h.moss@at.com', 505603021);
insert into CUSTOMER (c_id, name, email, phone)
values (182, 'Claire-Ronstadt', 'Claire@com', 578659238);
insert into CUSTOMER (c_id, name, email, phone)
values (474, 'Larry-Rourke', 'larry.rourke@fm', 574281894);
insert into CUSTOMER (c_id, name, email, phone)
values (594, 'Joshua-Matthau', 'joshuam@codykra', 548754047);
insert into CUSTOMER (c_id, name, email, phone)
values (246, 'Mika-Kurtz', 'm.kurtz@kwraf.d', 538483961);
insert into CUSTOMER (c_id, name, email, phone)
values (29, 'Natasha-Crudup', 'ncrudup@curagro', 523066978);
insert into CUSTOMER (c_id, name, email, phone)
values (376, 'Giancarlo-Grigg', 'Giancarlo@com', 573085263);
insert into CUSTOMER (c_id, name, email, phone)
values (814, 'Anita-Kershaw', 'anita.kershaw@p', 517498812);
insert into CUSTOMER (c_id, name, email, phone)
values (747, 'Ossie-Cazale', 'ossie.cazale@fa', 507817253);
insert into CUSTOMER (c_id, name, email, phone)
values (919, 'Buddy-Thurman', 'buddy.thurman@f', 578944739);
insert into CUSTOMER (c_id, name, email, phone)
values (800, 'Malcolm-Negbaur', 'malcolm@insurma', 591372016);
commit;
prompt 396 records loaded
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
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (251, to_date('28-09-2022', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 786, 84);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (158, to_date('20-05-2022', 'dd-mm-yyyy'), to_date('24-06-2023', 'dd-mm-yyyy'), 927, 937);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (556, to_date('15-09-2022', 'dd-mm-yyyy'), to_date('28-05-2023', 'dd-mm-yyyy'), 507, 912);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (51, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 64, 903);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (392, to_date('30-01-2023', 'dd-mm-yyyy'), to_date('31-01-2023', 'dd-mm-yyyy'), 516, 313);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (778, to_date('09-01-2023', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 431, 80);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (536, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('20-10-2023', 'dd-mm-yyyy'), 968, 900);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (211, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 428, 923);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (820, to_date('31-01-2023', 'dd-mm-yyyy'), to_date('01-04-2023', 'dd-mm-yyyy'), 183, 730);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (893, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 210, 225);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (46, to_date('26-02-2023', 'dd-mm-yyyy'), to_date('27-02-2023', 'dd-mm-yyyy'), 519, 208);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (28, to_date('08-01-2023', 'dd-mm-yyyy'), to_date('09-01-2023', 'dd-mm-yyyy'), 646, 518);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (548, to_date('26-06-2023', 'dd-mm-yyyy'), to_date('27-06-2023', 'dd-mm-yyyy'), 849, 691);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (667, to_date('14-08-2022', 'dd-mm-yyyy'), to_date('14-03-2023', 'dd-mm-yyyy'), 611, 873);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (473, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('12-02-2023', 'dd-mm-yyyy'), 446, 841);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (736, to_date('28-02-2023', 'dd-mm-yyyy'), to_date('01-03-2023', 'dd-mm-yyyy'), 26, 730);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (515, to_date('13-01-2023', 'dd-mm-yyyy'), to_date('14-01-2023', 'dd-mm-yyyy'), 800, 80);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (570, to_date('11-03-2023', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 464, 891);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (245, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 737, 722);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (981, to_date('23-01-2022', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 771, 39);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (950, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 776, 655);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (709, to_date('22-10-2023', 'dd-mm-yyyy'), to_date('24-12-2023', 'dd-mm-yyyy'), 702, 672);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (340, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 781, 445);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (933, to_date('23-07-2022', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 143, 978);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (123, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 681, 153);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (920, to_date('07-01-2022', 'dd-mm-yyyy'), to_date('01-04-2023', 'dd-mm-yyyy'), 340, 628);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (573, to_date('09-01-2022', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 587, 912);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (499, to_date('22-08-2023', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 296, 581);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (304, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 997, 913);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (952, to_date('30-03-2023', 'dd-mm-yyyy'), to_date('31-03-2023', 'dd-mm-yyyy'), 997, 376);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (717, to_date('26-05-2023', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 764, 615);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (425, to_date('25-04-2023', 'dd-mm-yyyy'), to_date('26-04-2023', 'dd-mm-yyyy'), 66, 650);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (813, to_date('17-01-2022', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 654, 366);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (929, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('15-02-2023', 'dd-mm-yyyy'), 345, 602);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (133, to_date('21-12-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 480, 52);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (945, to_date('19-12-2022', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 640, 923);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (996, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('06-04-2023', 'dd-mm-yyyy'), 785, 499);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (333, to_date('11-01-2022', 'dd-mm-yyyy'), to_date('17-02-2023', 'dd-mm-yyyy'), 497, 987);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (694, to_date('31-07-2023', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 777, 909);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (267, to_date('14-06-2022', 'dd-mm-yyyy'), to_date('18-02-2023', 'dd-mm-yyyy'), 888, 933);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (325, to_date('13-03-2023', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 910, 454);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (165, to_date('12-06-2023', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 751, 473);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (745, to_date('25-10-2023', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 878, 2);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (544, to_date('17-09-2022', 'dd-mm-yyyy'), to_date('19-06-2023', 'dd-mm-yyyy'), 591, 927);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (59, to_date('23-01-2023', 'dd-mm-yyyy'), to_date('24-01-2023', 'dd-mm-yyyy'), 700, 965);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (872, to_date('07-06-2023', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 553, 397);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (10, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 759, 353);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (112, to_date('11-08-2023', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 804, 216);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (565, to_date('01-07-2023', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 21, 318);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (511, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 927, 628);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (132, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 641, 684);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (1, to_date('21-06-2022', 'dd-mm-yyyy'), to_date('03-04-2023', 'dd-mm-yyyy'), 326, 475);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (642, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('17-04-2023', 'dd-mm-yyyy'), 219, 673);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (505, to_date('17-04-2023', 'dd-mm-yyyy'), to_date('29-10-2023', 'dd-mm-yyyy'), 295, 618);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (901, to_date('12-02-2023', 'dd-mm-yyyy'), to_date('13-02-2023', 'dd-mm-yyyy'), 700, 832);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (272, to_date('02-01-2023', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 720, 276);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (653, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 186, 570);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (319, to_date('25-02-2023', 'dd-mm-yyyy'), to_date('26-02-2023', 'dd-mm-yyyy'), 356, 709);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (227, to_date('16-05-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 287, 554);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (682, to_date('26-07-2023', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 404, 431);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (992, to_date('18-05-2023', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 21, 781);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (854, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('20-09-2023', 'dd-mm-yyyy'), 759, 120);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (935, to_date('20-12-2022', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 214, 421);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (437, to_date('10-05-2022', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 295, 327);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (834, to_date('31-05-2022', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 484, 762);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (485, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 740, 95);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (464, to_date('06-07-2022', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 764, 648);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (908, to_date('11-05-2023', 'dd-mm-yyyy'), to_date('12-05-2023', 'dd-mm-yyyy'), 109, 40);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (239, to_date('19-01-2023', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 650, 618);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (491, to_date('21-07-2022', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 223, 235);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (214, to_date('10-04-2023', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 607, 385);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (420, to_date('09-05-2023', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 271, 963);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (188, to_date('10-03-2023', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 569, 963);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (350, to_date('21-08-2023', 'dd-mm-yyyy'), to_date('15-09-2023', 'dd-mm-yyyy'), 265, 588);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (918, to_date('07-10-2023', 'dd-mm-yyyy'), to_date('22-12-2023', 'dd-mm-yyyy'), 134, 683);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (635, to_date('29-09-2022', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 9, 526);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (546, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 187, 800);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (924, to_date('14-02-2022', 'dd-mm-yyyy'), to_date('23-05-2023', 'dd-mm-yyyy'), 791, 677);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (462, to_date('14-03-2022', 'dd-mm-yyyy'), to_date('12-12-2023', 'dd-mm-yyyy'), 247, 973);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (45, to_date('25-10-2022', 'dd-mm-yyyy'), to_date('19-07-2023', 'dd-mm-yyyy'), 232, 873);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (331, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('19-04-2023', 'dd-mm-yyyy'), 786, 521);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (274, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 170, 18);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (193, to_date('07-05-2023', 'dd-mm-yyyy'), to_date('08-05-2023', 'dd-mm-yyyy'), 681, 225);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (115, to_date('25-03-2022', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 880, 649);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (725, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('25-02-2023', 'dd-mm-yyyy'), 486, 479);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (470, to_date('21-04-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 918, 756);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (125, to_date('18-03-2023', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 343, 113);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (703, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('01-03-2023', 'dd-mm-yyyy'), 773, 507);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (775, to_date('31-05-2023', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 276, 730);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (414, to_date('20-02-2022', 'dd-mm-yyyy'), to_date('15-02-2023', 'dd-mm-yyyy'), 788, 391);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (219, to_date('28-06-2022', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 64, 473);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (498, to_date('20-08-2022', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 757, 248);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (914, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 691, 963);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (479, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('19-01-2023', 'dd-mm-yyyy'), 21, 627);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (566, to_date('10-03-2023', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 5, 192);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (410, to_date('11-01-2023', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 997, 810);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (639, to_date('08-01-2023', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 317, 640);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (669, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 155, 994);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (80, to_date('28-07-2022', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 996, 994);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (256, to_date('06-05-2023', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 844, 900);
commit;
prompt 100 records committed...
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (136, to_date('05-06-2022', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 965, 499);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (508, to_date('22-12-2023', 'dd-mm-yyyy'), to_date('23-12-2023', 'dd-mm-yyyy'), 568, 614);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (666, to_date('14-04-2023', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 319, 627);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (215, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('17-08-2023', 'dd-mm-yyyy'), 709, 972);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (195, to_date('19-01-2023', 'dd-mm-yyyy'), to_date('20-01-2023', 'dd-mm-yyyy'), 673, 278);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (139, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('05-12-2023', 'dd-mm-yyyy'), 404, 471);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (434, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('22-01-2023', 'dd-mm-yyyy'), 231, 608);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (507, to_date('06-02-2023', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 609, 973);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (810, to_date('21-07-2022', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 431, 720);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (576, to_date('01-08-2023', 'dd-mm-yyyy'), to_date('02-08-2023', 'dd-mm-yyyy'), 954, 527);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (866, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('08-04-2023', 'dd-mm-yyyy'), 69, 711);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (417, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('29-03-2023', 'dd-mm-yyyy'), 899, 583);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (722, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 935, 837);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (395, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 465, 189);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (406, to_date('03-06-2022', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 938, 225);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (97, to_date('12-03-2023', 'dd-mm-yyyy'), to_date('13-03-2023', 'dd-mm-yyyy'), 764, 133);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (634, to_date('07-08-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 526, 454);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (523, to_date('30-01-2023', 'dd-mm-yyyy'), to_date('16-05-2023', 'dd-mm-yyyy'), 516, 402);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (286, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 317, 210);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (185, to_date('01-03-2023', 'dd-mm-yyyy'), to_date('30-06-2023', 'dd-mm-yyyy'), 602, 626);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (522, to_date('16-05-2023', 'dd-mm-yyyy'), to_date('17-05-2023', 'dd-mm-yyyy'), 991, 153);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (467, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 232, 633);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (312, to_date('28-08-2022', 'dd-mm-yyyy'), to_date('05-05-2023', 'dd-mm-yyyy'), 878, 80);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (609, to_date('02-04-2023', 'dd-mm-yyyy'), to_date('06-04-2023', 'dd-mm-yyyy'), 379, 394);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (744, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 88, 359);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (812, to_date('31-05-2022', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 290, 660);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (959, to_date('31-07-2022', 'dd-mm-yyyy'), to_date('10-02-2023', 'dd-mm-yyyy'), 285, 285);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (526, to_date('26-07-2022', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 786, 301);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (230, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 899, 959);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (756, to_date('04-07-2023', 'dd-mm-yyyy'), to_date('13-07-2023', 'dd-mm-yyyy'), 557, 925);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (539, to_date('25-03-2022', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 296, 633);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (427, to_date('23-01-2022', 'dd-mm-yyyy'), to_date('12-03-2023', 'dd-mm-yyyy'), 317, 276);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (691, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('16-01-2023', 'dd-mm-yyyy'), 955, 278);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (496, to_date('05-01-2023', 'dd-mm-yyyy'), to_date('06-01-2023', 'dd-mm-yyyy'), 211, 39);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (174, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 485, 329);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (64, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('09-08-2023', 'dd-mm-yyyy'), 296, 98);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (152, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 342, 331);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (218, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 433, 113);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (21, to_date('10-02-2023', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 794, 154);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (299, to_date('22-06-2023', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 250, 555);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (354, to_date('24-05-2023', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 331, 87);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (418, to_date('15-09-2023', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 170, 986);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (941, to_date('20-04-2023', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 867, 312);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (884, to_date('20-08-2022', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 609, 154);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (563, to_date('16-03-2022', 'dd-mm-yyyy'), to_date('28-03-2023', 'dd-mm-yyyy'), 550, 405);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (431, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 38, 216);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (620, to_date('31-07-2022', 'dd-mm-yyyy'), to_date('25-04-2023', 'dd-mm-yyyy'), 865, 789);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (173, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 233, 349);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (795, to_date('24-02-2023', 'dd-mm-yyyy'), to_date('25-02-2023', 'dd-mm-yyyy'), 274, 414);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (817, to_date('15-01-2023', 'dd-mm-yyyy'), to_date('16-01-2023', 'dd-mm-yyyy'), 524, 341);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (860, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('29-03-2023', 'dd-mm-yyyy'), 596, 280);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (253, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 290, 965);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (22, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 402, 647);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (762, to_date('08-06-2023', 'dd-mm-yyyy'), to_date('09-06-2023', 'dd-mm-yyyy'), 602, 773);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (278, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 192, 695);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (326, to_date('28-09-2023', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 170, 209);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (650, to_date('07-03-2023', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 265, 817);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (547, to_date('23-03-2023', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 118, 555);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (541, to_date('31-03-2023', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 226, 782);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (991, to_date('21-12-2022', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 800, 808);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (577, to_date('28-06-2023', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 870, 306);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (53, to_date('17-01-2023', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 761, 764);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (229, to_date('13-09-2022', 'dd-mm-yyyy'), to_date('22-02-2023', 'dd-mm-yyyy'), 399, 57);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (187, to_date('15-05-2023', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 142, 84);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (177, to_date('06-08-2023', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 709, 257);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (306, to_date('06-01-2022', 'dd-mm-yyyy'), to_date('12-03-2023', 'dd-mm-yyyy'), 654, 282);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (975, to_date('22-08-2022', 'dd-mm-yyyy'), to_date('23-08-2022', 'dd-mm-yyyy'), 409, 359);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (568, to_date('24-04-2022', 'dd-mm-yyyy'), to_date('26-12-2022', 'dd-mm-yyyy'), 587, 99);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (91, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('18-04-2022', 'dd-mm-yyyy'), 279, 683);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (897, to_date('21-10-2022', 'dd-mm-yyyy'), to_date('07-11-2022', 'dd-mm-yyyy'), 232, 923);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (432, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2022', 'dd-mm-yyyy'), 553, 412);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (684, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('21-03-2022', 'dd-mm-yyyy'), 484, 245);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (606, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('09-09-2022', 'dd-mm-yyyy'), 396, 651);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (527, to_date('19-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 59, 195);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (973, to_date('18-01-2022', 'dd-mm-yyyy'), to_date('17-03-2022', 'dd-mm-yyyy'), 671, 376);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (295, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('28-12-2022', 'dd-mm-yyyy'), 953, 62);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (76, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('12-06-2022', 'dd-mm-yyyy'), 497, 13);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (385, to_date('14-07-2022', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'), 990, 113);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (82, to_date('18-06-2022', 'dd-mm-yyyy'), to_date('19-06-2022', 'dd-mm-yyyy'), 794, 52);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (265, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('10-05-2022', 'dd-mm-yyyy'), 219, 97);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (535, to_date('07-02-2022', 'dd-mm-yyyy'), to_date('06-04-2022', 'dd-mm-yyyy'), 876, 673);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (233, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2022', 'dd-mm-yyyy'), 738, 474);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (252, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('30-05-2022', 'dd-mm-yyyy'), 43, 986);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (172, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'), 519, 208);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (719, to_date('17-03-2022', 'dd-mm-yyyy'), to_date('18-03-2022', 'dd-mm-yyyy'), 409, 978);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (503, to_date('18-11-2022', 'dd-mm-yyyy'), to_date('19-11-2022', 'dd-mm-yyyy'), 762, 458);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (835, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('06-06-2022', 'dd-mm-yyyy'), 814, 148);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (118, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('13-12-2022', 'dd-mm-yyyy'), 9, 99);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (685, to_date('10-04-2022', 'dd-mm-yyyy'), to_date('12-11-2022', 'dd-mm-yyyy'), 43, 953);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (455, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('19-02-2022', 'dd-mm-yyyy'), 486, 257);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (374, to_date('09-02-2022', 'dd-mm-yyyy'), to_date('10-02-2022', 'dd-mm-yyyy'), 935, 584);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (855, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('22-11-2022', 'dd-mm-yyyy'), 474, 277);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (181, to_date('20-09-2022', 'dd-mm-yyyy'), to_date('21-09-2022', 'dd-mm-yyyy'), 431, 521);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (288, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('01-11-2022', 'dd-mm-yyyy'), 544, 195);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (194, to_date('17-11-2022', 'dd-mm-yyyy'), to_date('18-11-2022', 'dd-mm-yyyy'), 414, 781);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (533, to_date('06-03-2022', 'dd-mm-yyyy'), to_date('07-03-2022', 'dd-mm-yyyy'), 538, 575);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (972, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('22-09-2022', 'dd-mm-yyyy'), 334, 431);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (167, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('11-03-2022', 'dd-mm-yyyy'), 77, 970);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (391, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('02-02-2022', 'dd-mm-yyyy'), 6, 927);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (588, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('24-02-2022', 'dd-mm-yyyy'), 568, 153);
commit;
prompt 200 records committed...
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (990, to_date('12-03-2022', 'dd-mm-yyyy'), to_date('13-03-2022', 'dd-mm-yyyy'), 421, 219);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (519, to_date('01-01-2022', 'dd-mm-yyyy'), to_date('23-10-2022', 'dd-mm-yyyy'), 640, 329);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (19, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('19-08-2022', 'dd-mm-yyyy'), 673, 340);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (567, to_date('15-08-2022', 'dd-mm-yyyy'), to_date('16-08-2022', 'dd-mm-yyyy'), 143, 715);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (590, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('21-03-2022', 'dd-mm-yyyy'), 919, 650);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (163, to_date('01-03-2022', 'dd-mm-yyyy'), to_date('02-03-2022', 'dd-mm-yyyy'), 589, 924);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (313, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('15-11-2022', 'dd-mm-yyyy'), 541, 391);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (398, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('16-08-2022', 'dd-mm-yyyy'), 304, 39);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (407, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('04-10-2022', 'dd-mm-yyyy'), 506, 720);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (38, to_date('24-02-2022', 'dd-mm-yyyy'), to_date('25-02-2022', 'dd-mm-yyyy'), 761, 709);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (601, to_date('25-01-2022', 'dd-mm-yyyy'), to_date('11-08-2022', 'dd-mm-yyyy'), 934, 670);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (529, to_date('03-12-2022', 'dd-mm-yyyy'), to_date('04-12-2022', 'dd-mm-yyyy'), 480, 98);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (128, to_date('08-07-2022', 'dd-mm-yyyy'), to_date('09-07-2022', 'dd-mm-yyyy'), 116, 633);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (888, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('26-07-2022', 'dd-mm-yyyy'), 272, 257);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (840, to_date('20-06-2022', 'dd-mm-yyyy'), to_date('12-09-2022', 'dd-mm-yyyy'), 543, 672);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (161, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('09-08-2022', 'dd-mm-yyyy'), 702, 929);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (939, to_date('11-03-2022', 'dd-mm-yyyy'), to_date('15-07-2022', 'dd-mm-yyyy'), 521, 924);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (983, to_date('28-10-2022', 'dd-mm-yyyy'), to_date('29-10-2022', 'dd-mm-yyyy'), 557, 454);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (301, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('09-10-2022', 'dd-mm-yyyy'), 340, 410);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (348, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'), 265, 135);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (782, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('04-03-2022', 'dd-mm-yyyy'), 272, 817);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (282, to_date('13-03-2022', 'dd-mm-yyyy'), to_date('30-09-2022', 'dd-mm-yyyy'), 516, 684);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (135, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('25-12-2022', 'dd-mm-yyyy'), 910, 459);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (789, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('23-08-2022', 'dd-mm-yyyy'), 728, 741);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (26, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('10-11-2022', 'dd-mm-yyyy'), 333, 805);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (234, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 478, 916);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (372, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('12-07-2022', 'dd-mm-yyyy'), 235, 902);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (450, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('28-02-2022', 'dd-mm-yyyy'), 62, 42);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (62, to_date('19-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 639, 473);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (366, to_date('26-05-2022', 'dd-mm-yyyy'), to_date('27-05-2022', 'dd-mm-yyyy'), 732, 181);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (708, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('20-07-2022', 'dd-mm-yyyy'), 595, 986);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (902, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 463, 713);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (859, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('11-02-2022', 'dd-mm-yyyy'), 429, 762);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (630, to_date('14-04-2022', 'dd-mm-yyyy'), to_date('24-07-2022', 'dd-mm-yyyy'), 21, 873);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (616, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('28-04-2022', 'dd-mm-yyyy'), 27, 963);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (430, to_date('10-11-2022', 'dd-mm-yyyy'), to_date('23-12-2022', 'dd-mm-yyyy'), 409, 471);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (967, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('11-06-2022', 'dd-mm-yyyy'), 56, 561);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (652, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('25-05-2022', 'dd-mm-yyyy'), 606, 569);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (68, to_date('13-04-2022', 'dd-mm-yyyy'), to_date('14-04-2022', 'dd-mm-yyyy'), 520, 691);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (531, to_date('08-11-2022', 'dd-mm-yyyy'), to_date('09-11-2022', 'dd-mm-yyyy'), 257, 422);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (439, to_date('19-01-2022', 'dd-mm-yyyy'), to_date('13-08-2022', 'dd-mm-yyyy'), 219, 954);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (457, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('19-02-2022', 'dd-mm-yyyy'), 712, 889);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (79, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('09-06-2022', 'dd-mm-yyyy'), 610, 800);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (355, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('08-03-2022', 'dd-mm-yyyy'), 368, 255);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (71, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('12-10-2022', 'dd-mm-yyyy'), 742, 41);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (787, to_date('11-04-2022', 'dd-mm-yyyy'), to_date('12-04-2022', 'dd-mm-yyyy'), 414, 410);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (349, to_date('02-05-2022', 'dd-mm-yyyy'), to_date('03-05-2022', 'dd-mm-yyyy'), 827, 214);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (923, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('16-04-2022', 'dd-mm-yyyy'), 816, 624);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (454, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('17-11-2022', 'dd-mm-yyyy'), 784, 158);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (594, to_date('09-08-2022', 'dd-mm-yyyy'), to_date('10-08-2022', 'dd-mm-yyyy'), 297, 13);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (627, to_date('16-04-2022', 'dd-mm-yyyy'), to_date('21-09-2022', 'dd-mm-yyyy'), 751, 527);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (110, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('21-10-2022', 'dd-mm-yyyy'), 77, 585);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (622, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('20-12-2022', 'dd-mm-yyyy'), 376, 672);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (321, to_date('30-01-2022', 'dd-mm-yyyy'), to_date('27-07-2022', 'dd-mm-yyyy'), 774, 918);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (658, to_date('22-04-2022', 'dd-mm-yyyy'), to_date('13-06-2022', 'dd-mm-yyyy'), 461, 412);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (771, to_date('28-02-2022', 'dd-mm-yyyy'), to_date('01-03-2022', 'dd-mm-yyyy'), 431, 331);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (279, to_date('02-04-2022', 'dd-mm-yyyy'), to_date('03-04-2022', 'dd-mm-yyyy'), 287, 987);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (403, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('05-09-2022', 'dd-mm-yyyy'), 175, 313);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (815, to_date('13-07-2022', 'dd-mm-yyyy'), to_date('14-07-2022', 'dd-mm-yyyy'), 20, 985);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (886, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('13-12-2022', 'dd-mm-yyyy'), 694, 626);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (928, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 257, 19);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (637, to_date('10-03-2022', 'dd-mm-yyyy'), to_date('11-03-2022', 'dd-mm-yyyy'), 10, 165);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (144, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('25-07-2022', 'dd-mm-yyyy'), 171, 955);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (184, to_date('28-12-2022', 'dd-mm-yyyy'), to_date('29-12-2022', 'dd-mm-yyyy'), 876, 11);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (78, to_date('16-12-2022', 'dd-mm-yyyy'), to_date('17-12-2022', 'dd-mm-yyyy'), 396, 555);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (394, to_date('26-10-2022', 'dd-mm-yyyy'), to_date('27-10-2022', 'dd-mm-yyyy'), 965, 543);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (409, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('31-10-2022', 'dd-mm-yyyy'), 816, 40);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (11, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('27-09-2022', 'dd-mm-yyyy'), 331, 175);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (315, to_date('23-08-2022', 'dd-mm-yyyy'), to_date('21-11-2022', 'dd-mm-yyyy'), 536, 837);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (714, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('11-06-2022', 'dd-mm-yyyy'), 327, 414);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (514, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('15-09-2022', 'dd-mm-yyyy'), 379, 717);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (704, to_date('03-08-2022', 'dd-mm-yyyy'), to_date('04-08-2022', 'dd-mm-yyyy'), 18, 27);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (452, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('07-11-2022', 'dd-mm-yyyy'), 197, 703);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (501, to_date('28-05-2022', 'dd-mm-yyyy'), to_date('29-05-2022', 'dd-mm-yyyy'), 557, 709);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (832, to_date('04-05-2022', 'dd-mm-yyyy'), to_date('27-10-2022', 'dd-mm-yyyy'), 757, 474);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (948, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('25-07-2022', 'dd-mm-yyyy'), 737, 369);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (5, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('04-02-2022', 'dd-mm-yyyy'), 650, 248);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (48, to_date('07-02-2022', 'dd-mm-yyyy'), to_date('21-06-2022', 'dd-mm-yyyy'), 756, 340);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (595, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('28-03-2022', 'dd-mm-yyyy'), 325, 819);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (919, to_date('06-05-2022', 'dd-mm-yyyy'), to_date('07-05-2022', 'dd-mm-yyyy'), 927, 388);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (4, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('29-04-2022', 'dd-mm-yyyy'), 366, 626);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (615, to_date('15-07-2022', 'dd-mm-yyyy'), to_date('16-07-2022', 'dd-mm-yyyy'), 747, 808);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (538, to_date('07-11-2022', 'dd-mm-yyyy'), to_date('08-11-2022', 'dd-mm-yyyy'), 279, 318);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (871, to_date('19-03-2022', 'dd-mm-yyyy'), to_date('20-03-2022', 'dd-mm-yyyy'), 611, 18);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (911, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('02-09-2022', 'dd-mm-yyyy'), 543, 925);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (208, to_date('30-07-2022', 'dd-mm-yyyy'), to_date('31-07-2022', 'dd-mm-yyyy'), 182, 918);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (640, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('11-07-2022', 'dd-mm-yyyy'), 742, 210);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (379, to_date('07-05-2022', 'dd-mm-yyyy'), to_date('08-05-2022', 'dd-mm-yyyy'), 446, 168);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (8, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('27-11-2022', 'dd-mm-yyyy'), 832, 327);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (733, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('23-05-2022', 'dd-mm-yyyy'), 61, 819);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (240, to_date('23-04-2022', 'dd-mm-yyyy'), to_date('24-04-2022', 'dd-mm-yyyy'), 793, 414);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (388, to_date('04-12-2022', 'dd-mm-yyyy'), to_date('05-12-2022', 'dd-mm-yyyy'), 433, 948);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (480, to_date('03-10-2022', 'dd-mm-yyyy'), to_date('04-10-2022', 'dd-mm-yyyy'), 10, 709);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (869, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('10-04-2022', 'dd-mm-yyyy'), 396, 942);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (446, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('02-09-2022', 'dd-mm-yyyy'), 791, 2);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (236, to_date('08-05-2022', 'dd-mm-yyyy'), to_date('09-05-2022', 'dd-mm-yyyy'), 791, 851);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (643, to_date('07-09-2022', 'dd-mm-yyyy'), to_date('08-09-2022', 'dd-mm-yyyy'), 713, 486);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (290, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('21-10-2022', 'dd-mm-yyyy'), 604, 815);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (488, to_date('05-05-2022', 'dd-mm-yyyy'), to_date('06-05-2022', 'dd-mm-yyyy'), 219, 206);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (995, to_date('01-06-2022', 'dd-mm-yyyy'), to_date('02-06-2022', 'dd-mm-yyyy'), 591, 916);
commit;
prompt 300 records committed...
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (974, to_date('16-03-2022', 'dd-mm-yyyy'), to_date('09-12-2022', 'dd-mm-yyyy'), 464, 314);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (792, to_date('23-09-2022', 'dd-mm-yyyy'), to_date('24-09-2022', 'dd-mm-yyyy'), 61, 85);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (593, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('26-04-2022', 'dd-mm-yyyy'), 369, 113);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (336, to_date('23-05-2022', 'dd-mm-yyyy'), to_date('24-05-2022', 'dd-mm-yyyy'), 326, 608);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (284, to_date('11-11-2022', 'dd-mm-yyyy'), to_date('12-11-2022', 'dd-mm-yyyy'), 64, 86);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (29, to_date('08-05-2022', 'dd-mm-yyyy'), to_date('26-09-2022', 'dd-mm-yyyy'), 541, 674);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (294, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('23-03-2022', 'dd-mm-yyyy'), 990, 349);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (74, to_date('26-11-2022', 'dd-mm-yyyy'), to_date('27-11-2022', 'dd-mm-yyyy'), 867, 625);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (277, to_date('19-07-2022', 'dd-mm-yyyy'), to_date('20-07-2022', 'dd-mm-yyyy'), 827, 666);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (749, to_date('28-03-2022', 'dd-mm-yyyy'), to_date('29-03-2022', 'dd-mm-yyyy'), 524, 629);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (204, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('05-10-2022', 'dd-mm-yyyy'), 77, 431);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (168, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('07-09-2022', 'dd-mm-yyyy'), 844, 214);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (309, to_date('12-12-2022', 'dd-mm-yyyy'), to_date('13-12-2022', 'dd-mm-yyyy'), 816, 827);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (96, to_date('27-07-2022', 'dd-mm-yyyy'), to_date('28-07-2022', 'dd-mm-yyyy'), 182, 717);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (199, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('01-04-2022', 'dd-mm-yyyy'), 688, 880);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (647, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('11-08-2022', 'dd-mm-yyyy'), 794, 285);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (663, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('08-06-2022', 'dd-mm-yyyy'), 863, 313);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (693, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('08-06-2022', 'dd-mm-yyyy'), 863, 313);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (393, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('08-06-2022', 'dd-mm-yyyy'), 863, 313);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (839, to_date('21-05-2023', 'dd-mm-yyyy'), to_date('22-05-2023', 'dd-mm-yyyy'), 279, 744);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (458, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 363, 240);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (681, to_date('08-08-2023', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 699, 847);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (734, to_date('12-11-2022', 'dd-mm-yyyy'), to_date('27-04-2023', 'dd-mm-yyyy'), 557, 791);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (483, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 555, 99);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (700, to_date('13-03-2023', 'dd-mm-yyyy'), to_date('22-04-2023', 'dd-mm-yyyy'), 342, 608);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (373, to_date('29-08-2023', 'dd-mm-yyyy'), to_date('24-11-2023', 'dd-mm-yyyy'), 371, 62);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (209, to_date('26-01-2023', 'dd-mm-yyyy'), to_date('27-01-2023', 'dd-mm-yyyy'), 38, 147);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (103, to_date('23-10-2022', 'dd-mm-yyyy'), to_date('19-04-2023', 'dd-mm-yyyy'), 433, 832);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (968, to_date('06-03-2023', 'dd-mm-yyyy'), to_date('07-03-2023', 'dd-mm-yyyy'), 97, 615);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (604, to_date('12-01-2023', 'dd-mm-yyyy'), to_date('13-01-2023', 'dd-mm-yyyy'), 870, 994);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (989, to_date('27-01-2022', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 947, 405);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (648, to_date('06-07-2022', 'dd-mm-yyyy'), to_date('03-01-2023', 'dd-mm-yyyy'), 52, 509);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (63, to_date('22-03-2022', 'dd-mm-yyyy'), to_date('19-10-2023', 'dd-mm-yyyy'), 41, 292);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (819, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('23-01-2023', 'dd-mm-yyyy'), 880, 499);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (793, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 536, 410);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (842, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('05-07-2023', 'dd-mm-yyyy'), 865, 626);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (532, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 204, 275);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (680, to_date('30-09-2023', 'dd-mm-yyyy'), to_date('01-10-2023', 'dd-mm-yyyy'), 89, 730);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (697, to_date('28-05-2023', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 143, 512);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (551, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('20-03-2023', 'dd-mm-yyyy'), 116, 188);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (644, to_date('08-09-2023', 'dd-mm-yyyy'), to_date('09-09-2023', 'dd-mm-yyyy'), 904, 907);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (41, to_date('28-09-2023', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 860, 512);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (823, to_date('01-02-2023', 'dd-mm-yyyy'), to_date('21-06-2023', 'dd-mm-yyyy'), 334, 985);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (957, to_date('03-09-2022', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 464, 952);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (493, to_date('21-03-2023', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 155, 913);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (216, to_date('31-05-2023', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 684, 404);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (626, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 860, 703);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (891, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('06-01-2023', 'dd-mm-yyyy'), 740, 962);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (273, to_date('24-03-2022', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 142, 873);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (289, to_date('28-05-2023', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 537, 880);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (408, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('14-03-2023', 'dd-mm-yyyy'), 910, 314);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (518, to_date('10-07-2023', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 771, 87);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (116, to_date('17-08-2022', 'dd-mm-yyyy'), to_date('17-04-2023', 'dd-mm-yyyy'), 232, 725);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (203, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('14-07-2023', 'dd-mm-yyyy'), 368, 85);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (169, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 493, 585);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (36, to_date('14-07-2023', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 256, 972);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (296, to_date('15-06-2023', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 804, 581);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (360, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('25-01-2023', 'dd-mm-yyyy'), 605, 904);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (903, to_date('15-12-2022', 'dd-mm-yyyy'), to_date('05-04-2023', 'dd-mm-yyyy'), 331, 780);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (451, to_date('23-04-2023', 'dd-mm-yyyy'), to_date('24-04-2023', 'dd-mm-yyyy'), 303, 749);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (61, to_date('07-06-2023', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 492, 169);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (120, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 632, 472);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (779, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('14-07-2023', 'dd-mm-yyyy'), 402, 369);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (555, to_date('02-03-2023', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 334, 804);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (657, to_date('02-06-2023', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 742, 85);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (311, to_date('21-06-2023', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 93, 666);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (517, to_date('05-06-2023', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 306, 623);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (300, to_date('05-11-2022', 'dd-mm-yyyy'), to_date('10-04-2023', 'dd-mm-yyyy'), 644, 602);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (308, to_date('09-07-2022', 'dd-mm-yyyy'), to_date('24-09-2023', 'dd-mm-yyyy'), 602, 210);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (318, to_date('20-09-2023', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 370, 99);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (500, to_date('26-08-2023', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 955, 605);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (57, to_date('06-02-2023', 'dd-mm-yyyy'), to_date('07-02-2023', 'dd-mm-yyyy'), 453, 933);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (925, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 62, 385);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (178, to_date('27-11-2022', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 326, 366);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (180, to_date('09-09-2022', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 976, 425);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (777, to_date('21-01-2023', 'dd-mm-yyyy'), to_date('22-01-2023', 'dd-mm-yyyy'), 761, 191);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (559, to_date('14-04-2023', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 553, 296);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (926, to_date('27-06-2023', 'dd-mm-yyyy'), to_date('27-07-2023', 'dd-mm-yyyy'), 867, 254);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (951, to_date('10-06-2022', 'dd-mm-yyyy'), to_date('13-01-2023', 'dd-mm-yyyy'), 303, 479);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (877, to_date('10-02-2022', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 304, 425);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (713, to_date('02-01-2023', 'dd-mm-yyyy'), to_date('03-01-2023', 'dd-mm-yyyy'), 776, 815);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (345, to_date('17-06-2023', 'dd-mm-yyyy'), to_date('15-08-2023', 'dd-mm-yyyy'), 940, 759);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (65, to_date('23-01-2023', 'dd-mm-yyyy'), to_date('24-01-2023', 'dd-mm-yyyy'), 379, 359);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (978, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('21-12-2023', 'dd-mm-yyyy'), 720, 741);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (783, to_date('09-04-2022', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 19, 11);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (156, to_date('12-07-2023', 'dd-mm-yyyy'), to_date('13-07-2023', 'dd-mm-yyyy'), 942, 640);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (287, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 200, 722);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (375, to_date('01-09-2022', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 288, 431);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (217, to_date('25-06-2023', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 398, 820);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (867, to_date('09-02-2023', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 168, 404);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (670, to_date('05-08-2022', 'dd-mm-yyyy'), to_date('17-11-2023', 'dd-mm-yyyy'), 297, 512);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (943, to_date('19-09-2023', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 371, 841);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (628, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 318, 195);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (665, to_date('09-02-2022', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'), 421, 573);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (512, to_date('26-01-2022', 'dd-mm-yyyy'), to_date('08-04-2023', 'dd-mm-yyyy'), 265, 80);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (875, to_date('25-04-2023', 'dd-mm-yyyy'), to_date('26-04-2023', 'dd-mm-yyyy'), 587, 827);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (552, to_date('23-05-2023', 'dd-mm-yyyy'), to_date('24-05-2023', 'dd-mm-yyyy'), 10, 952);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (997, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('22-03-2023', 'dd-mm-yyyy'), 771, 391);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (689, to_date('06-05-2023', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 785, 666);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (339, to_date('10-07-2023', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 806, 278);
commit;
prompt 400 records committed...
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (153, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('17-01-2023', 'dd-mm-yyyy'), 368, 817);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (347, to_date('09-06-2022', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 327, 32);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (137, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('24-06-2023', 'dd-mm-yyyy'), 804, 387);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (718, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 41, 910);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (807, to_date('25-04-2022', 'dd-mm-yyyy'), to_date('24-04-2023', 'dd-mm-yyyy'), 956, 804);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (50, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 507, 674);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (428, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 244, 153);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (766, to_date('27-10-2023', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 616, 900);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (731, to_date('24-04-2023', 'dd-mm-yyyy'), to_date('25-04-2023', 'dd-mm-yyyy'), 90, 507);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (716, to_date('04-09-2023', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 484, 851);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (673, to_date('22-11-2023', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 200, 341);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (826, to_date('12-04-2023', 'dd-mm-yyyy'), to_date('13-04-2023', 'dd-mm-yyyy'), 712, 908);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (198, to_date('05-09-2023', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 616, 219);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (513, to_date('13-06-2023', 'dd-mm-yyyy'), to_date('03-08-2023', 'dd-mm-yyyy'), 51, 547);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (481, to_date('13-05-2022', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 166, 475);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (751, to_date('28-04-2023', 'dd-mm-yyyy'), to_date('29-04-2023', 'dd-mm-yyyy'), 130, 986);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (324, to_date('06-05-2023', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 908, 730);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (969, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 937, 458);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (310, to_date('20-03-2022', 'dd-mm-yyyy'), to_date('28-08-2023', 'dd-mm-yyyy'), 851, 292);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (824, to_date('06-03-2023', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 317, 822);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (654, to_date('01-05-2022', 'dd-mm-yyyy'), to_date('23-04-2023', 'dd-mm-yyyy'), 327, 255);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (938, to_date('14-12-2022', 'dd-mm-yyyy'), to_date('22-08-2023', 'dd-mm-yyyy'), 366, 254);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (54, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 480, 25);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (207, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('04-05-2023', 'dd-mm-yyyy'), 791, 954);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (268, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('01-02-2023', 'dd-mm-yyyy'), 562, 561);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (85, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('31-03-2023', 'dd-mm-yyyy'), 200, 987);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (946, to_date('21-09-2022', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 433, 431);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (73, to_date('27-03-2023', 'dd-mm-yyyy'), to_date('28-03-2023', 'dd-mm-yyyy'), 286, 625);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (786, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('26-09-2022', 'dd-mm-yyyy'), 909, 48);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (243, to_date('31-03-2022', 'dd-mm-yyyy'), to_date('01-04-2022', 'dd-mm-yyyy'), 997, 627);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (585, to_date('23-06-2022', 'dd-mm-yyyy'), to_date('24-06-2022', 'dd-mm-yyyy'), 171, 52);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (589, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('06-09-2022', 'dd-mm-yyyy'), 276, 764);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (805, to_date('12-02-2022', 'dd-mm-yyyy'), to_date('13-02-2022', 'dd-mm-yyyy'), 632, 98);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (92, to_date('22-07-2022', 'dd-mm-yyyy'), to_date('30-08-2022', 'dd-mm-yyyy'), 897, 331);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (107, to_date('09-10-2022', 'dd-mm-yyyy'), to_date('10-10-2022', 'dd-mm-yyyy'), 93, 225);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (147, to_date('17-06-2022', 'dd-mm-yyyy'), to_date('18-06-2022', 'dd-mm-yyyy'), 918, 422);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (534, to_date('02-07-2022', 'dd-mm-yyyy'), to_date('03-07-2022', 'dd-mm-yyyy'), 790, 282);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (910, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('21-12-2022', 'dd-mm-yyyy'), 19, 805);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (486, to_date('13-12-2022', 'dd-mm-yyyy'), to_date('14-12-2022', 'dd-mm-yyyy'), 411, 618);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (162, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('22-11-2022', 'dd-mm-yyyy'), 516, 723);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (131, to_date('01-04-2022', 'dd-mm-yyyy'), to_date('02-04-2022', 'dd-mm-yyyy'), 800, 985);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (592, to_date('20-01-2022', 'dd-mm-yyyy'), to_date('02-03-2022', 'dd-mm-yyyy'), 41, 983);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (510, to_date('28-08-2022', 'dd-mm-yyyy'), to_date('26-12-2022', 'dd-mm-yyyy'), 544, 86);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (701, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('30-07-2022', 'dd-mm-yyyy'), 43, 933);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (129, to_date('10-04-2022', 'dd-mm-yyyy'), to_date('11-04-2022', 'dd-mm-yyyy'), 899, 941);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (632, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('27-09-2022', 'dd-mm-yyyy'), 484, 2);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (261, to_date('11-12-2022', 'dd-mm-yyyy'), to_date('12-12-2022', 'dd-mm-yyyy'), 151, 416);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (93, to_date('19-02-2022', 'dd-mm-yyyy'), to_date('20-02-2022', 'dd-mm-yyyy'), 908, 431);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (365, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('10-08-2022', 'dd-mm-yyyy'), 214, 188);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (605, to_date('24-09-2022', 'dd-mm-yyyy'), to_date('25-09-2022', 'dd-mm-yyyy'), 541, 928);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (201, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('07-07-2022', 'dd-mm-yyyy'), 908, 257);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (186, to_date('20-02-2022', 'dd-mm-yyyy'), to_date('21-02-2022', 'dd-mm-yyyy'), 493, 175);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (426, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('28-03-2022', 'dd-mm-yyyy'), 516, 827);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (900, to_date('22-05-2022', 'dd-mm-yyyy'), to_date('23-05-2022', 'dd-mm-yyyy'), 171, 192);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (396, to_date('01-08-2022', 'dd-mm-yyyy'), to_date('02-08-2022', 'dd-mm-yyyy'), 331, 999);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (636, to_date('23-03-2022', 'dd-mm-yyyy'), to_date('24-03-2022', 'dd-mm-yyyy'), 860, 412);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (934, to_date('03-05-2022', 'dd-mm-yyyy'), to_date('04-05-2022', 'dd-mm-yyyy'), 650, 2);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (280, to_date('29-06-2022', 'dd-mm-yyyy'), to_date('30-06-2022', 'dd-mm-yyyy'), 484, 947);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (808, to_date('29-09-2022', 'dd-mm-yyyy'), to_date('30-09-2022', 'dd-mm-yyyy'), 899, 717);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (381, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('30-08-2022', 'dd-mm-yyyy'), 876, 986);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (557, to_date('30-04-2022', 'dd-mm-yyyy'), to_date('01-05-2022', 'dd-mm-yyyy'), 736, 953);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (882, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('28-11-2022', 'dd-mm-yyyy'), 948, 722);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (584, to_date('13-06-2022', 'dd-mm-yyyy'), to_date('14-06-2022', 'dd-mm-yyyy'), 527, 658);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (411, to_date('08-02-2022', 'dd-mm-yyyy'), to_date('09-02-2022', 'dd-mm-yyyy'), 707, 282);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (599, to_date('07-04-2022', 'dd-mm-yyyy'), to_date('08-04-2022', 'dd-mm-yyyy'), 519, 762);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (138, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 990, 972);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (828, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('23-10-2022', 'dd-mm-yyyy'), 876, 296);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (81, to_date('15-02-2022', 'dd-mm-yyyy'), to_date('16-02-2022', 'dd-mm-yyyy'), 366, 385);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (861, to_date('02-03-2022', 'dd-mm-yyyy'), to_date('03-03-2022', 'dd-mm-yyyy'), 596, 902);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (735, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('29-12-2022', 'dd-mm-yyyy'), 639, 781);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (558, to_date('29-03-2022', 'dd-mm-yyyy'), to_date('26-04-2022', 'dd-mm-yyyy'), 197, 794);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (283, to_date('20-12-2022', 'dd-mm-yyyy'), to_date('21-12-2022', 'dd-mm-yyyy'), 671, 85);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (885, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('07-02-2022', 'dd-mm-yyyy'), 736, 248);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (255, to_date('04-04-2022', 'dd-mm-yyyy'), to_date('16-10-2022', 'dd-mm-yyyy'), 878, 188);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (484, to_date('18-09-2022', 'dd-mm-yyyy'), to_date('19-09-2022', 'dd-mm-yyyy'), 415, 112);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (811, to_date('16-09-2022', 'dd-mm-yyyy'), to_date('17-09-2022', 'dd-mm-yyyy'), 743, 827);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (564, to_date('26-05-2022', 'dd-mm-yyyy'), to_date('27-05-2022', 'dd-mm-yyyy'), 781, 135);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (342, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-02-2022', 'dd-mm-yyyy'), 340, 368);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (210, to_date('18-10-2022', 'dd-mm-yyyy'), to_date('19-10-2022', 'dd-mm-yyyy'), 200, 841);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (688, to_date('06-06-2022', 'dd-mm-yyyy'), to_date('07-06-2022', 'dd-mm-yyyy'), 77, 850);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (40, to_date('08-09-2022', 'dd-mm-yyyy'), to_date('09-09-2022', 'dd-mm-yyyy'), 64, 301);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (353, to_date('03-07-2022', 'dd-mm-yyyy'), to_date('04-07-2022', 'dd-mm-yyyy'), 757, 285);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (60, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('23-09-2022', 'dd-mm-yyyy'), 909, 547);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (122, to_date('09-12-2022', 'dd-mm-yyyy'), to_date('10-12-2022', 'dd-mm-yyyy'), 281, 526);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (189, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-02-2022', 'dd-mm-yyyy'), 954, 535);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (561, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('07-09-2022', 'dd-mm-yyyy'), 931, 501);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (413, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('31-08-2022', 'dd-mm-yyyy'), 110, 943);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (223, to_date('12-04-2022', 'dd-mm-yyyy'), to_date('13-04-2022', 'dd-mm-yyyy'), 776, 398);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (100, to_date('12-01-2022', 'dd-mm-yyyy'), to_date('06-10-2022', 'dd-mm-yyyy'), 737, 932);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (262, to_date('25-06-2022', 'dd-mm-yyyy'), to_date('21-08-2022', 'dd-mm-yyyy'), 963, 912);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (942, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('09-04-2022', 'dd-mm-yyyy'), 942, 189);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (126, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('01-11-2022', 'dd-mm-yyyy'), 334, 95);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (292, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('16-04-2022', 'dd-mm-yyyy'), 804, 985);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (83, to_date('25-07-2022', 'dd-mm-yyyy'), to_date('26-07-2022', 'dd-mm-yyyy'), 772, 248);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (58, to_date('08-03-2022', 'dd-mm-yyyy'), to_date('09-03-2022', 'dd-mm-yyyy'), 744, 924);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (837, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('01-07-2022', 'dd-mm-yyyy'), 402, 312);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (157, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('28-03-2022', 'dd-mm-yyyy'), 947, 422);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (445, to_date('04-06-2022', 'dd-mm-yyyy'), to_date('03-07-2022', 'dd-mm-yyyy'), 966, 789);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (741, to_date('18-07-2022', 'dd-mm-yyyy'), to_date('09-10-2022', 'dd-mm-yyyy'), 461, 416);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (205, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('16-03-2022', 'dd-mm-yyyy'), 595, 410);
commit;
prompt 500 records committed...
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (478, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('30-04-2022', 'dd-mm-yyyy'), 284, 909);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (668, to_date('17-05-2022', 'dd-mm-yyyy'), to_date('18-05-2022', 'dd-mm-yyyy'), 137, 421);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (936, to_date('11-07-2022', 'dd-mm-yyyy'), to_date('12-07-2022', 'dd-mm-yyyy'), 288, 412);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (816, to_date('20-05-2022', 'dd-mm-yyyy'), to_date('01-06-2022', 'dd-mm-yyyy'), 480, 219);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (696, to_date('22-09-2022', 'dd-mm-yyyy'), to_date('23-09-2022', 'dd-mm-yyyy'), 976, 949);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (322, to_date('02-10-2022', 'dd-mm-yyyy'), to_date('03-10-2022', 'dd-mm-yyyy'), 758, 692);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (768, to_date('01-08-2022', 'dd-mm-yyyy'), to_date('02-08-2022', 'dd-mm-yyyy'), 418, 431);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (987, to_date('29-04-2022', 'dd-mm-yyyy'), to_date('19-09-2022', 'dd-mm-yyyy'), 699, 627);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (314, to_date('15-05-2022', 'dd-mm-yyyy'), to_date('18-09-2022', 'dd-mm-yyyy'), 115, 206);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (196, to_date('09-03-2022', 'dd-mm-yyyy'), to_date('10-03-2022', 'dd-mm-yyyy'), 990, 647);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (726, to_date('15-02-2022', 'dd-mm-yyyy'), to_date('08-03-2022', 'dd-mm-yyyy'), 833, 904);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (371, to_date('06-10-2022', 'dd-mm-yyyy'), to_date('07-10-2022', 'dd-mm-yyyy'), 947, 474);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (435, to_date('08-03-2022', 'dd-mm-yyyy'), to_date('09-03-2022', 'dd-mm-yyyy'), 896, 472);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (244, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('22-05-2022', 'dd-mm-yyyy'), 318, 464);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (465, to_date('05-06-2022', 'dd-mm-yyyy'), to_date('12-07-2022', 'dd-mm-yyyy'), 604, 479);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (190, to_date('11-06-2022', 'dd-mm-yyyy'), to_date('14-10-2022', 'dd-mm-yyyy'), 910, 941);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (2, to_date('26-03-2022', 'dd-mm-yyyy'), to_date('27-03-2022', 'dd-mm-yyyy'), 790, 837);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (476, to_date('16-10-2022', 'dd-mm-yyyy'), to_date('17-10-2022', 'dd-mm-yyyy'), 142, 206);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (864, to_date('25-01-2022', 'dd-mm-yyyy'), to_date('02-07-2022', 'dd-mm-yyyy'), 630, 316);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (662, to_date('24-01-2022', 'dd-mm-yyyy'), to_date('02-06-2022', 'dd-mm-yyyy'), 175, 165);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (334, to_date('30-06-2022', 'dd-mm-yyyy'), to_date('01-07-2022', 'dd-mm-yyyy'), 279, 416);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (705, to_date('22-02-2022', 'dd-mm-yyyy'), to_date('23-02-2022', 'dd-mm-yyyy'), 684, 841);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (631, to_date('29-07-2022', 'dd-mm-yyyy'), to_date('30-07-2022', 'dd-mm-yyyy'), 257, 952);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (238, to_date('15-03-2022', 'dd-mm-yyyy'), to_date('10-06-2022', 'dd-mm-yyyy'), 452, 474);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (404, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('24-02-2022', 'dd-mm-yyyy'), 5, 791);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (111, to_date('12-08-2022', 'dd-mm-yyyy'), to_date('13-08-2022', 'dd-mm-yyyy'), 356, 63);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (655, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('25-07-2022', 'dd-mm-yyyy'), 32, 285);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (37, to_date('21-02-2022', 'dd-mm-yyyy'), to_date('22-02-2022', 'dd-mm-yyyy'), 814, 36);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (909, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('19-01-2022', 'dd-mm-yyyy'), 215, 310);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
values (848, to_date('20-02-2023', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 639, 412);
insert into BOOKING (b_id, check_in, check_out, c_id, p_id)
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
prompt Loading EMPLOYES...
insert into EMPLOYES (position, e_id, name, salary)
values (' ', 135, ' Noga-Shir', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Counter Clerk', 785, 'Noga-Shir', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Counter Clerk', 75, 'Noga-Shir', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Driver', 15, ' Noa-Sir', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Driver', 155, ' Noa-Sir', 4177.248169415651);
insert into EMPLOYES (position, e_id, name, salary)
values ('Driver', 125, ' Amir-Lev', 4177.248169415651);
insert into EMPLOYES (position, e_id, name, salary)
values ('Counter Clerk', 725, 'Noga-Shir', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Shift Manager', 123, ' Avi-choen', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Bartender', 258, ' Saar-Roi', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Driver', 332, ' Nili-Lev', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('child operator', 711, ' Sara-Rot', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('lifeguard', 369, ' Ron-Cali', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('Internal driver', 856, ' Noa-Gor', 1000);
insert into EMPLOYES (position, e_id, name, salary)
values ('lifeguard', 748, ' Haim-Tov', 1331);
insert into EMPLOYES (position, e_id, name, salary)
values ('Driver', 145, ' Noga-Shir', 1100);
insert into EMPLOYES (position, e_id, name, salary)
values (' ', 165, ' Noga-Shir', 1000);
commit;
prompt 16 records loaded
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
prompt Enabling foreign key constraints for BOOKING...
alter table BOOKING enable constraint SYS_C007176;
alter table BOOKING enable constraint SYS_C007177;
prompt Enabling foreign key constraints for BOOKINGACTIVITIES...
alter table BOOKINGACTIVITIES enable constraint SYS_C007198;
alter table BOOKINGACTIVITIES enable constraint SYS_C007199;
prompt Enabling foreign key constraints for BOOKINGROOMS...
alter table BOOKINGROOMS enable constraint SYS_C007181;
alter table BOOKINGROOMS enable constraint SYS_C007182;
prompt Enabling foreign key constraints for WORK...
alter table WORK enable constraint SYS_C007203;
alter table WORK enable constraint SYS_C007204;
prompt Enabling triggers for ACTIVITIES...
alter table ACTIVITIES enable all triggers;
prompt Enabling triggers for CUSTOMER...
alter table CUSTOMER enable all triggers;
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
prompt Enabling triggers for EMPLOYES...
alter table EMPLOYES enable all triggers;
prompt Enabling triggers for WORK...
alter table WORK enable all triggers;

set feedback on
set define on
prompt Done
