create database bhavya;

use bhavya;

select * from world_population_data;


-- 1.EXTRACT THE WORLD POPLATION OF 2023
SELECT SUM(POPULATION_2023) AS POPULATION_2023
FROM WORLD_POPULATION_DATA;

/* INSIGHTS :

                              Provides the information of total Population of the world. Gross value of the total world population with any categorizations

*/

 
 -- 2. EXTRACT THE WORLD POPULATION GROWTH FROM 2000 TILL  THE LATEST CENSUS(2023)
 select sum(population_2023)-sum(population_2000) as 'POPULATION GROWTH N LAST 23 YEARS'
 FROM WORLD_POPULATION_DATA;
 
/* OBSERVATION :  GROSS INCREASE IN THE WORLD POPULATION SINCE THE TURN OF THE MILLENIUM .



-- 3. EXTRACT CONTINENTWISE POPULATION IN 2023
 select CONTINENT,sum(POPULATION_2023) AS POPULATION_2023
 FROM WORLD_POPULATION_DATA
 group by CONTINENT ORDER BY CONTINENT ASC;

/*  OBSERVATION :   Provides Information about the  Population of Each Continent in 2023

INSIGHTS :

As per our figures, it is evident that Asia homes close to 5 Billion Population  and other Continents together accomodate 3 Billion.

Reasons :

a) Asia is the home for very ancient Civilizations

-- 4. EXTRACT THE  ASIA'S TOP 5 HIGHEST POPULATED COUNTRIES
SELECT COUNTRY,SUM(POPULATION_2023) AS "POPULATION_2023"
FROM WORLD_POPULATION_DATA
WHERE CONTINENT='ASIA'
GROUP BY COUNTRY,CONTINENT LIMIT 5;

/*

OBSERVATION:  4 Indian Subcontinent Countries have the highest Population in Top 5 Countries .

 

INSIGHTS :China & India have the largest Population in Asia  followed by Indian Subcontinent Countries
population control regulations
Pakisthan , Bangladesh also being Muslim countries follow on the footsteps of Indonasia

*/



-- 5.HOW HAS INDIA'S POPULATION GROWN SINCE 1970 BASED ON EVERY CENSUS
SELECT COUNTRY,(POPULATION_2020-POPULATION_2010) AS '10-20 GROWTH',
               (POPULATION_2010-POPULATION_2000) AS '00-10 GROWTH',
               (POPULATION_2000-POPULATION_1990) AS '90-00 GROWTH',
               (POPULATION_1990-POPULATION_1980) AS '80-90 GROWTH',
               (POPULATION_1980-POPULATION_1970) AS '70-80 GROWTH'
FROM WORLD_POPULATION_DATA
WHERE COUNTRY='INDIA';

/*

OBSERVATION :  Steady growth in Populution every decade since 1970s .

 INSIGHT - :  There has been a steady growth of 17% to 20 % every decade in India's Population.


    
-- 6.  PROVIDE THE 5 HIGHEST POPULATED COUNTRIES IN EACH CONTINENT
select T.* from

                              (select dense_rank() over (partition by continent order by population_2023 desc) as Rank_Continentwise , Continent , Country, population_2023,

        AreaPerKM as Area_in_KM , World_percentage from world_population_data) as T

where T.Rank_Continentwise <=  5;

/* OBSERVATION : Asian Countries have the highest Population in World Percentagewise and 

Countries in Australian Continent have the least Population World Percentagewise */

 

  --  7.  10 COUINTRIES WITH LEAST POPULATION IN 2023 YEAR 
    SELECT COUNTRY_RANK,CONTINENT,COUNTRY,POPULATION_2023,AREAPERKM FROM WORLD_POPULATION_DATA ORDER BY POPULATION_2023 ASC, COUNTRY LIMIT 10;

 
  /* OBSERVATION :  Countries in the list are all Small Islands in NorthAmerica , Australia , Europe .

 

 INSIGHTS : 

 The countries in the list are small Islands  in various continents with practically no significant landmass to accomodate people.

 */
 
  -- 8 .  PROVIDE THE GROWTH RATE OF COUNTRIES  FROM 1970 TO 2023 IN MILLIONS
 select w.Continent , w.Country ,   Concat(round(( w.Population_2020 - w.Population_1970 ) / 1000000 , 2), "   Millions ") as growth_50years

 from world_population_data  w ;
 
 
 /*

OBSERVATION : Since 1970, The countries with maximum growth are India, China , USA , Indonasia

 

INSIGHT: Reasons are below

a ) Huge Agregarian lands and rivers  which is  supportive to Human thriving */


 
 -- 9: Write a query to select the top 5 countries with the highest population in 2023.
 select country,population_2023
 from world_population_data
 order by population_2023 desc limit 5;                                                                                                                                         

/* Observations:
The query selects the top 5 countries with the highest population in 2023.
The columns returned are country and population_2023.
The result is ordered by population_2023 in descending order, which means the country with the highest population is listed first.

Insights:
Population Leaders:
India and China are the two most populous countries in the world, with populations exceeding 1.4 billion each.

*/

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
/* observation
country: Lists the countries meeting the specified growth rate criterion.
growth_rate: Displays the calculated growth rate for each country.

Insights:
Countries with High Growth:
Nigeria and Ethiopia exhibit the highest growth rates, surpassing 2.4% and 2.5%, respectively.
Data Source:
The table pulls data from a table named "world_population_data," which likely contains population figures for various countries across different years.
Growth Rate Calculation:
The query calculates the growth rate using the formula: (population_2023 - population_2020) / population_2020.
*/

