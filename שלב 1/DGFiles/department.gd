
[General]
Version=1

[Preferences]
Username=
Password=2276
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=DEPARTMENT
Count=10..20

[Record]
Name=DEP_NAME
Type=VARCHAR2
Size=20
Data=list('math', 'computer science', 'anthropology', 'art', 'history', 'geographics', 'biology', 'cardiology', 'chemistry', 'physics', 'astronomy', 'ecology', 'economics', 'english', 'engineering', 'neurology', 'oncology', 'theatre', 'psychology', 'sociology')
Master=

[Record]
Name=EMAIL
Type=VARCHAR2
Size=30
Data=email
Master=

[Record]
Name=PHONE_NUMBER
Type=VARCHAR2
Size=10
Data=[0]+[0]+[0]+[0]+[0]+[0]+[0]+[0]
Master=

[Record]
Name=L_ID
Type=NUMBER
Size=
Data=list(select l_id from lecturer)
Master=

