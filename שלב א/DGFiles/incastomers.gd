
[General]
Version=1

[Preferences]
Username=
Password=2858
Database=
DateFormat=dd-mm-yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=AVIGAIL
Name=CUSTOMERS
Count=400

[Record]
Name=CUSTOMERID
Type=NUMBER
Size=5
Data=Random(200, 1000)
Master=

[Record]
Name=CNAME
Type=VARCHAR2
Size=15
Data=FirstName - LastName
Master=

[Record]
Name=ADDRESS
Type=VARCHAR2
Size=15
Data=Address1
Master=

[Record]
Name=DATEOFBIRTH
Type=DATE
Size=
Data=Random(1/1/1970, 26/5/2019)
Master=

[Record]
Name=PHONE
Type=VARCHAR2
Size=10
Data=Random(0500000000, 0509999999)
Master=

