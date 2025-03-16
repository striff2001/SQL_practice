select car_name
	, car_class
	, min_avg_car_pos as average_position
	, race_count
	, country as car_country
from (
	select *
		, avg(position) over (partition by c.car_class) as min_avg_class_pos
		, avg(position) over (partition by c.car_name) as min_avg_car_pos
		, count(race) over (partition by c.car_name) as race_count
	from classes cl
	join (
		select name as car_name, class as car_class
			, count(name) over (partition by class) as cnt
		from cars
		) c
		on cl."class" = c.car_class
		and c.cnt > 1
	join results r 
	 	on c.car_name = r.car 
) t
where min_avg_car_pos < min_avg_class_pos