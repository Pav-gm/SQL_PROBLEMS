## Employee Salary Analysis

**Table Definition**

| Column Name | Type | Description                                       |
|-------------|------|---------------------------------------------------|
| id          | int  | Unique identifier for each employee               |
| month       | int  | Month number (1-12)                               |
| salary      | int  | Employee's salary amount for the specified month  |

**(id, month) is the primary key for this table.**

**Problem Statement**

Calculate the cumulative salary summary for each employee in a unified table, excluding the most recent month of data.  

**Calculation Rules**

* For each month an employee worked, calculate the 3-month sum (current month + previous two months).
* If an employee did not work in previous months, treat their salary as 0 for those months.
* Exclude the 3-month sum for the employee's most recent month.
* Exclude any 3-month sum for a month the employee did not work.
* Order the results by employee ID (ascending), and then by month (descending) for ties.

**Example 1**

**Input:**

+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 1 | 1   | 20   |
| 2 | 1   | 20   |
| 1 | 2   | 30   |
| 2 | 2   | 30   |
| 3 | 2   | 40   |
| 1 | 3   | 40   |
| 3 | 3   | 60   |
| 1 | 4   | 60   |
| 3 | 4   | 70   |
| 1 | 7   | 90   |
| 1 | 8   | 90   |
+----+-------+--------+

**Output:**

+----+-------+--------+
| id | month | Salary |
+----+-------+--------+
| 1 | 7   | 90   |
| 1 | 4   | 130  |
| 1 | 3   | 90   |
| 1 | 2   | 50   |
| 1 | 1   | 20   |
| 2 | 1   | 20   |
| 3 | 3   | 100  |
| 3 | 2   | 40   |
+----+-------+--------+

**Explanation**

* **Employee 1:**  Excluding their most recent month (8), their salary records and calculations are as follows:
    * Month 7: 90 (90 + 0 + 0)
    * Month 4: 130 (60 + 40 + 30)
    * Month 3: 90 (40 + 30 + 20)
    * Month 2: 50 (30 + 20 + 0)
    * Month 1: 20 (20 + 0 + 0)
* **Employee 2:** Only has one relevant salary record (month 1). 
* **Employee 3:** Has two relevant salary records.

**Let me know if you'd like an SQL solution to generate this cumulative salary summary!** 
