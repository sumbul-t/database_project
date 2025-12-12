
--Query 1:

List the unique PersonNames along with their BirthDates.
SELECT DISTINCT p.PersonName, p.BirthDate
FROM persons_3nf p;

--Query 2:

FROM employment_records_3nf ef, persons_3nf p, departments_3nf d, schools_3nf s
WHERE ef.PersonID = p.PersonID
  AND ef.DepartmentID = d.DepartmentID
  AND d.SchoolID = s.SchoolID
  AND ef.StillWorking = 'Yes';

--Query 3:

SELECT p.PersonName, j.JobTitle
FROM employment_records_3nf ef, persons_3nf p, jobs_3nf j, departments_3nf d, schools_3nf s
WHERE ef.PersonID = p.PersonID
  AND ef.JobID = j.JobID
  AND ef.DepartmentID = d.DepartmentID
  AND d.SchoolID = s.SchoolID
  AND j.JobTitle = 'Assistant Professor'
  AND s.SchoolName = 'University of Massachusetts'
  AND s.SchoolCampus = 'Dartmouth'
  AND ef.StillWorking = 'Yes';

--Query 4:

SELECT s.SchoolCampus, COUNT(DISTINCT ef.PersonID) AS NumPeople
FROM employment_records_3nf ef, departments_3nf d, schools_3nf s
WHERE ef.DepartmentID = d.DepartmentID
  AND d.SchoolID = s.SchoolID
  AND ef.StillWorking = 'Yes'
  AND ef.EarningsYear = (
        SELECT MAX(EarningsYear)
        FROM employment_records_3nf
      )
GROUP BY s.SchoolCampus
ORDER BY NumPeople DESC;

--Query 5:

SELECT p.PersonName, SUM(ef.Earnings) AS TotalEarnings
FROM employment_records_3nf ef, persons_3nf p
WHERE ef.PersonID = p.PersonID
GROUP BY p.PersonName
ORDER BY TotalEarnings DESC;
