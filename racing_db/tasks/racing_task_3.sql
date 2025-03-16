select
	c."name" as car_name
	, c."class" as car_class
	, avg(position) as average_position
	, count(race) as race_count
	, cl.country 
	, count(race) as total_races
from results r 
join cars c
	on r.car =c."name" 
join classes cl
	on cl."class" = c."class" 
group by 1, 2, 5
having avg(position) = (select min(avg_pos) 
						from (select avg(position) as avg_pos 
								from results r2 group by r2.*)
							) 