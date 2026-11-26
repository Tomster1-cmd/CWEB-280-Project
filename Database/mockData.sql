
USE cweb_280_project;

-- Add departments
INSERT IGNORE INTO Department
VALUES (1, 'IT', 'Technology');

INSERT IGNORE INTO Department
VALUES (2, 'HR', 'Human Resources');

-- Add employees
INSERT IGNORE INTO ContactInfo
VALUES (1, 'John', 'Smith', 1, 1001);

INSERT IGNORE INTO ContactInfo
VALUES (2, 'Jane', 'Doe', 2, 1002);

-- Add issues
INSERT IGNORE INTO Issues
VALUES (1, 'Computer Problem', '2026-11-18', 'High');

INSERT IGNORE INTO Issues
VALUES (2, 'Password Reset', '2026-11-18', 'Low');

-- Add tickets
INSERT IGNORE INTO Ticket
VALUES (1, '2026-11-18', 1, 1);

INSERT IGNORE INTO Ticket
VALUES (2, '2026-11-18', 2, 2);

-- Add incomplete ticket
INSERT IGNORE INTO IncompleteTickets
VALUES (1, 1, '2026-11-18', 'Computer Problem');

-- Add completed ticket
INSERT IGNORE INTO CompletedTickets
VALUES (1, 2, '2026-11-18', 'Password Reset');

-- Display tickets
SELECT * FROM Ticket;


-- Insert sample issues with detailed descriptions.
INSERT IGNORE INTO Issues (
    IssuesID,
    TypeOfIssue,
    IssueDescription,
    IssueDate,
    Priority
)
VALUES
    (
        1,
        'Computer Problem',
        'Employee computer fails to start after restarting.',
        '2026-11-18',
        'High'
    ),
    (
        2,
        'Password Reset',
        'Employee forgot their account password.',
        '2026-11-18',
        'Low'
    );

-- Update existing mock issue descriptions.
UPDATE Issues
SET IssueDescription = 'Employee computer fails to start after restarting.'
WHERE IssuesID = 1;

UPDATE Issues
SET IssueDescription = 'Employee forgot their account password.'
WHERE IssuesID = 2;