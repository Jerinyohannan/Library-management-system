# library-management-system
using MySql
we are going to build a project based on Library Management System. It keeps track of all information about books in the library, their cost, status and total number of books available in the library.
# Dataset and Tables Used.
Created a database named library and following TABLES in the database: 

1. Branch 
2. Employee 
3. Books
4. Customer
5. IssueStatus
6. ReturnStatus

Used a dataset to insert datas in Books table that dataset is also uploaded with this as Books new.CSV

# Triggers used in this mangement system
* before_issue_book_to_customer(created trriger before inserting the data into issuestatus to not select avoid entering book not available by checking the books table)
* after_issue_book_to_customer(created trigger  after insertion for changing update the book status form the book table as not available after that book is issuesed to customer)
* after_return_book_to_customer(creating after triggers to change the book status from no to yes after book is returned by customer)

# Views used in this mangement system
* Books_Count (Created a view to get the no of books in the library ,available books , and books gone out)
* 
