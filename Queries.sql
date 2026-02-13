
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

	
10) BONUS: REAL-LIFE EXAMPLES
	
1, Which movie is rented the most?

select m.title, count(r.date_renting) as most_rented
from movies as m
left join renting as r
using(movie_id)
group by m.title
order by most_rented desc
LIMIT 3;

Result:
"title"	"most_rented"
"The Kingdom"	15
"Training Day"	14
"Harry Potter and the Half-Blood Prince"	13

	
2, Top 10 movies by revenue

select m.title, SUM(m.renting_price) as Rent_price,count(r.date_renting) as most_rented
from movies as m
left join renting as r
using(movie_id)
group by m.title
order by most_rented desc
LIMIT 10;

	
Result:
"title"	"rent_price"	"most_rented"
"The Kingdom"	31.35	15
"Training Day"	25.06	14
"Harry Potter and the Half-Blood Prince"	20.67	13
"Bridget Jones - The Edge of Reason"	37.57	13
"Monster"	27.17	13
"World Trade Center"	20.67	13
"Harry Potter and the Deathly Hallows – Part 2"	23.88	12
"Fair Game"	34.68	12
"25th Hour"	17.49	11
"Shall We Dance"	18.59	11


	
3, Which release year is the most popular?

select m.title ,count(r.date_renting) as most_rented, m.year_of_release
from movies as m
left join renting as r
using(movie_id)
group by m.title,  m.year_of_release
order by most_rented desc
LIMIT 1;

Result:
"title"	"most_rented"	"year_of_release"
"The Kingdom"	15	2007


	
4,Ratio of new vs old movies (New>=2010, Old: Before 2010) 
	
with new_films as (
select Count(year_of_release) as nfilm
from movies
where year_of_release >= 2010),

old_films as (
select Count(year_of_release) as olfilm
from movies
where year_of_release < 2010
),

total_films as (
select Count(year_of_release) as tot
from movies 
)

select 
	new_films.nfilm,
	old_films.olfilm,
	total_films.tot,
	ROUND(new_films.nfilm::numeric / NULLIF(total_films.tot, 0) * 100, 2) AS new_ration,
	ROUND(old_films.olfilm::numeric / NULLIF(total_films.tot, 0) * 100, 2) AS old_ration
	from new_films
	cross join old_films
	cross join total_films;

	Result:
	"nfilm"	"olfilm"	"tot"	"new_ration"	"old_ration"
		22	49			71			30.99			69.01
	Old ration: 69%
	New Ration: 31%
	
5	Who rents the most?
6	Average number of rentals per customer
7	Customer Lifetime Value (CLV)
8	Returning vs one-time customers
9	In which month is revenue the highest?
10	Weekend vs weekday performance
11	Seasonal patterns (e.g. Christmas, summer)
12	Year-over-Year (YoY) growth
13	Revenue by genre
14	Average rental price
15	Most profitable category
16	Do the top 20% of movies generate 80% of the revenue? (Pareto 👀)
17	Which genre is the most popular?
18	Male vs female customer preferences (if gender data is available)
19	Age group vs genre (if birth year is available)

