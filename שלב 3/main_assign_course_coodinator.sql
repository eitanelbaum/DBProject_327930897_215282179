declare
    ci number := 14246;
    cy number := 2012;
    sem number := 2;
    li number;
    l_cursor sys_refcursor;
    no_free_lecturer exception;
begin
    --get one random free lecturer
    l_cursor := get_free_lecturers(cy, sem, ci);
    fetch l_cursor into li;
    
    --check that the cursor is not empty
    if l_cursor%notfound then raise no_free_lecturer; end if;
    
    --assign the lecturer to the course
    assign_course_coodinator(ci,cy,sem,li);
    
    --handle exceptions
    exception
      when no_free_lecturer then
        dbms_output.put_line('there is no free lecturer to teach the course');
      when others then
        dbms_output.put_line('An error occurred: ' || sqlerrm);
end;
/
