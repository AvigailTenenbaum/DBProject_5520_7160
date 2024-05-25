create user Avigail --user name
IDENTIFIED BY aaa    --passward
default tablespace SYSTEM
temporary tablespace TEMP
profile DEFAULT
password expire;
GRANT ALL PRIVILEGES TO Avigail
