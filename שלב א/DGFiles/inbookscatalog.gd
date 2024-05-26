
[General]
Version=1

[Preferences]
Username=
Password=2458
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AVIGAIL
Name=BOOKSCATALOG
Count=400

[Record]
Name=BOOKID
Type=NUMBER
Size=5
Data=Random(400, 1000)
Master=

[Record]
Name=BOOKNAME
Type=VARCHAR2
Size=15
Data=LastName
Master=

[Record]
Name=AMOUNT
Type=NUMBER
Size=
Data=Random(2, 50)
Master=

[Record]
Name=CATEGORYID
Type=NUMBER
Size=5
Data=List(select CATEGORYID from CATEGORIES)
Master=

[Record]
Name=AUTHORID
Type=NUMBER
Size=5
Data=List(select AUTHORID from AUTHORS)
Master=

