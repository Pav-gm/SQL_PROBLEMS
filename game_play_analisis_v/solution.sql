/* Write your T-SQL query statement below */
WITH retentions AS(
SELECT
    activity.player_id
    ,MIN(activity.event_date) first_login
FROM
    activity 
GROUP BY
    activity.player_id 
)
,calc_retention AS(

SELECT 
    retentions.first_login install_dt
    ,count(retentions.player_id) installs
    ,SUM(CASE WHEN activity.event_date IS NOT NULL THEN 1 ELSE 0 END) logged_back
FROM
    retentions
LEFT JOIN
    activity
ON
    retentions.player_id = activity.player_id
AND 
    retentions.first_login = DATEADD(DAY,-1,activity.event_date)
GROUP BY 
    retentions.first_login
)

SELECT 
    install_dt
    ,installs
    ,ROUND(CAST(logged_back AS FLOAT) / CAST(NULLIF(installs,0) AS FLOAT),2) Day1_retention
FROM
    calc_retention