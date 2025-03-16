select t.car, c."class" , t.average_position, t.race_count, cl.country 
from (
	select 
		car
		, avg("position") as average_position
		, count(*) as race_count 
		, min(avg("position")) over() as min_avg_pos 
	from results r 
	group by 1
) t
join cars c
	on c."name" = t.car
	and t.min_avg_pos = t.average_position
join classes cl
	on cl."class" = c."class" 
order by t.car
limit 1