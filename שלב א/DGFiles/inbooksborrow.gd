
[General]
Version=1

[Preferences]
Username=
Password=2993
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AVIGAIL
Name=BOOKSTOBORROW
Count=400

[Record]
Name=BOOKNUMBER
Type=NUMBER
Size=5
Data=Random(300, 5000)
Master=

[Record]
Name=ISBORROW
Type=CHAR
Size=1
Data=List('y', 'n')
Master=

[Record]
Name=BOOKID
Type=NUMBER
Size=5
Data=List(select BOOKID from BOOKSCATALOG)
Master=

