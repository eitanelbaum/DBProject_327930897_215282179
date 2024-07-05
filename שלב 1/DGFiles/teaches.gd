
[General]
Version=1

[Preferences]
Username=
Password=2437
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=TEACHES
Count=400

[Record]
Name=SEMESTER
Type=NUMBER
Size=
Data=list(select semester from course)
Master=

[Record]
Name=COURSE_YEAR
Type=NUMBER
Size=
Data=list(select course_year from course)
Master=

[Record]
Name=C_ID
Type=NUMBER
Size=
Data=list(select c_id from course)
Master=

[Record]
Name=L_ID
Type=NUMBER
Size=
Data=list(select l_id from lecturer)
Master=

