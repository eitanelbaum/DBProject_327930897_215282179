--get one not full dormitory
create or replace function get_one_not_full_dormitory(dnm varchar2)
return varchar2 is
       new_nm varchar2(20);
begin
    --check that it's not full, and that it's not the original dormitory
    select d_name into new_nm
    from dormitories
    where d_name!=dnm
          and free_beds_num > 0
    order by dbms_random.value
    fetch first 1 rows only;
    return new_nm;
    
    exception
      when others then
        raise;
end;
/
