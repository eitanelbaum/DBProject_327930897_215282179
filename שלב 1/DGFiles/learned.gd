
[General]
Version=1

[Preferences]
Username=
Password=2131
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=LEARNED
Count=400

[Record]
Name=GRADE
Type=NUMBER
Size=
Data=random(50,100)
Master=

[Record]
Name=EXRECISES_GRADE
Type=NUMBER
Size=
Data=random(40,100)
Master=

[Record]
Name=MOEDAGRADE
Type=NUMBER
Size=
Data=random(40,100)
Master=

[Record]
Name=MOEDBGRADE
Type=NUMBER
Size=
Data=random(50,100)
Master=

[Record]
Name=S_ID
Type=NUMBER
Size=
Data=list(select s_id from student)
Master=

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

