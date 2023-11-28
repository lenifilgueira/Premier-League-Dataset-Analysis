

-- TEAM PERFORMANCE

--Which team(s) scored the most goals in a season?
SELECT Team, Season, SUM(TotalGoals) AS 'Goals Scored'
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
SELECT Home AS Team, ROUND(AVG(HomeGoals), 2) AS 'Average Home Goals' 
FROM Matches 
GROUP BY Home 
ORDER BY AVG(HomeGoals) DESC