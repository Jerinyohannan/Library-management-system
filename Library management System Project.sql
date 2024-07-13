create database library;
use library;
-- branch table 
CREATE TABLE Branch (
    Branch_no CHAR(5) PRIMARY KEY,
    Manager_Id INT NOT NULL,
    Branch_address VARCHAR(30),
    Contact_no BIGINT
);
INSERT INTO Branch (Branch_no, Manager_Id,Branch_address, Contact_no) VALUES
('B01', 1,'kochi main Library Kochi',6357895287),
('B02', 2,'Tvm Branch Thiruvananthapuram',8975489657),
('B03', 3,'Kollam Branch Kollam',7585897596);
-- employee table 
CREATE TABLE employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(20),
    Position VARCHAR(20),
    Salary INT NOT NULL,
    Branch_no CHAR(5),
    FOREIGN KEY (Branch_no)
        REFERENCES Branch (Branch_no)
);
INSERT INTO employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1, 'Alice Johnson', 'Librarian', 45000, 'B01'),
(2, 'John s', 'Assistant Librarian', 35000, 'B01'),
(3, 'Charlie', 'Library Technician', 30000, 'B02'),
(4, 'Sam ', 'Library Assistant', 28000, 'B02'),
(5, 'Davis', 'Library Manager', 50000, 'B03'),
(6, 'Jay', 'Library Clerk', 25000, 'B03'),
(7, 'Elizabeth', 'Library Clerk', 25000, 'B01'),
(8, 'Ravi', 'Library Technician', 30000, 'B01'),
(9, 'Alan', 'Library Manager', 50000, 'B01'),
(10, 'Tom', 'Library Clerk', 25000, 'B02');
INSERT INTO employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(11, 'Alice Johnson', 'Library Manager', 55000, 'B01');
-- Books 
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(650) NOT NULL,
    Category VARCHAR(200),
    Rental_Price INT NOT NULL,
    Status varchar(3),
    Author VARCHAR(250),
    Publisher VARCHAR(205)
);
-- imported csv fill using table data import 
select * from books;
update books set Rental_Price=30 where ISBN=2005018;
-- Customer
CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY,
    Customer_name VARCHAR(20),
    Customer_address VARCHAR(30),
    Reg_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
insert into Customer values (101, "Jerin","kollam", default);
insert into Customer values (102, "alen","kochi", default);
insert into Customer values (103, "albin","Thiruvananthapuram", default);
insert into Customer values (104, "rameez","kollam", default);
insert into Customer values (105, "subin","Thiruvananthapuram", default);
insert into Customer values (106, "subith","kochi", default), 
(107, "ameesha","kollam", default),(108, "adithya","kochi", default),
(109, "keerthi","Thiruvananthapuram", default),(110, "sneha","kochi", default),
(111, "adil","kollam", default),(112, "pranav","kochi", default),
(113, "mallesh","kochi", default),(114, "justin","Thiruvananthapuram", default),
(115, "ajay","kollam", default), (116, "rathod","kollam", default),
(117, "tanzeel","Thiruvananthapuram", default),(118, "praveen","kochi", default),
(119, "jobin","kollam", default),(120, "ikbal","Thiruvananthapuram", default);
select * from Customer;
insert into Customer values (90, "sam","Thiruvananthapuram", '2020-07-09 18:53:32');
insert into Customer values (91, "tom","Thiruvananthapuram", '2020-08-09 18:53:32');
insert into Customer values (92, "ram","Kollam", '2021-07-01 18:53:32');

-- IssueStatus
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issue_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust)
        REFERENCES Customer (Customer_id),
    FOREIGN KEY (Isbn_book)
        REFERENCES Books (ISBN)
);
-- creating trriger before inserting the data into issuestatus to not select avoid entering book not available by checking the books table
delimiter $$
create trigger before_issue_book_to_customer before insert on IssueStatus for each row
begin  DECLARE book_status varchar(3);
    SELECT Status INTO book_status FROM Books WHERE ISBN = NEW.Isbn_book;
    IF book_status = "No" THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot issue a book that is not available';
end if;
end$$
delimiter ;
-- creating trigger  after insertion for changing update the book status form the book table as not available after that book is issuesed to customer
delimiter $$
create trigger after_issue_book_to_customer after insert on IssueStatus for each row
begin UPDATE Books
    SET Status = "no"
    WHERE ISBN = NEW.Isbn_book;
end$$
delimiter ;

