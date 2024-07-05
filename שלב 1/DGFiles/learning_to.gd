
[General]
Version=1

[Preferences]
Username=
Password=2550
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=LEARNING_TO
Count=400

[Record]
Name=S_ID
Type=NUMBER
Size=
Data=list(select s_id from student)
Master=

[Record]
Name=TYPE_BA_OR_MA
Type=VARCHAR2
Size=2
Data=list('BA','MA')
Master=

[Record]
Name=DEP_NAME
Type=VARCHAR2
Size=20
Data=list(select dep_name from department)
Master=

