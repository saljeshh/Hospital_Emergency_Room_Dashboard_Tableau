-- area chart 
WITH age_group AS 
(
select 
	patient_age,
	patient_id,
	CASE 
		WHEN patient_age >=0 AND patient_age <=18 THEN '0-18'
		WHEN patient_age >=19 AND patient_age <= 65 THEN '18-65'
		WHEN patient_age >= 66 THEN '66+'
	END as age_group,
	date

FROM hospital_emergencey
)

select 	
	MONTH(date) as month, 
	YEAR(date) as year,
	age_group,
	count(patient_id) as patient
FROM age_group
GROUP BY MONTH(date), YEAR(date), age_group
order by 1,2 desc




-- Patient per race 
select patient_race,
	count(patient_id) as cnt
from hospital_emergencey
group by patient_race
order by cnt desc



-- patient per department 
select department_referral,
	count(patient_id) as cnt 
from hospital_emergencey
group by department_referral
having department_referral <> 'None'
order by cnt desc


-- percent total gender
WITH total_patient AS
(
	select count(*) as total_patient 
	from hospital_emergencey
),
gender_patient_grp as 
(
	select patient_gender,
		count(*) as gender_count 
	from hospital_emergencey
	group by patient_gender
)

SELECT 
	gp.patient_gender,
	gp.gender_count,
	tp.total_patient,
	ROUND((CAST(gp.gender_count AS float) / tp.total_patient) * 100,2) as percentage_total
FROM total_patient as tp
CROSS JOIN gender_patient_grp as gp



-- avg waiting time 
select
MONTH(date) as month,
YEAR(date) as year,
round(AVG(cast(patient_waittime as float)),2) as avg_time
from hospital_emergencey
group by MONTH(date), YEAR(date)
order by 1,2 desc


select
MONTH(date) as month,
YEAR(date) as year,
round(AVG(cast(patient_sat_score as float)),2) as avg_time
from hospital_emergencey
group by MONTH(date), YEAR(date)
order by 1,2 desc
