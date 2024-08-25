USE FL;

-- Q1 -  Count the total rows in dataset 

SELECT 	COUNT(*) FROM flights_sample_3m;

-- What is the total number of flights that took off in each month of 2023?

SELECT MONTHNAME(FL_dATE),COUNT(*) FROM flights_sample_3m
WHERE YEAR(FL_dATE) = 2023
GROUP BY MONTHNAME(FL_dATE)
ORDER BY COUNT(*) ASC;

-- Calculate the average departure delay for each day in January 2023.

SELECT FL_DATE,AVG(DEP_DELAY) FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND MONTH(FL_DATE) = 01
GROUP BY FL_DATE
ORDER BY AVG(DEP_DELAY) DESC;

-- Find the top 10 busiest airports (based on departures) in March 2023.

SELECT ORIGIN,COUNT(*) FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND MONTH(FL_DATE) = 03
GROUP BY ORIGIN
ORDER BY COUNT(*) DESC
LIMIT 10;


-- Determine the longest flight delay by any airline in February 2023.

SELECT AIRLINE,MAX(DEP_DELAY) FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND MONTH(FL_DATE) = 02
GROUP BY AIRLINE
ORDER BY MAX(DEP_DELAY) DESC
LIMIT 1;

-- Which airline had the most flights cancelled in the second quarter of 2023?

SELECT AIRLINE,COUNT(*) FROM flights_sample_3m
WHERE CANCELLED = 1 AND FL_DATE BETWEEN '2023-04-01' AND '2023-06-30'
GROUP BY AIRLINE
ORDER BY COUNT(*)
LIMIT 1;

-- Calculate the total number of flights that arrived on time each week in 2023.

SELECT WEEK(FL_dATE),COUNT(*) FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND ARR_DELAY <= 0
GROUP BY WEEK(FL_DATE)
ORDER BY WEEK(FL_dATE) ASC;

-- Find the day with the highest number of flight cancellations in the entire dataset.

SELECT FL_DATE,COUNT(*) FROM flights_sample_3m
WHERE CANCELLED = 1
GROUP BY FL_dATE
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Calculate the average arrival delay per airport for each month in 2023.

SELECT DEST,MONTH(FL_DATE),AVG(ARR_DELAY) FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023
GROUP BY MONTH(FL_DATE),DEST
ORDER BY MONTH(FL_DATE) ASC;

-- Which airline had the most flights delayed by more than 1 hour in the summer of 2023 (June-August)?

SELECT AIRLINE FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND FL_DATE BETWEEN '2023-06-01' AND '2023-08-31' AND ARR_DELAY > 60
GROUP BY AIRLINE
LIMIT 1;

-- Calculate the number of flights that were delayed on Fridays in 2023.

SELECT COUNT(*) FROM flights_sample_3m
WHERE DAYOFWEEK(FL_DATE) = 06 AND YEAR(FL_DATE) = 2023 AND (DEP_DELAY >0 OR ARR_DELAY >0);


-- Find the top 5 routes (origin-destination pairs) with the most delays.

SELECT ORIGIN,DEST,COUNT(*) FROM flights_sample_3m
WHERE (DEP_DELAY >0  OR ARR_DELAY >0) 
GROUP BY ORIGIN,DEST
ORDER BY COUNT(*) DESC
LIMIT 5;

-- What is the average delay per flight on weekends (Saturdays and Sundays) in the dataset?

SELECT AVG(ARR_DELAY) FROM flights_sample_3m
WHERE DAYOFWEEK(FL_DATE) = 07 OR DAYOFWEEK(FL_DATE) = 01;

--  Identify the month with the highest average flight delay in 2023.

SELECT MONTH(FL_DATE),AVG(DEP_DELAY) FROM flights_sample_3m
GROUP BY MONTH(FL_DATE)
ORDER BY AVG(DEP_DELAY) DESC
LIMIT 1;

-- Calculate the total number of flights that were delayed by more than 30 minutes for each day of the week (e.g., Monday, Tuesday, etc.).

