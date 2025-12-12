-- Data Loading Script
-- Description: Load CSV data into MySQL using LOAD DATA INFILE
-- This method was used instead of the GUI for better performance on large datasets.

LOAD DATA INFILE 'myfiles.csv'
INTO TABLE salary_tracker_1MB
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'myfiles.csv'
INTO TABLE salary_tracker_10MB
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'myfiles.csv'
INTO TABLE salary_tracker_100MB
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
