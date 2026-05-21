select * from branch;
select * from employees;
select * from members;
select * from books;
select * from issued_status;
select * from return_status;

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
insert into books values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee','J.B. Lippincott & Co');

-- Task 2: Update an Existing Member's Address
update members
set member_address='121 Main st'
where member_address='123 Main st';
-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.
delete from issued_status 
where issued_id='IS104';

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
select * from issued_status
where issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.
select issued_member_id,count(*) from issued_status 
group by issued_member_id
having count(*)>1
order by issued_member_id asc;

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
create table book_issued_cnt as
select b.isbn, b.book_title, count(ist.issued_id) as issue_count
from issued_status as ist
join books as b
on ist.issued_book_isbn = b.isbn
group by b.isbn, b.book_title;


-- Task 7. **Retrieve All Books in a Specific Category:
select * from books 
where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:
select category ,sum(rental_price) as rental_price from books
group by category ;

-- Task 9. **List Members Who Registered in the Last 180 Days**:
select * from members 
where reg_date >= current_date-interval '180 days';

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:
select e.emp_id,e.emp_name,e.position,e.salary ,b.*
from employees e join branch b
on b.branch_id=e.branch_id

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
create expensive_books as
select * from books
where rental_price > 7.00;

--Task 12: Retrieve the List of Books Not Yet Returned
select * from issued_status as ist
left join return_status as rs
on rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

--Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue
select  ist.issued_member_id,
m.member_name,
bk.book_title,
ist.issued_date, 
current_date - ist.issued_date as over_dues_days
from issued_status as ist
join members as m 
on m.member_id=ist.issued_member_id
join books as bk
on bk.isbn=ist.issued_book_isbn
left join
return_status  as rs
on rs.issued_id=ist.issued_id
where(current_date - ist.issued_date)>30;

--Task 14: Update Book Status on Return
--Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).
update books
set status = 'available'
WHERE isbn IN (
    select isbn
   from return_status
    where return_date IS NOT NULL
);

--Task 15: Branch Performance Report
--Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
create table branch_reports
AS
select
    b.branch_id,
    b.manager_id, count(ist.issued_id) as number_book_issued,count(rs.return_id) as number_of_book_return,
sum(bk.rental_price) as total_revenue from issued_status as ist
JOIN 
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
books as bk
ON ist.issued_book_isbn = bk.isbn
group by 1,2;

select * from branch_reports;


