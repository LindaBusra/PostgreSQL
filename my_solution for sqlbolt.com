
SQL Lesson 1: SELECT queries 101
https://sqlbolt.com/lesson/select_queries_introduction


DROP TABLE MOVIES;
create table movies(
Id SERIAL,
Title VARCHAR(40),	
Director VARCHAR(40),
Year NUMERIC(4),
Length_minutes NUMERIC(5)

)

INSERT INTO movies VALUES(1, 'Monsters University',	'Dan Scanlon',	2013, 110);
INSERT INTO movies VALUES(2, 'The Incredibles',	'Brad Bird',	2004, 116);
INSERT INTO movies VALUES(3, 'Ratatouille',	'Brad Bird',	2007, 115);
INSERT INTO movies VALUES(4, 'Toy Story 2',	'John Lasseter',	1999, 93);
INSERT INTO movies VALUES(5, 'A Bugs Life', 'John Lasseter', 1998, 95);
INSERT INTO movies VALUES(6, 'Cars',	'John Lasseter',	2006, 117);
INSERT INTO movies VALUES(7, 'Finding Nemo',	'Andrew Stanton',	2003, 107);
INSERT INTO movies VALUES(8, 'Toy Story 3',	'Lee Unkrich',	2010, 103);
INSERT INTO movies VALUES(9, 'Brave',	'Brenda Chapman',	2012, 102);
INSERT INTO movies VALUES(10, 'Cars 2',	'John Lasseter',	2011, 120);
INSERT INTO movies VALUES(11, 'WALL-E',	'Andrew Stanton',	2008, 104);
INSERT INTO movies VALUES(12, 'Monsters, Inc.',	'Pete Docter',	2001, 92);
INSERT INTO movies VALUES(13, 'Toy Story',	'John Lasseter',	1995, 81);
INSERT INTO movies VALUES(14, 'Up',	'Pete Docter',	2009, 101);



--https://sqlbolt.com/lesson/select_queries_introduction

--Select query for a specific columns
SELECT column, another_column, …
FROM mytable;


--Select query for all columns
SELECT * 
FROM mytable;


--Exercise 1 — Tasks

--1)Find the title of each film ✓
SELECT title FROM movies;

--2)Find the director of each film ✓
SELECT director FROM movies;

--3)Find the title and director of each film ✓
SELECT director, title FROM movies;

--4)Find the title and year of each film ✓
SELECT year, title FROM movies;

--Find all the information about each film 
SELECT * FROM movies;


--**********************************************************************************************************************


SQL Lesson 2: Queries with constraints (Pt. 1)
--https://sqlbolt.com/lesson/select_queries_with_constraints

--Select query with constraints
SELECT column, another_column, …
FROM mytable
WHERE condition
    AND/OR another_condition
    AND/OR …;
	
	
	
Operator				Condition												SQL Example
=, !=, < <=, >, >=		Standard numerical operators							col_name != 4
BETWEEN … AND …			Number is within range of two values (inclusive)		col_name BETWEEN 1.5 AND 10.5
NOT BETWEEN … AND …		Number is not within range of two values (inclusive)	col_name NOT BETWEEN 1 AND 10
IN (…)					Number exists in a list	col_name 						IN (2, 4, 6)
NOT IN (…)				Number does not exist in a list	col_name 				NOT IN (1, 3, 5)



Exercise 2 — Tasks

1-Find the movie with a row id of 6
SELECT * FROM movies
WHERE id=6;


2-Find the movies released in the years between 2000 and 2010
SELECT * FROM movies
WHERE year BETWEEN 2000 AND 2010;


3-Find the movies not released in the years between 2000 and 2010
SELECT * FROM movies
WHERE year NOT BETWEEN 2000 AND 2010;

--or
SELECT * FROM movies
WHERE year <2000 OR year>2010;

4-Find the first 5 Pixar movies and their release year
SELECT title, year FROM movies
WHERE year <= 2003;

SELECT title, year FROM movies
limit 5;



--**********************************************************************************************************************



SQL Lesson 3: Queries with constraints (Pt. 2)
--https://sqlbolt.com/lesson/select_queries_with_constraints_pt_2

Select query with constraints
SELECT column, another_column, …
FROM mytable
WHERE condition
    AND/OR another_condition
    AND/OR …;


