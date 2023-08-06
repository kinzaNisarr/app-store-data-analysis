1. SQL code to combine multiple tables into one:
sql
-- Combine multiple tables (appleStore_description1, appleStore_description2, appleStore_description3, appleStore_description4) into one.
-- Using UNION ALL to maintain all records from each table.
-- Store the result in a new table named 'applestore_description_combined'.
CREATE TABLE applestore_description_combined AS
SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4;


2. SQL code to find the number of unique apps in each dataset:
sql
-- Count the number of distinct app IDs in the AppleStore table.
SELECT COUNT(DISTINCT id) AS uniqueAppIds
FROM AppleStore;

-- Count the number of distinct app IDs in the 'applestore_description_combined' table.
SELECT COUNT(DISTINCT id) AS uniqueAppIds
FROM applestore_description_combined;


3. SQL code to check for missing values in key fields:
sql
-- Check for missing values in the key fields (track_name, user_rating, prime_genre) of the AppleStore table.
SELECT COUNT(*) AS missingValue
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL;

-- Check for missing values in the 'track_name' field of the 'applestore_description_combined' table.
SELECT COUNT(*) AS missingValue
FROM applestore_description_combined
WHERE track_name IS NULL;


4. SQL code to find the number of apps per genre:
sql
-- Count the number of apps in each genre from the AppleStore table.
-- Group the results by the 'prime_genre' column.
-- Order the genres based on the number of apps in descending order (most apps first).
SELECT prime_genre, COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC;


5. SQL code to get an overview of the app ratings:
sql
-- Calculate the minimum, maximum, and average user ratings from the AppleStore table.
SELECT MIN(user_rating) AS minRating,
       MAX(user_rating) AS maxRating,
       AVG(user_rating) AS AvgRating
FROM AppleStore;


6. SQL code to determine if paid apps have higher ratings than free apps:
sql
-- Determine if apps are paid or free based on the 'price' column.
-- Calculate the average user rating for each category (paid and free).
-- Group the results by the 'app_type' column (paid or free).
SELECT CASE
    WHEN price > 0 THEN 'Paid'
    ELSE 'Free'
END AS app_type,
AVG(user_rating) AS avg_rating
FROM AppleStore
GROUP BY app_type;


7. SQL code to check if apps with more supported languages have higher ratings:
sql
-- Categorize apps based on the number of supported languages.
-- Calculate the average user rating for each language category.
-- Group the results by the 'language_bucket' column (10<languages, 10-30 languages, >30 languages).
-- Order the results based on the average rating in descending order (highest rating first).
SELECT CASE
    WHEN lang_num < 10 THEN '10<languages'
    WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
    ELSE '>30 languages'
END AS language_bucket,
AVG(user_rating) AS Avg_rating
FROM AppleStore
GROUP BY language_bucket
ORDER BY Avg_rating DESC;


8. SQL code to check genres with low ratings:
sql
-- Calculate the average user rating for each genre from the AppleStore table.
-- Group the results by the 'prime_genre' column.
-- Order the results based on the average rating in ascending order (lowest rating first).
-- Limit the results to the top 10 genres with the lowest ratings.
SELECT prime_genre, AVG(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating
LIMIT 10;


9. SQL code to check the correlation between the length of the app description and user ratings:
sql
-- Categorize app descriptions based on their length (short, medium, long).
-- Calculate the average user rating for each description length category.
-- Join the AppleStore and applestore_description_combined tables on the 'id' column to link descriptions and ratings.
-- Group the results by the 'description_length_bucket' column (short, medium, long).
-- Order the results based on the average rating in descending order (highest rating first).
SELECT CASE
    WHEN LENGTH(b.app_desc) < 500 THEN 'Short'
    WHEN LENGTH(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
    ELSE 'Long'
END AS description_length_bucket,
AVG(a.user_rating) AS average_rating
FROM AppleStore AS a
JOIN applestore_description_combined AS b ON a.id = b.id
GROUP BY description_length_bucket
ORDER BY average_rating DESC;
