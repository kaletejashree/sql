create database tejashree_assi3_exercise;
use tejashree_assi3_exercise;

create table actor(
act_id int primary key identity(901,1),
act_fname varchar(30),
act_lname varchar(30),
act_gender varchar(20));

drop table actor;
create table genre(
gen_id int primary key identity(901,1),
gen_title varchar(30));

drop table genre;
create table director(
dir_id int primary key identity(901,1),
dir_fname varchar(30),
dir_lname varchar(30));

drop table director;
create table movie(
mov_id int primary key identity(901,1),
mov_title varchar(30),
mov_year int,
mov_time int,
mov_lang varchar(30),
mov_dt_rel date,
mov_release_country varchar(30));

drop table movie;
create table movie_genres (
    mov_id int,
    gen_id int,
    primary key (mov_id, gen_id),
    foreign key (mov_id) references movie(mov_id),
    foreign key (gen_id) references genre(gen_id)
);

drop table movie_genres;
create table movie_direction (
    dir_id int,
    mov_id int,
     primary key (dir_id, mov_id),
    foreign key (dir_id) references director(dir_id),
    foreign key (mov_id) references movie(mov_id)
);

drop table movie_direction;
create table reviewer (
    rev_id int  primary key,
    rev_name varchar(30)
);
drop table reviewer;

create table rating (
    mov_id int,
    rev_id int,
    rev_stars int,
    num_o_rating int,
     primary key (mov_id, rev_id),
    foreign key (mov_id) references movie(mov_id),
    foreign key (rev_id) references reviewer(rev_id)
);

drop table rating;
create table movie_cast (
    act_id int,
    mov_id int,
    role varchar(30),
     primary key (act_id, mov_id),
    foreign key (act_id) references actor(act_id),
    foreign key (mov_id) references movie(mov_id)
);
drop table movie_cast;

insert into actor(act_id,act_fname,act_lname,act_gender) values ('John', 'Doe', 'M'),('Tej', 'Kale', 'F'),('ritz', 'patel', 'M'),('Janvhi', 'Dongriya', 'F');
insert into genre(gen_id,gen_title) values ( 'Action'),('Comedy'),('Drama'),('History');
insert into director values ('Jane', 'Doe'),('ritz', 'patel'),('Tej', 'Kale'),('jjj','shinde');
insert into movie values ('Sample Movie', 1999, 120, 'English', '1999-01-01', 'USA'),('Comedy Movie', 2024, 160, 'Hindi', '2024-07-01', 'Gujarat'),('Mystery Movies', 1999, 120, 'English', '1999-01-01', 'USA'),('Mystery Movies', 2000, 160, 'Hindi', '2000-01-01', 'Mumbai');
insert into movie_genres values (901, 904),(902, 903),(903, 902),(904, 901);
insert into movie_direction values (904, 901),(903, 902),(902, 903),(901, 904);
insert into reviewer values (1, 'Reviewer 2'),(2, 'Reviewer 2'),(3, 'Reviewer 3'),(4, 'Reviewer 4'), (5, 'Reviewer 5'),(6, 'Reviewer 6');
insert into rating values (901, 4, 5, 10),(902, 3, 4, 15),(903, 2, 3, 1),(904, 1, 5, 10);
insert into movie_cast values (902, 904, 'Lead Actor'),(901, 903, 'Main'),(904, 901, 'Lead Actor'),(903, 902, 'dancer');
--insert into movie values ('Mystery Movies', 1999, 120, 'English', '1999-01-01', 'USA'),('Mystery Movies', 2000, 160, 'Hindi', '2000-01-01', 'Mumbai');
--insert into genre values ( 'Action'),('History');
--insert into reviewer values (5, 'Reviewer 5'),(6, 'Reviewer 6');
--insert into rating values (905, 6, 3, 5),(906, 5, 2, 2);

select * from actor;
select * from genre;
select * from director;
select * from movie;
select * from movie_genres;
select * from movie_direction;
select * from reviewer;
select * from rating;
select * from movie_cast;

--1)find the name and year of the movies. Return movie title, movie release year
select mov_id,mov_title,mov_year,mov_dt_rel from movie;

--2)write a SQL query to find when the movie specific released. Return movie release year
select mov_title,mov_dt_rel from movie
where mov_title='Action Movie';

