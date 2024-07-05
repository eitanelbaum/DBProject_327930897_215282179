
[General]
Version=1

[Preferences]
Username=
Password=2553
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=STUDENT
Count=1000

[Record]
Name=S_ID
Type=NUMBER
Size=
Data=random(1000000,9999999)
Master=

[Record]
Name=S_NAME
Type=VARCHAR2
Size=20
Data=FirstName + LastName
Master=

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
Data=email
Master=

[Record]
Name=BIRTH_DATE
Type=DATE
Size=
Data=Random(01/01/1960, 01/01/2010)
Master=

[Record]
Name=LEARNING_YEAR
Type=NUMBER
Size=
Data=random(1,5)
Master=

[Record]
Name=D_NAME
Type=VARCHAR2
Size=20
Data=list(select d_name from dormitories)
Master=

