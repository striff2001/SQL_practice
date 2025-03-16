select *
from (
	select
		c.name as car_name
		, cl.class as car_class
		, avg(position) over (partition by r.car) as average_position
		, count(race) over (partition by r.car) as race_count
		, cl.country as car_country
		, count(race) over (partition by c.class) as low_position_count
	from results r 
	join cars c 
		on r.car = c."name" 
	join classes cl
		on cl."class" = c."class" 
) t
where average_position > 3
order by low_position_count desc, car_class