--3. From the following table, write a SQL query to find the movie that was released in 1999. Return movie title.
select mov_title,mov_year from movie
where mov_year =1999;

--4. From the following table, write a SQL query to find those movies, which were released before 1998. Return movie title.
select mov_title,mov_year from movie
where mov_year <1998;

--5. From the following tables, write a SQL query to find the name of all reviewers and movies together in a single list.
select mov_title from movie
union
select rev_name from reviewer;
--6. From the following table, write a SQL query to find all reviewers who have rated seven or more stars to their rating. Return reviewer name.
select rev_name from reviewer join rating
on reviewer.rev_id = rating.rev_id
where rev_stars>=7;

--7. From the following tables, write a SQL query to find the movies without any rating. Return movie title.
select mov_title from movie
where mov_id not in(select mov_id from rating);

--8. From the following table, write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title.
select mov_id,mov_title from movie
where mov_id in (905,907,917);

--9. From the following table, write a SQL query to find the movie titles that contain the specific word. 
--Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year.
select mov_title,mov_id,mov_dt_rel from movie
where mov_title like '%a%'
order by mov_year asc;

--10. From the following table, write a SQL query to find those actors with the first name 'Woody' and the last name 'Allen'. Return actor ID
select act_id from actor
where act_fname='Woody' and act_lname='Allen';

--11. get directors who have directed movies with avrage rating higher then 5
select director.dir_id  from director 
inner join movie_direction 
on director.dir_id=movie_direction.dir_id
inner join rating 
on movie_direction .mov_id=rating.mov_id
group by director.dir_id
having avg(rating.rev_stars)>5;



--12. get all actors who have worked for movies that were directed by specific director
select actor.act_id,actor.act_fname,actor.act_lname from actor
inner join movie_cast 
on actor.act_id=movie_cast.act_id
inner join movie_direction
on movie_direction.mov_id=movie_cast.mov_id
where movie_direction.dir_id=901;

--13. create a stored proc to get list of movies which is 3 years old and having rating greater than 5
/*create procedure Getmovies
as
begin
declare @year int
set @year=year(getDate());
select movie.mov_id,movie.mov_title,movie.mov_year,rating.rev_stars from movie inner join rating on
movie.mov_id=rating.mov_id
where @year-mov_year>=3 and rating.rev_stars>5;
end;
exec Getmovies;*/
select movie.mov_id,movie.mov_title,movie.mov_year,rating.rev_stars from movie inner join rating 
on movie.mov_id=rating.mov_id
where year(mov_year)>=3 and rating.rev_stars>5;

--14. create a stored proc to get list of all directors who have directed more then 2 movies
/*create procedure directmovie
as
begin
select  d.dir_id,d.dir_fname,d.dir_lname, count(m.mov_id)from director as d 
inner join movie_direction as m
on d.dir_id=m.dir_id
group by  d.dir_id,d.dir_fname,d.dir_lname
having count(m.mov_id)>=3;
end;
exec directmovie;*/
select  d.dir_id,d.dir_fname,d.dir_lname, count(m.mov_id)from director as d 
inner join movie_direction as m
on d.dir_id=m.dir_id
group by  d.dir_id,d.dir_fname,d.dir_lname
having count(m.mov_id)>=3;

--15. create a stored proc to get list of all directors which have directed a movie which have rating greater than 3.
/*create procedure getdirmovie
as
begin
select d.dir_id,d.dir_fname,d.dir_lname,r.rev_stars
from director as d join movie_direction as m
on d.dir_id=m.dir_id
join rating as r
on m.mov_id=r.mov_id
where (r.rev_stars)>3
end;
exec getdirmovie;*/

select d.dir_id,d.dir_fname,d.dir_lname,r.rev_stars
from director as d join movie_direction as m
on d.dir_id=m.dir_id
join rating as r
on m.mov_id=r.mov_id
where (r.rev_stars)>3;

--16. create a function to get worst director according to movie rating
/*create procedure worstdir
as
begin
select d.dir_id,d.dir_fname,r.rev_stars from director as d
inner join movie_direction m
on d.dir_id=m.dir_id
inner join rating as r
on r.mov_id=m.mov_id
where r.rev_stars<=3
end;
exec worstdir;*/
select d.dir_id,d.dir_fname,r.rev_stars from director as d
inner join movie_direction m
on d.dir_id=m.dir_id
inner join rating as r
on r.mov_id=m.mov_id
where r.rev_stars<=3;
--17.  create a function to get worst actor according to movie rating

