
[General]
Version=1

[Preferences]
Username=
Password=2617
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=COURSE_TYPE
Count=400

[Record]
Name=C_ID
Type=NUMBER
Size=
Data=random(10000,99999)
Master=

[Record]
Name=CREDITS
Type=NUMBER
Size=
Data=random(2,5)
Master=

[Record]
Name=DEP_NAME
Type=VARCHAR2
Size=20
Data=list(select dep_name from department)
Master=

