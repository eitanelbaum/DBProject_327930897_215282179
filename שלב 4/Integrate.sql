alter table person rename column ID to p_id;
alter table person rename column name to p_name;
alter table person add (email varchar2(30));
update person set email = lower(dbms_random.string('L', 8)) || '@gmail.com';
commit;
alter table person add (birth_date date);
update person
set birth_date = sysdate - age*365 - dbms_random.value(1, 364);
update person
set birth_date = to_date(to_char(birth_date,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;
alter table person drop column age;


alter table room add(d_name varchar2(20));
update room r
set r.d_name = (select d.d_name
               from (select d_name, ROW_NUMBER() over  (order by rooms_num) as rn
                    from dormitories) d
               where d.rn = BuildingID);
commit;
alter table room rename column RoomID to roomNumber;
alter table room drop constraint SYS_C0010361;
alter table student1 drop constraint SYS_C0010371;
alter table room drop constraint SYS_C0010360;
alter table room add constraint pk_room primary key(d_name, roomNumber);
alter table room add constraint fk_room_d_name foreign key(d_name) references dormitories(d_name);
alter table room drop column buildingID;

alter table worksIn add(d_name varchar2(20));
update worksIn w
set w.d_name = (select d.d_name
               from (select d_name, ROW_NUMBER() over  (order by rooms_num) as rn
                    from dormitories) d
               where d.rn = BuildingID);
commit;
alter table worksIn drop constraint SYS_C0010384;
drop table building;
alter table worksIn drop constraint SYS_C0010382;
alter table worksIn drop column buildingID;
alter table worksIn add constraint fk_worksIn_d_name foreign key(d_name) references dormitories(d_name);
alter table worksIn rename column ID to p_id;
alter table worksIn add constraint pk_worksIn primary key(d_name, p_id);

alter table person
modify (phoneNumber varchar2(30));
alter table person
modify (email varchar2(40));
insert into person (p_id, p_name, birth_date, email, phoneNumber)
select s_id, s_name,birth_date,email,phone_number
from student;
commit;

alter table student drop column email;
alter table student drop column phone_number;
alter table student drop column s_name;
alter table student drop column birth_date;
alter table student add(roomNumber number);
alter table student drop constraint SYS_C0010144;
update student set roomNumber = floor(dbms_random.value(1, 2.9999));
commit;
alter table student add constraint fk_student_room foreign key(d_name, roomNumber) references room(d_name, roomNumber);
alter table student add constraint fk_student_person foreign key(s_id) references person(p_id);

alter table worker rename column ID to w_id;
alter table worker add(salary_per_month number);
update worker set salary_per_month = floor(dbms_random.value(20000, 45000));
commit;

alter table lecturer add(birth_date date);
update lecturer set birth_date = sysdate - dbms_random.value(365*30, 365*60);
update lecturer set birth_date = to_date(to_char(birth_date,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;
insert into person (p_id, p_name, birth_date, email, phoneNumber)
select l_id, l_name,birth_date,email,phone_number
from lecturer;
commit;
alter table lecturer drop column email;
alter table lecturer drop column phone_number;
alter table lecturer drop column birth_date;
alter table lecturer drop column l_name;
alter table lecturer add(hire_date date);
update lecturer set hire_date = sysdate - dbms_random.value(0, 365*10);
update lecturer set hire_date = to_date(to_char(hire_date,'dd/mm/yyyy'),'dd/mm/yyyy');
commit;
insert into worker (w_id, hireDate, salary_per_month)
select l_id, hire_date, salary_per_month
from lecturer;
commit;
alter table lecturer drop column hire_date;
alter table lecturer drop column salary_per_month;
alter table lecturer add constraint fk_lecturer_worker foreign key(l_id) references worker(w_id);

create table dormitory_worker (
    dw_id number primary key,
    constraint fk_dormitory_worker
    foreign key (dw_id) references worker(w_id)
);
alter table cleaner rename column ID to c_id;
alter table manager rename column ID to m_id;
insert into dormitory_worker (dw_id)
select c_id
from cleaner;
insert into dormitory_worker (dw_id)
select m_id
from manager;
commit;
alter table worksIn rename column p_id to dw_id;
alter table worksIn drop constraint SYS_C0010383;
alter table worksIn add constraint fk_worksIn_dw_id foreign key(dw_id) references dormitory_worker(dw_id);

alter table cleaner drop constraint SYS_C0010379;
alter table cleaner add constraint fk_cleaner_dw_id foreign key(c_id) references dormitory_worker(dw_id);

alter table manager drop constraint SYS_C0010375;
alter table manager add constraint fk_manager_dw_id foreign key(m_id) references dormitory_worker(dw_id);
alter table manager rename column department to responsibility;

alter table student1 rename column ID to s_id;
alter table student1 add(d_name varchar2(20));
update student1 s
set s.d_name = (select d.d_name
               from (select d_name, ROW_NUMBER() over  (order by rooms_num) as rn
                    from dormitories) d
               where d.rn = s.BuildingID);
commit;
alter table student1 drop column buildingID;
alter table student1 add(learning_year number);
update student1 set learning_year = floor(dbms_random.value(1, 5.9999));
commit;
alter table student1 drop column enrollmentDate;
alter table student1 drop column major;
alter table student1 add(dep_name varchar2(20));
alter table student1 add(type_ba_or_ma varchar2(2));
update student1 s
set (s.dep_name,s.type_ba_or_ma) = (select d.dep_name,d.type_ba_or_ma
               from (select * from deg
                    order by (dbms_random.value+s.s_id)
                    fetch first 1 rows only) d);
commit;
insert into student (s_id, learning_year, d_name, roomNumber)
select s_id, learning_year, d_name, roomId
from student1;
insert into learning_to (s_id, type_ba_or_ma, dep_name)
select s_id, type_ba_or_ma, dep_name
from student1;
drop table student1;

alter table dormitories drop column rooms_num;
alter table dormitories drop column beds_num;
update dormitories d
set d.free_beds_num = (select sum(maxCapacity) from room r where r.d_name=d.d_name)
                      -(select count(*) from student s where s.d_name=d.d_name);
commit;
