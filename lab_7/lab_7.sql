/* Pourna Sengupta */
/* CSCI 3308: Lab 7 */

/* #1: PostgreSQL Database Setup */
CREATE TABLE IF NOT EXISTS football_games (
  visitor_name VARCHAR(30),       /* Name of the visiting team                     */
  home_score SMALLINT NOT NULL,   /* Final score of the game for the Buffs         */
  visitor_score SMALLINT NOT NULL,/* Final score of the game for the visiting team */
  game_date DATE NOT NULL,        /* Date of the game                              */
  players INT[] NOT NULL,         /* This array consists of the football player ids (basically a foreign key to the football_player.id) */
  PRIMARY KEY(visitor_name, game_date) /* A game's unique primary key consists of the visitor_name & the game date (this assumes you can't have multiple games against the same team in a single day) */
);

CREATE TABLE IF NOT EXISTS football_players(
  id SERIAL PRIMARY KEY,       /* Unique identifier for each player (it's possible multiple players have the same name/similiar information) */
  name VARCHAR(50) NOT NULL,   /* The player's first & last name */
  year VARCHAR(3),             /* FSH - Freshman, SPH - Sophomore, JNR - Junior, SNR - Senior */
  major VARCHAR(4),            /* The unique 4 character code used by CU Boulder to identify student majors (ex. CSCI, ATLS) */
  passing_yards SMALLINT,      /* The number of passing yards in the players entire football career  */
  rushing_yards SMALLINT,      /* The number of rushing yards in the players entire football career  */
  receiving_yards SMALLINT,    /* The number of receiving yards in the players entire football career*/
  img_src VARCHAR(200)         /* This is a file path (absolute or relative), that locates the player's profile image */
);

INSERT INTO football_games(visitor_name, home_score, visitor_score, game_date, players)
VALUES('Colorado State', 45, 13, '20200831', ARRAY [1,2,3,4,5] ),
('Nebraska', 33, 28, '20200908', ARRAY [2,3,4,5,6]),
('New Hampshire', 45, 14, '20200915', ARRAY [3,4,5,6,7]),
('UCLA', 38, 16, '20200928', ARRAY [4,5,6,7,8]),
('Arizona State', 28, 21, '20201006', ARRAY [5,6,7,8,9]),
('Southern California', 20, 31, '20201013', ARRAY [6,7,8,9,10]),
('Washington', 13, 27, '20201020', ARRAY [7,8,9,10,1]),
('Oregon State', 34, 41, '20201027', ARRAY [8,9,10,1,2]),
('Arizona', 34, 42, '20201102', ARRAY [9,10,1,2,3]),
('Washington State', 7, 31, '20201110', ARRAY [10,1,2,3,4]),
('Utah', 7, 30, '20201117', ARRAY [1,2,3,4,5]),
('California', 21, 33, '20201124', ARRAY [2,3,4,5,6]);

INSERT INTO football_players(name, year, major, passing_yards, rushing_yards, receiving_yards)
VALUES('Cedric Vega', 'FSH', 'ARTS', 15, 25, 33),
('Myron Walters', 'SPH', 'CSCI', 32, 43, 52),
('Javier Washington', 'JNR', 'MATH', 1, 61, 45),
('Wade Farmer', 'SNR', 'ARTS', 14, 55, 12),
('Doyle Huff', 'FSH', 'CSCI', 23, 44, 92),
('Melba Pope', 'SPH', 'MATH', 13, 22, 45),
('Erick Graves', 'JNR', 'ARTS', 45, 78, 98 ),
('Charles Porter', 'SNR', 'CSCI', 92, 102, 125),
('Rafael Boreous', 'JNR', 'MATH', 102, 111, 105),
('Jared Castillo', 'SNR', 'ARTS', 112, 113, 114);

/* #3: Creating Tables & Inserting Data */

/* #3.1 Write an SQL Script to create a new table to hold information on the competing universities. The table should hold the following information:

  University Name (VARCHAR(200)) (Note: University Name should be unique and set as PRIMARY KEY)
  Date Established (Date)
  Address (Text)
  Student Population (Int)
  Acceptance Rate (Decimal)
*/
CREATE TABLE IF NOT EXISTS 
universities( university_name VARCHAR(200) PRIMARY KEY, 
date_est DATE NOT NULL, 
address TEXT NOT NULL, 
student_pop INT NOT NULL, 
acceptance_rate DECIMAL(5, 2)); 

/* #3.2: Write an insert statement to add the University Information The table should hold the following information:

  University Name :- CU Boulder
  Date Established :- April 1st, 1876
  Address :- 1100 28th St, Boulder, CO 80303
  Student Population :- 35,000
  Acceptance Rate :- 80%
*/
INSERT INTO 
universities(university_name, date_est, address, student_pop, acceptance_rate) 
VALUES('CU Boulder', '1876-04-01', '1100 28th St, Boulder, CO 80303', 35000, 80.00);


/* #4: Query Basics */

/* #4.1: Write a script to list the Football Players (name and major), 
organized by major in college.*/
SELECT name, major 
FROM football_players
ORDER BY major; 

/*name        | major 
-------------------+-------
 Cedric Vega       | ARTS
 Wade Farmer       | ARTS
 Erick Graves      | ARTS
 Jared Castillo    | ARTS
 Doyle Huff        | CSCI
 Myron Walters     | CSCI
 Charles Porter    | CSCI
 Melba Pope        | MATH
 Rafael Boreous    | MATH
 Javier Washington | MATH
(10 rows)
*/

