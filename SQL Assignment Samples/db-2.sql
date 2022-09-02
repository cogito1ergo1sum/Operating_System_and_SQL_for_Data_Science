USE world;

# Q1
# Retrieve all continents. How many continents are there?
SELECT DISTINCT
    Continent
FROM
    country;
    
# Q2 
# Retrieve the countries that are from South America? How many countries are there?
SELECT 
    Name as Country
FROM
    country
WHERE
    Continent = 'South America';
    
# Q3 
# Retrieve the names of 10 countries with the highest life expectancy.
SELECT 
    Name as Country, LifeExpectancy
FROM
    country
ORDER BY LifeExpectancy DESC
LIMIT 10;

# Q4
# In how many countries only one language is used by its entire population?
SELECT
    COUNT(*) as 'Number of \'One language\' countries'
FROM
    countrylanguage
WHERE
    Percentage = 100.0;
    
# Q5
# Retrieve the languages that are dominant in any country (i.e. there is a country where its
# entire population speak only this language). How many such languages are there?
SELECT DISTINCT
    (Language) AS Language
FROM
    world.countrylanguage
WHERE
    Percentage = '100.0'
ORDER BY 1 ASC;

# Q6
# Retrieve a sorted list of countries that got independent during decade of the 1980s. How
# many such countries are there?
SELECT 
    Name as Country, IndepYear
FROM
    country
WHERE
    IndepYear BETWEEN '1980' AND '1989'
ORDER BY IndepYear ASC;

# Q7
# What are the names of the 5 cities with the lowest population?
SELECT 
    Name as City
FROM
    city
ORDER BY Population ASC
LIMIT 5;

# Q8
# List the countries located in America (either north or south) which are not republic
SELECT 
    Name AS Country
FROM
    country
WHERE
    Continent IN ('South America' , 'North America')
        AND GovernmentForm != 'Republic';
        
# Q9
# Examine the country table, how many countries are not independent? How many
# countries have a strange IndepYear value? What query did you use? Explain your answer.
SELECT 
    Name AS Country
FROM
    country
WHERE
    IndepYear IS NULL;

# Q10
# Which countries with population over 100,000,000 are Constitutional Monarchy?
SELECT 
    Name AS Country
FROM
    country
WHERE
    Population > 100000000
        AND GovernmentForm = 'Constitutional Monarchy';
        
USE sakila;
# Q11. A
# Explore the sakila Schema. How many tables does this database include?
SHOW TABLES;
# Q11.B
# List of the names (first and last) of the staff in sakila.
SELECT 
    first_name, last_name
FROM
    staff;
# Q11.C
SELECT 
    title as film
FROM
    film
WHERE
    length > 180
ORDER BY 1 ASC;