USE world;
# Q1
# What is the average population per country?
SELECT 
    AVG(Population) as avg
FROM
    country;
    
# Q2
# What is the total population in the world?
SELECT 
    SUM(Population) AS 'total population'
FROM
    country;
    
# Q3
# How many spoken languages are there?
SELECT 
    COUNT(DISTINCT Language) as 'Spoken languges'
FROM
    countrylanguage
WHERE
    percentage > 0;
    
# Q4
# How many countries are in each continent?
SELECT 
    Continent, COUNT(name) as Countries
FROM
    country
GROUP BY Continent;

# Q5 
# Find number of languages spoken in each country (you may use country code instead of
# country name)
SELECT 
    country.Name as Country, COUNT(Language) as languages
FROM
    countrylanguage
        LEFT JOIN
    country ON countrylanguage.CountryCode = country.Code
GROUP BY CountryCode;

# Q6
# List the countries with more than 10 spoken languages?
SELECT 
    country.Name as Country, COUNT(Language) as languages
FROM
    countrylanguage
        LEFT JOIN
    country ON countrylanguage.CountryCode = country.Code
GROUP BY CountryCode
HAVING COUNT(Language) > 10;

# Q7
# List the top 5 countries with the highest number of spoken languages?
SELECT 
    country.Name AS Country, COUNT(Language) AS languages
FROM
    countrylanguage
        LEFT JOIN
    country ON countrylanguage.CountryCode = country.Code
GROUP BY CountryCode
ORDER BY COUNT(Language) DESC
LIMIT 5;

use sakila;
# Q8
# Refer to the address table and list the addresses in which the phone number starts
# with 177.
SELECT 
    address
FROM
    address
WHERE
    phone LIKE '177%';
    
# Q9.A
# Create the DB using SQL commands. Make sure to correctly define the schema key
# constraints
CREATE DATABASE MyWorld;
use MyWorld;
Drop database if exists Myworld;
create database MyWorld;
use MyWorld;

CREATE TABLE Country (
Code char(3) primary KEY,
name char(52),
continent enum ('North America' ,
'Asia',
'Africa',
'Europe',
'South America',
'Oceania',
'Antarctica')
);

CREATE TABLE countrylanguage (
    CountryCode CHAR(3),
    language CHAR(30),
    IsOfficial ENUM('T', 'F'),
    PRIMARY KEY (CountryCode , language),
    CONSTRAINT fk_CL_CountryCode FOREIGN KEY (CountryCode)
        REFERENCES country (code)
);

use classicmodels;

# Q9.1
# For all sales rep. employee list: the employee name, the total number of orders, and total
# payments their customers made.
SELECT 
    CONCAT(employees.firstName,
            ' ',
            employees.lastName) AS fullName,
    CASE
        WHEN totalOrders IS NULL THEN 0
        ELSE totalOrders
    END AS totalOrders,
    CASE
        WHEN sumPayments IS NULL THEN 0
        ELSE sumPayments
    END AS sumPayments
FROM
    employees
        LEFT JOIN
    (SELECT 
        salesRepEmployeeNumber AS employeeNumber,
            COUNT(DISTINCT orderNumber) AS totalOrders
    FROM
        customers
    LEFT JOIN orders ON customers.customerNumber = orders.customerNumber
    GROUP BY salesRepEmployeeNumber) AS o ON employees.employeeNumber = o.employeeNumber
        LEFT JOIN
    (SELECT 
        salesRepEmployeeNumber AS employeeNumber,
            SUM(payments.amount) AS sumPayments
    FROM
        customers
    LEFT JOIN payments ON customers.customerNumber = payments.customerNumber
    GROUP BY salesRepEmployeeNumber) AS p ON employees.employeeNumber = p.employeeNumber
WHERE
    jobTitle = 'Sales Rep';

# Q9.2
# For all orders in dispute status list: the order number, the customer name, the customer
# phone number, the sales representative, the sales manager, the total amount paid, and
# the reason for the dispute.
SELECT 
    o.ordernumber,
    c.customername,
    c.phone,
    CONCAT(e.firstname, ' ', e.lastname) AS SalesRep,
    CONCAT(manager.firstname, ' ', manager.lastname) AS Manager,
    SUM(p.amount) AS TotPaid,
    status,
    o.comments AS Reas2disp
FROM
    customers AS c
        INNER JOIN
    payments AS p ON c.customernumber = p.customernumber
        INNER JOIN
    orders AS o ON c.customernumber = o.customernumber
        INNER JOIN
    employees AS e ON c.salesRepEmployeeNumber = e.employeenumber
        INNER JOIN
    employees AS manager ON e.reportsto = manager.employeenumber
WHERE
    o.status = 'Disputed'
GROUP BY o.ordernumber;

# Q9.3
# Write a query that lists the total sales per year.
SELECT
	year(paymentDate) as year, SUM(amount) as totalSales
FROM
	payments
GROUP BY year(paymentDate)
ORDER BY year(paymentDate);


# Q10
# B
# Use the data related to Israel in the world database and insert in into the MyWorld
# tables using the proper SQL commands.

INSERT INTO country
SELECT Code,  Name, Continent FROM world.country
WHERE Code = "ISR";

INSERT INTO countrylanguage
SELECT CountryCode, Language, IsOfficial FROM world.countrylanguage
WHERE CountryCode = "ISR";