
[General]
Version=1

[Preferences]
Username=
Password=2637
Database=
DateFormat=dd-mm-yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AVIGAIL
Name=BORROWS
Count=400

[Record]
Name=BORROEID
Type=NUMBER
Size=5
Data=Random(100, 2000)
Master=

[Record]
Name=RETURNDATE
Type=DATE
Size=
Data=Random(1/06/2024, 1/7/2024)
Master=

[Record]
Name=BORROWDATE
Type=DATE
Size=
Data=Random(1/1/2024, 1/3/2024)
Master=

[Record]
Name=BOOKNUMBER
Type=NUMBER
Size=5
Data=List(select BOOKID from BOOKSCATALOG)
Master=

[Record]
Name=CUSTOMERID
Type=NUMBER
Size=5
Data=List(select CUSTOMERID from CUSTOMERS)
Master=

[Record]
Name=LIBRARYID
Type=NUMBER
Size=5
Data=List(select LIBRARYID from LIBRARIANS)
Master=

