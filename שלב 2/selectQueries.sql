/*select queries*/

--students who have avarage more than 90, sorted by their avarage
select S.s_name,S.s_id,avg(L.grade) as grades_avarage
from student S, learned L
where (L.s_id = S.s_id)
group by S.s_id,S.s_name
having avg(L.grade) > 90
order by avg(L.grade);

--10 youngest and 10 oldest students, who did more than 8 courses, sorted by their age, calculated from their birth_date
select r.s_name,r.s_id,(sysdate-r.birth_date)/365.2524 as age
from (select *
      from student S
      where (select count(*)
             from learned L
             where L.s_id = s.s_id)>8) R
where (select count(*)
       from (select *
             from student S
             where (select count(*)
                    from learned L
                    where L.s_id = s.s_id)>8) Q
       where q.birth_date > r.birth_date)<10
       or
       (select count(*)
       from (select *
             from student S
             where (select count(*)
                    from learned L
                    where L.s_id = s.s_id)>8) Q
       where q.birth_date < r.birth_date)<10
order by r.birth_date desc

--dormitories where where are more residents than rooms, sorted by the difference
select d.d_name, d.rooms_num, count(*) as residents_number
from dormitories d join student s on d.d_name=s.d_name
group by d.d_name, d.rooms_num
having count(*) > d.rooms_num
order by d.rooms_num-count(*), d.rooms_num;

--cases when the original test grade is not sure because the grade is 100 and there was a factor
select s.s_name, l.moedAgrade as test_grade, e.factor
from (student s
     join learned l
     join course c 
     on (c.c_id=l.c_id and c.course_year=l.course_year and c.semester=l.semester) 
     on l.s_id=s.s_id 
     join exam e 
     on (c.c_id=e.c_id and c.course_year=e.course_year and c.semester=e.semester))
where l.moedAgrade = 100 and e.moed=0 and e.factor>0
union
select s.s_name, l.moedBgrade as test_grade, e.factor
from (student s
     join learned l
     join course c 
     on (c.c_id=l.c_id and c.course_year=l.course_year and c.semester=l.semester) 
     on l.s_id=s.s_id 
     join exam e 
     on (c.c_id=e.c_id and c.course_year=e.course_year and c.semester=e.semester))
where l.moedBgrade = 100 and e.moed=1 and e.factor>0;
