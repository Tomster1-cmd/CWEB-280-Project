
-- Reopens a previously completed ticket

DELIMITER $$

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
            SET MESSAGE_TEXT = 'Ticket is not completed or does not exist';
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

    -- Add the ticket back to incomplete
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

    -- Remove the completed ticket record
    DELETE FROM CompletedTickets
    WHERE CompletedTicketsID = v_CompletedID;

    COMMIT;
END$$

DELIMITER ;
