
[General]
Version=1

[Preferences]
Username=
Password=2083
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=WORKING_FOR
Count=400

[Record]
Name=L_ID
Type=NUMBER
Size=
Data=list(select l_id from lecturer)
Master=

[Record]
Name=DEP_NAME
Type=VARCHAR2
Size=20
Data=list(select dep_name from department)
Master=

