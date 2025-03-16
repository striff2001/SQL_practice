select car_name, car_class, average_position, race_count
from (
	select
		c.name as car_name
		, c."class" as car_class
		, res.average_position
		, res.race_count
		, min(res.average_position) over(partition by c."class") as min_pos
	from cars c 
	join (
		select 
			car
			, avg("position") as average_position
			, count(*) as race_count 
		from results r 
		group by 1
	) res
	on c."name" = res.car
) t
where min_pos = average_position
order by average_position, car_name