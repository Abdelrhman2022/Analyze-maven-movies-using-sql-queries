-- 1- Separate count of inventory items held at each of two stores 

Select  store_id,
		count(inventory_id) as items 
	from inventory 
	group by store_id;



-- 2 Count of active customers for each of stores, separately. 

Select  store_id,
	count(customer_id) as ActiveCutomer
	from customer
		WHERE active = 1
	group by store_id;

-- 3- Make a list of all staff members, including (first/last name), email address, and store identification number where they work 

select first_name,
		last_name,
        email,
        store_id
	from staff;


-- 4- Count of all customer email address stored in database. 

select count(email)
	from customer
    where email is not null;
    
    
-- 5- Send the managers' name at each store with the full address of each property(street, district, city, and country) 

select s.store_id,
		CONCAT(s.first_name," ", s.last_name) as Name,
        a.address,
        a.district,
        c.city,
        coun.country
	from  staff as s
    left join store as st
		on s.staff_id = st.manager_staff_id 
    left join address as a
		on a.address_id = s.address_id
	left join city as c
		on a.city_id =  c.city_id
    left join country as coun
		on coun.country_id =  c.country_id;
        
-- 6- Pull a list of each inventory item you have stocked including store_id number, inventory_id, name of the film's rating, rental rate and replacement cost. 
select inv.inventory_id,
			inv.store_id,
            f.title,
            f.rating,
            f.rental_rate,
			f.replacement_cost
		from inventory as inv
	inner join film  as f
		on f.film_id = inv.film_id;

-- 7- From the list you just pulled, roll the data up and provide summary level overview of inventory. How many inventory items you have with each rating at each store 

select  inv.store_id,
        f.rating,
        count(inv.inventory_id) as 'inventory item'
	from inventory as inv
	left join film as f
		on f.film_id = inv.film_id
	group by 
		inv.store_id ,
		f.rating;
		

-- 8- Number if films and the replacement cost and total replacement cost sliced by store and film category 
	
    select 
			inventory.store_id,
			category.name as category, 
			count(film.film_id),
			 avg(film.replacement_cost) as 'Average replacement cost',
			sum(film.replacement_cost) as 'total replacement_cost'
		from  film
    left join film_category
		on film.film_id = film_category.film_id
	left join category
		on film_category.category_id = category.category_id
	left join inventory
		on inventory.film_id = film.film_id
	group by inventory.store_id,
			category.name;