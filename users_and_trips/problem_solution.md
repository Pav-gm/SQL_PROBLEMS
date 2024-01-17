# Common Table Expressions (CTEs)

The query uses two CTEs, `banned_trips` and `amount_trips`.

## `banned_trips` CTE
This CTE identifies trips (id) that involve banned users. It joins the `trips` and `users` tables on the condition that either the client or the driver in a trip is a user marked as banned (`users.banned = 'Yes'`). It creates a subset of trips that should be excluded from the analysis.

## `amount_trips` CTE
This CTE focuses on calculating the total number of requested trips and the number of cancelled trips for each day within a specific date range ('2013-10-01' to '2013-10-03'). It filters out the trips identified in the `banned_trips` CTE. It uses a CASE statement to count how many trips were cancelled (where `trips.status` contains the word 'cancelled').

# Filtering and Date Range
The query filters the data to only include trips between October 1, 2013, and October 3, 2013, and excludes trips linked to banned users.

# Aggregation and Grouping
The query aggregates the data by the date of the trip request (`trips.request_at`), counting total requested trips and cancelled trips for each day.

# Final Selection
The main `SELECT` statement at the end computes the daily cancellation rate. This is done by dividing the number of cancelled trips by the total number of requested trips for each day, and the result is rounded to two decimal places. The `ROUND` and `CAST` functions are used for this purpose. The cancellation rate is presented alongside the corresponding date (`request_at`), which is labeled as "Day" in the output.
