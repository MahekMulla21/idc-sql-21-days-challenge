use hospital_services;


with service_totals as (
select
service,
sum(patients_admitted) as total_patients_admitted
from services_weekly
group by service
),
overall_avg as(
select avg(total_patients_admitted) as avg_admission
from service_totals
)
select
	st.service,
	st.total_patients_admitted,
	round(st.total_patients_admitted- OA.avg_admission,2) as diff_from_avg,
	case
when st.total_patients_admitted>OA.avg_admission then "Above Average"
when st.total_patients_admitted = OA.avg_admission then "Average"
else "Below Average"
end as rank_indicator
from service_totals as st
cross join overall_avg as OA
order by st.total_patients_admitted desc;