/* #4.2: Write a script to list all of the Football Players 
(name and rushing yards) who have 70 or more rushing yards.*/
SELECT name, rushing_yards 
FROM football_players 
WHERE rushing_yards >= 70
ORDER BY rushing_yards ASC; 

/*      name      | rushing_yards 
----------------+---------------
 Erick Graves   |            78
 Charles Porter |           102
 Rafael Boreous |           111
 Jared Castillo |           113
(4 rows)
*/

/* #4.3: Write a script to list all of the games played against 
Nebraska (show all game information).*/
SELECT visitor_name, home_score, visitor_score, game_date, players
FROM football_games 
WHERE visitor_name = 'Nebraska'; 

/* visitor_name | home_score | visitor_score | game_date  |   players   
--------------+------------+---------------+------------+-------------
 Nebraska     |         33 |            28 | 2020-09-08 | {2,3,4,5,6}
(1 row)
*/

/* #4.4: Write a script to list all of the games CU Boulder has 
won (show all game information).*/
SELECT visitor_name, home_score, visitor_score, game_date, players
FROM football_games 
WHERE home_score > visitor_score; 

/*  visitor_name  | home_score | visitor_score | game_date  |   players   
----------------+------------+---------------+------------+-------------
 Colorado State |         45 |            13 | 2020-08-31 | {1,2,3,4,5}
 Nebraska       |         33 |            28 | 2020-09-08 | {2,3,4,5,6}
 New Hampshire  |         45 |            14 | 2020-09-15 | {3,4,5,6,7}
 UCLA           |         38 |            16 | 2020-09-28 | {4,5,6,7,8}
 Arizona State  |         28 |            21 | 2020-10-06 | {5,6,7,8,9}
(5 rows)
*/


/* #4.5: Write a script to list all of the games played in the 
Fall 2020 Season, September 1st through December 31st 
(show team name and game date).*/
SELECT visitor_name, game_date
FROM football_games 
WHERE game_date BETWEEN '2020-09-01' AND '2020-12-31'; 

/*visitor_name     | game_date  
---------------------+------------
 Nebraska            | 2020-09-08
 New Hampshire       | 2020-09-15
 UCLA                | 2020-09-28
 Arizona State       | 2020-10-06
 Southern California | 2020-10-13
 Washington          | 2020-10-20
 Oregon State        | 2020-10-27
 Arizona             | 2020-11-02
 Washington State    | 2020-11-10
 Utah                | 2020-11-17
 California          | 2020-11-24
(11 rows)*/


/* #4.6: Write a script to list the average number of points 
CU has scored in past games.*/
SELECT AVG(home_score) AS AvgScore
FROM football_games; 

/*avgscore       
---------------------
 27.0833333333333333
(1 row)*/


/* #4.7: Write a script to list the majors of the Football 
players and calculate how many of them are in each of the majors 
listed. Rename the column where you calculate the majors to "number_of_players".*/
SELECT major, COUNT(major) AS number_of_players
FROM football_players 
GROUP BY major; 

/* major | number_of_players 
-------+-------------------
 CSCI  |                 3
 ARTS  |                 4
 MATH  |                 3
(3 rows)
*/

/* #4.8: Write a script to modify the query in 4.7 above to include 
only the Football players who are majoring in Computer Science.*/
SELECT major, COUNT(major) AS number_of_players
FROM football_players 
WHERE major = 'CSCI'
GROUP BY major; 

/* major | number_of_players 
-------+-------------------
 CSCI  |                 3
(1 row)
*/

/* #5: Views & SubQueries*/

/* #5.1: Write a script to create a view that counts the total number 
of winning games. Output the view.*/
CREATE VIEW winning_games  
AS SELECT COUNT(home_score) AS num_of_wins
FROM football_games
WHERE home_score > visitor_score; 

/* winning_games
-----------------
              5
(1 row) */

/* #5.2: Write a script to create a view that counts the total number 
of games played. Output the view.*/
CREATE VIEW games 
AS SELECT COUNT(*) AS num_of_games
FROM football_games; 

/*   games
-----------------
              12
(1 row) */


/* #5.3: Write a script that uses the two views you created (5.1 and 5.2) 
to calculate the percent of wins.*/
SELECT(
	(CAST(winning_games.COUNT AS DECIMAL)/CAST(games.COUNT AS DECIMAL))*100) AS Percent_Of_Wins 
    FROM winning_games, games; 
    
/* percent_of_wins
-----------------
41.66666666666667
(1 row) */



/* #6: Handling Joins */

/* #6.1: Write a script that will count how many games 
"Cedric Vega" has played in during his entire football career. 
You can do this using a JOIN or a sub query.*/
SELECT COUNT(*)
FROM football_players
INNER JOIN football_games 
	ON football_players.id = ANY(football_games.players) 
WHERE football_players.name = 'Cedric Vega'; 

/* count 
-------
     6
(1 row)*/

/* #6.2: Write a script that will calculate the average number 
of rushing yards for "Cedric Vega", based on the number of 
games he has played.*/
CREATE VIEW c_vega_games 
AS SELECT * 
FROM football_players 
INNER JOIN football_games 
	ON football_players.id = ANY(football_games.players) 
WHERE football_players.name = 'Cedric Vega'; 


SELECT CAST(c_vega_games.rushing_yards AS DECIMAL)/CAST(c_vega_games.count AS DECIMAL)
FROM c_vega_games
GROUP BY rushing_yards; 


/*    ?column?      
--------------------
 4.1666666666666667
(1 row)*/
