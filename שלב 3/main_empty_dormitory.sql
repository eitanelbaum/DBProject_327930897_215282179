declare
    --get the dormitory name to empty as parameter
    dnm varchar2(20) := '&dorm_name';
    --the studetns who live there
    cursor dorm_students is
        select s_id from student where d_name=dnm;
    sti number;
    new_nm varchar2(20);
begin
    --for each student, pick a random not full dormitory, and move him there
    open dorm_students;
    loop
        fetch dorm_students into sti;
        exit when dorm_students%notfound;
        --pick a dormitory
        new_nm := get_one_not_full_dormitory(dnm);
        --move the student to the new dormitory
        move_dormitory(sti,new_nm);
    end loop;
    close dorm_students;
    
    --handle exceptions
    exception
      when others then
        dbms_output.put_line('An error occurred: ' || sqlerrm);
end;
/
