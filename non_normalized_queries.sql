-- Note:
-- The following queries were executed on salary_tracker_1MB, salary_tracker_10MB and salary_tracker_100MB tables to measure performance across different dataset sizes.
-- Query 1

SELECT DISTINCT PersonName, BirthDate
FROM salary_tracker_1mb;

-- Query 2

SELECT DISTINCT PersonName, SchoolName, SchoolCampus
FROM salary_tracker_1mb
WHERE StillWorking = 'Yes';

-- Query 3

SELECT PersonName, JobTitle
FROM salary_tracker_1mb
WHERE JobTitle = 'Assistant Professor'
AND SchoolName = 'University of Massachusetts Dartmouth'
AND StillWorking = 'Yes';

-- Query 4

SELECT SchoolCampus, COUNT(DISTINCT PersonID) AS NumPeople
FROM salary_tracker_1mb
WHERE StillWorking = 'Yes'
AND EarningsYear = (SELECT MAX(EarningsYear) FROM salary_tracker_1mb)
GROUP BY SchoolCampus
ORDER BY NumPeople DESC;


-- Query 5

SELECT PersonName, SUM(Earnings) AS TotalEarnings
FROM salary_tracker_1mb
GROUP BY PersonName
ORDER BY TotalEarnings DESC;

