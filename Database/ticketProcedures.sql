
USE cweb_280_project;

DELIMITER $$

DROP PROCEDURE IF EXISTS CompleteTicket$$

CREATE PROCEDURE CompleteTicket(
    IN p_TicketID INT
)
BEGIN

    DECLARE v_TypeOfTicket VARCHAR(50);
    DECLARE v_IncompleteID INT DEFAULT NULL;


    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    -- Find the incomplete ticket
    SELECT
        -- Selects both the IncompleteTicketsID then the type of that ticket
        IncompleteTicketsID,
        TypeOfTicket
    INTO
        v_IncompleteID,
        v_TypeOfTicket
    FROM IncompleteTickets
    WHERE TicketID = p_TicketID
    LIMIT 1
    FOR UPDATE;

    -- Check if the ticket is incomplete
    IF v_IncompleteID IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ticket does not exist or is not incomplete';
    END IF;

    -- Prevent duplicate completed tickets
    IF EXISTS (
        SELECT 1
        FROM CompletedTickets
        WHERE TicketID = p_TicketID
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ticket has already been completed';
    END IF;

    -- Add the completed ticket
    INSERT INTO CompletedTickets (
        TicketID,
        DateFinished,
        TypeOfTicket
    )
    VALUES (
               p_TicketID,
               CURDATE(),
               v_TypeOfTicket
           );

    -- Remove the incomplete ticket
    DELETE FROM IncompleteTickets
    WHERE IncompleteTicketsID = v_IncompleteID;

    COMMIT;
END$$


-- ========================================
-- REOPEN TICKET PROCEDURE
-- ========================================

DROP PROCEDURE IF EXISTS ReopenTicket$$

CREATE PROCEDURE ReopenTicket(
    IN p_TicketID INT
)
BEGIN
    DECLARE v_TypeOfTicket VARCHAR(50);
    DECLARE v_CompletedID INT DEFAULT NULL;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    -- Find the completed ticket
    SELECT
        CompletedTicketsID,
        TypeOfTicket
    INTO
        v_CompletedID,
        v_TypeOfTicket
    FROM CompletedTickets
    WHERE TicketID = p_TicketID
    LIMIT 1
    FOR UPDATE;

    -- Check if the ticket is completed
    IF v_CompletedID IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ticket does not exist or is not completed';
    END IF;

    -- Prevent duplicate incomplete tickets
    IF EXISTS (
        SELECT 1
        FROM IncompleteTickets
        WHERE TicketID = p_TicketID
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ticket is already incomplete';
    END IF;

    -- Add the reopened ticket
    INSERT INTO IncompleteTickets (
        TicketID,
        DateMade,
        TypeOfTicket
    )
    VALUES (
               p_TicketID,
               CURDATE(),
               v_TypeOfTicket
           );

    -- Remove the completed ticket
    DELETE FROM CompletedTickets
    WHERE CompletedTicketsID = v_CompletedID;

    COMMIT;
END$$

DELIMITER ;


-- creates ticket

DELIMITER $$

DROP PROCEDURE IF EXISTS CreateTicket$$

CREATE PROCEDURE CreateTicket(
    IN p_ContactInfoID INT,
    IN p_TypeOfIssue VARCHAR(50),
    IN p_Priority VARCHAR(50),
    IN p_TypeOfTicket VARCHAR(50)
)
BEGIN
    DECLARE v_IssuesID INT;
    DECLARE v_TicketID INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1
        FROM ContactInfo
        WHERE ContactInfoID = p_ContactInfoID
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Contact does not exist';
    END IF;

    INSERT INTO Issues (

        TypeOfIssue,
        IssueDate,
        Priority
    )
    VALUES (
               p_TypeOfIssue,
               CURDATE(),
               p_Priority
           );

    SET v_IssuesID = LAST_INSERT_ID();

    INSERT INTO Ticket (
        TicketDate,
        ContactInfoID,
        IssuesID
    )
    VALUES (
               CURDATE(),
               p_ContactInfoID,
               v_IssuesID
           );

    SET v_TicketID = LAST_INSERT_ID();

    INSERT INTO IncompleteTickets (
        TicketID,
        DateMade,
        TypeOfTicket
    )
    VALUES (
               v_TicketID,
               CURDATE(),
               p_TypeOfTicket
           );

    COMMIT;

    SELECT v_TicketID AS NewTicketID;

END$$

DELIMITER ;