-- uni_db

-- students table
-- contains the ids and passwords of all students.
create table students (
  id int not null,
  password varchar(255) not null,
  primary key (id)
);

-- lecturers table
-- contains the ids and passwords of all lecturers.
create table lecturers (
  id int not null,
  password varchar(255) not null,
  primary key (id)
);

-- Tables bellow used for classes and attendance.
-- Each class will have two tables:
-- - class_details - contains the list of all lessons for a class with their ID, start date/time and duration,
-- - class_attendance - contains the attendance for each student for every class.
--
-- NOTE: The class_attendance table will have no columns except for the list of students in the class by default
--       rather, it will add columns everytime a new lesson is added to the class_details table.
--
-- NOTE: Each class/unit will have a specific name for each table, for example:
-- The Operating Systems unit for ICS 2B will have it's two tables titled:
-- ICS2202_BICS2B_details  and ICS2202_BICS2B_attendance
-- The first part contains the unit code, while the second part contains the degree/course and group taking the unit.
--
-- Since this is a demo, this database will only have a single class for a single course.
-- The unit in this case has the code ICS2202 and the class has the code BICS2B.

-- classes table
-- A table containing the ids of all classes which is used to lookup and reference the details and attendance tables.
create table classes (
  class_id varchar(255) not null,
  primary key (class_id)
);

-- class details table
create table ICS2202_BICS2B_details (
  lesson_id int not null,
  lesson_datetime datetime not null,
  duration time not null,
  primary key (lesson_id)
);

-- class attendance table
create table ICS2202_BICS2B_attendance (
  student_id int not null,
  lesson_1 bool not null default false,
  primary key (student_id),
  foreign key (student_id) references students(id)
);


-- Setting up some default data/users for the tables.
insert into students values (166335, 'Password');
insert into lecturers values (123456, 'Password');
insert into classes values ('ICS2202_BICS2B');
insert into classes values ('ICS2203_BBIT2A');

-- Add lessons to the class
insert into ICS2202_BICS2B_details values 
  (1, '2024-10-18 08:15:00', '02:00:00'),
  (2, '2024-10-25 12:15:00', '02:00:00');
alter table ICS2202_BICS2B_attendance add lesson_2 bool not null default false;

-- Add student to class
insert into ICS2202_BICS2B_attendance(student_id, lesson_1) values (166335, true);

select * from students;
select * from lecturers;
select * from classes;
select * from ICS2202_BICS2B_details;
select * from ICS2202_BICS2B_attendance;