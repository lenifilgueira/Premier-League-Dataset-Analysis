# Premier League Dataset Analysis

Dataset can be found [here](https://www.kaggle.com/datasets/evangower/premier-league-matches-19922022)

SQL Server is used throughout this document since the queries were run on a locally hosted database using SQL Server Management Studio.

**Note**: In some instances, the SQL output is limited for better readability.

## Team Performance
* Which teams scored the most goals in a season?
  
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
___
| Team            | Season | Goals Scored |
|-----------------|--------|--------------|
| Manchester City | 2018   | 106          |
| Chelsea         | 2010   | 103          |
| Manchester City | 2020   | 102          |
| Manchester City | 2014   | 102          |
| Liverpool       | 2014   | 101          |
___  

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
    WHERE FTR = 'A') -- Selects and appends all the Away wins
    AS TotalWins 
GROUP BY Team
ORDER BY Wins DESC
```

* What are the best performing Home and Away teams?
## Match Results Analysis

* What percentage of matches ended in home wins, away wins, or draws?
* Is there a correlation between home goals scored and the match result (Home Win/Draw/Away Win)?


## Seasonal Trends and Comparison:
* How are the different match results (Home Wins, Draws, Away Wins) distributed across different seasons?
* How does the number of goals scored change across seasons?
* Are there any trends in the number of draws or wins over seasons?
* Which season had the highest number of total goals scored?

## Matchweek Analysis:

* Are there particular match weeks where more goals are typically scored?
* Do teams perform differently based on the match week (early vs. later in the season)?

## Specific Match Analysis:

* What was the highest-scoring match in terms of total goals?
* Are there any specific matches where a team had an exceptionally high or low scoring game?