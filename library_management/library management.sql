--creating table
--Table for branch:-
DROP TABLE branch CASCADE; --ye isliye use kiye coz ek baar foreign key use kiye to phir agr koi change krte h create table me to nhi hoga 
--drop table if exists branch;
create table branch
(branch_id varchar(10) primary key , 
manager_id varchar(10) ,
branch_address varchar(50),
contact_no varchar(20) );

--Table for employess:-
DROP TABLE employees CASCADE;
--drop table if exists employess;
create table employees(emp_id varchar(10) primary key,	
emp_name varchar(19), 
position varchar(15) ,
salary	float  ,
branch_id varchar(10) , FOREIGN KEY (branch_id)
REFERENCES branch(branch_id));


--Table for members:-
DROP TABLE members CASCADE;
--drop table if exists members;
create table members (member_id varchar (10) primary key,
member_name varchar (25),
member_address varchar (75),
reg_date date);

--Table for books:-
DROP TABLE books CASCADE;
--drop table if exists books;
create table books (isbn varchar(20) primary key,
book_title varchar (75),
category varchar (25),
rental_price float,	
status varchar (15),
author varchar (75),
publisher varchar (75));

--Table for issued_status:-
DROP TABLE issued_status CASCADE;
--drop table if exists issued_status ;
create table issued_status(issued_id varchar(10) primary key ,
issued_member_id varchar(10) , foreign key (issued_member_id ) references members (member_id),
issued_book_name varchar(75),
issued_date date,
issued_book_isbn varchar (50) , foreign key (issued_book_isbn) references books (isbn),
issued_emp_id varchar (10) , foreign key (issued_emp_id ) references employees(emp_id));

--Table for return_status:-
DROP TABLE return_status CASCADE;
--drop table if exists return_status;
create table return_status (return_id varchar(10) primary key ,
issued_id varchar (10) ,foreign key (issued_id) references issued_status (issued_id),
return_book_name varchar(75),
return_date	date,
return_book_isbn varchar (50) ,foreign key (return_book_isbn) references books (isbn));

--import data from csv file 
copy
branch (branch_id,	manager_id,branch_address,contact_no)
from 'D:\datasets\branch.csv'
delimiter ','
csv header;

copy
employees(emp_id,emp_name,	position	,salary	,branch_id)
from 'D:\datasets\employees.csv'
delimiter ','
csv header;

copy
members (member_id,member_name,member_address,reg_date)
from 'D:\datasets\members.csv'
delimiter ','
csv header;

copy 
books (isbn	,book_title	,category,	rental_price,	status	,author,	publisher)
from 'D:\datasets\books.csv'
delimiter ','
csv header;

copy
issued_status (issued_id	,issued_member_id,issued_book_name,issued_date,issued_book_isbn,issued_emp_id)
from 'D:\datasets\issued_status.csv'
delimiter ','
csv header;

copy
return_status(return_id	,issued_id	,return_book_name	,return_date	,return_book_isbn)
from 'D:\datasets\return_status.csv'
delimiter ','
csv header;

