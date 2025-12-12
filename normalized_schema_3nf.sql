-- Normalized Database Schema (3NF)
-- 1. Create Tables

-- Persons
CREATE TABLE persons_3nf (
  PersonID INT PRIMARY KEY,
  PersonName VARCHAR(255) NOT NULL,
  BirthDate DATE NULL
);

-- Schools
CREATE TABLE schools_3nf (
  SchoolID VARCHAR(20) PRIMARY KEY,
  SchoolName VARCHAR(255) NOT NULL,
  SchoolCampus VARCHAR(255) NOT NULL
);

-- Departments 
CREATE TABLE departments_3nf (
  DepartmentID VARCHAR(20) PRIMARY KEY,
  DepartmentName VARCHAR(255) NOT NULL,
  SchoolID VARCHAR(20) NOT NULL,
  CONSTRAINT fk_dept_school
    FOREIGN KEY (SchoolID) REFERENCES schools_3nf(SchoolID)
);

-- Jobs
CREATE TABLE jobs_3nf (
  JobID VARCHAR(20) PRIMARY KEY,
  JobTitle VARCHAR(255) NOT NULL
);

 --Employment/Earnings records (fact table)
CREATE TABLE employment_records_3nf (
  EmploymentID BIGINT AUTO_INCREMENT PRIMARY KEY,
  PersonID INT NOT NULL,
  DepartmentID VARCHAR(20) NOT NULL,
  JobID VARCHAR(20) NOT NULL,
  Earnings INT NOT NULL,
  EarningsYear INT NOT NULL,
  StillWorking VARCHAR(5) NOT NULL,
  CONSTRAINT fk_emp_person
    FOREIGN KEY (PersonID) REFERENCES persons_3nf(PersonID),
  CONSTRAINT fk_emp_dept
    FOREIGN KEY (DepartmentID) REFERENCES departments_3nf(DepartmentID),
  CONSTRAINT fk_emp_job
    FOREIGN KEY (JobID) REFERENCES jobs_3nf(JobID)
);

--2) Populate the normalized tables from salary_tracker_100MB

--Persons

INSERT INTO persons_3nf (PersonID, PersonName, BirthDate)
SELECT DISTINCT PersonID, PersonName, STR_TO_DATE(BirthDate, '%m/%d/%Y')
FROM salary_tracker_100MB
WHERE PersonID IS NOT NULL;

-- Schools

INSERT IGNORE INTO schools_3nf (SchoolID, SchoolName, SchoolCampus)
SELECT SchoolID, SchoolName, SchoolCampus
FROM salary_tracker_100MB
WHERE SchoolID IS NOT NULL;

-- Departments

INSERT IGNORE INTO departments_3nf (DepartmentID, DepartmentName, SchoolID)
SELECT DISTINCT DepartmentID, DepartmentName, SchoolID
FROM salary_tracker_100MB
WHERE DepartmentID IS NOT NULL;

-- Jobs

INSERT INTO jobs_3nf (JobID, JobTitle)
SELECT DISTINCT JobID, JobTitle
FROM salary_tracker_100MB
WHERE JobID IS NOT NULL;

-- Employment Records

INSERT IGNORE INTO employment_records_3nf (PersonID, DepartmentID, JobID, Earnings, EarningsYear, StillWorking)
SELECT PersonID,DepartmentID,JobID, Earnings,EarningsYear,StillWorking
FROM salary_tracker_100MB
WHERE PersonID IS NOT NULL
AND DepartmentID IS NOT NULL
AND JobID IS NOT NULL;
