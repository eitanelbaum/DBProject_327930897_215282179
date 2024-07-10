alter table dormitories
add(free_beds_num number);

update dormitories d
set d.free_beds_num = d.beds_num - (select count(*)
                                   from student s
                                   where s.d_name=d.d_name);
commit;
