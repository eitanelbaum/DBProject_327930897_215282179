--view of lecturers in our original database
create or replace view originalLecturers as
select l.l_id,
       p.p_name as l_name,
       w.salary_per_month,
       p.phoneNumber,
       p.email,
       t.c_id,
       t.semester,
       t.course_year
from lecturer l
     join worker w
     on w.w_id=l.l_id
     join person p
     on p.p_id=w.w_id
     join teaches t
     on t.l_id=l.l_id;
select * from originalLecturers;
--salary per course for each lecturer
select l_id,l_name,salary_per_month,count(*) as courses_num, salary_per_month/count(*) as salary_per_course
from originalLecturers
group by l_id,l_name,salary_per_month
having count(*) > 1
order by salary_per_month/count(*);
--number of lecturers for each course
select c_id, semester, course_year, count(*) as lecturers_num
from originalLecturers
group by c_id, semester, course_year
order by count(*) desc;

--view of cleaners in the out database
create or replace view outCleaners as
select c.c_id as ID,
       w.hireDate,
       p.phoneNumber,
       p.p_name as name,
       extract(year from sysdate)-extract(year from p.birth_date) as age,
       c.shift,
       wi.d_name
from cleaner c
     join worker w
     on w.w_id=c.c_id
     join person p
     on p.p_id=w.w_id
     join worksIn wi
     on wi.dw_id=c.c_id;
select * from outCleaners;
--buildings that have more than two cleaners
select d_name, count(*) as cleaners_num
from outCleaners
group by d_name
having count(*) > 2
order by count(*);
--old or senior cleaners who have shift in evening
select id, name, age, extract(year from sysdate) - extract(year from hireDate) as seniority,shift
from outCleaners
where (age >= 40 or (extract(year from sysdate) - extract(year from hireDate)) >= 20) and shift = 'evening'
order by age desc;
