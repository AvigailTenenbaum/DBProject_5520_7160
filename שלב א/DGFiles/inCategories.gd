
[General]
Version=1

[Preferences]
Username=
Password=2240
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AVIGAIL
Name=CATEGORIES
Count=7

[Record]
Name=CATEGORYID
Type=NUMBER
Size=5
Data=Random(20, 200)
Master=

[Record]
Name=CTYPE
Type=VARCHAR2
Size=15
Data=List('comics', 'adults','children','science fiction','romantic','crime')
Master=

[Record]
Name=FROMAGE
Type=NUMBER
Size=
Data=Random(5, 20)
Master=

