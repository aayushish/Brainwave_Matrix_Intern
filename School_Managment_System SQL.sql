CREATE DATABASE Students ;
SHOW DATABASES;
USE Students;


CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    grade VARCHAR(10),
    enrollment_date DATE
);


CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50),
    description TEXT
);


CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    subject_id INT,
    hire_date DATE,
    email VARCHAR(100),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);


CREATE TABLE Classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50),
    subject_id INT,
    teacher_id INT,
    schedule VARCHAR(100),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);


CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    class_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);


CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    class_id INT,
    grade VARCHAR(2),
    date_assigned DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

#INSERTING VALUES INTO TABLES


INSERT INTO Students (first_name, last_name, date_of_birth, gender, grade, enrollment_date)
VALUES
('John', 'Doe', '2006-05-14', 'M', '10th', '2024-08-01'),
('Jane', 'Smith', '2007-09-23', 'F', '9th', '2024-08-01'),
('Emily', 'Johnson', '2005-11-30', 'F', '11th', '2024-08-01'),
('Michael', 'Brown', '2006-03-15', 'M', '10th', '2024-08-01');

SELECT * FROM  students;

INSERT INTO Subjects (subject_name, description)
VALUES
('Mathematics', 'Study of numbers, shapes, and patterns'),
('Science', 'Study of the natural world through observation and experiment'),
('English', 'Study of literature and language'),
('History', 'Study of past events and their impact on the present');

SELECT * FROM Subjects;

INSERT INTO Teachers (first_name, last_name, subject_id, hire_date, email)
VALUES
('Alice', 'Williams', 1, '2022-06-01', 'alice.williams@example.com'),
('Bob', 'Davis', 2, '2021-03-15', 'bob.davis@example.com'),
('Carol', 'Martinez', 3, '2020-08-20', 'carol.martinez@example.com'),
('David', 'Wilson', 4, '2019-01-10', 'david.wilson@example.com');

SELECT * FROM Teachers;


INSERT INTO Classes (class_name, subject_id, teacher_id, schedule)
VALUES
('Algebra 101', 1, 1, 'Mon, Wed, Fri 10:00-11:00 AM'),
('Biology 202', 2, 2, 'Tue, Thu 9:00-10:30 AM'),
('English Literature', 3, 3, 'Mon, Wed 1:00-2:30 PM'),
('World History', 4, 4, 'Tue, Thu 2:00-3:30 PM');

SELECT * FROM Classes;


INSERT INTO Enrollments (student_id, class_id, enrollment_date)
VALUES
(1, 1, '2024-08-01'),
(1, 2, '2024-08-01'),
(2, 3, '2024-08-01'),
(3, 4, '2024-08-01'),
(4, 1, '2024-08-01'),
(4, 2, '2024-08-01');

SELECT * FROM Enrollments;


INSERT INTO Grades (student_id, class_id, grade, date_assigned)
VALUES
(1, 1, '90', '2024-08-30'),
(1, 2, '75', '2024-08-30'),
(2, 3, '85', '2024-08-30'),
(3, 4, '70', '2024-08-30'),
(4, 1, '75', '2024-08-30'),
(4, 2, '90', '2024-08-30');

SELECT * FROM Grades;

# SOME QUERIES

SELECT * FROM Students
WHERE grade = '10th';


SELECT C.class_name, S.subject_name
FROM Classes C
JOIN Subjects S ON C.subject_id = S.subject_id
WHERE C.teacher_id = 1; 

SELECT S.first_name, S.last_name
FROM Enrollments E
JOIN Students S ON E.student_id = S.student_id
WHERE E.class_id = 2; 


SELECT AVG(cast(G.grade as decimal)) AS average_grade
FROM Grades G
WHERE G.student_id = 1;  


SELECT S.subject_name, COUNT(C.class_id) AS class_count
FROM Subjects S
LEFT JOIN Classes C ON S.subject_id = C.subject_id
GROUP BY S.subject_name;


SELECT first_name, last_name, email,hire_date
FROM Teachers;


