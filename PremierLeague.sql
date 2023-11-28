


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