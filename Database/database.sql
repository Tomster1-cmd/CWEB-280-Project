
/*
    This file creates the database with each of the tables.
    These tables manage the data for departments, employee information,
    issues and Tickets ranging from incomplete to complete.

    This file does not require another file to run properly.

 */

CREATE DATABASE IF NOT EXISTS cweb_280_project;

USE cweb_280_project;

-- Stores organized  departments
-- Each of the departments has its own unique ID from the DepartmentID
-- Can be associated with multiple employees contacts info
CREATE TABLE IF NOT EXISTS Department (

     DepartmentID INT PRIMARY KEY,

     NameOfDepartment VARCHAR(50),

     TypeOfDepartment VARCHAR(50)

);

-- Contact Information
/*
 Stores employee contact information including their first name, last name,
 employee id, and the department associated with them.
 */
CREATE TABLE IF NOT EXISTS ContactInfo (

      ContactInfoID INT PRIMARY KEY,

      FirstName VARCHAR(50),

      LastName VARCHAR(50),

      DepartmentID INT,

      EmployeeID INT,

      FOREIGN KEY (DepartmentID)

          REFERENCES Department(DepartmentID)

);

-- Issues
/*
 Stores reported issues including the category of the issue
 either being network, software, hardware. The table also will save the
 date for each of the issues.
 */
CREATE TABLE IF NOT EXISTS Issues (

    IssuesID INT auto_increment primary KEY,

    TypeOfIssue VARCHAR(50),

    IssueDate DATE,

    Priority VARCHAR(50)

);

-- Tickets
/*
 Stores the users tickets including the creation of the ticket,
 the table also references the employees contact information.
 */
CREATE TABLE IF NOT EXISTS Ticket (

    TicketID INT  auto_increment PRIMARY KEY,

    TicketDate DATE,

    ContactInfoID INT,

    IssuesID INT ,

    FOREIGN KEY (ContactInfoID)

        REFERENCES ContactInfo(ContactInfoID),

    FOREIGN KEY (IssuesID)

        REFERENCES Issues(IssuesID)

);

-- Incomplete Tickets
CREATE TABLE IF NOT EXISTS IncompleteTickets (

   IncompleteTicketsID INT auto_increment primary key,

   TicketID INT,

   DateMade DATE,

   TypeOfTicket VARCHAR(50),

   FOREIGN KEY (TicketID)

       REFERENCES Ticket(TicketID)

);

-- Completed Tickets
CREATE TABLE IF NOT EXISTS CompletedTickets (

CompletedTicketsID INT AUTO_INCREMENT PRIMARY KEY,

   TicketID INT,

   DateFinished DATE,

   TypeOfTicket VARCHAR(50),

   FOREIGN KEY (TicketID)

       REFERENCES Ticket(TicketID)

);

-- Check that all tables exist
SHOW TABLES;
