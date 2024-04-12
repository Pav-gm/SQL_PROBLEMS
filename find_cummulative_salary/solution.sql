WITH not_recents AS (
SELECT
    employee.id
    ,MAX(employee.month) month
FROM    
    employee
GROUP BY
    employee.id
)
,all_months AS (
SELECT
    1 as month

UNION ALL

SELECT 
    month + 1 as month
FROM 
    all_months
WHERE 
    month < 12
)
,salary_all_months AS(
SELECT
    all_months.month
    ,emp.id
FROM 
    all_months
CROSS JOIN 
    (
        SELECT DISTINCT
            employee.id
        FROM 
            employee
    ) emp
)
,emp_all_months AS (
SELECT 
    salary_all_months.id
    ,salary_all_months.month
    ,SUM(employee.salary) OVER(PARTITION BY salary_all_months.id ORDER BY salary_all_months.month ROWS BETWEEN 
        2 PRECEDING AND CURRENT ROW) months
FROM 
    salary_all_months
LEFT JOIN 
    employee
ON 
    salary_all_months.id = employee.id
AND 
    salary_all_months.month = employee.month
GROUP BY 
    salary_all_months.id
    ,salary_all_months.month
    ,employee.salary)

SELECT 
    emp_all_months.id
    ,emp_all_months.month
    ,months Salary
FROM 
    emp_all_months
INNER JOIN 
    employee
ON 
    emp_all_months.id = employee.id
AND 
    emp_all_months.month = employee.month
INNER JOIN 
    not_recents
ON      
    emp_all_months.id = not_recents.id
AND 
    emp_all_months.month <> not_recents.month  

ORDER BY    
    emp_all_months.id
    ,emp_all_months.month DESC