# Common Table Expressions (CTEs)

## `retentions` CTE
This part of the query identifies the first login date for each player. It selects the `player_id` and the minimum `event_date` (which represents the first login) from the `activity` table, grouping the results by `player_id`. This gives you a list of players along with their first login date.

## `calc_retention` CTE
This is where the retention calculation happens. It does the following:

- Joins the `retentions` CTE with the `activity` table on `player_id`. The join condition also includes a filter to match records where the `event_date` in the `activity` table is exactly one day after the `first_login` date from the `retentions` CTE. This is done using the `DATEADD(DAY, -1, activity.event_date)` function.
- Counts the total number of installs (`installs`) for each `install_dt` (first login date).
- Sums the number of players who logged back in one day after their first login (`logged_back`).
- Groups the results by the first login date (`install_dt`).

# Final SELECT
This part of the query selects the install date, the total number of installs, and calculates the Day 1 retention rate. The retention rate is calculated by dividing the number of players who logged back in one day after their first login (`logged_back`) by the total number of installs (`installs`), and the result is rounded to two decimal places.