-- 12.list the countryies in europe with a population greater than 50 milion in 2023.
select country,population_2023
from world_population_data
where continent='europe' and population_2023>50000000;

/* Observations:
The query lists European countries with a population exceeding 50 million in 2023.
The result table includes the country name and its corresponding 2023 population.
Six countries meet the criteria: Russia, Germany, the United Kingdom, France, Italy, and Ukraine.
Insights:
Russia has the largest population among European countries, exceeding 144 million.
Germany, the United Kingdom, France, and Italy also have substantial populations, ranging from 58 to 83 million.
Ukraine, despite facing ongoing conflict, maintains a population above 43 million.*/

-- 13. show the country which is highly densed
select country,max(densityperkm) as density
from world_population_data group by country limit 1;

/* Observation:
The query is aimed at finding the country with the highest population density.
The result table shows two columns: "country" and "density".
The single row in the result displays "India" as the country with the highest density at 481 people per square kilometer.
*/

 -- 14.Show top 5 countries with high density
select country,densityperkm
from world_population_data
order by densityperkm desc limit 5;
/* Observation:
Country
Density per km²
Macau
21,403
Monaco
18,149
Singapore
8,377
Hong Kong
7,135
Gibraltar
4,807
Insights:
High Density:
These countries have significantly higher population densities compared to most other countries in the world.
Small Size:
Macau, Monaco, Singapore, and Hong Kong are all relatively small in terms of land area, which contributes to their high population densities.
Urbanization:
These countries are highly urbanized, with a large proportion of their populations living in cities.
*/

-- 15.Find the countries with a population growth rate beetween 1970 and 2023.
select country,growth_rate
from world_population_data
where (population_2023-population_1970) / population_1970;

/* Observation:
The table shows the population growth rate of several countries between 1970 and 2023.
It includes columns for "country" and "growth_rate".
The growth rate is displayed as a percentage.
Insights:
Highest Growth Rate:
Nigeria has the highest population growth rate among the listed countries at 2.41%.
Lowest Growth Rate:
China exhibits a negative growth rate of -0.02%, indicating a slight decrease in population.
India's Growth:
India boasts a significant growth rate of 0.81%.
Developed Nations:
The United States and Brazil show moderate growth rates of 0.50% and 0.52%, respectively.
*/

-- 16.Show the top 3 countries where population grew the most from 2020 to 2023
select country,growth_rate
from world_population_data
where (population_2023-population_2020) / population_2020
order by growth_rate desc limit 3;

/* observation: The query aims to identify the top 3 countries with the highest population growth rate between 2020 and 2023.
Table:
Country
Growth Rate
Moldova
4.98%
Syria
4.98%
Niger
3.80%

Insights:
Top Growth: Moldova and Syria share the highest population growth rate at 4.98%, followed by Niger at 3.80%.
Data Source: The data is pulled from a table named world_population_data.
Calculation: The growth rate is calculated using the formula (population_2023 - population_2020) / population_2020. */


-- 17.According to the region of The Continent of Asia top 5 country.
select continent,country,areaperkm
from world_population_data
where continent='asia' order by areaperkm desc;

/* observation : The query aims to identify the top 3 countries with the highest population growth rate between 2020 and 2023.
Table:
Country
Growth Rate
Moldova
4.98%
Syria
4.98%
Niger
3.80%
Insights:
Top Growth: Moldova and Syria share the highest population growth rate at 4.98%, followed by Niger at 3.80%.
Data Source: The data is pulled from a table named world_population_data.
Calculation: The growth rate is calculated using the formula (population_2023 - population_2020) / population_2020.
*/

-- 18.how much is the population growth in asian countries,show the total of all countries.
select continent,country,growth_rate
from world_population_data
where continent='asia'
order by growth_rate desc;

/* Observations:
The query selects the continent, country, and growth rate columns from the table.
It filters the results to only include countries in Asia.
The results are sorted in descending order by the growth rate.
Insights:
Syria has the highest population growth rate in Asia at 4.98%.
Afghanistan follows with a growth rate of 2.70%.
The lowest growth rate displayed in the results is Tajikistan at 1.92%.

*/


-- 19.show the 2000 population of the countries of australia-oceania.
SELECT CONTINENT,country,POPULATION_2000 FROM WORLD_POPULATION_DATA WHERE CONTINENT='Australia- Oceania';

/* Observations:
The query is selecting the CONTINENT, COUNTRY, and POPULATION_2000 columns from the table.
The query is filtering the results to only include rows where the CONTINENT is 'Australia-Oceania'.
The result set shows the population of different countries in the Australia-Oceania region in the year 2000.
Insights:
Australia has the largest population in the region, followed by Papua New Guinea and New Zealand.
The total population of the listed countries in Australia-Oceania in 2000 was approximately 30,671,352.
*/

-- 20.show the 2010 population of the countries of north america.
SELECT CONTINENT,country,POPULATION_2000
 FROM WORLD_POPULATION_DATA
  WHERE CONTINENT='North america';
  
 /* Observations:
The query aims to retrieve the 2000 population data for countries in North America.
The query is executed against the WORLD_POPULATION_DATA table.
The result set shows seven countries in North America, including the United States, Mexico, Canada, Guatemala, Haiti, the Dominican Republic, and Cuba.
The population figures are presented in the POPULATION_2000 column.
Insights:
The United States had the largest population in North America in 2000, followed by Mexico and Canada.
The combined population of these seven countries in 2000 was approximately 431 million.
  
*/ 
 
