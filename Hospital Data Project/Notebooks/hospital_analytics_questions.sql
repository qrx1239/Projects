USE hospital_db;
## OBJECTIVE 1: ENCOUNTERS OVERVIEW
## a. Total encounters that occurred each year
SELECT YEAR(START) AS Year,
    COUNT(ID) AS 'Total Encounters'
FROM encounters
GROUP BY Year
ORDER BY Year DESC;
SELECT YEAR(START) AS Year,
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'ambulatory' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS Ambulatory,
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'outpatient' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS Outpatient,
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'wellness' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS Wellness,
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'urgentcare' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS 'Urgent care',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'emergency' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS Emergency,
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'inpatient' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS Inpatient,
    COUNT(*) AS num_encounters
FROM encounters
GROUP BY Year
ORDER BY Year DESC;
SELECT ROUND(
        SUM(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Ambulatory_over_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Ambulatory_under_24hrs',
    COUNT(*) AS num_encounters
FROM encounters;
SELECT YEAR(START) AS Year,
    ROUND(
        SUM(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Ambulatory_over_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Ambulatory_under_24hrs',
    COUNT(*) AS num_encounters
FROM encounters
GROUP BY Year
ORDER BY Year DESC;
SELECT YEAR(START) AS Year,
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'ambulatory'
                AND TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Ambulatory_over_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'ambulatory'
                AND TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Ambulatory_under_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'outpatient'
                AND TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Outpatient_over_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'outpatient'
                AND TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Outpatient_under_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'wellness'
                AND TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Wellness_over_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'wellness'
                AND TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Wellness_under_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'urgentcare'
                AND TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Urgent_care_over_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'urgentcare'
                AND TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Urgent_care_under_24hrs ',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'emergency'
                AND TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Emergency_over_24_hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'emergency'
                AND TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Emergency_under_24_hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'inpatient'
                AND TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Inpatient_over_24hrs',
    ROUND(
        SUM(
            CASE
                WHEN ENCOUNTERCLASS = 'inpatient'
                AND TIMESTAMPDIFF(HOUR, START, STOP) < 24 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Inpatient_under_24hrs',
    COUNT(*) AS num_encounters
FROM encounters
GROUP BY Year
ORDER BY Year DESC;
SELECT YEAR(START) AS Year,
    ROUND(
        SUM(
            CASE
                WHEN PAYER_COVERAGE > 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Payers WITH Coverage',
    ROUND(
        SUM(
            CASE
                WHEN PAYER_COVERAGE = 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Payers WITHOUT Coverage',
    COUNT(*) AS 'Total Encounters'
FROM encounters
GROUP BY Year
ORDER BY Year DESC;
SELECT ROUND(
        SUM(
            CASE
                WHEN PAYER_COVERAGE > 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Payers WITH Coverage',
    ROUND(
        SUM(
            CASE
                WHEN PAYER_COVERAGE = 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        1
    ) AS '% of Payers WITHOUT Coverage',
    COUNT(*) AS 'Total Encounters'
FROM encounters;
SELECT AVG(BASE_COST) AS 'Average Base Cost',
    DESCRIPTION,
    COUNT(*) AS number_of_procedures_performed
FROM procedures
GROUP BY DESCRIPTION
ORDER BY number_of_procedures_performed DESC
LIMIT 10;
SELECT AVG(BASE_COST) AS Average_Base_Cost,
    DESCRIPTION,
    COUNT(*) AS number_of_procedures_performed
FROM procedures
GROUP BY DESCRIPTION
ORDER BY Average_Base_Cost DESC
LIMIT 10;
SELECT p.NAME AS Insurance_Name,
    AVG(TOTAL_CLAIM_COST) AS AVG_Claim_Cost,
    COUNT(*)
FROM encounters e
    JOIN payers p ON e.PAYER = p.Id
GROUP BY PAYER
ORDER BY AVG_Claim_Cost DESC;
-- OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS
SELECT YEAR(START) AS Year,
    QUARTER(START) AS quarter_of_year,
    COUNT(DISTINCT PATIENT) AS num_unique_patients
FROM encounters
GROUP BY Year,
    quarter_of_year
ORDER BY Year,
    quarter_of_year;
## b. How many patients were readmitted within 30 days of a previous encounter?
SELECT PATIENT,
    START,
    STOP,
    LEAD(START) OVER (
        PARTITION BY PATIENT
        ORDER BY START
    ) AS next_start_date
FROM encounters
ORDER BY PATIENT,
    START;
WITH cte AS (
    SELECT PATIENT,
        START,
        STOP,
        LEAD(START) OVER (
            PARTITION BY PATIENT
            ORDER BY START
        ) AS next_start_date
    FROM encounters
)
SELECT COUNT(DISTINCT PATIENT) AS num_patients
FROM cte
WHERE datediff(next_start_date, STOP) < 30;
## c. Which patients had the most readmissions?
WITH cte AS (
    SELECT PATIENT,
        START,
        STOP,
        LEAD(START) OVER (
            PARTITION BY PATIENT
            ORDER BY START
        ) AS next_start_date
    FROM encounters
)
SELECT COUNT(*) AS num_readmissions,
    p.FIRST,
    p.LAST
FROM cte c
    JOIN patients p ON c.PATIENT = p.Id
WHERE datediff(next_start_date, STOP) < 30
GROUP BY PATIENT
ORDER BY num_readmissions desc