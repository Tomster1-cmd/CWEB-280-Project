
CREATE DATABASE IF NOT EXISTS cweb_280_project;

USE cweb-280-project;

-- Department
CREATE TABLE IF NOT EXISTS Department (

     DepartmentID INT PRIMARY KEY,

     NameOfDepartment VARCHAR(50),

     TypeOfDepartment VARCHAR(50)

);

-- Contact Information
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
CREATE TABLE IF NOT EXISTS Issues (

    IssuesID INT PRIMARY KEY,

    TypeOfIssue VARCHAR(50),

    IssueDate DATE,

    Priority VARCHAR(50)

);

-- Tickets
CREATE TABLE IF NOT EXISTS Ticket (

    TicketID INT PRIMARY KEY,

    TicketDate DATE,

    ContactInfoID INT,

    IssuesID INT,

    FOREIGN KEY (ContactInfoID)

        REFERENCES ContactInfo(ContactInfoID),

    FOREIGN KEY (IssuesID)

        REFERENCES Issues(IssuesID)

);

-- Incomplete Tickets
CREATE TABLE IF NOT EXISTS IncompleteTickets (

   IncompleteTicketsID INT PRIMARY KEY,

   TicketID INT,

   DateMade DATE,

   TypeOfTicket VARCHAR(50),

   FOREIGN KEY (TicketID)

       REFERENCES Ticket(TicketID)

);

-- Completed Tickets
CREATE TABLE IF NOT EXISTS CompletedTickets (

   CompletedTicketsID INT PRIMARY KEY,

   TicketID INT,

   DateFinished DATE,

   TypeOfTicket VARCHAR(50),

   FOREIGN KEY (TicketID)

       REFERENCES Ticket(TicketID)

);

-- Check that all tables exist
SHOW TABLES;
