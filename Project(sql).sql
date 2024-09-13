create database bhavya;

use bhavya;

select * from world_population_data;


-- 1.EXTRACT THE WORLD POPLATION OF 2023
SELECT SUM(POPULATION_2023) AS POPULATION_2023
FROM WORLD_POPULATION_DATA;



 
 -- 2. EXTRACT THE WORLD POPULATION GROWTH FROM 2000 TILL  THE LATEST CENSUS(2023)
 select sum(population_2023)-sum(population_2000) as 'POPULATION GROWTH N LAST 23 YEARS'
 FROM WORLD_POPULATION_DATA;
 




-- 3. EXTRACT CONTINENTWISE POPULATION IN 2023
 select CONTINENT,sum(POPULATION_2023) AS POPULATION_2023
 FROM WORLD_POPULATION_DATA
 group by CONTINENT ORDER BY CONTINENT ASC;



-- 4. EXTRACT THE  ASIA'S TOP 5 HIGHEST POPULATED COUNTRIES
SELECT COUNTRY,SUM(POPULATION_2023) AS "POPULATION_2023"
FROM WORLD_POPULATION_DATA
WHERE CONTINENT='ASIA'
GROUP BY COUNTRY,CONTINENT LIMIT 5;



-- 5.HOW HAS INDIA'S POPULATION GROWN SINCE 1970 BASED ON EVERY CENSUS
SELECT COUNTRY,(POPULATION_2020-POPULATION_2010) AS '10-20 GROWTH',
               (POPULATION_2010-POPULATION_2000) AS '00-10 GROWTH',
               (POPULATION_2000-POPULATION_1990) AS '90-00 GROWTH',
               (POPULATION_1990-POPULATION_1980) AS '80-90 GROWTH',
               (POPULATION_1980-POPULATION_1970) AS '70-80 GROWTH'
FROM WORLD_POPULATION_DATA
WHERE COUNTRY='INDIA';




    
-- 6.  PROVIDE THE 5 HIGHEST POPULATED COUNTRIES IN EACH CONTINENT
select T.* from

                              (select dense_rank() over (partition by continent order by population_2023 desc) as Rank_Continentwise , Continent , Country, population_2023,

        AreaPerKM as Area_in_KM , World_percentage from world_population_data) as T

where T.Rank_Continentwise <=  5;

    
  --  7.  10 COUINTRIES WITH LEAST POPULATION IN 2023 YEAR 
    SELECT COUNTRY_RANK,CONTINENT,COUNTRY,POPULATION_2023,AREAPERKM FROM WORLD_POPULATION_DATA ORDER BY POPULATION_2023 ASC, COUNTRY LIMIT 10;

 
 
 
  -- 8 .  PROVIDE THE GROWTH RATE OF COUNTRIES  FROM 1970 TO 2023 IN MILLIONS
 select w.Continent , w.Country ,   Concat(round(( w.Population_2020 - w.Population_1970 ) / 1000000 , 2), "   Millions ") as growth_50years

 from world_population_data  w ;
 
 



 
 -- 9: Write a query to select the top 5 countries with the highest population in 2023.
 select country,population_2023
 from world_population_data
 order by population_2023 desc limit 5;                                                                                                                                         





-- 10.Calculate the average population density in asia in 2023. 
   select avg(Densityperkm)
   from world_population_data
   where continent='asia';
   
/* observation: as of 2023,population avg density of asia 1005.4600
   As of 2024, the population density of Asia is 155 people per square kilometer. This is equivalent to 401 people per square mile.*/
   
  

-- 11.Find the countries with a population growth rate greater than 2% between 2020 and 2023.
select country,growth_rate
from world_population_data
where (population_2023-population_2020) / population_2020 >0.02;


-- 12.list the countryies in europe with a population greater than 50 milion in 2023.
select country,population_2023
from world_population_data
where continent='europe' and population_2023>50000000;



-- 13. show the country which is highly densed
select country,max(densityperkm) as density
from world_population_data group by country limit 1;


 -- 14.Show top 5 countries with high density
select country,densityperkm
from world_population_data
order by densityperkm desc limit 5;


 
-- 15.Find the countries with a population growth rate beetween 1970 and 2023.
select country,growth_rate
from world_population_data
where (population_2023-population_1970) / population_1970;



-- 16.Show the top 3 countries where population grew the most from 2020 to 2023
select country,growth_rate
from world_population_data
where (population_2023-population_2020) / population_2020
order by growth_rate desc limit 3;




-- 17.According to the region of The Continent of Asia top 5 country.
select continent,country,areaperkm
from world_population_data
where continent='asia' order by areaperkm desc;



-- 18.how much is the population growth in asian countries,show the total of all countries.
select continent,country,growth_rate
from world_population_data
where continent='asia'
order by growth_rate desc;




-- 19.show the 2000 population of the countries of australia-oceania.
SELECT CONTINENT,country,POPULATION_2000 FROM WORLD_POPULATION_DATA WHERE CONTINENT='Australia- Oceania';




-- 20.show the 2010 population of the countries of north america.
SELECT CONTINENT,country,POPULATION_2000
 FROM WORLD_POPULATION_DATA
  WHERE CONTINENT='North america';
  
  
  
 
 