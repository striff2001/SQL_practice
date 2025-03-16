with hotel_types as (
	select 
		id_hotel
		, case
			when avg_price < 175 then 'Дешевый'
			when avg_price > 300 then 'Дорогой'
			else 'Средний'
		end as hotel_type
	from (
	select id_hotel, avg(price) as avg_price
	from room r 
	group by id_hotel) t
),
client_preference as (
	select
		id_customer
		, case 
			when expensive_hotels_count > 0 then 'дорогой'
			when medium_hotels_count > 0 then 'средний'
			when cheap_hotels_count > 0 then 'дешевый'
		end as preferred_hotel_type 
		, visited_hotels
	from (
	select
		b.id_customer
		, count(distinct case when ht.hotel_type = 'Дорогой' then ht.id_hotel end) as expensive_hotels_count
		, count(distinct case when ht.hotel_type = 'Средний' then ht.id_hotel end) as medium_hotels_count
		, count(distinct case when ht.hotel_type = 'Дешевый' then ht.id_hotel end) as cheap_hotels_count
		, string_agg(distinct h.name, ',') as visited_hotels 
	from booking b
	join room r 
		on b.id_room = r.id_room
	join hotel_types ht
		on ht.id_hotel = r.id_hotel
	join hotel h
		on h.id_hotel = r.id_hotel
	group by 1) t
)
select 
	cp.id_customer
	, c."name" 
	, cp.preferred_hotel_type
	, cp.visited_hotels
from client_preference cp
join customer c
	on c.id_customer = cp.id_customer
order by array_position(array['дешевый', 'средний', 'дорогой'], cp.preferred_hotel_type), id_customer