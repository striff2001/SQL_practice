select
	b.id_customer 
	, c."name" 
	, count(id_booking) as total_bookings
	, sum(r.price * (b.check_out_date - b.check_in_date)) as total_spent
	, count(distinct r.id_hotel) as unique_hotels
from booking b 
join room r 
	on b.id_room = r.id_room 
join hotel h 
	on h.id_hotel = r.id_hotel 
join customer c 
	on c.id_customer = b.id_customer
group by 1,2
having count(id_booking) > 2 and count(distinct h.id_hotel) > 1
union
select
	b.id_customer 
	, c."name" 
	, count(id_booking) as total_bookings
	, sum(r.price * (b.check_out_date - b.check_in_date)) as total_spent
	, count(distinct r.id_hotel) as unique_hotels
from booking b 
join room r 
	on b.id_room = r.id_room 
join hotel h 
	on h.id_hotel = r.id_hotel 
join customer c 
	on c.id_customer = b.id_customer
group by 1,2
having sum(r.price * (b.check_out_date - b.check_in_date)) > 500
order by total_spent