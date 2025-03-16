select
	v.maker
	, c.model 
	, c.horsepower 
	, c.engine_capacity 
	, 'Car' as vehicle_type
from car c
join vehicle v 
	on c.model = v.model 
where horsepower > 150
	and engine_capacity < 3
	and price < 35000	
union all
select
	v.maker
	, m.model 
	, m.horsepower 
	, m.engine_capacity 
	, 'Motorcycle' as vehicle_type
from motorcycle m 
join vehicle v 
	on m.model = v.model 
where m.horsepower > 150
	and m.engine_capacity < 1.5
	and m.price < 20000	
union all
select
	v.maker 
	, b.model 
	, null as horsepower
	, null as engine_capacity
	, 'Bicycle' as vehicle_type
from bicycle b 
join vehicle v 
	on v.model = b.model 
where b.gear_count > 18
	and b.price < 4000	
order by horsepower desc nulls last;