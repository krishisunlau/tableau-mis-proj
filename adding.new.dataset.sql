
-- merging data_salaries with homeinsurance and zipfips on zipcode
DROP TABLE if EXISTS okk;
CREATE TABLE okk AS
SELECT
    HOME_INSURANCE.zip_code,
	data_salaries.city,
	data_salaries.state,
    data_salaries.salary,
	ZIP_FIPS.fips
FROM
    HOME_INSURANCE
 INNER JOIN
    data_salaries ON HOME_INSURANCE.zip_code = data_salaries.zip_code
JOIN
    ZIP_FIPS on data_salaries.state=ZIP_FIPS.state

--adding misery rate
CREATE TABLE CombinedData AS
SELECT
    misery.rate,
    okk.*
FROM
    misery
JOIN
    okk ON okk.state = misery.state;

--merging with 
DROP TABLE if EXISTS final;
CREATE TABLE final AS
SELECT
    CombinedData.*,
    dw_county.*
FROM
    CombinedData 
JOIN
    dw_county  ON dw_county.fips = CombinedData.fips;


-- make sure its only third quarter of 2023
create table final_1 AS
select * 
FROM final
where date in ('2023-07-31', '2023-08-31', '2023-09-30');
 
