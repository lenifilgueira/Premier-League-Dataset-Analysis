
/*
SQL Queries for Premier League Dataset Analysis
Dataset can be found at https://www.kaggle.com/datasets/evangower/premier-league-matches-19922022
SQL Server is used throughout this document since the database was locally hosted on SSMS
*/

-- TEAM PERFORMANCE

--Which teams scored the most goals in a season?

SELECT TOP 5 Team, Season, SUM(TotalGoals) AS 'Goals Scored'
FROM (
    SELECT Home AS Team, Season_End_Year AS Season, HomeGoals AS TotalGoals 
    FROM Matches
    UNION ALL
    SELECT Away AS Team, Season_End_Year AS Season, AwayGoals AS TotalGoals
    FROM Matches
) AS GoalsScored
GROUP BY Team, Season
ORDER BY 'Goals Scored' DESC

--Which team(s) had the highest average goals per match at home and away?

--Home
SELECT Home AS Team, ROUND(AVG(HomeGoals), 2)  AS 'Average Home Goals' 
FROM Matches 
GROUP BY Home 
ORDER BY AVG(HomeGoals) DESC

--Away
SELECT Away AS Team, ROUND(AVG(AwayGoals), 2)  AS 'Average Away Goals'
FROM Matches
GROUP BY Away
ORDER BY AVG(AwayGoals) DESC

-- Which team(s) had the most wins, losses, or draws across different seasons?

--Wins
SELECT Team, COUNT(*) AS Wins
FROM (
    SELECT Home as Team
    FROM Matches
    WHERE FTR = 'H' -- Selects all the Home wins
    UNION ALL
    SELECT Away as Team
    FROM Matches
    WHERE FTR = 'A') -- Selects and appends all the Away wins
    AS TotalWins 
GROUP BY Team
ORDER BY Wins DESC

--Losses
SELECT Team, COUNT(*) AS Losses
FROM (
    SELECT Home as Team
    FROM Matches
    WHERE FTR = 'A' -- Selects all the Home losses
    UNION ALL
    SELECT Away as Team
    FROM Matches
    WHERE FTR = 'H') -- Selects and appends all the Away losses
    AS TotalLosses  
GROUP BY Team
ORDER BY Losses DESC

--Draws
SELECT Team, COUNT(*) AS Draws
FROM (
    SELECT Home as Team
    FROM Matches
    WHERE FTR = 'D' -- Selects all the Home draws
    UNION ALL
    SELECT Away as Team
    FROM Matches
    WHERE FTR = 'D') -- Selects and appends all the Away draws
    AS TotalDraws  
GROUP BY Team
ORDER BY Draws DESC

-- HOME VS. AWAY PERFORMANCE

-- Is there a home advantage? 
SELECT 
    ROUND(CAST(COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Home Winning %',
    ROUND(CAST(COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Away Winning %'
FROM Matches

/*
There seems indeed to be a Home advantage as per the result of the query above
Winning % for home games: 45.89%  
Winning % for away games: 28.36%
*/

-- What is the average number of goals scored at home vs. away?
SELECT 
    Round(AVG(HomeGoals), 2) AS 'Average Home Goals',
    Round(AVG(AwayGoals), 2) AS 'Average Away Goals'
FROM Matches

-- What are the best performing Home and Away teams?

--Home
SELECT TOP 1 Home AS Team, ROUND(CAST(COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Home Winning %'
FROM Matches
GROUP BY Home
ORDER BY 'Home Winning %' DESC

--Away
SELECT TOP 1 Away AS Team, ROUND(CAST(COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Away Winning %'
FROM Matches
GROUP BY Away
ORDER BY 'Away Winning %' DESC

-- MATCH RESULT ANALYSIS

-- What percentage of matches ended in home wins, away wins, or draws?
SELECT 
    ROUND(CAST(COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Home Winning %',
    ROUND(CAST(COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Away Winning %',
    ROUND(CAST(COUNT(CASE WHEN FTR = 'D' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Draws %'
FROM Matches

-- Is there a correlation between home goals scored and the match result (Home Win/Draw/Away Win)?
SELECT 
    CASE 
        WHEN HomeGoals > AwayGoals THEN 'Home Win'
        WHEN HomeGoals = AwayGoals THEN 'Draw'
        ELSE 'Away Win'
    END AS 'Match Result',
    AVG(HomeGoals) AS 'Average Home Goals'
FROM Matches
GROUP BY
    CASE 
        WHEN HomeGoals > AwayGoals THEN 'Home Win'
        WHEN HomeGoals = AwayGoals THEN 'Draw'
        ELSE 'Away Win'
    END
ORDER BY 'Match Result';

-- As expected there is a positive correlation between a home win and goals scored



-- SEASONAL TRENDS AND COMPARISON

-- How are the different match results (Home Wins, Draws, Away Wins) distributed across different seasons?
SELECT 
    Season_End_Year AS Season, 
    COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS 'Home Wins', 
    COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS 'Away Wins', 
    COUNT(CASE WHEN FTR = 'D' THEN 1 END) AS 'Draws Wins'
FROM Matches
GROUP BY Season_End_Year
ORDER BY Season_End_Year DESC

-- How does the number of goals scored change across seasons?

SELECT 
    Season_End_Year AS Season, 
    SUM(CASE WHEN FTR = 'H' THEN HomeGoals END) AS 'Home Win Goals', 
    SUM(CASE WHEN FTR = 'A' THEN HomeGoals END) AS 'Away Win Goals', 
    SUM(CASE WHEN FTR = 'D' THEN HomeGoals END) AS 'Draw Goals' 
FROM Matches
GROUP BY Season_End_Year
ORDER BY Season_End_Year DESC

-- Are there any trends in the number of draws or wins over seasons?
