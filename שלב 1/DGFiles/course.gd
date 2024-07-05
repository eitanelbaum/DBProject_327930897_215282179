
[General]
Version=1

[Preferences]
Username=
Password=2877
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=COURSE
Count=400

[Record]
Name=SEMESTER
Type=NUMBER
Size=
Data=list(1,2)
Master=

[Record]
Name=COURSE_YEAR
Type=NUMBER
Size=
Data=random(2000,2020)
Master=

[Record]
Name=GRADE_TO_PASS
Type=NUMBER
Size=
Data=list(55,60,65)
Master=

[Record]
Name=TEST_PERCENTAGE
Type=FLOAT
Size=22
Data=random(50, 100)
Master=

[Record]
Name=EXRECISE_PERCENTAGE
Type=FLOAT
Size=22
Data=random(0,50)
Master=

[Record]
Name=C_ID
Type=NUMBER
Size=
Data=list(select c_id from course_type)
Master=

[Record]
Name=L_ID
Type=NUMBER
Size=
Data=list(select l_id from lecturer)
Master=

