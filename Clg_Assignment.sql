
create database assignment;

use assignment;

-- Q1

create table Department (
Deptno int(2) auto_increment ,
Dname varchar(20) not null,
City varchar(20) ,
primary key(Deptno)
);

create table Employ (
Empno int(4) auto_increment,
Ename varchar(20) not null,
Salary int(6) check(Salary>10000),
Doj date,
mgr int(4),
Deptno int(2),
primary key(Empno),
foreign key(Deptno)references Department(Deptno)
); 

-- Q2
desc Department;
desc Employ;

-- Q3
insert into Department(Deptno,Dname,City) 
value
(1,"Finance","Bhopal"),
(2,"Testing","Jaipur"),
(3,"Development","Agra"),
(4,"Sales","Delhi"),
(5,"Training","Mumbai");

-- Q4
insert into Employ(Ename,Salary,Doj,Deptno)
values
("Suresh",70000, '2004-03-12',1),
("Sharma",73000, '2005-11-15',4),
("Guru",50000, '2012-05-22',4),
("Raju",55000, '2011-12-23',3),
("Rakesh",80000, '2002-02-02',3),	
("Arab",62000, '2006-05-12',2),
("Abra",47000, '2010-08-20',5),
("Sourabh",40000, '2015-10-18',5),
("Prateek",70000, '2005-06-28',3),
("Gaurav",60000, '2013-12-02',2),
("Sharad",74000, '2002-04-02',1);

-- Q5
select* from Employ;

-- Q6
alter table Employ
add Designation varchar(15);

-- Q7
update Employ set Designation="Budgets" where Empno =1;
update Employ set Designation="Adminestrator" where Empno =2;
update Employ set Designation="Advitising" where Empno =3;
update Employ set Designation="Research" where Empno =4;
update Employ set Designation="Preliminary Design" where Empno =5;
update Employ set Designation="Selenium" where Empno =6;
update Employ set Designation="Programming" where Empno =7;
update Employ set Designation="Marketing" where Empno =8;
update Employ set Designation="Application Dev" where Empno =9;
update Employ set Designation="Application Testing" where Empno =10;
update Employ set Designation="Financial Planning" where Empno =11;

-- Q8
alter table Employ
modify Designation char(30);

-- Q9
select* from Employ
where Salary>65000;

-- Q
update employ set Doj=NULL where Empno in(1,4,7);

-- Q10
select * from Employ 
where Doj is null;

-- Q12

select * from Employ
where salary between 50000 and 60000;

-- Q13
select Ename, Designation from Employ
where Deptno in(1,3,5);

-- Q14
select Ename,Dname from Employ,Department
where Employ.Deptno=Department.Deptno;

-- Q15
select Ename from Employ as E,Department as D 
where (E.Deptno=D.Deptno)and city="Jaipur";

-- Q16
select Dname,sum(Salary) from Employ as E, Department as D
where (E.Deptno=D.Deptno)
group by Dname;

-- Q
update employ set mgr=11 where empno=1;
update employ set mgr=4 where empno=2;
update employ set mgr=1 where empno=3;
update employ set mgr=6 where empno=5;
update employ set mgr=7 where empno=9;
update employ set mgr=6 where empno=10;
-- and e1.mgr=(select empno from enploy)

-- Q17
select e1.ename as manager,e2.ename as employee from employ as e1,employ as e2 
where (e1.empno=e2.mgr);

-- Q18
commit;
update employ set salary=(salary+salary*0.1) where salary<50000;

-- Q20

select d.dname, e.ename 
from employ as e,
(select dname,deptno 
from department 
group by dname) as d
where d.deptno=e.deptno;

-- Q21

select dname, max(salary) from department d,employ e
where d.deptno=e.deptno
group by dname;

-- Q22
select dname, count(*) no_of_emp  from department d, employ e
where d.deptno=e.deptno
group by dname;

-- Q23

select dname,empno, ename, salary  
from employ e join department d on d.deptno=e.deptno
where salary in(select max(salary) from employ e join department d on d.deptno=e.deptno 
									   group by dname);
-- commit;
-- Q24
update employ set salary = (salary+salary*0.05) where deptno=3 and(salary<60000);

-- Q25 
-- commit;
delete from employ where empno=2;
-- rollback;

-- Q27
-- commit;
create table dept2 as (select * from employ where deptno=2);

-- Q28
-- commit;
create view view_dept2 as (select * from employ where deptno=2);
-- select * from view_dept2;
-- Q29
update view_dept2 set salary=(salary+salary*0.05);
-- commit;
-- Q30
drop view view_dept2;
-- rollback; rollback will not work on DDL command
