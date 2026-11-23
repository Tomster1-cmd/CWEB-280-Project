
USE cweb_280_project;

-- View 1: Ticket details
CREATE OR REPLACE VIEW TicketDetailsView AS
SELECT
    t.TicketID,
    t.TicketDate,
    c.EmployeeID,
    c.FirstName,
    c.LastName,
    d.NameOfDepartment,
    i.TypeOfIssue,
    i.IssueDate,
    i.Priority
FROM Ticket AS t
         LEFT JOIN ContactInfo AS c
                   ON t.ContactInfoID = c.ContactInfoID
         LEFT JOIN Department AS d
                   ON c.DepartmentID = d.DepartmentID
         LEFT JOIN Issues AS i
                   ON t.IssuesID = i.IssuesID;


-- View 2: Incomplete tickets
CREATE OR REPLACE VIEW IncompleteTicketsView AS
SELECT
    it.IncompleteTicketsID,
    t.TicketID,
    t.TicketDate,
    it.DateMade,
    it.TypeOfTicket,
    c.FirstName,
    c.LastName,
    i.TypeOfIssue,
    i.Priority
FROM IncompleteTickets AS it
         INNER JOIN Ticket AS t
                    ON it.TicketID = t.TicketID
         LEFT JOIN ContactInfo AS c
                   ON t.ContactInfoID = c.ContactInfoID
         LEFT JOIN Issues AS i
                   ON t.IssuesID = i.IssuesID;


-- View 3: Completed tickets
CREATE OR REPLACE VIEW CompletedTicketsView AS
SELECT
    ct.CompletedTicketsID,
    t.TicketID,
    t.TicketDate,
    ct.DateFinished,
    ct.TypeOfTicket,
    c.FirstName,
    c.LastName,
    i.TypeOfIssue,
    i.Priority
FROM CompletedTickets AS ct
         INNER JOIN Ticket AS t
                    ON ct.TicketID = t.TicketID
         LEFT JOIN ContactInfo AS c
                   ON t.ContactInfoID = c.ContactInfoID
         LEFT JOIN Issues AS i
                   ON t.IssuesID = i.IssuesID;
