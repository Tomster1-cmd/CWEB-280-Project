/*
  This file modifies the existing database to allow
  automatic ID generation for both the issue and ticket records.

  This file requires the existing database with both the tables and forgein keys.
 */

USE cweb_280_project;

-- Temporarily remove foreign key constraints
/*
  This section will temporarily remove the forgein keys that would be
  associated with both IssuesID and TicketID
  to avoid any bugs or issues that may or may not occur when modifying
  the columns' data.
 */

ALTER TABLE CompletedTickets
    DROP FOREIGN KEY completedtickets_ibfk_1;

ALTER TABLE IncompleteTickets
    DROP FOREIGN KEY incompletetickets_ibfk_1;

ALTER TABLE Ticket
    DROP FOREIGN KEY ticket_ibfk_2;


-- Enable automatic ID generation
/*
 Allows automatic ID generations for the Ticket and Issue records.
 This section modify the existing primary key columns to use
 auto_increment which allows MySQL to create unique ids without.
 needing to do it manually.
 */

ALTER TABLE Issues
    MODIFY COLUMN IssuesID INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Ticket
    MODIFY COLUMN TicketID INT NOT NULL AUTO_INCREMENT;


-- Restore foreign key constraints
/*
 Restores the foreign keys that we temporally removed during the migration of the data
 This reestablishes the connection between the Issues, Tickets, Incomplete and complete ticket tables.
 */

ALTER TABLE Ticket
    ADD CONSTRAINT ticket_ibfk_2
        FOREIGN KEY (IssuesID)
            REFERENCES Issues(IssuesID);

ALTER TABLE IncompleteTickets
    ADD CONSTRAINT incompletetickets_ibfk_1
        FOREIGN KEY (TicketID)
            REFERENCES Ticket(TicketID);

ALTER TABLE CompletedTickets
    ADD CONSTRAINT completedtickets_ibfk_1
        FOREIGN KEY (TicketID)
            REFERENCES Ticket(TicketID);


-- Verify changes
/*
 Confirms that both the Issue and Ticket ids are configured with auto_increment primary keys after
 the migration.
 */

DESCRIBE Issues;
DESCRIBE Ticket;