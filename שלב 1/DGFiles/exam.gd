
[General]
Version=1

[Preferences]
Username=
Password=2232
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=EXAM
Count=400

[Record]
Name=EXAM_DATE
Type=DATE
Size=
Data=random(01/01/2000, 01/01/2020)
Master=

[Record]
Name=QUESTIONS_NUM
Type=NUMBER
Size=
Data=random(5,8)
Master=

[Record]
Name=FACTOR
Type=NUMBER
Size=
Data=random(0,10)
Master=

[Record]
Name=MOED
Type=NUMBER
Size=
Data=list(1,2)
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

