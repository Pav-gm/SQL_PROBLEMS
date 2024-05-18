/* Write your T-SQL query statement below */
WITH decompressing AS (
    SELECT 
        num, 1 as freq, frequency  
    FROM 
        numbers
    
    UNION ALL

    SELECT 
        num, freq + 1, frequency  
    FROM 
        decompressing
    WHERE
        freq < frequency
        
)

SELECT
    ROUND(CAST(
            (SELECT MAX(num) FROM (SELECT TOP 50 PERCENT num FROM decompressing ORDER BY num) AS first_half)
        +
            (SELECT MIN(num) FROM (SELECT TOP 50 PERCENT num FROM decompressing ORDER BY num DESC) AS sec_half)

    AS FLOAT),1) / 2 as median