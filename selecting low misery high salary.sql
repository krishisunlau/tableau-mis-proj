WITH StateMiseryAvg AS (
    SELECT state, AVG(rate) AS avg_misery_rate
    FROM final_1
    GROUP BY state
    ORDER BY rate ASC
    LIMIT 10
)
SELECT DISTINCT city, state, rate, salary
FROM final_1
WHERE state IN (SELECT state FROM StateMiseryAvg)
ORDER BY salary DESC
LIMIT 10;
