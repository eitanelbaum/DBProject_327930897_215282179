
[General]
Version=1

[Preferences]
Username=
Password=2498
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=LECTURER
Count=400

[Record]
Name=PHONE_NUMBER
Type=VARCHAR2
Size=10
Data=[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]
Master=

[Record]
Name=EMAIL
Type=VARCHAR2
Size=30
Data=Email
Master=

[Record]
Name=L_ID
Type=NUMBER
Size=
Data=Random(1000000, 9999999)
Master=

[Record]
Name=L_NAME
Type=VARCHAR2
Size=20
Data=FirstName + LastName
Master=

[Record]
Name=SALARY_PER_MONTH
Type=NUMBER
Size=
Data=Random(20000, 45000)
Master=

