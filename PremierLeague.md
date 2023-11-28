# Premier League Dataset Analysis

Dataset: https://www.kaggle.com/datasets/evangower/premier-league-matches-19922022

## Team Performance
* Which team(s) scored the most goals in a season?
  
```sql
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
```
* What team(s) had the highest average goals per match at home and away?

Home
```sql
SELECT Home AS Team, ROUND(AVG(HomeGoals), 2) AS 'Average Home Goals'
FROM Matches
GROUP BY Home
ORDER BY AVG(HomeGoals) DESC
```

Away
```sql
SELECT Away AS Team, ROUND(AVG(AwayGoals), 2) AS 'Average Away Goals'
FROM Matches
GROUP BY Away
ORDER BY AVG(AwayGoals) DESC
```

* Which team(s) had the most wins, losses, or draws across different seasons?

Wins
```sql
SELECT Team, COUNT(*) AS Wins
FROM (
    SELECT Home as Team
    FROM Matches
    WHERE FTR = 'H' -- Selects all the Home wins
    UNION ALL
    SELECT Away as Team
    FROM Matches
    WHERE FTR = 'A') -- Selects all the Away wins
GROUP BY Team
ORDER BY Wins DESC
```