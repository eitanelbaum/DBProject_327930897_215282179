from faker import Faker
import csv
import random
import datetime

fake = Faker()
fake.unique.clear()

def gen_dormitories():
    return [fake.unique.last_name(), random.randint(3,5), random.randint(10,15)]

dormitories=[]
with open('dormitories.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['d_name', 'rooms_num', 'beds_num'])
    for n in range(400):
        x=gen_dormitories()
        q=writer.writerow(x)
        dormitories+=[x]

lecturer=[]
def gen_lecturer():
    return [fake.phone_number(), fake.email(), fake.unique.pyint(1000000,9999999), fake.name(), random.randint(20000,45000)]

with open('lecturer.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['phone_number', 'email', 'l_id', 'l_name', 'salary_per_month'])
    for n in range(400):
        x=gen_lecturer()
        q=writer.writerow(x)
        lecturer+=[x]

department=[]
dep_list = ['math', 'computer science', 'anthropology', 'art', 'history', 'geographics', 'biology', 'cardiology', 'chemistry', 'physics', 'astronomy', 'ecology', 'economics', 'english', 'engineering', 'neurology', 'oncology', 'theatre', 'psychology', 'sociology']
def gen_department():
    return [fake.email(), fake.phone_number(), lecturer[random.randint(0,len(lecturer)-1)][2]]

with open('department.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['dep_name', 'email', 'phone_number', 'l_id'])
    for n in range(20):
        x=[dep_list[n]]+ gen_department()
        q=writer.writerow(x)
        department+=[x]

deg=[]
with open('deg.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['dep_name', 'type_BA_or_MA', 'credits', 'thesis'])
    for n in range(40):
        x=[dep_list[n//2]]
        if n%2==1:
            x+=['MA']
            x+=[fake.pyint(20,40)]
            if fake.boolean():
                x+=['Y']
            else:
                x+=['N']
        else:
            x+=['BA']
            x+=[fake.pyint(100,120)]
            x+=['N']
        q=writer.writerow(x)
        deg+=[x]

working_for=[]
def gen_working():
    return [lecturer[random.randint(0,len(lecturer)-1)][2], dep_list[fake.pyint(0,19)]]

with open('working_for.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['l_id', 'dep_name'])
    for n in range(400):
        x=gen_working()
        while x in working_for:
            x=gen_working()
        q=writer.writerow(x)
        working_for+=[x]

student=[]
def gen_student():
    return [fake.unique.pyint(1000000,9999999), fake.name(), fake.phone_number(), fake.email(), fake.date_of_birth(None,13,75), fake.pyint(1,5), dormitories[fake.pyint(0,len(dormitories)-1)][0]]

with open('student.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['s_id', 's_name', 'phone_number', 'email', 'birth_date', 'learning_year', 'd_name'])
    for n in range(1000):
        x=gen_student()
        q=writer.writerow(x)
        student+=[x]

course_type=[]
def gen_c_type():
    return [fake.unique.pyint(10000,99999), fake.pyint(2,5), dep_list[fake.pyint(0,19)]]

with open('course_type.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['c_id', 'credits', 'dep_name'])
    for n in range(400):
        x=gen_c_type()
        q=writer.writerow(x)
        course_type+=[x]

fake.unique.clear()
learning_to=[]
def gen_learning_to():
    i = fake.pyint(0,39)
    return [student[fake.unique.pyint(0,len(student)-1)][0], deg[i][0], deg[i][1]]

with open('learning_to.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['s_id', 'dep_name', 'type_BA_or_MA'])
    for n in range(1000):
        x=gen_learning_to()
        q=writer.writerow(x)
        learning_to+=[x]

pre_course=[]
def gen_pre_course():
    c1=course_type[fake.pyint(0,len(course_type)-1)]
    c2=course_type[fake.pyint(0,len(course_type)-1)]
    while c1==c2 or c1[0]>c2[0] or c1[2]!=c2[2] or ([c1[0],c2[0]] in pre_course):
        c1=course_type[fake.pyint(0,len(course_type)-1)]
        c2=course_type[fake.pyint(0,len(course_type)-1)]
    return [c1[0],c2[0]]

with open('pre_course.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['c_id1', 'c_id2'])
    for n in range(400):
        x=gen_pre_course()
        q=writer.writerow(x)
        pre_course+=[x]

course=[]
def gen_course():
    g = 55 + 5*fake.pyint(0,1)
    t = fake.pyint(10,20)
    e = (20 - t) / 20.0
    t /= 20.0
    return [course_type[fake.pyint(0,len(course_type)-1)][0], fake.pyint(1,2), fake.pyint(2000, 2020), g, t, e, lecturer[fake.pyint(0,len(lecturer)-1)][2]]

with open('course.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['c_id', 'semester', 'course_year', 'grade_to_pass', 'test_percentage', 'exrecises_percentage', 'l_id'])
    for n in range(400):
        x=gen_course()
        q=writer.writerow(x)
        course+=[x]

exam=[]
def gen_date(y,s,m):
    n = 1 + (s-1)*6 + m
    return fake.date_between_dates(datetime.date(y,n,1), datetime.date(y,n,28))

with open('exam.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['moed', 'c_id', 'semester', 'course_year', 'exam_date', 'questions_num', 'factor'])
    for n in range(2*len(course)):
        x=[n%2,course[n//2][0],course[n//2][1],course[n//2][2],gen_date(course[n//2][2], course[n//2][1], n%2), fake.pyint(5,8), fake.pyint(0, 10)]
        q=writer.writerow(x)
        exam+=[x]

teaches=[]
def gen_teaches():
    c=course[fake.pyint(0,len(course)-1)]
    l=lecturer[fake.pyint(0,len(lecturer)-1)]
    return [c[0],c[1], c[2], l[2]]

with open('teaches.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['c_id', 'semester', 'course_year', 'l_id'])
    for n in range(400):
        x=gen_teaches()
        while x in teaches:
            x=gen_teaches()
        q=writer.writerow(x)
        teaches+=[x]

learned=[]
def gen_learned():
    c=course[fake.pyint(0,len(course)-1)]
    s=student[fake.pyint(0,len(student)-1)]
    e = fake.pyint(60,100)
    ma = fake.pyint(40,100)
    if ma*c[4]+e*c[5] > c[3]+5:
        mb=-1
        g=ma*c[4]+e*c[5]
    else:
        mb = fake.pyint(50,100)
        g=mb*c[4]+e*c[5]
    
    return [c[0],c[1], c[2], s[0], g,e,ma,mb]

with open('learned.csv', 'w') as csvfile:
    writer = csv.writer(csvfile)
    q=writer.writerow(['c_id', 'semester', 'course_year', 's_id', 'grade', 'ex_grade', 'moedAgrade', 'moedBgrade'])
    for n in range(5000):
        x=gen_learned()
        q=writer.writerow(x)
        learned+=[x]
