
1) SELECT / WHERE / AND / OR / IN / DISTINCT / ORDER BY / LIMIT

All the films longer than 90mins.
    select title, year_of_release,runtime
  from movies
  where runtime >= 90
  order by runtime DESC;

All the films between 2000 and 2010 released or Genre is Comdey, Limit it to 15 rows
  Select * 
  from movies
  where year_of_release between 2000 and 2010 or genre = 'Comedy'
  order by year_of_release 
  LIMIT 15;


2) COUNT / AVG / MAX / MIN / GROUP BY
  
Films in every Category separately.
  select genre, count(*) as Film_pcs
  from movies
  group by genre
  order by genre;

Average runtime in every Genre
  select genre, ROUND(avg(runtime),2) as AVG_Runtime_min 
  from movies
  group by genre
  order by genre
  limit 10;

Difference between the longest and shortest film in min
  Select max(runtime) - min(runtime) as Range_in_min
  from movies;


3) JOINS + ALIAS
List the Customer name, Film title, Renting date and Film rateng by the user
  select c.name, m.title, r.date_renting, r.rating
  from customers as c 
  left join renting as r
  using(customer_id)
  left join movies as m
  on m.movie_id = r.movie_id
  where r.rating is not null
  order by r.rating desc
  limit 10;

Renting number by each country
  select Distinct c.country, count(r.renting_id) as Renting_num
  from customers as c
  left join renting as r
  using(customer_id)
  group by c.country
  order by Renting_num desc;

4) CASE STATEMENT

Categorize the films based on runtime: Short (< 90 perc) Medium (90–120)Long (>120)
select title,
case 
	when runtime < 90 then 'Short'
	when runtime between 91 and 120 then 'Medium'
	else 'Long' end as Long_Category
from movies
group by title, runtime

6) SUBQUERIES

Renting prices are higher than the average
    select title
    from movies
    where renting_price > (
	    select avg(renting_price)
	    from movies
	    );

7) WINDOW FUNCTIONS

Ranking the films based on the Genre
select title, genre,
RANK() over(partition by genre order by title) as rank
from movies

Average rating in each year for each category
select 
	m.genre,
	m.year_of_release,
	AVG(r.rating) over(partition by m.genre)
from movies as m
full join renting as r
using (movie_id)
where rating is not null
group by m.genre, m.year_of_release, r.rating;


8) CTE

Listing all tha Actor's name, nationality who played in a film longer than 120min. Using: CTE, Left and Cross join
	
	with avg_run as (
	select avg(runtime) as avg_time
	from movies
)

select a.name, a.nationality
from actors as a
left join actsin as b
using(actor_id)
left join movies as m
using(movie_id)
cross join avg_run as r
where m.runtime > r.avg_time
group by a.name, a.nationality
order by a.name

	
9) TEMP TABLE
	
CREATE TEMP TABLE temp_movies AS
select m.title, m.genre, Count(r.date_renting) as renting_number
from movies as m
left join renting as r
using(movie_id)
group by m.title,m.genre
order by renting_number desc
limit 10;

select * from temp_movies

