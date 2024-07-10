create or replace procedure assign_course_coodinator
(ci number, cy number, sem number, li number) is
    not_good_lecturer exception;
begin
    --check that the given lecturer is free
    if (check_free_lecturer(cy,sem,ci,li)=0) then
      raise not_good_lecturer;
    end if;
    
    --update the coordinator of that course
    update course
    set l_id = li
    where (c_id=ci and semester=sem and course_year=cy);
    
    --update the table teaches, with the values of the lecturer and the course
    insert into SYSTEM.TEACHES (SEMESTER, COURSE_YEAR, C_ID, L_ID)
    values (sem, cy, ci, li);
    commit;
    
    exception
      when not_good_lecturer then
        rollback;
        raise_application_error(-20001, 'the lecturer is not free');
      when others then
        rollback;
        raise;
end;
/
