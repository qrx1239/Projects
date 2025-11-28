-- Connect to database (MySQL only)
USE hospital_db;

## OBJECTIVE 1: ENCOUNTERS OVERVIEW
## a. How many total encounters occurred each year?
## has 27,891 total to begin with 

SELECT 
    YEAR(START) AS Year, 
    COUNT(ID) AS 'Total Encounters'
FROM encounters
GROUP BY Year
ORDER BY Year DESC;


##  b. For each year, what percentage of all encounters belonged to each encounter class
##  (ambulatory, outpatient, wellness, urgent care, emergency, and inpatient)?

SELECT 
	year(START) as Year,
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'ambulatory' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS Ambulatory,
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'outpatient' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS Outpatient,
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'wellness' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS Wellness,
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'urgentcare' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS 'Urgent care',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'emergency' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS Emergency,
    ROUND( SUM( CASE WHEN ENCOUNTERCLASS = 'inpatient' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS Inpatient,
    COUNT(*) as num_encounters
FROM encounters
GROUP BY Year
ORDER BY Year desc;

##  c. What percentage of encounters were over 24 hours versus under 24 hours?

## Here is the percentage of encounters that were over 24 hours versus under 24 hours **IN TOTAL FOR ALL YEARS**
SELECT 
    ROUND(SUM(CASE WHEN timestampdiff(HOUR, START, STOP) >= 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Ambulatory_over_24hrs',
    ROUND(SUM(CASE WHEN timestampdiff(HOUR, START, STOP) < 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Ambulatory_under_24hrs',
    COUNT(*) as num_encounters
FROM encounters;

## Here is the percentage of encounters that were over 24 hours versus under 24 hours **PER YEAR**
SELECT 
	year(START) as Year,
    ROUND(SUM(CASE WHEN timestampdiff(HOUR, START, STOP) >= 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Ambulatory_over_24hrs',
    ROUND(SUM(CASE WHEN timestampdiff(HOUR, START, STOP) < 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Ambulatory_under_24hrs',
    COUNT(*) as num_encounters
FROM encounters
GROUP BY Year
ORDER BY Year desc;

## ## Here is the percentage of encounters that were over 24 hours versus under 24 hours **PER YEAR & PER ENCOUNTERCLASS**
SELECT 
	year(START) as Year,
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'ambulatory' AND timestampdiff(HOUR, START, STOP) >= 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Ambulatory_over_24hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'ambulatory' AND timestampdiff(HOUR, START, STOP) < 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Ambulatory_under_24hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'outpatient' AND timestampdiff(HOUR, START, STOP) >= 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Outpatient_over_24hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'outpatient' AND timestampdiff(HOUR, START, STOP) < 24  THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Outpatient_under_24hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'wellness' AND timestampdiff(HOUR, START, STOP) >= 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Wellness_over_24hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'wellness' AND timestampdiff(HOUR, START, STOP) < 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Wellness_under_24hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'urgentcare' AND timestampdiff(HOUR, START, STOP) >= 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Urgent_care_over_24hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'urgentcare' AND timestampdiff(HOUR, START, STOP) < 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Urgent_care_under_24hrs ',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'emergency' AND timestampdiff(HOUR, START, STOP) >= 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Emergency_over_24_hrs',
    ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'emergency' AND timestampdiff(HOUR, START, STOP) < 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Emergency_under_24_hrs',
    ROUND(SUM( CASE WHEN ENCOUNTERCLASS = 'inpatient' AND timestampdiff(HOUR, START, STOP) >= 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Inpatient_over_24hrs',
    ROUND(SUM( CASE WHEN ENCOUNTERCLASS = 'inpatient' AND timestampdiff(HOUR, START, STOP) < 24 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Inpatient_under_24hrs',
    COUNT(*) as num_encounters
FROM encounters
GROUP BY Year
ORDER BY Year desc;


## OBJECTIVE 2: COST & COVERAGE INSIGHTS
## a. How many encounters had zero payer coverage, and what percentage of total encounters does this represent?

SELECT 
	year(START) as Year,
    ROUND(SUM(CASE WHEN PAYER_COVERAGE > 0 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Payers WITH Coverage',
    ROUND(SUM(CASE WHEN PAYER_COVERAGE = 0 THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS '% of Payers WITHOUT Coverage',
    COUNT(*) AS 'Total Encounters'
FROM encounters
GROUP BY Year
ORDER BY Year DESC

-- b. What are the top 10 most frequent procedures performed and the average base cost for each?

-- c. What are the top 10 procedures with the highest average base cost and the number of times they were performed?

-- d. What is the average total claim cost for encounters, broken down by payer?

-- OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS

-- a. How many unique patients were admitted each quarter over time?

-- b. How many patients were readmitted within 30 days of a previous encounter?

-- c. Which patients had the most readmissions?
