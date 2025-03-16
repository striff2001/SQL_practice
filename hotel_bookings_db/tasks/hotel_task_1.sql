select
	c."name" 
	, c.email 
	, c.phone
	, count(id_booking) as total_bookings
	, string_agg(distinct h."name", ', ') as hotels
	, avg(b.check_out_date - b.check_in_date) as average_period
from booking b 
join room r 
	on b.id_room = r.id_room 
join hotel h 
	on h.id_hotel = r.id_hotel 
join customer c 
	on c.id_customer = b.id_customer
group by 1,2,3 
having count(id_booking) > 2 and count(distinct h.id_hotel) > 1
order by total_bookings desc