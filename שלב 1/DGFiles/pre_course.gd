
[General]
Version=1

[Preferences]
Username=
Password=2372
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=PRE_COURSE
Count=400

[Record]
Name=C_ID_1
Type=NUMBER
Size=
Data=list(select c_id from course_type)
Master=

[Record]
Name=C_ID_2
Type=NUMBER
Size=
Data=list(select c_id from course_type)
Master=

