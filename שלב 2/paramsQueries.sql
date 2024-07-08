/*parameters queries*/

--check for list of names who are students in the university
select *
from student s
where s.s_name in (&<name=names_list hint="list of names">);

--get all studetns learning in chosen department who did between a to b courses
select s.s_id,s.s_name,count(*) as courses_num
from student s
     join learning_to l
     on l.s_id=s.s_id
     join learned le
     on le.s_id=s.s_id
where l.dep_name = &<name=departure_name type="string" hint="name of departure">
group by s.s_id, s.s_name
having count(*)>=&min_courses_num and count(*)<=&max_courses_num
order by count(*);

--all lecturers having exam in their course between two given dates, order by num of exams they have between those dates
select l.l_id, l.l_name, count(*) as num_of_exams
from lecturer l
     join teaches t
     on t.l_id=l.l_id
     join exam e
     on (e.c_id=t.c_id and e.semester=t.semester and e.course_year=t.course_year)
where e.exam_date >= to_date('&min_date', 'dd/mm/yyyy') and e.exam_date <= to_date('&max_date', 'dd/mm/yyyy')
group by l.l_id, l.l_name
order by count(*);

--all students who did x courses or more, in year y, and had avarage of z or more
select s.s_name, s.s_id, avg(l.grade) as avarage_grade, count(*) as courses_amount
from student s
     join learned l
     on l.s_id=s.s_id
where l.course_year=&<name=year_to_check type="integer" hint="year to find excellent students">
group by s.s_name,s.s_id
having avg(l.grade)>=&<name=avg_grade type="float" hint="avarage_grade_for_exellence"> and count(*)>=&<name=mn_courses type="integer" hint="courses_amount_for_exellence">;
