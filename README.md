# library-management-system
using MySql
we are going to build a project based on Library Management System. It keeps track of all information about books in the library, their cost, status and total number of books available in the library.
# Tables Used.
Created a database named library and following TABLES in the database: 

1. Branch 
2. Employee 
3. Books
4. Customer
5. IssueStatus
6. ReturnStatus

# Dataset used
Used a dataset to insert datas in Books table that dataset is also uploaded with this as Books new.CSV
# Sql Queries
main Sql Queries uploaded with this as library-management-system.sql


# Triggers used in this mangement system
* before_issue_book_to_customer(created trriger before inserting the data into issuestatus to not select avoid entering book not available by checking the books table)
* after_issue_book_to_customer(created trigger  after insertion for changing update the book status form the book table as not available after that book is issuesed to customer)
* after_return_book_to_customer(creating after triggers to change the book status from no to yes after book is returned by customer)

# Views used in this mangement system
* Books_Count (Created a view to get the no of books in the library ,available books , and books gone out)

# Simple Queries
1. Retrieve the book title, category, and rental price of all available books.
2. List the employee names and their respective salaries in descending order of salary.
3. Retrieve the book titles and the corresponding customers who have issued those books.
4. Display the total count of books in each category.
5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
7. Display the branch numbers and the total count of employees in each branch.
8. Display the names of customers who have issued books in the month of June 2023.
9. Retrieve book_title from book table containing history.
10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
11. Retrieve the names of employees who manage branches and their respective branch addresses.
12. Display the names of customers who have issued books with a rental price higher than Rs. 25.

# Screenshots
uploaded the screenshots of data that retrive while this sql codes were runned

# Use of this
from this we can easily get the information of library and the books that are available now and the books taken by the customers from the library returned books.
it will automatically changes the status of books available in the libray when the customer took that book and when the customer return the books.



