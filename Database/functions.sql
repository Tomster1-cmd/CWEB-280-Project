use cweb_280_project;

delimiter $$

drop function if exists CalculatePriority$$

create function CalculatePriority(

    p_TypeOfIssue varchar(50),
    p_IssueDescription text
)
returns varchar(50)
deterministic
no sql
begin
    declare v_IssueText text;

    set v_IssueText = lower(concat_ws( ' ' , p_TypeOfIssue, p_IssueDescription));

    if v_IssueText like '%server down%'
        or v_IssueText like '%security breach%'
        or v_IssueText like '%system outage%'
        or v_IssueText like '%data loss'

        then
            return 'High';

    ELSEIF v_IssueText LIKE '%network problem%'
        OR v_IssueText LIKE '%cannot connect%'
        OR v_IssueText LIKE '%software error%'
        OR v_IssueText LIKE '%not working%'
    THEN
        RETURN 'Medium';


    ELSEIF v_IssueText LIKE '%password reset%'
        OR v_IssueText LIKE '%slow computer%'
        OR v_IssueText LIKE '%general inquiry%'
    THEN
        RETURN 'Low';

    else
        return 'Medium';

    end if;
end$$

delimiter ;