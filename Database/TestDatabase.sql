USE cweb_280_project;

-- Test automatic priority assignment and compare
-- actual results against expected results.

SELECT
    TestName,
    ExpectedPriority,
    ActualPriority,
    CASE
        WHEN ExpectedPriority = ActualPriority
            THEN 'PASS'
        ELSE 'FAIL'
        END AS TestResult
FROM (
         -- Test high priority.
         SELECT
             'Server Problem' AS TestName,
             'High' AS ExpectedPriority,
             CalculatePriority(
                     'Server Problem',
                     'The server down issue affects all employees.'
             ) AS ActualPriority

         UNION ALL

         -- Test medium priority.
         SELECT
             'Network Problem',
             'Medium',
             CalculatePriority(
                     'Network Problem',
                     'Employee cannot connect to the network.'
             )

         UNION ALL

         -- Test low priority.
         SELECT
             'Password Reset',
             'Low',
             CalculatePriority(
                     'Password Reset',
                     'Employee forgot their password.'
             )

         UNION ALL

         -- Test default priority.
         SELECT
             'Unrecognized Issue',
             'Medium',
             CalculatePriority(
                     'Other',
                     'Employee requires assistance.'
             )

         UNION ALL

         -- Verify that high priority overrides low priority.
         SELECT
             'Conflicting Keywords',
             'High',
             CalculatePriority(
                     'Password Reset',
                     'A security breach has occurred.'
             )

         UNION ALL

         -- Verify case-insensitive keyword matching.
         SELECT
             'Uppercase Keywords',
             'High',
             CalculatePriority(
                     'SERVER DOWN',
                     'SYSTEM OUTAGE'
             )

     ) AS PriorityTests;