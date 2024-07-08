/*update queries*/

--decrease by 2 the beds number for each dormitory where there are more than 5 unnecessary beds
select * from dormitories;
update dormitories d
    set d.beds_num = case
        when (select count(*) from student s where s.d_name = d.d_name) < d.beds_num-5 then d.beds_num-2
        else d.beds_num
end;
select * from dormitories;
rollback;
select * from dormitories;

--add 2 points to each exam in courses of math department, and update the exams grades and final grades for the studetns
select * from exam where c_id in (select c.c_id from course_type c where c.dep_name = 'math');
select s.s_name,s.s_id,l.moedAgrade,l.moedBgrade,l.grade
from student s join learned l on l.s_id=s.s_id
where l.c_id in (select c.c_id from course_type c where c.dep_name = 'math');
update exam e
    set e.factor = e.factor + 2
    where e.c_id in (select c.c_id from course_type c where c.dep_name = 'math');
update learned l
    set l.moedAgrade = case
                       when l.moedAgrade >= 98 then 100
                       else l.moedAgrade+2
                       end,
        l.moedBgrade = case
                       when l.moedBgrade >= 98 then 100
                       when l.moedBgrade=-1 then -1
                       else l.moedBgrade+2
                       end
    where l.c_id in (select c.c_id from course_type c where c.dep_name = 'math');
update learned l
    set l.grade = (case
                  when moedBgrade=-1 then moedAgrade
                  else moedBgrade
                  end)*(select avg(c.test_percentage) from course c where c.c_id=l.c_id and c.course_year=l.course_year and c.semester=l.semester) + 
                  l.exrecises_grade*(select avg(c.exrecise_percentage) from course c where c.c_id=l.c_id and c.course_year=l.course_year and c.semester=l.semester)
    where l.c_id in (select c.c_id from course_type c where c.dep_name = 'math');
select * from exam where c_id in (select c.c_id from course_type c where c.dep_name = 'math');
select s.s_name,s.s_id,l.moedAgrade,l.moedBgrade,l.grade
from student s join learned l on l.s_id=s.s_id
where l.c_id in (select c.c_id from course_type c where c.dep_name = 'math');
rollback;
select * from exam where c_id in (select c.c_id from course_type c where c.dep_name = 'math');
select s.s_name,s.s_id,l.moedAgrade,l.moedBgrade,l.grade
from student s join learned l on l.s_id=s.s_id
where l.c_id in (select c.c_id from course_type c where c.dep_name = 'math');
