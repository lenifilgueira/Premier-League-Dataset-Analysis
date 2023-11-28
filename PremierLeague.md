# Premier League Dataset Analysis
![](https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Premier_League_Logo.svg/280px-Premier_League_Logo.svg.png)  



## About the Dataset


The dataset can be found [here](https://www.kaggle.com/datasets/evangower/premier-league-matches-19922022). It encompasses every match played in the English Premier League since its inception in 1992, spanning up to the final week of the 2021-2022 season.

## About the Premier League


The Premier League was established on 20 February 1992 after clubs in the Football League First Division opted to break away from the Football League, which was founded in 1888. This decision was driven by the opportunity to capitalize on a lucrative television rights sale to Sky.

A total of 50 clubs have competed in the Premier League since its establishment in 1992. Among these clubs, forty-eight are English, and two are Welsh. Seven teams have clinched the title: Manchester United (13), Manchester City (6), Chelsea (5), Arsenal (3), Blackburn Rovers (1), Leicester City (1), and Liverpool (1).


## Note
SQL Server is used throughout this document since the queries were run on a locally hosted database using SQL Server Management Studio.

In some instances, the SQL output is limited for better readability.

## Summary

This project involves analyzing the Premier League dataset to extract insights and patterns related to team performance, match results, seasonal trends, and specific match analysis. SQL Server was utilized extensively in querying the locally hosted database using SQL Server Management Studio.

Key areas of investigation include:

### Team Performance
* Identifying teams that scored the most goals in a season
* Determining teams with the highest average goals per match at home and away
* Analyzing teams with the most wins, losses, or draws across different seasons

### Match Results Analysis
* Calculating the percentage of matches ending in home wins, away wins, or draws
* Exploring the correlation between home goals scored and match results (Home Win/Draw/Away Win)

### Seasonal Trends and Comparison
* Observing how different match results are distributed across various seasons
* Analyzing the change in the number of goals scored across seasons and identifying changes in wins, losses or draws over time
* Determining the season with the highest total goals scored

### Matchweek Analysis
* Investigating if specific match weeks tend to have more goals scored
* Investigating if specific match weeks tend to have more Draws as a match result
  
### Specific Match Analysis
* Identifying the highest-scoring match in terms of total goals
* Exploring matches where teams had exceptionally high or low-scoring games

This project aims to uncover statistical insights and trends using SQL within the Premier League dataset, offering valuable perspectives on team performance, match results, and season-by-season analysis to better understand the dynamics of the football league.


## Team Performance
### Which teams scored the most goals in a season?
  
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
<details>
<summary>Result</summary>

| Team            | Season | Goals Scored |
|-----------------|--------|--------------|
| Manchester City | 2018   | 106          |
| Chelsea         | 2010   | 103          |
| Manchester City | 2020   | 102          |
| Manchester City | 2014   | 102          |
| Liverpool       | 2014   | 101          |
</details>

### What team(s) had the highest average goals per match at home and away?

Home
```sql
SELECT Home AS Team, ROUND(AVG(HomeGoals), 2) AS 'Average Home Goals'
FROM Matches
GROUP BY Home
ORDER BY AVG(HomeGoals) DESC
```
<details>
<summary>Result</summary>

| Team            | Average Home Goals |
|-----------------|--------------------|
| Manchester Utd  | 2.1                |
| Manchester City | 2.03               |
| Arsenal         | 2.03               |
| Liverpool       | 2.02               |
| Chelsea         | 1.92               |
| Tottenham       | 1.73               |
| Newcastle Utd   | 1.62               |
| Oldham Athletic | 1.6                |
| Blackpool       | 1.58               |
| Blackburn       | 1.57               |
| Everton         | 1.51               |
| Brentford       | 1.5                |
| Sheffield Weds  | 1.48               |
| Leeds United    | 1.48               |
| West Ham        | 1.46               |
| Leicester City  | 1.41               |
| Southampton     | 1.4                |
| QPR             | 1.4                |
| Portsmouth      | 1.38               |
| Wimbledon       | 1.38               |
| Middlesbrough   | 1.37               |
| Bournemouth     | 1.37               |
| Fulham          | 1.35               |
| Swansea City    | 1.35               |
| Aston Villa     | 1.33               |
| Barnsley        | 1.32               |
| Charlton Ath    | 1.31               |
| Stoke City      | 1.31               |
| Bolton          | 1.29               |
| Reading         | 1.25               |
| Ipswich Town    | 1.24               |
| Coventry City   | 1.24               |
| Brighton        | 1.24               |
| Norwich City    | 1.22               |
| Birmingham City | 1.22               |
| Bradford City   | 1.21               |
| Nott'ham Forest | 1.2                |
| West Brom       | 1.19               |
| Swindon Town    | 1.19               |
| Watford         | 1.18               |
| Sheffield Utd   | 1.18               |
| Derby County    | 1.18               |
| Wolves          | 1.17               |
| Hull City       | 1.13               |
| Wigan Athletic  | 1.11               |
| Sunderland      | 1.11               |
| Crystal Palace  | 1.08               |
| Cardiff City    | 1.08               |
| Burnley         | 1.06               |
| Huddersfield    | 0.68               |
</details>
<br>

Away
```sql
SELECT Away AS Team, ROUND(AVG(AwayGoals), 2) AS 'Average Away Goals'
FROM Matches
GROUP BY Away
ORDER BY AVG(AwayGoals) DESC
```
<details>
<summary>Result</summary>

| Team            | Average Away Goals |
|-----------------|--------------------|
| Manchester Utd  | 1.67               |
| Arsenal         | 1.51               |
| Liverpool       | 1.5                |
| Manchester City | 1.47               |
| Chelsea         | 1.46               |
| Tottenham       | 1.32               |
| Blackpool       | 1.32               |
| Brentford       | 1.29               |
| Leicester City  | 1.27               |
| Leeds United    | 1.25               |
| Reading         | 1.14               |
| Aston Villa     | 1.11               |
| Sheffield Weds  | 1.11               |
| Blackburn       | 1.1                |
| Crystal Palace  | 1.09               |
| Newcastle Utd   | 1.08               |
| Bournemouth     | 1.07               |
| Brighton        | 1.06               |
| Nott'ham Forest | 1.06               |
| Everton         | 1.06               |
| Wimbledon       | 1.05               |
| Swindon Town    | 1.05               |
| QPR             | 1.04               |
| Bolton          | 1.04               |
| Southampton     | 1.01               |
| West Ham        | 1.01               |
| Wigan Athletic  | 0.97               |
| Swansea City    | 0.95               |
| Coventry City   | 0.95               |
| Charlton Ath    | 0.94               |
| Ipswich Town    | 0.93               |
| Wolves          | 0.93               |
| Burnley         | 0.91               |
| Sunderland      | 0.91               |
| Oldham Athletic | 0.9                |
| Fulham          | 0.9                |
| Middlesbrough   | 0.89               |
| Norwich City    | 0.89               |
| West Brom       | 0.87               |
| Derby County    | 0.86               |
| Watford         | 0.86               |
| Birmingham City | 0.83               |
| Portsmouth      | 0.81               |
| Stoke City      | 0.79               |
| Hull City       | 0.78               |
| Sheffield Utd   | 0.71               |
| Cardiff City    | 0.66               |
| Barnsley        | 0.63               |
| Huddersfield    | 0.63               |
| Bradford City   | 0.58               |
</details>

### Which team(s) had the most wins, losses, or draws across different seasons?

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
<details>
<summary>Result</summary>

| Team            | Wins |
|-----------------|------|
| Manchester Utd  | 726  |
| Arsenal         | 645  |
| Chelsea         | 629  |
| Liverpool       | 628  |
| Tottenham       | 520  |
| Manchester City | 501  |
| Everton         | 426  |
| Newcastle Utd   | 401  |
| Aston Villa     | 372  |
| West Ham        | 346  |
| Southampton     | 280  |
| Blackburn       | 262  |
| Leeds United    | 223  |
| Leicester City  | 218  |
| Fulham          | 177  |
| Middlesbrough   | 165  |
| Crystal Palace  | 156  |
| Sunderland      | 153  |
| Bolton          | 149  |
| West Brom       | 117  |
| Stoke City      | 116  |
| Wolves          | 101  |
| Sheffield Weds  | 101  |
| Coventry City   | 99   |
| Wimbledon       | 99   |
| Norwich City    | 99   |
| Charlton Ath    | 93   |
| Wigan Athletic  | 85   |
| Burnley         | 83   |
| Swansea City    | 82   |
| QPR             | 81   |
| Portsmouth      | 79   |
| Watford         | 73   |
| Birmingham City | 73   |
| Nott'ham Forest | 69   |
| Derby County    | 68   |
| Bournemouth     | 67   |
| Brighton        | 66   |
| Ipswich Town    | 57   |
| Sheffield Utd   | 53   |
| Hull City       | 41   |
| Reading         | 32   |
| Brentford       | 28   |
| Oldham Athletic | 22   |
| Cardiff City    | 17   |
| Bradford City   | 14   |
| Huddersfield    | 12   |
| Blackpool       | 10   |
| Barnsley        | 10   |
| Swindon Town    | 5    |
</details>
<br>

Losses
```sql
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
```
<details>
<summary>Result</summary>

| Team            | Losses |
|-----------------|--------|
| Everton         | 432    |
| West Ham        | 428    |
| Aston Villa     | 401    |
| Southampton     | 396    |
| Newcastle Utd   | 393    |
| Tottenham       | 383    |
| Sunderland      | 296    |
| Manchester City | 284    |
| Liverpool       | 270    |
| Fulham          | 270    |
| Chelsea         | 266    |
| Leicester City  | 265    |
| Arsenal         | 255    |
| Blackburn       | 250    |
| Crystal Palace  | 243    |
| Middlesbrough   | 240    |
| West Brom       | 238    |
| Bolton          | 217    |
| Leeds United    | 208    |
| Manchester Utd  | 201    |
| Norwich City    | 188    |
| Watford         | 165    |
| Wolves          | 155    |
| Stoke City      | 155    |
| Burnley         | 145    |
| Wigan Athletic  | 143    |
| Coventry City   | 143    |
| QPR             | 132    |
| Charlton Ath    | 129    |
| Derby County    | 128    |
| Sheffield Weds  | 126    |
| Wimbledon       | 123    |
| Portsmouth      | 122    |
| Swansea City    | 118    |
| Bournemouth     | 112    |
| Birmingham City | 111    |
| Hull City       | 101    |
| Nott'ham Forest | 97     |
| Sheffield Utd   | 95     |
| Ipswich Town    | 92     |
| Brighton        | 89     |
| Reading         | 59     |
| Huddersfield    | 47     |
| Cardiff City    | 46     |
| Bradford City   | 42     |
| Oldham Athletic | 39     |
| Brentford       | 27     |
| Barnsley        | 23     |
| Swindon Town    | 22     |
| Blackpool       | 19     |
</details>
<br>

Draws
```sql
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
```

<details>
<summary>Result</summary>

| Team            | Draws |
|-----------------|-------|
| Everton         | 332   |
| Aston Villa     | 303   |
| Chelsea         | 295   |
| Liverpool       | 292   |
| Arsenal         | 290   |
| Tottenham       | 287   |
| Newcastle Utd   | 278   |
| Manchester Utd  | 263   |
| West Ham        | 260   |
| Southampton     | 248   |
| Manchester City | 215   |
| Blackburn       | 184   |
| Middlesbrough   | 169   |
| Leicester City  | 167   |
| Fulham          | 161   |
| Sunderland      | 159   |
| Leeds United    | 151   |
| Crystal Palace  | 141   |
| West Brom       | 139   |
| Bolton          | 128   |
| Coventry City   | 112   |
| Stoke City      | 109   |
| Norwich City    | 105   |
| Wimbledon       | 94    |
| Sheffield Weds  | 89    |
| Wolves          | 86    |
| Charlton Ath    | 82    |
| Birmingham City | 82    |
| Burnley         | 76    |
| Wigan Athletic  | 76    |
| Brighton        | 73    |
| Derby County    | 70    |
| Nott'ham Forest | 70    |
| Swansea City    | 66    |
| Watford         | 66    |
| Portsmouth      | 65    |
| QPR             | 65    |
| Ipswich Town    | 53    |
| Sheffield Utd   | 50    |
| Bournemouth     | 49    |
| Hull City       | 48    |
| Oldham Athletic | 23    |
| Reading         | 23    |
| Brentford       | 21    |
| Bradford City   | 20    |
| Huddersfield    | 17    |
| Swindon Town    | 15    |
| Cardiff City    | 13    |
| Blackpool       | 9     |
| Barnsley        | 5     |
</details>
<br>

## Home vs. Away Performance

### Is there a home advantage?
```sql
SELECT 
    ROUND(CAST(COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Home Winning %',
    ROUND(CAST(COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Away Winning %'
FROM Matches
```
<details>
<summary>Result</summary>

| Home Winning % | Away Winning % |
|----------------|----------------|
| 45.89          | 28.36          |
</details>
<br>

There seems indeed to be a Home advantage as per the result of the query above  

Winning % for *home* games: **45.89%**  
Winning % for *away* games: **28.36%**


### What is the average number of goals scored at home vs. away?
```sql
SELECT 
    Round(AVG(HomeGoals), 2) AS 'Average Home Goals',
    Round(AVG(AwayGoals), 2) AS 'Average Away Goals'
FROM Matches
```
<details>
<summary>Result</summary>

| Average Home Goals | Average Away Goals |
|--------------------|--------------------|
| 1.52               | 1.14               |
</details>
<br> 

### What are the best performing Home and Away teams?

Home
```sql
SELECT TOP 1 Home AS Team, ROUND(CAST(COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Home Winning %'
FROM Matches
GROUP BY Home
ORDER BY 'Home Winning %' DESC
```
<details>
<summary>Result</summary>

| Team           | Home Winning % |
|----------------|----------------|
| Manchester Utd | 70.08          |
</details>
<br>

Away
```sql
SELECT TOP 1 Away AS Team, ROUND(CAST(COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Away Winning %'
FROM Matches
GROUP BY Away
ORDER BY 'Away Winning %' DESC
```

<details>
<summary>Result</summary>

| Team           | Away Winning % |
|----------------|----------------|
| Manchester Utd | 51.93          |
</details>
<br>

## Match Results Analysis

### What percentage of matches ended in home wins, away wins, or draws?
```sql
SELECT 
    ROUND(CAST(COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Home Winning %',
    ROUND(CAST(COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Away Winning %',
    ROUND(CAST(COUNT(CASE WHEN FTR = 'D' THEN 1 END) AS FLOAT)/COUNT(FTR)*100, 2) AS 'Draws %'
FROM Matches
```
<details>
<summary>Result</summary>

| Home Winning % | Away Winning % | Draws % |
|----------------|----------------|---------|
| 45.89          | 28.36          | 25.75   |
</details>
<br>

### Is there a correlation between home goals scored and the match result (Home Win/Draw/Away Win)?
```sql
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
```

<details>
<summary>Result</summary>

| Match Result | Average Home Goals |
|--------------|--------------------|
| Away Win     | 0.5709677419354838 |
| Draw         | 0.9731998708427511 |
| Home Win     | 2.422721507519478  |
</details>
<br>

As expected there is a positive correlation between a home win and goals scored. Home wins on average have more goals than Away wins and Draws.

## Seasonal Trends and Comparison

### How are the different match results (Home Wins, Draws, Away Wins) distributed across different seasons?
```sql
SELECT 
    Season_End_Year AS Season, 
    COUNT(CASE WHEN FTR = 'H' THEN 1 END) AS 'Home Wins', 
    COUNT(CASE WHEN FTR = 'A' THEN 1 END) AS 'Away Wins', 
    COUNT(CASE WHEN FTR = 'D' THEN 1 END) AS 'Draws Wins'
FROM Matches
GROUP BY Season_End_Year
ORDER BY Season_End_Year DESC
```

<details>
<summary>Result</summary>

| Season | Home Wins | Away Wins | Draws Wins |
|--------|-----------|-----------|------------|
| 2023   | 184       | 109       | 87         |
| 2022   | 163       | 129       | 88         |
| 2021   | 144       | 153       | 83         |
| 2020   | 172       | 116       | 92         |
| 2019   | 181       | 128       | 71         |
| 2018   | 173       | 108       | 99         |
| 2017   | 187       | 109       | 84         |
| 2016   | 157       | 116       | 107        |
| 2015   | 172       | 115       | 93         |
| 2014   | 179       | 123       | 78         |
| 2013   | 166       | 106       | 108        |
| 2012   | 171       | 116       | 93         |
| 2011   | 179       | 90        | 111        |
| 2010   | 193       | 91        | 96         |
| 2009   | 173       | 110       | 97         |
| 2008   | 176       | 104       | 100        |
| 2007   | 182       | 100       | 98         |
| 2006   | 192       | 111       | 77         |
| 2005   | 173       | 97        | 110        |
| 2004   | 167       | 105       | 108        |
| 2003   | 187       | 103       | 90         |
| 2002   | 165       | 114       | 101        |
| 2001   | 184       | 95        | 101        |
| 2000   | 187       | 101       | 92         |
| 1999   | 169       | 96        | 115        |
| 1998   | 184       | 101       | 95         |
| 1997   | 162       | 99        | 119        |
| 1996   | 186       | 96        | 98         |
| 1995   | 205       | 123       | 134        |
| 1994   | 192       | 128       | 142        |
| 1993   | 214       | 118       | 130        |
</details>
<br>

### How does the number of goals scored change across seasons?
```sql
SELECT 
    Season_End_Year AS Season, 
    SUM(CASE WHEN FTR = 'H' THEN HomeGoals END) AS 'Home Win Goals', 
    SUM(CASE WHEN FTR = 'A' THEN HomeGoals END) AS 'Away Win Goals', 
    SUM(CASE WHEN FTR = 'D' THEN HomeGoals END) AS 'Draw Goals' 
FROM Matches
GROUP BY Season_End_Year
ORDER BY Season_End_Year DESC
```
<details>
<summary>Result</summary>

| Season | Home Win Goals | Away Win Goals | Draw Goals |
|--------|----------------|----------------|------------|
| 2023   | 464            | 60             | 97         |
| 2022   | 407            | 74             | 94         |
| 2021   | 353            | 89             | 72         |
| 2020   | 418            | 63             | 95         |
| 2019   | 459            | 69             | 68         |
| 2018   | 427            | 63             | 92         |
| 2017   | 467            | 62             | 78         |
| 2016   | 380            | 73             | 114        |
| 2015   | 406            | 64             | 90         |
| 2014   | 445            | 73             | 80         |
| 2013   | 401            | 79             | 112        |
| 2012   | 432            | 76             | 96         |
| 2011   | 428            | 61             | 128        |
| 2010   | 506            | 46             | 93         |
| 2009   | 393            | 58             | 81         |
| 2008   | 435            | 42             | 104        |
| 2007   | 423            | 42             | 87         |
| 2006   | 435            | 60             | 60         |
| 2005   | 406            | 53             | 111        |
| 2004   | 415            | 58             | 99         |
| 2003   | 417            | 58             | 95         |
| 2002   | 398            | 70             | 89         |
| 2001   | 439            | 44             | 104        |
| 2000   | 473            | 58             | 104        |
| 1999   | 398            | 61             | 94         |
| 1998   | 446            | 56             | 90         |
| 1997   | 403            | 45             | 111        |
| 1996   | 422            | 65             | 93         |
| 1995   | 500            | 81             | 116        |
| 1994   | 449            | 72             | 142        |
| 1993   | 526            | 72             | 125        |
</details>
<br>

### Which season had the highest number of total goals scored?
```sql
SELECT TOP 1 Season_End_Year AS Season, SUM(HomeGoals+AwayGoals) AS Goals
FROM Matches
GROUP BY Season_End_Year
ORDER BY Goals DESC
```
<details>
<summary>Result</summary>

| Season | Goals |
|--------|-------|
| 1993   | 1222  |
</details>
<br>

## Matchweek Analysis

### Are there particular match weeks where more goals are typically scored?
```sql
SELECT TOP 5 Wk AS Week, SUM(HomeGoals+AwayGoals) AS Goals
FROM Matches
GROUP BY Wk
ORDER BY Goals DESC
```

<details>
<summary>Result</summary>

| Week | Goals |
|------|-------|
| 38   | 948   |
| 8    | 893   |
| 32   | 890   |
| 31   | 872   |
| 11   | 862   |
</details>
<br>

The last week (week 38) is historically the week with most goals each season.

### Are there particular match weeks with more Draws?
```sql
SELECT TOP 5 Wk AS Week, COUNT(CASE WHEN FTR = 'D' THEN 1 END) AS Draws
FROM Matches
GROUP BY Wk
ORDER BY Draws DESC
```

<details>
<summary>Result</summary>

| Week | Draws |
|------|-------|
| 23   | 104   |
| 3    | 99    |
| 13   | 98    |
| 21   | 89    |
| 12   | 88    |
</details>

Week 23, right around the middle of the season, exhibits the highest amount of Draws historically.

## Specific Match Analysis

### What was the highest-scoring match in terms of total goals?
```sql
SELECT TOP 1
    Season_End_Year AS Season,
    Wk AS Week,
    Date,
    Home,
    HomeGoals AS Goals,
    Away,
    AwayGoals AS Goals
FROM Matches
ORDER BY HomeGoals+AwayGoals DESC
```

<details>
<summary>Result</summary>

| Season | Week | Date       | Home       | Goals | Away    | Goals |
|--------|------|------------|------------|-------|---------|-------|
| 2008   | 8    | 2007-09-29 | Portsmouth | 7     | Reading | 4     |
</details>
<br>

### What was the match with the highest score difference?
```sql
SELECT TOP 1
    Season_End_Year AS Season,
    Wk AS Week,
    Date,
    Home,
    HomeGoals AS Goals,
    Away,
    AwayGoals AS Goals
FROM Matches
ORDER BY ABS(HomeGoals-AwayGoals) DESC
```

<details>
<summary>Result</summary>

| Season | Week | Date       | Home           | Goals | Away         | Goals |
|--------|------|------------|----------------|-------|--------------|-------|
| 1995   | 32   | 1995-03-04 | Manchester Utd | 9     | Ipswich Town | 0     |
</details>
