
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
    SET v_IncompleteID = NULL;

    SELECT
        IncompleteTicketsID,
        TypeOfTicket
    INTO
        v_IncompleteID,
        v_TypeOfTicket
    FROM IncompleteTickets
    WHERE TicketID = p_TicketID
    LIMIT 1
    FOR UPDATE;

    -- Check whether the ticket is incomplete
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

DELIMITER ;
