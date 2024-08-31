use Portfolio_Projects
select * from dbo.Amazon_Customer;


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'Amazon_Customer';


-- finding NULL values

SELECT *
FROM dbo.Amazon_Customer
WHERE 
    [Timestamp] IS NULL OR
    age IS NULL OR
	Gender IS NULL OR
	Purchase_Frequency IS NULL OR
	Purchase_Categories IS NULL OR
	Personalized_Recommendation_Frequency IS NULL OR
	Browsing_Frequency IS NULL OR
	Product_Search_Method IS NULL OR
	Search_Result_Exploration IS NULL OR
	Customer_Reviews_Importance IS NULL OR
	Add_to_Cart_Browsing IS NULL OR
	Cart_Completion_Frequency IS NULL OR
	Cart_Abandonment_Factors IS NULL OR
	Saveforlater_Frequency IS NULL OR
	Review_Left IS NULL OR
	Review_Reliability IS NULL OR
	Review_Helpfulness IS NULL OR
	Personalized_Recommendation_Frequency IS NULL OR
	Recommendation_Helpfulness IS NULL OR
	Rating_Accuracy IS NULL OR
	Shopping_Satisfaction IS NULL OR
	Service_Appreciation IS NULL OR
	Improvement_Areas IS NULL;

-- Finding the mode of column having null values

SELECT TOP 1 Product_Search_Method AS Mode, COUNT(*) AS Frequency
FROM dbo.Amazon_Customer
GROUP BY Product_Search_Method
ORDER BY COUNT(*) DESC;

-- Update NULL values with the mode

UPDATE dbo.Amazon_Customer
SET Product_Search_Method = (
    SELECT TOP 1 Product_Search_Method
    FROM dbo.Amazon_Customer
    WHERE Product_Search_Method IS NOT NULL
    GROUP BY Product_Search_Method
    ORDER BY COUNT(*) DESC
)
WHERE Product_Search_Method IS NULL;

-- checking for duplicates

SELECT [Timestamp],
    age,
	Gender,
	Purchase_Frequency,
	Purchase_Categories,
	Personalized_Recommendation_Frequency,
	Browsing_Frequency,
	Product_Search_Method,
	Search_Result_Exploration,
	Customer_Reviews_Importance,
	Add_to_Cart_Browsing,
	Cart_Completion_Frequency,
	Cart_Abandonment_Factors,
	Saveforlater_Frequency,
	Review_Left,
	Review_Reliability,
	Review_Helpfulness,
	Personalized_Recommendation_Frequency,
	Recommendation_Helpfulness,
	Rating_Accuracy,
	Shopping_Satisfaction,
	Service_Appreciation,
	Improvement_Areas, COUNT(*) as duplicate_count
FROM dbo.Amazon_Customer
GROUP BY [Timestamp],
    age,
	Gender,
	Purchase_Frequency,
	Purchase_Categories,
	Personalized_Recommendation_Frequency,
	Browsing_Frequency,
	Product_Search_Method,
	Search_Result_Exploration,
	Customer_Reviews_Importance,
	Add_to_Cart_Browsing,
	Cart_Completion_Frequency,
	Cart_Abandonment_Factors,
	Saveforlater_Frequency,
	Review_Left,
	Review_Reliability,
	Review_Helpfulness,
	Personalized_Recommendation_Frequency,
	Recommendation_Helpfulness,
	Rating_Accuracy,
	Shopping_Satisfaction,
	Service_Appreciation,
	Improvement_Areas
HAVING COUNT(*) > 1;

-- there were no duplicates

-- there can not be any outliers are there are no continuous numerical columns

-- CHANGING COLUMN DATA TYPES

SELECT DISTINCT(Review_Left)
FROM dbo.Amazon_Customer


SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Amazon_Customer' AND COLUMN_NAME = 'Review_Left';

UPDATE dbo.Amazon_Customer
SET Review_Left = CASE WHEN Review_Left = 'Yes' THEN 1 WHEN Review_Left = 'No' THEN 0 ELSE NULL END;

ALTER TABLE dbo.Amazon_Customer
ALTER COLUMN Review_Left bit;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Amazon_Customer' AND COLUMN_NAME = 'Timestamp';


-- Extracting Date part from TimestampColumn
SELECT LEFT([Timestamp], 10) AS ExtractedDate
FROM dbo.Amazon_Customer;

-- Add a new column named "Date" to the table
ALTER TABLE dbo.Amazon_Customer
ADD DateColumn DATE;

-- Update the new "Date" column with extracted date values
UPDATE dbo.Amazon_Customer
SET DateColumn = CONVERT(DATE, LEFT([Timestamp], 10));

-- Rename the "DateColumn" to "Date"
EXEC sp_rename 'dbo.Amazon_Customer.DateColumn', 'Date', 'COLUMN';

-- Extracting time from Timestamp column
USE Portfolio_Projects

SELECT RIGHT(LEFT([Timestamp], CHARINDEX(' GMT', [Timestamp]) - 1), 11) AS ExtractedTime
FROM dbo.Amazon_Customer;


-- droping Timestamp column after extracting date from it

ALTER TABLE dbo.Amazon_Customer
DROP COLUMN [Timestamp];



SELECT * FROM dbo.Amazon_Customer
WHERE AGE< 18

DELETE FROM dbo.Amazon_Customer
WHERE AGE < 18;













