/*constaints*/

--check final grades are between 0 and 100
alter table learned
add constraint chk_grade check (grade between 0 and 100);
insert into SYSTEM.LEARNED (GRADE, EXRECISES_GRADE, MOEDAGRADE, MOEDBGRADE, S_ID, SEMESTER, COURSE_YEAR, C_ID)
values (101, 100, 100, 100, 4571258, 1, 2020, 92893);

--checks that the pre course id is smaller than the next course
alter table pre_course
add constraint chk_dep check (c_id_1 < c_id_2);
insert into SYSTEM.PRE_COURSE (C_ID_1, C_ID_2)
values (48455, 56103);
rollback;
insert into SYSTEM.PRE_COURSE (C_ID_1, C_ID_2)
values (56103, 48455);

--make sure that no two departments have the same email address
alter table department
add unique(email);
insert into SYSTEM.DEPARTMENT (DEP_NAME, EMAIL, PHONE_NUMBER, L_ID)
values ('magic', 'julie29@example.net', '0542088562', 5970291);
