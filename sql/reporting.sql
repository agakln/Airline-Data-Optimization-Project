
CREATE OR REPLACE VIEW reporting.flight AS
SELECT 
    f.*, 
    CASE 
        WHEN f."DEP_DELAY_NEW" > 0 THEN 1
        ELSE 0
    END AS is_delayed
FROM flight f
LEFT JOIN aircraft a ON f."TAIL_NUM" = a."TAIL_NUM"
LEFT JOIN airport_list al ON f."ORIGIN_AIRPORT_ID" = al."ORIGIN_AIRPORT_ID"
LEFT JOIN airport_list al_dest ON f."DEST_AIRPORT_ID" = al_dest."ORIGIN_AIRPORT_ID"
WHERE f."CANCELLED" = 0;


CREATE OR REPLACE VIEW reporting.top_reliability_roads AS
WITH flight_stats AS (
    SELECT 
        f."ORIGIN_AIRPORT_ID",
        al."DISPLAY_AIRPORT_NAME" AS "ORIGIN_AIRPORT_NAME",
        f."DEST_AIRPORT_ID",
        al_dest."DISPLAY_AIRPORT_NAME" AS "DEST_AIRPORT_NAME",
        f."YEAR",
        COUNT(*) AS "CNT",
        AVG(CASE WHEN f."DEP_DELAY_NEW" > 0 THEN 1 ELSE 0 END) AS "reliability"
    FROM flight f
    LEFT JOIN airport_list al ON f."ORIGIN_AIRPORT_ID" = al."ORIGIN_AIRPORT_ID"
    LEFT JOIN airport_list al_dest ON f."DEST_AIRPORT_ID" = al_dest."ORIGIN_AIRPORT_ID"
    WHERE f."CANCELLED" = 0
    GROUP BY f."ORIGIN_AIRPORT_ID", al."DISPLAY_AIRPORT_NAME", f."DEST_AIRPORT_ID", al_dest."DISPLAY_AIRPORT_NAME", f."YEAR"
    HAVING COUNT(*) > 10000
),
ranked_flights AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY "YEAR" ORDER BY "reliability" ASC) AS "nb"
    FROM flight_stats
)
SELECT *
FROM ranked_flights;


CREATE OR REPLACE VIEW reporting.year_to_year_comparision AS
SELECT 
    f."YEAR" AS "year",
    f."MONTH" AS "month",
    COUNT(*) AS "flights_amount",
    AVG(CASE WHEN f."DEP_DELAY_NEW" > 0 THEN 1 ELSE 0 END) AS "reliability"
FROM flight f
LEFT JOIN airport_list al ON f."ORIGIN_AIRPORT_ID" = al."ORIGIN_AIRPORT_ID"
GROUP BY f."YEAR", f."MONTH";


CREATE OR REPLACE VIEW reporting.day_to_day_comparision AS
SELECT 
    f."YEAR" AS "year",
    f."DAY_OF_WEEK" AS "day_of_week",
    COUNT(*) AS "flights_amount"
FROM flight f
LEFT JOIN airport_list al ON f."ORIGIN_AIRPORT_ID" = al."ORIGIN_AIRPORT_ID"
GROUP BY f."YEAR", f."DAY_OF_WEEK";


CREATE OR REPLACE VIEW reporting.day_by_day_reliability AS
SELECT 
    TO_DATE(
        LPAD(CAST(f."YEAR" AS TEXT), 4, '0') || '-' ||
        LPAD(CAST(f."MONTH" AS TEXT), 2, '0') || '-' ||
        LPAD(CAST(f."DAY_OF_MONTH" AS TEXT), 2, '0'),
        'YYYY-MM-DD'
    ) AS "date",
    AVG(CASE WHEN f."DEP_DELAY_NEW" > 0 THEN 1 ELSE 0 END) AS "reliability"
FROM flight f
LEFT JOIN airport_list al ON f."ORIGIN_AIRPORT_ID" = al."ORIGIN_AIRPORT_ID"
GROUP BY "date";
