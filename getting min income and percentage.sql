WITH StateMiseryAvg AS (
    SELECT state, AVG(rate) AS avg_misery_rate
    FROM finallyfinal
    GROUP BY state
    ORDER BY rate ASC
    LIMIT 10
)
, CityDetails AS (
    SELECT
        city,
        state,
        avg(min_average_income) AS min_average_income,
        avg(percentage_of_income) AS percentage_of_income
    FROM finallyfinal
    WHERE date = '2022-10-31' -- using a specific date
    AND state IN (SELECT state FROM StateMiseryAvg)
    GROUP BY city, state
)
SELECT DISTINCT
    ff.city,
    ff.state,
    ff.rate,
    ff.salary,
    cd.min_average_income,
    cd.percentage_of_income
FROM finallyfinal ff
JOIN CityDetails cd ON ff.city = cd.city AND ff.state = cd.state
WHERE ff.state IN (SELECT state FROM StateMiseryAvg)
ORDER BY ff.salary DESC
LIMIT 10;
