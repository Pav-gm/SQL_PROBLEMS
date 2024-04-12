# SQL Script Explanation: Rolling Salary Calculation (Excluding Latest Month)

**Purpose**

This SQL script calculates the 3-month rolling salary for employees while excluding the most recent month's salary data.

**Why Exclude the Latest Month?**

* Salary data for the most recent month may be incomplete or delayed.
* The focus may be on analyzing longer-term salary trends.

**How It Works**

1. **Identify Most Recent Months**
  * The `not_recents` subquery finds the most recent month with salary data for each employee.

2. **Generate All Months**
   * The `all_months` subquery creates a list of all months (1 to 12) by taking advantage of CTE recursion.

3. **Employee and Month Grid**
   *  The `salary_all_months` subquery combines all employees with all months.

4. **Calculate Rolling Salary**
   * The `emp_all_months` subquery calculates the rolling salary for each employee/month using a window function.

5. **Filter and Display**
   * The final query filters out the most recent month for each employee.
   * Results are ordered by employee ID and month (descending).
