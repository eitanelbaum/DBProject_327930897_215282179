/*changes*/

--update learned and student to be deleted cascade when delete student
alter table learned
drop constraint sys_c0010154;
alter table learned
add constraint sys_c0010154 foreign key (s_id)
references student (s_id)
on delete cascade;

--update learning_to and student to be deleted cascade when delete student
alter table learning_to
drop constraint sys_c0010160;
alter table learning_to
add constraint sys_c0010160 foreign key (s_id)
references student (s_id)
on delete cascade;