SELECT TOP 1
        AC.act_id,
        AC.act_fname,
        AC.act_lname,
        AVG(R.rev_stars) AS AverageRating
    FROM
        actor AC
    JOIN
        movie_cast MC ON AC.act_id = MC.act_id
    JOIN
        rating R ON MC.mov_id = R.mov_id
    GROUP BY
        AC.act_id, AC.act_fname, AC.act_lname
    ORDER BY
        AverageRating;

--18. create a parameterized stored procedure which accept genre and give movie accordingly 

--19. get list of movies that start with 'a' and end with letter 'e' and movie released before 2015
/*create procedure getmov
as
begin
select mov_id,mov_title,mov_year,mov_time,mov_lang,mov_dt_rel from movie
where mov_title like 'a%e' and year(mov_dt_rel)<2015
end;
exec getmov;*/
select mov_id,mov_title,mov_year,mov_time,mov_lang,mov_dt_rel from movie
where mov_title like 'a%e' and year(mov_dt_rel)<2015;

--20. get a movie with highest movie cast
select m.mov_id,m.mov_title,m.mov_year,m.mov_time,m.mov_lang,m.mov_dt_rel,m.mov_release_country,count(mc.act_id) as countact from movie as m
inner join movie_cast as mc
on m.mov_id=mc.mov_id
group by  m.mov_id,m.mov_title,m.mov_year,m.mov_time,m.mov_lang,m.mov_dt_rel,m.mov_release_country
order by countact desc;

--21. create a function to get reviewer that has rated highest number of movies

--22. From the following tables, write a query in SQL to generate a report, which contain the fields movie title, name of the female actor, year of the movie, role, movie genres, the director, date of release, and rating of that movie.

select m.mov_title,a.act_fname,a.act_gender,m.mov_year,m.mov_dt_rel,g.gen_id,d.dir_id,r.rev_stars
from movie as m
inner join movie_cast as mc on m.mov_id=mc.mov_id
inner join actor as a on mc.act_id=a.act_id and a.act_gender='F'
inner join movie_genres as mg on m.mov_id=mg.mov_id
inner join genre as g on g.gen_id=mg.gen_id
inner join rating as r on r.mov_id=m.mov_id
inner join movie_direction as md on m.mov_id=md.mov_id
inner join director as d on d.dir_id=md.dir_id
group by m.mov_title,a.act_fname,a.act_gender,m.mov_year,m.mov_dt_rel,g.gen_id,d.dir_id,r.rev_stars;


--23. From the following tables, write a SQL query to find the years when most of the ‘Mystery Movies’ produced. Count the number of generic title and compute their average rating. Group the result set on movie release year, generic title. Return movie year, generic title, number of generic title and average rating.
select year(m.mov_dt_rel) as released_year,m.mov_title,g.gen_title,count(g.gen_id) as count,avg(r.num_o_rating) as avg from movie as m
inner join movie_genres as mg on m.mov_id=mg.mov_id
inner join genre as g on g.gen_id=mg.gen_id
inner join rating as r on r.mov_id=m.mov_id
group by m.mov_dt_rel,m.mov_title,g.gen_title
having m.mov_title='Mystery Movies';

--24.  From the following tables, write a SQL query to find the highest-rated ‘Mystery Movies’. Return the title, year, and rating
select m.mov_title,m.mov_dt_rel,r.rev_stars from movie as m inner join rating as r
on m.mov_id=r.rev_stars
group by  m.mov_title,m.mov_dt_rel,r.rev_stars
having m.mov_title='Mystery Movies'
order by r.rev_stars desc;
--25. create a function which accepts genre and suggests best movie according to ratings
select g.gen_id,g.gen_title from genre inner join movie_genres as mg
on g.mov_id=mg.mov_id
inner join movie as m on m.mov_id=mg.mov_id
inner join rating as r on r.mov_id=mg.mov_id

--26. create a function which accepts genre and suggests best director according to ratings. 

--27. create a function that accepts a genre and give random movie according to genre


