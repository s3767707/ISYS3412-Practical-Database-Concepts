/*Task D.1*/
select 
v2.date as 'Observation Date 1 (OD1)', 
v2.c_name as 'Country Name (CN)',
v2.total_vaccinations as 'Administered Vaccine on OD1 (VOD1)',
v1.date as 'Observation Date 2 (OD2)', 
v1.total_vaccinations as 'Administered Vaccine on OD2 (VOD2)',
v1.total_vaccinations - v2.total_vaccinations as 'Difference of totals (VOD2-VOD1)'
from 
(select * from vaccination v1 where date = 
(select v2.date from vaccination v2 
where v2.c_name = v1.c_name and v2.date <= '2022-05-31' and v2.total_vaccinations != '' order by v2.date desc limit 1))
v1 join
(select * from vaccination v3 where date = 
(select v4.date from vaccination v4 
where v4.c_name = v3.c_name and v4.date <= '2022-04-30' and v4.total_vaccinations != '' order by v4.date desc limit 1))
v2 on v1.c_name = v2.c_name;

/*Task D.2*/
select v1.c_name as 'Country',
v1.total_vaccinations as 'Cumulative Doses' 
from vaccination v1 
where v1.date = (select max(date) from vaccination v2 where v2.c_name = v1.c_name and v2.total_vaccinations != '')
and v1.total_vaccinations > (select avg(v3.total_vaccinations) from vaccination v3 
where v3.date = (select max(date) from vaccination v4 where v4.c_name = v3.c_name and v4.total_vaccinations != ''));

/*Task D.3*/
select c_name as 'Country',
v_name as 'Vaccine Type'
from country_vaccine 
where c_name 
in (select c_name from country_vaccine 
group by c_name 
order by count(*) 
desc limit 10);

/*Task D.4*/
select c1.source_name as 'Source Name',
v1.total_vaccinations as 'Total Administered Vaccines',
c1.source_url as 'Source URL' 
from vaccination v1 join country c1 on v1.c_name = c1.c_name 
where v1.date = (select max(date) from vaccination v2 
where v2.c_name = v1.c_name and v2.total_vaccinations != '')
order by c1.source_name, c1.source_url;

/*Task D.5*/
select d.date as 'Date', 
v1.people_fully_vaccinated as 'Australia',
v2.people_fully_vaccinated as 'China',
v3.people_fully_vaccinated as 'England',
v4.people_fully_vaccinated as 'United States'
from (((((select distinct date from country_data order by date) d left join (select * from vaccination where vaccination.C_name = 'Australia') v1 on d.date = v1.date) 
left join (select * from vaccination where vaccination.C_name = 'China') v2 on d.date = v2.date) 
left join (select * from vaccination where vaccination.C_name = 'England') v3 on d.date = v3.date) 
left join (select * from vaccination where vaccination.C_name = 'United States') v4 on d.date = v4.date) 
where d.date like '2022%';