SELECT DAYOFWEEK(FL_DATE),COUNT(*) FROM flights_sample_3m
WHERE (ARR_DELAY>30 OR DEP_DELAY>30)
AND YEAR(FL_DATE) = 2023
GROUP BY DAYOFWEEK(FL_DATE)
ORDER BY DAYOFWEEK(FL_DATE);

-- Which month in 2023 had the highest percentage of on-time flights (flights with zero delays)?

SELECT MONTH(FL_DATE),COUNT(*) FROM  flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND (ARR_DELAY>1 OR DEP_DELAY>1)
GROUP BY MONTH(FL_DATE)
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Find the average arrival delay per airline for every Friday in 2023.

SELECT AIRLINE,AVG(ARR_DELAY) FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND DAYOFWEEK(FL_DATE) = 06
GROUP BY AIRLINE;

-- Determine the top 3 airports with the most delayed departures during the winter of 2023 (January and February).

SELECT ORIGIN,SUM(DEP_DELAY) FROM flights_sample_3m
WHERE MONTH(FL_DATE) IN (01,02)
GROUP BY ORIGIN
ORDER BY  SUM(DEP_DELAY) DESC
LIMIT 3;

-- What is the percentage of cancelled flights per month for the entire dataset?

SELECT MONTH(FL_DATE),(SUM(CASE WHEN CANCELLED = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS CancelledPercentage 
FROM flights_sample_3m
WHERE CANCELLED >0
GROUP BY MONTH(FL_DATE);

--  Identify the airport with the highest average departure delay on Mondays in 2023.

SELECT ORIGIN,AVG(DEP_DELAY) FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023 AND DAYOFWEEK(FL_DATE) = 02
GROUP BY ORIGIN
ORDER BY AVG(DEP_DELAY) DESC
LIMIT 1;

--  Calculate the total number of flights delayed by weather in each month of 2023.

SELECT MONTH(FL_DATE),COUNT(*) FROM flights_sample_3m
WHERE `DELAY_DUE_WEATHER` > 0
GROUP BY MONTH(FL_DATE)
ORDER BY MONTH(FL_DATE);

-- Find the top 5 airlines with the most delays during the Thanksgiving week (last week of November) in 2023.

SELECT AIRLINE,COUNT(*) AS TotalDelays FROM flights_sample_3m
WHERE (DEP_DELAY > 0 OR ARR_DELAY > 0) AND FL_DATE BETWEEN '2023-11-23' AND '2023-11-30'
GROUP BY AIRLINE
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Which day of the week had the highest average arrival delay in the entire dataset?

SELECT 
    DAYOFWEEK(FL_DATE) AS DayOfWeek,
    AVG(ARR_DELAY) AS AverageArrivalDelay
FROM flights_sample_3m
GROUP BY DayOfWeek
ORDER BY AverageArrivalDelay DESC
LIMIT 1;

-- Determine the average time difference between scheduled departure time and actual departure time for each airline in 2023.

SELECT 
    AIRLINE,
    AVG(DEP_DELAY) AS AverageDepartureDelay
FROM flights_sample_3m
WHERE YEAR(FL_DATE) = 2023
GROUP BY AIRLINE
ORDER BY AverageDepartureDelay DESC;

-- Calculate the number of flights that were delayed on New Year's Eve (December 31) across all years in the dataset.

SELECT 
    COUNT(*) AS DelayedFlights
FROM flights_sample_3m
WHERE (DEP_DELAY > 0 OR ARR_DELAY > 0) 
  AND DATE_FORMAT(FL_DATE, '%m-%d') = '12-31';
  
-- What is the total number of flights that departed on public holidays in 2023? (Consider major U.S. holidays like Independence Day, Labor Day, etc.)

SELECT 
    COUNT(*) AS HolidayDepartures
FROM flights_sample_3m
WHERE FL_DATE IN ('2023-01-01', -- New Year's Day
                  '2023-07-04', -- Independence Day
                  '2023-11-23', -- Thanksgiving
                  '2023-12-25', -- Christmas
                  '2023-09-04'); -- Labor Day (example dates, adjust for other holidays)
















