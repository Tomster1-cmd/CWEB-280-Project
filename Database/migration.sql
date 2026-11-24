USE cweb_280_project;

-- Temporarily remove foreign key constraints

ALTER TABLE CompletedTickets
    DROP FOREIGN KEY completedtickets_ibfk_1;

ALTER TABLE IncompleteTickets
    DROP FOREIGN KEY incompletetickets_ibfk_1;

ALTER TABLE Ticket
    DROP FOREIGN KEY ticket_ibfk_2;


-- Enable automatic ID generation

ALTER TABLE Issues
    MODIFY COLUMN IssuesID INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Ticket
    MODIFY COLUMN TicketID INT NOT NULL AUTO_INCREMENT;


-- Restore foreign key constraints

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

DESCRIBE Issues;
DESCRIBE Ticket;