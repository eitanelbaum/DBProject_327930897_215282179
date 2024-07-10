--given a course and a lecturer, check if the lecturer is free to teach the course
create or replace function check_free_lecturer(cy number, sem number, ci number, li number)
return number is
       cnd number;
       numCrs number;
       nm varchar2(20);
       d_ser varchar2(20);
       flag boolean := false;
       --the departments name that lecturer is working for
       cursor dpnm is
        ((select w.dep_name
        from working_for w
        where w.l_id = li)
        union
        (select d.dep_name
        from department d
        where d.l_id = li));
begin
    --get the department name of the course
    select c.dep_name into nm
    from course_type c
    where c.c_id=ci
    fetch first 1 rows only;
    
    --check if the lecturer works for that department
    open dpnm;
    loop
      fetch dpnm into d_ser;
      exit when dpnm%notfound;
      if d_ser=nm then flag := true; end if;
    end loop;
    close dpnm;
    if not flag then return 0; end if;
    
    --check that he doesnt teach too much courses in that semester (at most one more course)
    select count(*) into numCrs
    from teaches t
    where t.course_year=cy and t.semester=sem and t.c_id!=ci and t.l_id=li;
    if numCrs >= 2 then return 0; end if;
    
    return 1;
    
    exception
      when others then
        raise;
end;
/

create or replace function get_free_lecturers(cy number, sem number, ci number)
return sys_refcursor is
       l_cursor sys_refcursor;
begin
    --send only the free lecturers, as a ref cursor
    open l_cursor for
        select l.l_id
        from lecturer l
        where (check_free_lecturer(cy,sem,ci,l.l_id)=1)
        order by dbms_random.value;
    return l_cursor;
    
    exception
      when others then
        raise;
end;
/



