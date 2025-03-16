select v.maker, m.model  
from motorcycle m 
join vehicle v
	on m.model = v.model 
where m.horsepower > 150
	and m.price < 20000
	and m."type" = 'Sport'