-- insering datas
insert into IssueStatus values (1,101,default,19515344);
insert into IssueStatus values (2,102,default,2005018);
insert into IssueStatus values (3,103,default,39913578);
insert into IssueStatus values (4,104,default,67942560);
insert into IssueStatus values (5,105,default,7432267);
insert into IssueStatus values (6,101,default,15520417);
insert into IssueStatus values (7,102,default,18813201);
insert into IssueStatus values (8,103,default,45226446);
insert into IssueStatus values (9,111,default,60980461);
insert into IssueStatus values (10,113,default,43909502);
insert into IssueStatus values (11,119,default,42516309);
insert into IssueStatus values (12,120,default,34424106);
insert into IssueStatus values (13,102,default,37540632);
insert into IssueStatus values (14,116,default,61099686);
insert into IssueStatus values (15,110,default,81252387);
insert into IssueStatus values (16,110,default,44022570);
insert into IssueStatus values (17,119,default,15604762);
insert into IssueStatus values (18,111,default,44900561);
insert into IssueStatus values (19,103,default,18532624);
insert into IssueStatus values (20,108,default,80410630);
insert into IssueStatus values (21,90,default,19515344);
insert into IssueStatus values (22,90,'2023-07-01 18:53:32',45226446);
insert into IssueStatus values (23,90,'2023-06-01 18:53:32',67187043);
insert into IssueStatus values (24,91,'2023-06-03 18:53:32',37415706);
insert into IssueStatus values (25,90,'2023-06-20 18:53:32',88784174);
select * from IssueStatus;
-- ReturnStatus
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(150),
    Return_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2)
        REFERENCES Books (ISBN),
	FOREIGN KEY (Return_cust)
        REFERENCES Customer (Customer_id)
);
-- creating after triggers to change the book status from no to yes
delimiter $$
create trigger after_return_book_to_customer after insert on ReturnStatus for each row
begin UPDATE Books
    SET Status = "Yes"
    WHERE ISBN = NEW.Isbn_book2;
end$$
delimiter ;

insert into ReturnStatus values (1,101,"A Tale of Two Cities",default,19515344);
insert into ReturnStatus values (2,102,'The Little Prince ',default,2005018);
insert into ReturnStatus values (3,103,'The Hobbit',default,39913578);
insert into ReturnStatus values (4,104,'Vardi Wala Gunda ',default,67942560);
insert into ReturnStatus values (5,105,'The Da Vinci Code',default,7432267);
insert into ReturnStatus values (6,101,'Harry Potter and the Order of the Phoenix',default,15520417);
insert into ReturnStatus values (7,102,'The Catcher in the Rye',default,18813201);
insert into ReturnStatus values (8,103,'Ben-Hur: A Tale of the Christ',default,45226446);
insert into ReturnStatus values (9,111,'You Can Heal Your Life',default,60980461);
insert into ReturnStatus values (10,113,'The Common Sense Book of Baby and Child Care',default,43909502);
insert into ReturnStatus values (11,119,"Charlotte's Web",default,42516309);
insert into ReturnStatus values (12,120,"Jonathan Livingston Seagull",default,34424106);
insert into ReturnStatus values (13,102,'A Message to Garcia',default,37540632);
insert into ReturnStatus values (14,116,'How the Steel Was Tempered ',default,61099686);
insert into ReturnStatus values (21,90,"A Tale of Two Cities",default,19515344);
select * from books where ISBN=15604762;

-- Creating a view to get the no of books in the library ,available books , and books gone out 
create view Books_Count AS select(select count(*) from Books) total_no_of_books ,
(select count(*)  from Books where Status ='yes') no_of_books_available_now,
(select count(*)  from Books where Status ='No') no_of_books_gone_out;
select * from Books_Count;

-- 1. Retrieve the book title, category, and rental price of all available books. 
select Book_title,Category,Rental_Price from books where status ="yes";

-- 2. List the employee names and their respective salaries in descending order of salary. 
select Emp_name,Salary from employee order by Salary desc;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT 
    B.Book_title, I.Issued_cust, C.Customer_name
FROM
    IssueStatus I
        LEFT JOIN
    Books B ON I.Isbn_book = B.ISBN
        LEFT JOIN
    Customer C ON I.Issued_cust = C.Customer_id;

-- 4. Display the total count of books in each category. 
SELECT 
    COUNT(*), category
FROM
    books
GROUP BY category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT 
    Emp_name, position
FROM
    employee
WHERE
    salary > 50000;
    
-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT 
    customer_name
FROM
    customer
WHERE
    customer_id NOT IN (SELECT 
            issued_cust
        FROM
            IssueStatus)
        AND Reg_date < '2022-01-01';
-- another way
SELECT 
    c.customer_name
FROM
    customer c
        LEFT JOIN
    IssueStatus i ON i.issued_cust = c.customer_id
WHERE
    Reg_date < '2022-01-01'
        AND i.issued_cust IS NULL;
-- 7. Display the branch numbers and the total count of employees in each branch. 
SELECT 
    b.Branch_no, COUNT(e.Emp_Id)
FROM
    employee e
        LEFT JOIN
    Branch b ON e.Branch_no = b.Branch_no
GROUP BY Branch_no;
-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT 
    c.customer_name
FROM
    customer c
        LEFT JOIN
    IssueStatus i ON i.issued_cust = c.customer_id
WHERE
    Issue_date BETWEEN '2023-06-01' AND '2023-06-30';
-- 9. Retrieve book_title from book table containing history. 
SELECT 
    book_title
FROM
    books
WHERE
    book_title LIKE '%history%';
-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT 
    branch_no, COUNT(Emp_Id) no_of_emp
FROM
    employee e
GROUP BY branch_no
HAVING COUNT(Emp_Id) > 5;
-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT 
    e.Emp_name, b.Branch_address, e.position
FROM
    employee e
        LEFT JOIN
    Branch b ON b.Branch_no = e.Branch_no
WHERE
    position LIKE '%manager%';
-- 12.  Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT 
    c.Customer_name, b.Rental_Price
FROM
    IssueStatus i
        LEFT JOIN
    customer c ON c.Customer_id = i.Issued_cust
        LEFT JOIN
    books b ON b.ISBN = i.Isbn_book
WHERE
    Rental_Price > 25;