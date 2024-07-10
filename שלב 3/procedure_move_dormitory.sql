--given id of student, return is full name
create or replace function get_student_name_from_id(sti number)
return varchar2 is
       nm varchar2(20);
begin
    select s_name into nm
    from student
    where s_id=sti;
    return nm;
    
    exception
      when others then
        raise;
end;
/

create or replace procedure move_dormitory
(sti number, dnm varchar2) is
    old_nm varchar2(20);
    full_dormitory exception;
    tmp number;
    snm varchar2(20);
begin
    --check if there is such a student
    select count(*) into tmp
    from student
    where s_id=sti;
    if tmp=0
      then raise value_error;
    end if;
    
    --check if there is such a dormitory
    select count(*) into tmp
    from dormitories
    where d_name=dnm;
    if tmp=0
      then raise value_error;
    end if;
    
    --check that the dormitory is not full
    select free_beds_num into tmp
    from dormitories
    where d_name=dnm;
    if tmp=0
      then raise full_dormitory;
    end if;
    
    select d_name into old_nm
    from student
    where s_id=sti;
    
    --update old dormitory, new dormitory, sudent
    update dormitories
    set free_beds_num = free_beds_num+1
    where d_name=old_nm;
    
    update dormitories
    set free_beds_num = free_beds_num-1
    where d_name=dnm;
    
    update student
    set d_name = dnm
    where s_id=sti;
    
    commit;
    
    --print the action we did
    snm := get_student_name_from_id(sti);
    dbms_output.put_line('moved ' || snm || ' from ' || old_nm || ' to ' || dnm);
    
    exception
      when full_dormitory then
        raise_application_error(-20001, 'the dormitory is full');
      when others then
        rollback;
        raise;
end;
/