Operator	Condition																								Example
=			Case sensitive exact string comparison (notice the single equals)										col_name = "abc"
!= or <>	Case sensitive exact string inequality comparison														col_name != "abcd"
LIKE		Case insensitive exact string comparison																col_name LIKE "ABC"
NOT LIKE	Case insensitive exact string inequality comparison														col_name NOT LIKE "ABCD"
%			Used anywhere in a string to match a sequence of zero or more characters (only with LIKE or NOT LIKE)	col_name LIKE "%AT%"
																													(matches "AT", "ATTIC", "CAT" or even "BATS")
_			Used anywhere in a string to match a single character (only with LIKE or NOT LIKE)						col_name LIKE "AN_"
																													(matches "AND", but not "AN")
IN (…)		String exists in a list																					col_name IN ("A", "B", "C")
NOT IN (…)	String does not exist in a list																			col_name NOT IN ("D", "E", "F")



Exercise 3 — Tasks

--1-Find all the Toy Story movies 
SELECT * FROM movies
WHERE title LIKE "Toy Story%"


--2-Find all the movies directed by John Lasseter
SELECT*FROM movies
WHERE Director LIKE 'John Lasseter%'
--OR
SELECT * FROM movies
WHERE director='John Lasseter'


--3-Find all the movies (and director) not directed by John Lasseter 
SELECT title, director FROM movies 
WHERE director <> "John Lasseter";		--OR WHERE director!="John Lasseter"
--OR
SELECT title, director FROM movies
WHERE director NOT LIKE "John Lasseter"


--4-Find all the WALL-* movies 
SELECT * FROM movies
WHERE title LIKE "WALL%"



--**********************************************************************************************************************



SQL Lesson 4: Filtering and sorting Query results
https://sqlbolt.com/lesson/filtering_sorting_query_results

Select query with unique results
SELECT DISTINCT column, another_column, …			--DISTINCT keyword will remove duplicate rows
FROM mytable
WHERE condition(s);
	
	
Select query with ordered results
SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC;




Select query with limited rows
SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;

--The LIMIT will reduce the number of rows to return, and the optional OFFSET will specify where to begin counting the number rows from.


Exercise 4 — Tasks

--1-List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT director FROM movies
ORDER BY director;

--2-List the last four Pixar movies released (ordered from most recent to least)
SELECT * FROM movies
ORDER BY year DESC
limit 4;

--3-List the first five Pixar movies sorted alphabetically
SELECT * FROM movies
ORDER BY TITLE
LIMIT 5;

--4-List the next five Pixar movies sorted alphabetically
SELECT * FROM movies
ORDER BY TITLE
LIMIT 5 OFFSET 5;




--**********************************************************************************************************************



SQL Review: Simple SELECT Queries
https://sqlbolt.com/lesson/select_queries_review

SELECT query
SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;



--Review 1 — Tasks

--1-List all the Canadian cities and their populations
SELECT city, population FROM north_american_cities
WHERE country='Canada';

--2-Order all the cities in the United States by their latitude(enlem) from north to south
SELECT city FROM north_american_cities
WHERE country = 'United States'
ORDER BY latitude DESC;

--3-List all the cities west of Chicago, ordered from west to east
SELECT city, longitude FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;

--4-List the two largest cities in Mexico (by population)
SELECT city FROM north_american_cities
WHERE country = 'Mexico'
ORDER BY population DESC
LIMIT 2;

--5-List the third and fourth largest cities (by population) in the United States and their population
SELECT city, population FROM north_american_cities
WHERE country = 'United States'
ORDER BY population DESC
LIMIT 2 OFFSET 2;





--**********************************************************************************************************************




SQL Lesson 6: Multi-table queries with JOINs
https://sqlbolt.com/lesson/select_queries_with_joins


Select query with INNER JOIN on multiple tables
SELECT column, another_table_column, …
FROM mytable
INNER JOIN another_table 
    ON mytable.id = another_table.id
WHERE condition(s)
ORDER BY column, … ASC/DESC
LIMIT num_limit OFFSET num_offset;


--The INNER JOIN is a process that matches rows from the first table and the second table which have the same key (as defined 
--by the ON constraint) to create a result row with the combined columns from both tables.




Exercise 6 — Tasks

--1-Find the domestic and international sales for each movie ✓
SELECT Title, Domestic_sales, International_sales
FROM Movies
INNER JOIN Boxoffice
ON Movies.id=Boxoffice.Movie_id;

