CREATE TABLE lecturer
(
  phone_number VARCHAR2(30) NOT NULL,
  email VARCHAR2(50) NOT NULL,
  l_id INT NOT NULL,
  l_name VARCHAR(40) NOT NULL,
  salary_per_month INT NOT NULL,
  PRIMARY KEY (l_id)
);

CREATE TABLE dormitories
(
  d_name VARCHAR(20) NOT NULL,
  rooms_num INT NOT NULL,
  beds_num INT NOT NULL,
  PRIMARY KEY (d_name)
);

CREATE TABLE department
(
  dep_name VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  phone_number VARCHAR(30) NOT NULL,
  l_id INT NOT NULL,
  PRIMARY KEY (dep_name),
  FOREIGN KEY (l_id) REFERENCES lecturer(l_id)
);

CREATE TABLE deg
(
  type_BA_or_MA VARCHAR(2) NOT NULL,
  credits INT NOT NULL,
  thesis VARCHAR(1) NOT NULL,
  dep_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (type_BA_or_MA, dep_name),
  FOREIGN KEY (dep_name) REFERENCES department(dep_name)
);

CREATE TABLE working_for
(
  l_id INT NOT NULL,
  dep_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (l_id, dep_name),
  FOREIGN KEY (l_id) REFERENCES lecturer(l_id),
  FOREIGN KEY (dep_name) REFERENCES department(dep_name)
);

CREATE TABLE student
(
  s_id INT NOT NULL,
  s_name VARCHAR(40) NOT NULL,
  phone_number VARCHAR(30) NOT NULL,
  email VARCHAR(50) NOT NULL,
  birth_date DATE NOT NULL,
  learning_year INT NOT NULL,
  d_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (s_id),
  FOREIGN KEY (d_name) REFERENCES dormitories(d_name)
);

CREATE TABLE course_type
(
  c_id INT NOT NULL,
  credits INT NOT NULL,
  dep_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (c_id),
  FOREIGN KEY (dep_name) REFERENCES department(dep_name)
);

CREATE TABLE learning_to
(
  s_id INT NOT NULL,
  type_BA_or_MA VARCHAR(2) NOT NULL,
  dep_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (s_id, type_BA_or_MA, dep_name),
  FOREIGN KEY (s_id) REFERENCES student(s_id),
  FOREIGN KEY (type_BA_or_MA, dep_name) REFERENCES deg(type_BA_or_MA, dep_name)
);

CREATE TABLE pre_course
(
  c_id_1 INT NOT NULL,
  c_id_2 INT NOT NULL,
  PRIMARY KEY (c_id_1, c_id_2),
  FOREIGN KEY (c_id_1) REFERENCES course_type(c_id),
  FOREIGN KEY (c_id_2) REFERENCES course_type(c_id)
);

CREATE TABLE course
(
  semester INT NOT NULL,
  course_year INT NOT NULL,
  grade_to_pass INT NOT NULL,
  test_percentage FLOAT NOT NULL,
  exrecise_percentage FLOAT NOT NULL,
  c_id INT NOT NULL,
  l_id INT NOT NULL,
  PRIMARY KEY (semester, course_year, c_id),
  FOREIGN KEY (c_id) REFERENCES course_type(c_id),
  FOREIGN KEY (l_id) REFERENCES lecturer(l_id)
);

CREATE TABLE exam
(
  exam_date DATE NOT NULL,
  questions_num INT NOT NULL,
  factor INT NOT NULL,
  moed INT NOT NULL,
  semester INT NOT NULL,
  course_year INT NOT NULL,
  c_id INT NOT NULL,
  PRIMARY KEY (moed, semester, course_year, c_id),
  FOREIGN KEY (semester, course_year, c_id) REFERENCES course(semester, course_year, c_id)
);

CREATE TABLE teaches
(
  semester INT NOT NULL,
  course_year INT NOT NULL,
  c_id INT NOT NULL,
  l_id INT NOT NULL,
  PRIMARY KEY (semester, course_year, c_id, l_id),
  FOREIGN KEY (semester, course_year, c_id) REFERENCES course(semester, course_year, c_id),
  FOREIGN KEY (l_id) REFERENCES lecturer(l_id)
);

CREATE TABLE learned
(
  grade INT NOT NULL,
  exrecises_grade INT NOT NULL,
  moedAgrade INT NOT NULL,
  moedBgrade INT NOT NULL,
  s_id INT NOT NULL,
  semester INT NOT NULL,
  course_year INT NOT NULL,
  c_id INT NOT NULL,
  PRIMARY KEY (s_id, semester, course_year, c_id),
  FOREIGN KEY (s_id) REFERENCES student(s_id),
  FOREIGN KEY (semester, course_year, c_id) REFERENCES course(semester, course_year, c_id)
);
