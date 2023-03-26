--1. Create a table and name it records_may21. Populate the table with the randomly generated data in a CSV file.
CREATE TABLE records_may21 (
    record_id INTEGER,
    date DATE, ceo_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    date_of_birth DATE,
    total_revenue REAL,
    total_expenses REAL,
    state VARCHAR(14),
    postal_codes CHAR(5),
    compani_name TEXT,
    industry TEXT,
    email TEXT,
    PRIMARY KEY(record_id));


--2. Have a view of all the columns in the table.
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'records_may21';

--3. Correct the spelling error from 'compani_name' to 'company_name'.
ALTER TABLE records_may21
RENAME compani_name TO company_name;

--4. How many rows does the data has?
SELECT COUNT(*)
FROM records_may21;

--5. Delete the wrongly entered data with record_id 430 from the table.
DELETE FROM records_may21
WHERE record_id = 430;

--6. Insert a record that wasn't entered in the table.
INSERT INTO records_may21
VALUES(430,'2020-10-31',1012,'David','Wells','1977-09-19',495.71,
       202,'Florida',13888,'Adams-Rice','Financial','david.wells@Adams.io');
  
--7. Confirm the entry of the record above       
SELECT * FROM records_may21
WHERE record_id = 430;
       
/*8. A CEO’s company’s state was mistakenly omitted (has Null value) for records associated with it. Please,
fill these state name with “Texas”*/
SELECT * FROM records_may21
WHERE state IS null;

UPDATE records_may21
SET state = 'Texas'
WHERE state IS null;

--9. Display the unique states in the data.
SELECT DISTINCT(state) 
FROM records_may21;

--10. The state “New York” was misspelt as “New Yoke” in the dataset. Correct this in the dataset.
UPDATE records_may21
SET state = 'New York'
WHERE state = 'New Yoke';

/*11. Assuming the profit is total revenue – total expenses, find the total profit made by all companies in the 3
years*/
ALTER TABLE records_may21
ADD Profit REAL
UPDATE records_may21
SET Profit = (total_revenue-total_expenses)

SELECT SUM(profit) AS total_profit
FROM records_may21;

--12. Find the company with the lowest profit in the 3 years.
SELECT company_name, MIN(profit)
FROM records_may21
GROUP BY company_name
ORDER BY MIN(profit) ASC
LIMIT 1;

--13. Find the state where the highest mean profit was generated in the 3 years.
SELECT state, AVG(profit)
FROM records_may21
GROUP BY state
ORDER BY AVG(profit) DESC
LIMIT 1;

--14. Who is the youngest CEO?
SELECT first_name,last_name,ceo_id,date_of_birth
FROM records_may21
ORDER BY date_of_birth DESC
LIMIT 1;

/*15. Find the CEO(s) whose company are in the IT industry and in California State. (Return only the CEO’s first
name)*/
SELECT first_name 
FROM records_may21
WHERE industry = 'IT' AND state = 'California';

--16. Find the postal code in New York with the highest revenue.
SELECT postal_codes, total_revenue
FROM records_may21
WHERE state = 'New York'
ORDER BY total_revenue DESC
LIMIT 1;

--17. How many CEO’s email address have a top level domain (last four characters) as .com?
SELECT COUNT(email)
FROM records_may21
WHERE email LIKE '%.com';

--18. Which first name(s) is bore by most number of CEOs?
SELECT MAX(first_name)
FROM records_may21;