--2-Show the sales numbers for each movie that did better internationally rather than domestically
SELECT Title, Domestic_sales, International_sales
FROM Movies
INNER JOIN Boxoffice
ON Movies.id=Boxoffice.Movie_id
WHERE International_sales>Domestic_sales;


--3-List all the movies by their ratings in descending order
SELECT Title
FROM Movies
INNER JOIN Boxoffice
ON Movies.id=Boxoffice.Movie_id
ORDER BY Rating DESC;





--**********************************************************************************************************************


SQL Lesson 7: OUTER JOINs

https://sqlbolt.com/lesson/select_queries_with_outer_joins



Select query with LEFT/RIGHT/FULL JOINs on multiple tables
SELECT column, another_column, …
FROM mytable
INNER/LEFT/RIGHT/FULL JOIN another_table 
    ON mytable.id = another_table.matching_id
WHERE condition(s)
ORDER BY column, … ASC/DESC
LIMIT num_limit OFFSET num_offset;



Exercise 7 — Tasks

--1-Find the list of all buildings that have employees ✓
SELECT DISTINCT building from Employees;

--OR
SELECT 	DISTINCT Building FROM employees
WHERE NAME IS NOT NULL;

--or
SELECT DISTINCT Building FROM employees
left join Buildings
ON Building_name=Building
WHERE Name IS NOT NULL



--2-Find the list of all buildings and their capacity
SELECT Building_name, Capacity from Buildings;



--3-List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT building_name, role 
FROM buildings 
LEFT JOIN employees
ON building_name = building;		--or ON Buildings.Building_name= Employees.Building;
	
--or
SELECT Distinct b.Building_Name,  e.Role FROM Buildings b
LEFT JOIN Employees e
ON e.Building=b.Building_name;



--**********************************************************************************************************************


SQL Lesson 8: A short note on NULLs

https://sqlbolt.com/lesson/select_queries_with_nulls

Select query with constraints on NULL values
SELECT column, another_column, …
FROM mytable
WHERE column IS/IS NOT NULL
AND/OR another_condition
AND/OR …;



Exercise 8 — Tasks

--1-Find the name and role of all employees who have not been assigned to a building
SELECT Name, Role FROM Employees  --SELECT DISTINCT name, role FROM employees
WHERE Building IS NULL;

--or
SELECT Building_name, name, role FROM Employees
LEFT JOIN Buildings
ON Building_name=Building
WHERE Building IS NULL;


--2-Find the names of the buildings that hold no employees
SELECT Building_name FROM Buildings
LEFT JOIN Employees 
ON Building_name=Building		--ON Buildings.Building_name=Employees.Building
WHERE Name IS NULL;



--**********************************************************************************************************************


SQL Lesson 9: Queries with expressions
https://sqlbolt.com/lesson/select_queries_with_expressions


Example query with expressions
SELECT particle_speed / 2.0 AS half_particle_speed
FROM physics_data
WHERE ABS(particle_position) * 10.0 > 500;


Select query with expression aliases
SELECT col_expression AS expr_description, …
FROM mytable;


Example query with both column and table name aliases
SELECT column AS better_column_name, …
FROM a_long_widgets_table_name AS mywidgets
INNER JOIN widget_sales
ON mywidgets.id = widget_sales.widget_id;
    
  
  
 Exercise 9 — Tasks 
  
--1-List all movies and their combined sales in millions of dollars
SELECT title, (domestic_sales + international_sales) / 1000000 AS total_sales
FROM movies
LEFT JOIN boxoffice		--or  JOIN Boxoffice 
ON movies.id = boxoffice.movie_id;		--OR JUST -->  ON Id=Movie_id


--2-List all movies and their ratings in percent
SELECT title, rating*10 AS rating_in_percent  FROM movies
LEFT JOIN Boxoffice 
ON Id=Movie_id;
	

--3-List all movies that were released on even number years
SELECT title, year
FROM movies
WHERE year % 2 = 0;    --or WHERE year % 2 == 0;




--**********************************************************************************************************************




SQL Lesson 10: Queries with aggregates (Pt. 1)
https://sqlbolt.com/lesson/select_queries_with_aggregates


--Select query with aggregate functions over all rows
SELECT AGG_FUNC(column_or_expression) AS aggregate_description, …
FROM mytable
WHERE constraint_expression;


