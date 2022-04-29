
# Analyze maven movies using sql queries



## Case Study:
The Maven Movies' company insurance policy is up for renewal and the insurance providing company’s underwriters need some updated information from it before they will issue a new insurance policy.

## Objective:
Leveraging SQL skills to extract and analyze data from various tables in the Maven Movies database for the purpose of answering the insurance underwriters’ questions. Each question can be answered by querying just one table. Part of the analysis task is figuring out which table to be used.

## The project workflow follows the below key questions the insurance underwriters need to be answered:

1. We will need a list of all staff members, including their first and last names, email addresses, and the store identification number where they work.
```sql
   Select   store_id,
	count(inventory_id) as items 
	from inventory 
	group by store_id;
  ```
2. We will need separate counts of inventory items held at each of your two stores.
```sql
Select  store_id,
      	count(customer_id) as ActiveCutomer
  	from customer
		WHERE active = 1
	group by store_id;
```
3. We will need a count of active customers for each of your stores. Separately, please.
```sql
select first_name,
	last_name,
        email,
        store_id
	from staff;
```
4. In order to assess the liability of a data breach, we will need you to provide a count of all customer email addresses stored in the database.
```sql
select count(email)
	from customer
    where email is not null;
```
5. We are interested in how diverse your film offering is as a means of understanding how likely you are to keep customers engaged in the future. Please provide a count of unique film titles you have in inventory at each store and then provide a count of the unique categories of films you provide.
```sql
select  s.store_id,
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
```
6. We would like to understand the replacement cost of your films. Please provide the replacement cost for the film that is least expensive to replace, the most expensive to replace, and the average of all films you carry.
```sql
select      inv.inventory_id,
	    inv.store_id,
            f.title,
            f.rating,
            f.rental_rate,
	    f.replacement_cost
		from inventory as inv
	inner join film  as f
		on f.film_id = inv.film_id;
```
7. We are interested in having you put payment monitoring systems and maximum payment processing restrictions in place in order to minimize the future risk of fraud by your staff. Please provide the average payment you process, as well as the maximum payment you have processed.
```sql
select  inv.store_id,
        f.rating,
        count(inv.inventory_id) as 'inventory item'
	from inventory as inv
	left join film as f
		on f.film_id = inv.film_id
	group by 
		inv.store_id ,
		f.rating;
```
8. We would like to better understand what your customer base looks like. Please provide a list of all customer identification values, with a count of rentals they have made all-time, with your highest volume customers at the top of the list.
```sql
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
```
## Running the project:
1- MySQL Workbench or similar is needed. 

2- Use the "create_mavenmovies.sql" database file to read data to the project script.
