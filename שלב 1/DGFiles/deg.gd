
[General]
Version=1

[Preferences]
Username=
Password=2675
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=DEG
Count=50

[Record]
Name=TYPE_BA_OR_MA
Type=VARCHAR2
Size=2
Data=list(BA,MA)
Master=

[Record]
Name=CREDITS
Type=NUMBER
Size=
Data=random(80,120)
Master=

[Record]
Name=THESIS
Type=VARCHAR2
Size=1
Data=list(Y,N)
Master=

[Record]
Name=DEP_NAME
Type=VARCHAR2
Size=20
Data=list(select dep_name from department)
Master=

