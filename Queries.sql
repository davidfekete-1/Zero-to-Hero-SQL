
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