Function					Description
COUNT(*), COUNT(column)		A common function used to counts the number of rows in the group if no column name is specified. Otherwise, count the number of rows in the group with non-NULL values in the specified column.
MIN(column)					Finds the smallest numerical value in the specified column for all rows in the group.
MAX(column)					Finds the largest numerical value in the specified column for all rows in the group.
AVG(column)					Finds the average numerical value in the specified column for all rows in the group.
SUM(column)					Finds the sum of all numerical values in the specified column for the rows in the group.



--Select query with aggregate functions over groups
SELECT AGG_FUNC(column_or_expression) AS aggregate_description, …
FROM mytable
WHERE constraint_expression
GROUP BY column;



Exercise 10 — Tasks

--1-Find the longest time that an employee has been at the studio
SELECT name, MAX(Years_employed)  FROM employees;		--OR SELECT MAX(	Years_employed) FROM employees;

--2-For each role, find the average number of years employed by employees in that role
SELECT Role, AVG(Years_employed) FROM employees
GROUP BY Role;

--3-Find the total number of employee years worked in each building
SELECT Building, SUM(Years_employed) FROM employees
GROUP BY Building;




--**********************************************************************************************************************


SQL Lesson 11: Queries with aggregates (Pt. 2)
https://sqlbolt.com/lesson/select_queries_with_aggregates_pt_2



SELECT group_by_column, AGG_FUNC(column_expression) AS aggregate_result_alias, …
FROM mytable
WHERE condition
GROUP BY column
HAVING group_condition;



Exercise 11 — Tasks

--1-Find the number of Artists in the studio (without a HAVING clause)
SELECT COUNT(Name) FROM employees    -- or  SELECT COUNT(Role) FROM employees
WHERE Role='Artist';

--2-Find the number of Employees of each role in the studio
SELECT Role, COUNT(Name) FROM Employees
GROUP BY Role


--3-Find the total number of years employed by all Engineers
SELECT SUM(Years_employed) FROM Employees
WHERE Role='Engineer';

--or
select role,sum(years_employed)
from employees
group by role
having role = 'Engineer';



--**********************************************************************************************************************



SQL Lesson 12: Order of execution of a Query
https://sqlbolt.com/lesson/select_queries_order_of_execution



Complete SELECT query
SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
FROM mytable
    JOIN another_table
      ON mytable.column = another_table.column
    WHERE constraint_expression
    GROUP BY column
    HAVING constraint_expression
    ORDER BY column ASC/DESC
    LIMIT count OFFSET COUNT;
	

Exercise 12 — Tasks

--1-Find the number of movies each director has directed
SELECT  COUNT(Title), Director FROM movies
GROUP BY Director


--2-Find the total domestic and international sales that can be attributed to each director
SELECT Director, Title, SUM(Domestic_sales+International_sales) AS Total_Sales
FROM Movies
LEFT JOIN Boxoffice
ON Id=Movie_id
GROUP BY Director

--OR
SELECT Director, SUM(Domestic_sales+International_sales) as total_sales   
FROM Boxoffice 
INNER JOIN Movies		--INNER JOIN and JOIN ARE SAME.
ON Boxoffice.Movie_id=Movies.Id
GROUP BY Director;

--OR
SELECT Director, SUM(Domestic_sales+International_sales) as total_sales   
FROM Movies 
JOIN Boxoffice
ON Boxoffice.Movie_id=Movies.Id
GROUP BY Director;




--Extra questions:

--find director who has most movies.
SELECT count(Title), Director FROM movies
GROUP BY Director
ORDER BY Count(Title) DESC
LIMIT 1;

--Range the directors' movie numbers from largest to smallest
SELECT  Director, count(Title) as num_of_movies FROM movies
GROUP BY Director
ORDER BY Count(Title) DESC	--ORDER BY num_of_movies desc


----We collected both minutes and counted movies.
SELECT  Director, count(Title), sum(Length_minutes) as total_minuts_of_movies  FROM movies
GROUP BY Director
ORDER BY total_minuts_of_movies desc




--**********************************************************************************************************************


--SQL Lesson 13: Inserting rows
https://sqlbolt.com/lesson/inserting_rows

--Insert statement with values for all columns
INSERT INTO mytable
VALUES (value_or_expr, another_value_or_expr, …),
       (value_or_expr_2, another_value_or_expr_2, …),
       …;
	   
	   
