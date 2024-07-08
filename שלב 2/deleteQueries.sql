/*delete queries*/

--delete from the data base students who did no course and students who did their last course 10+ years ago
select count(*) from learned union select count(*) from student;
--because of the alters deleting studetn is enough
delete from student r
where r.s_id in ((select s.s_id
                 from student s
                      join learned l
                      on l.s_id=s.s_id
                  group by s.s_id,s.s_name
                  having extract(year from sysdate)-10 > max(l.course_year))
                  union
                  (select s.s_id
                  from student s
                  where (select count(*)
                        from learned l
                        where s.s_id=l.s_id) = 0));
select count(*) from learned union select count(*) from student;
rollback;
select count(*) from learned union select count(*) from student;

--delete moed B exams no student did
select count(*) from exam;
delete from exam f
where (f.c_id,f.semester,f.course_year,f.moed) in
      (select e.c_id,e.semester,e.course_year,e.moed
      from exam e
           join course c
           on (c.c_id=e.c_id and c.semester=e.semester and c.course_year=e.course_year)
           join learned l
           on (c.c_id=l.c_id and c.semester=l.semester and c.course_year=l.course_year)
      where e.moed=1
      group by e.c_id,e.semester,e.course_year,e.moed
      having max(l.moedBgrade)=-1);
select count(*) from exam;
rollback;
select count(*) from exam;
