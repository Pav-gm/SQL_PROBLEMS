/* Write your T-SQL query statement below */
WITH banned_trips as (
SELECT 
    id banned_trip_id
    ,request_at
FROM 
    trips
INNER JOIN 
    users
ON 
    trips.client_id = users.users_id
OR
    trips.driver_id = users.users_id
WHERE
    CASE WHEN users.banned = 'Yes' THEN 'Banned' ELSE 'Not Banned' END = 'Banned'
)
,amount_trips AS (
SELECT
    COUNT(*) as requested_trips
    ,SUM(CASE WHEN trips.status LIKE '%cancelled%' THEN 1 ELSE 0 END) AS cancelled_trips
    ,trips.request_at
FROM
    trips
LEFT JOIN
    banned_trips
ON
    trips.id = banned_trips.banned_trip_id
WHERE 
    1=1
AND
    trips.request_at BETWEEN '2013-10-01' AND '2013-10-03'
AND 
    banned_trip_id IS NULL
GROUP BY
    trips.request_at
)

SELECT 
    request_at "Day"
    ,ROUND(CAST(cancelled_trips as FLOAT)/
            CAST(requested_trips AS FLOAT),2) "Cancellation Rate"
FROM 
    amount_trips