--Insert statement with specific columns
INSERT INTO mytable
(column, another_column, …)
VALUES (value_or_expr, another_value_or_expr, …),
      (value_or_expr_2, another_value_or_expr_2, …),
      …;   
	  
	  
	   
Example Insert statement with expressions
INSERT INTO boxoffice
(movie_id, rating, sales_in_millions)
VALUES (1, 9.9, 283742034 / 1000000);



Exercise 13 — Tasks

--1-Add the studio's new production, Toy Story 4 to the list of movies (you can use any director) ✓
INSERT INTO movies VALUES(4, 'Toy Story 4', 'Andrew Stanton', 2023, 80);


--2-Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.
INSERT INTO Boxoffice VALUES(4, 8.7, 340000000, 270000000);




--**********************************************************************************************************************


https://sqlbolt.com/lesson/updating_rows
--SQL Lesson 14: Updating rows

Update statement with values
UPDATE mytable
SET column = value_or_expr, 
    other_column = another_value_or_expr, 
    …
WHERE condition;



Exercise 14 — Tasks

--1-The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
UPDATE movies
SET director = 'John Lasseter'
WHERE id = 2;
	
	
--2-The year that Toy Story 2 was released is incorrect, it was actually released in 1999
UPDATE Movies
SET Year=1999
WHERE Id=3;

--or
UPDATE movies
SET year = 1999
WHERE Title = "Toy Story 2";


--3-Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
UPDATE Movies
SET Title='Toy Story 3', Director='Lee Unkrich'
WHERE Id=11;

--or
UPDATE Movies
SET Director='Lee Unkrich', Title='Toy Story 3'
where Title='Toy Story 8'



--**********************************************************************************************************************


https://sqlbolt.com/lesson/deleting_rows
--SQL Lesson 15: Deleting rows

Delete statement with condition
DELETE FROM mytable
WHERE condition;



Exercise 15 — Tasks


--1-This database is getting too big, lets remove all movies that were released before 2005.
DELETE FROM movies
WHERE Year<2005

--2-Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE FROM Movies
WHERE Director='Andrew Stanton';


--**********************************************************************************************************************


https://sqlbolt.com/lesson/creating_tables
--SQL Lesson 16: Creating tables

--Create table statement w/ optional table constraint and default value
CREATE TABLE IF NOT EXISTS mytable (
    column DataType TableConstraint DEFAULT default_value,
    another_column DataType TableConstraint DEFAULT default_value,
    …
);



--Here's an example schema for the Movies table that we've been using in the lessons up to now.

Movies table schema
CREATE TABLE movies (
    id INTEGER PRIMARY KEY,
    title TEXT,
    director TEXT,
    year INTEGER, 
    length_minutes INTEGER
);




Exercise 16 — Tasks

/*Create a new table named Database with the following columns:
– Name A string (text) describing the name of the database
– Version A number (floating point) of the latest version of this database
– Download_count An integer count of the number of times this database was downloaded
This table has no constraints. */

CREATE TABLE Database (
Name TEXT,
Version INTEGER,
Download_count INTEGER
)



--**********************************************************************************************************************


https://sqlbolt.com/lesson/altering_tables
--SQL Lesson 17: Altering tables



--Altering table to add new column(s)
ALTER TABLE mytable
ADD column DataType OptionalTableConstraint 
    DEFAULT default_value;
	

--Altering table to remove column(s)
ALTER TABLE mytable
DROP column_to_be_deleted;


--Altering table name
ALTER TABLE mytable
RENAME TO new_table_name;



Exercise 17 — Tasks	

--1) Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each 
--movie was released in.

ALTER TABLE Movies
ADD COLUMN Aspect_ratio float


--2) Add another column named Language with a TEXT data type to store the language that the 
--movie was released in. Ensure that the default for this language is English.
ALTER TABLE Movies
ADD COLUMN Language TEXT DEFAULT 'English'



--**********************************************************************************************************************


https://sqlbolt.com/lesson/dropping_tables
SQL Lesson 18: Dropping tables


--Drop table statement
DROP TABLE IF EXISTS mytable;



Exercise 18 — Tasks

--1-We've sadly reached the end of our lessons, lets clean up by removing the Movies table
DROP TABLE Movies;

--2-And drop the BoxOffice table as well ✓
DROP TABLE Boxoffice;
