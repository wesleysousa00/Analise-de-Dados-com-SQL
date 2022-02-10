Análise Exploratória

Para este estudo de caso vamos aplicar SQL para analisar dados reais sobre a pandemia do Covid-19.
Faremos análisede estatísticas, agregações, relacionamentos e ainda análise de dados ao longo do tempo.
Por fim, apresentaremos o resultado do nosso trabalho de análise.

Para este estudo de caso usaremos dados reais disponíveis publicamente no link abaixo:
https://ourworldindata.org/covid-deaths

Criando as tabelas

CREATE TABLE cap07.covid_mortes (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` text,
  `population` text,
  `total_cases` text,
  `new_cases` text,
  `new_cases_smoothed` text,
  `total_deaths` text,
  `new_deaths` text,
  `new_deaths_smoothed` text,
  `total_cases_per_million` text,
  `new_cases_per_million` text,
  `new_cases_smoothed_per_million` text,
  `total_deaths_per_million` text,
  `new_deaths_per_million` text,
  `new_deaths_smoothed_per_million` text,
  `reproduction_rate` text,
  `icu_patients` text,
  `icu_patients_per_million` text,
  `hosp_patients` text,
  `hosp_patients_per_million` text,
  `weekly_icu_admissions` text,
  `weekly_icu_admissions_per_million` text,
  `weekly_hosp_admissions` text,
  `weekly_hosp_admissions_per_million` text
);


CREATE TABLE cap07.covid_vacinacao (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` text,
  `new_tests` text,
  `total_tests` text,
  `total_tests_per_thousand` text,
  `new_tests_per_thousand` text,
  `new_tests_smoothed` text,
  `new_tests_smoothed_per_thousand` text,
  `positive_rate` text,
  `tests_per_case` text,
  `tests_units` text,
  `total_vaccinations` text,
  `people_vaccinated` text,
  `people_fully_vaccinated` text,
  `new_vaccinations` text,
  `new_vaccinations_smoothed` text,
  `total_vaccinations_per_hundred` text,
  `people_vaccinated_per_hundred` text,
  `people_fully_vaccinated_per_hundred` text,
  `new_vaccinations_smoothed_per_million` text,
  `stringency_index` text,
  `population_density` text,
  `median_age` text,
  `aged_65_older` text,
  `aged_70_older` text,
  `gdp_per_capita` text,
  `extreme_poverty` text,
  `cardiovasc_death_rate` text,
  `diabetes_prevalence` text,
  `female_smokers` text,
  `male_smokers` text,
  `handwashing_facilities` text,
  `hospital_beds_per_thousand` text,
  `life_expectancy` text,
  `human_development_index` text,
  `excess_mortality` text
);




EXPLORAÇÃO INICIAL DOS DADOS
SELECT COUNT(*) FROM cap07.covid_mortes;
+----------+
| COUNT(*) |
+----------+
|   100181 |
+----------+
1 row in set (0.16 sec)



EXPLORAÇÃO INICIAL DOS DADOS
SELECT COUNT(*) FROM cap07.covid_vacinacao;
+----------+
| COUNT(*) |
+----------+
|   100181 |
+----------+
1 row in set (0.17 sec)



ORDERNANDO POR NOME DE COLUNA OU NÚMERO DA COLUNA
SELECT * FROM cap07.covid_mortes ORDER BY location, date;
SELECT * FROM cap07.covid_mortes ORDER BY 3,4;


	SAFE UPDATE DE COLUNAS
	Muito cuidado ao tentar utilizar o comando abaixo, pois sem o WHERE ele modifica a tabela inteira
	e por isto o mysql retorna uma mensagem de erro, pois o UPDATE sem o WHERE pode prejudicar a tabela inteira
	para desabilitar o SAFE UPDATE é através do comando abaixo.


SET SQL_SAFE_UPDATES = 0;

UPDATE cap07.covid_mortes
SET date = str_to_date(date, '%d/%m/%y');

UPDATE cap07.covid_vacinacao
SET date = str_to_date(date, '%d/%m/%y');


	O ideal é quando terminar de fazer o UPDATE na tabela, é retornar o SAFE UPDATE para 1 assim habilitando novamente

SET SQL_SAFE_UPDATES = 1;

	
	ANÁLISE UNIVARIADA COM SQL

Retornando algumas colunas relevantes para nosso estudo
SELECT date,
       location,
       total_cases,
       new_cases,
       total_deaths,
       population 
FROM cap07.covid_mortes 
ORDER BY 2,1
LIMIT 10;
+------------+-------------+-------------+-----------+--------------+------------+
| date       | location    | total_cases | new_cases | total_deaths | population |
+------------+-------------+-------------+-----------+--------------+------------+
| 2020-02-24 | Afghanistan | 1           | 1         |              | 38928341   |
| 2020-02-25 | Afghanistan | 1           | 0         |              | 38928341   |
| 2020-02-26 | Afghanistan | 1           | 0         |              | 38928341   |
| 2020-02-27 | Afghanistan | 1           | 0         |              | 38928341   |
| 2020-02-28 | Afghanistan | 1           | 0         |              | 38928341   |
| 2020-02-29 | Afghanistan | 1           | 0         |              | 38928341   |
| 2020-03-01 | Afghanistan | 1           | 0         |              | 38928341   |
| 2020-03-02 | Afghanistan | 1           | 0         |              | 38928341   |
| 2020-03-03 | Afghanistan | 2           | 1         |              | 38928341   |
| 2020-03-04 | Afghanistan | 4           | 2         |              | 38928341   |
+------------+-------------+-------------+-----------+--------------+------------+
10 rows in set (0.15 sec)



Qual a média de mortos por país?
Análise Univariada
SELECT location,
       AVG(total_deaths) AS MediaMortos
FROM cap07.covid_mortes 
GROUP BY location
ORDER BY MediaMortos DESC
LIMIT 10;
+----------------+--------------------+
| location       | MediaMortos        |
+----------------+--------------------+
| World          | 1479378.1528301886 |
| Europe         |  435781.5179584121 |
| North America  |  397753.5566037736 |
| South America  |  367182.1803607214 |
| European Union |  295565.6483931947 |
| United States  | 274030.92264150945 |
| Asia           | 248166.65094339623 |
| Brazil         | 182642.15555555557 |
| India          | 110945.25862068965 |
| Mexico         |  93108.05626134301 |
+----------------+--------------------+
10 rows in set (0.23 sec)



	ANÁLISE MULTIVARIADA

Qual a proporção de mortes em relação ao total de casos no Brasil?
Análise Mutivariada
SELECT date,
       location, 
       total_cases,
       total_deaths,
       (total_deaths / total_cases) * 100 AS PercentualMortes
FROM cap07.covid_mortes  
WHERE location = "Brazil" 
ORDER BY 2,1
LIMIT 10;
+------------+----------+-------------+--------------+------------------+
| date       | location | total_cases | total_deaths | PercentualMortes |
+------------+----------+-------------+--------------+------------------+
| 2020-02-26 | Brazil   | 1           |              |                0 |
| 2020-02-27 | Brazil   | 1           |              |                0 |
| 2020-02-28 | Brazil   | 1           |              |                0 |
| 2020-02-29 | Brazil   | 2           |              |                0 |
| 2020-03-01 | Brazil   | 2           |              |                0 |
| 2020-03-02 | Brazil   | 2           |              |                0 |
| 2020-03-03 | Brazil   | 2           |              |                0 |
| 2020-03-04 | Brazil   | 4           |              |                0 |
| 2020-03-05 | Brazil   | 4           |              |                0 |
| 2020-03-06 | Brazil   | 13          |              |                0 |
+------------+----------+-------------+--------------+------------------+
10 rows in set (0.13 sec)



	AGREGAÇÃO E ANÁLISE

Qual a proporção média entre o total de casos e a população de cada localidade?
SELECT location,
       AVG((total_cases / population) * 100) AS PercentualPopulacao
FROM cap07.covid_mortes  
GROUP BY location
ORDER BY PercentualPopulacao DESC
LIMIT 10;
+------------+---------------------+
| location   | PercentualPopulacao |
+------------+---------------------+
| Andorra    |   7.600817224579603 |
| Montenegro |   6.231348262801412 |
| San Marino |   6.174345549863143 |
| Czechia    |   5.663826827978126 |
| Bahrain    |   5.111716122888626 |
| Luxembourg |   4.722024557276311 |
| Qatar      |   4.283484274278229 |
| Israel     |   4.231837583875447 |
| Panama     |   4.200430192431739 |
| Slovenia   |   4.148941867946744 |
+------------+---------------------+
10 rows in set (0.26 sec)



Considerando o maior valor do total de casos, quais os países com a maior taxa de infecção em relação à população?
SELECT location, 
       MAX(total_cases) AS MaiorContagemInfec,
       MAX((total_cases / population)) * 100 AS PercentualPopulacao
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY location, population 
ORDER BY PercentualPopulacao DESC
LIMIT 10;
+------------+--------------------+---------------------+
| location   | MaiorContagemInfec | PercentualPopulacao |
+------------+--------------------+---------------------+
| Andorra    | 9972               |   18.01333074483919 |
| Seychelles | 9764               |   16.12466951393126 |
| Montenegro | 99988              |  15.974059885807451 |
| Bahrain    | 99817              |  15.657537716350012 |
| Czechia    | 9991               |  15.575103217093838 |
| San Marino | 994                |   15.00088396487713 |
| Maldives   | 9939               |  13.754897861775772 |
| Slovenia   | 997                |   12.38236748484318 |
| Luxembourg | 9840               |    11.3472401497821 |
| Sweden     | 995595             |  10.801572786944007 |
+------------+--------------------+---------------------+
10 rows in set (0.33 sec)



Quais os países com o maior número de mortes?
Cuidado!
SELECT location, 
       MAX(total_deaths) AS MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY MaiorContagemMortes DESC
LIMIT 10;
+--------------------+---------------------+
| location           | MaiorContagemMortes |
+--------------------+---------------------+
| Austria            | 9997                |
| Iran               | 9996                |
| Belgium            | 9996                |
| Egypt              | 9994                |
| France             | 99936               |
| Colombia           | 99934               |
| Tunisia            | 9993                |
| Pakistan           | 9992                |
| Peru               | 99910               |
| Dominican Republic | 999                 |
+--------------------+---------------------+
10 rows in set (0.23 sec)



Quais os países com o maior número de mortes?
Simples, mas resolve!
SELECT location, 
       MAX(total_deaths * 1) AS MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY MaiorContagemMortes DESC
LIMIT 10;
+----------------+---------------------+
| location       | MaiorContagemMortes |
+----------------+---------------------+
| World          |             3976335 |
| Europe         |             1109009 |
| South America  |             1017409 |
| North America  |              904252 |
| Asia           |              798971 |
| European Union |              740177 |
| United States  |              605526 |
| Brazil         |              524417 |
| India          |              402005 |
| Mexico         |              233622 |
+----------------+---------------------+
10 rows in set (0.23 sec)



Quais os países com o maior número de mortes?
Agora a forma ideal de resolver
https://dev.mysql.com/doc/refman/8.0/en/cast-functions.html#function_cast
A função CAST não permite conversão para o tipo INT
SELECT location, 
       MAX(CAST(total_deaths AS UNSIGNED)) AS MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY MaiorContagemMortes DESC
LIMIT 10;
+----------------+---------------------+
| location       | MaiorContagemMortes |
+----------------+---------------------+
| World          |             3976335 |
| Europe         |             1109009 |
| South America  |             1017409 |
| North America  |              904252 |
| Asia           |              798971 |
| European Union |              740177 |
| United States  |              605526 |
| Brazil         |              524417 |
| India          |              402005 |
| Mexico         |              233622 |
+----------------+---------------------+
10 rows in set, 13750 warnings (0.25 sec)



Quais os continentes com o maior número de mortes?
SELECT continent, 
       MAX(total_deaths) as MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY continent 
ORDER BY MaiorContagemMortes DESC
LIMIT 10;
+---------------+---------------------+
| continent     | MaiorContagemMortes |
+---------------+---------------------+
| Europe        | 9997                |
| Asia          | 9996                |
| Africa        | 9994                |
| South America | 99934               |
| North America | 999                 |
|               | 998761              |
| Oceania       | 99                  |
+---------------+---------------------+
7 rows in set (0.23 sec)



Quais os continentes com o maior número de mortes?
Na consulta anterior, vamos converter os dados para valores inteiros sem sinal (absolutos)
https://dev.mysql.com/doc/refman/8.0/en/integer-types.html
SELECT continent, 
       MAX(CAST(total_deaths AS UNSIGNED)) as MaiorContagemMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY continent 
ORDER BY MaiorContagemMortes DESC
LIMIT 10;
+---------------+---------------------+
| continent     | MaiorContagemMortes |
+---------------+---------------------+
|               |             3976335 |
| North America |              605526 |
| South America |              524417 |
| Asia          |              402005 |
| Europe        |              135637 |
| Africa        |               61840 |
| Oceania       |                 910 |
+---------------+---------------------+
7 rows in set, 13750 warnings (0.24 sec)



Qual o percentual de mortes por dia?
SELECT date,
       SUM(new_cases) as total_cases, 
       SUM(CAST(new_deaths AS UNSIGNED)) as total_deaths, 
       (SUM(CAST(new_deaths AS UNSIGNED)) / SUM(new_cases)) * 100 as PercentMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY date 
ORDER BY 1,2
LIMIT 10;
+------------+-------------+--------------+---------------+
| date       | total_cases | total_deaths | PercentMortes |
+------------+-------------+--------------+---------------+
| 2020-01-01 |           0 |            0 |          NULL |
| 2020-01-02 |           0 |            0 |          NULL |
| 2020-01-03 |           0 |            0 |          NULL |
| 2020-01-04 |           0 |            0 |          NULL |
| 2020-01-05 |           0 |            0 |          NULL |
| 2020-01-06 |           0 |            0 |          NULL |
| 2020-01-07 |           0 |            0 |          NULL |
| 2020-01-08 |           0 |            0 |          NULL |
| 2020-01-09 |           0 |            0 |          NULL |
| 2020-01-10 |           0 |            0 |          NULL |
+------------+-------------+--------------+---------------+
10 rows in set, 27378 warnings (0.34 sec)



Vamos melhorar a query.
SELECT date,
       SUM(new_cases) as total_cases, 
       SUM(CAST(new_deaths AS UNSIGNED)) as total_deaths, 
       COALESCE((SUM(CAST(new_deaths AS UNSIGNED)) / SUM(new_cases)) * 100, 'NA') as PercentMortes
FROM cap07.covid_mortes 
WHERE continent IS NOT NULL 
GROUP BY date 
ORDER BY 1,2
LIMIT 10;
+------------+-------------+--------------+---------------+
| date       | total_cases | total_deaths | PercentMortes |
+------------+-------------+--------------+---------------+
| 2020-01-01 |           0 |            0 | NA            |
| 2020-01-02 |           0 |            0 | NA            |
| 2020-01-03 |           0 |            0 | NA            |
| 2020-01-04 |           0 |            0 | NA            |
| 2020-01-05 |           0 |            0 | NA            |
| 2020-01-06 |           0 |            0 | NA            |
| 2020-01-07 |           0 |            0 | NA            |
| 2020-01-08 |           0 |            0 | NA            |
| 2020-01-09 |           0 |            0 | NA            |
| 2020-01-10 |           0 |            0 | NA            |
+------------+-------------+--------------+---------------+
10 rows in set, 27378 warnings (0.34 sec)



Qual o número de novos vacinados e a média móvel de novos vacinados ao longo do tempo por localidade?
Considere apenas os dados da América do Sul
SELECT mortos.continent,
       mortos.location,
       mortos.date,
       vacinados.new_vaccinations,
       AVG(CAST(vacinados.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY mortos.location ORDER BY mortos.date) as MediaMovelVacinados
FROM cap07.covid_mortes mortos 
JOIN cap07.covid_vacinacao vacinados
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.continent = 'South America'
ORDER BY 2,3
LIMIT 10;
+---------------+-----------+------------+------------------+---------------------+
| continent     | location  | date       | new_vaccinations | MediaMovelVacinados |
+---------------+-----------+------------+------------------+---------------------+
| South America | Argentina | 2020-01-01 |                  |              0.0000 |
| South America | Argentina | 2020-01-02 |                  |              0.0000 |
| South America | Argentina | 2020-01-03 |                  |              0.0000 |
| South America | Argentina | 2020-01-04 |                  |              0.0000 |
| South America | Argentina | 2020-01-05 |                  |              0.0000 |
| South America | Argentina | 2020-01-06 |                  |              0.0000 |
| South America | Argentina | 2020-01-07 |                  |              0.0000 |
| South America | Argentina | 2020-01-08 |                  |              0.0000 |
| South America | Argentina | 2020-01-09 |                  |              0.0000 |
| South America | Argentina | 2020-01-10 |                  |              0.0000 |
+---------------+-----------+------------+------------------+---------------------+
10 rows in set, 4849 warnings (0.42 sec)



Qual o número de novos vacinados e o total de novos vacinados ao longo do tempo por continente?
Considere apenas os dados da América do Sul
SELECT mortos.continent,
       mortos.date,
       vacinados.new_vaccinations,
       SUM(CAST(vacinados.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY mortos.continent ORDER BY mortos.date) as TotalVacinados
FROM cap07.covid_mortes mortos 
JOIN cap07.covid_vacinacao vacinados
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.continent = 'South America'
ORDER BY 1,2
LIMIT 10;
+---------------+------------+------------------+----------------+
| continent     | date       | new_vaccinations | TotalVacinados |
+---------------+------------+------------------+----------------+
| South America | 2020-01-01 |                  |              0 |
| South America | 2020-01-02 |                  |              0 |
| South America | 2020-01-03 |                  |              0 |
| South America | 2020-01-04 |                  |              0 |
| South America | 2020-01-05 |                  |              0 |
| South America | 2020-01-06 |                  |              0 |
| South America | 2020-01-06 |                  |              0 |
| South America | 2020-01-07 |                  |              0 |
| South America | 2020-01-07 |                  |              0 |
| South America | 2020-01-08 |                  |              0 |
+---------------+------------+------------------+----------------+
10 rows in set, 4849 warnings (0.39 sec)



Qual o número de novos vacinados e o total de novos vacinados ao longo do tempo por continente?
Considere apenas os dados da América do Sul
Considere a data no formato January/2020
SELECT mortos.continent,
       DATE_FORMAT(mortos.date, "%M/%Y") AS MES,
       vacinados.new_vaccinations,
       SUM(CAST(vacinados.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY mortos.continent ORDER BY DATE_FORMAT(mortos.date, "%M/%Y")) as TotalVacinados
FROM cap07.covid_mortes mortos 
JOIN cap07.covid_vacinacao vacinados
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.continent = 'South America'
ORDER BY 1,2
LIMIT 10;
+---------------+------------+------------------+----------------+
| continent     | MES        | new_vaccinations | TotalVacinados |
+---------------+------------+------------------+----------------+
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
| South America | April/2020 |                  |              0 |
+---------------+------------+------------------+----------------+
10 rows in set, 4849 warnings (0.38 sec)



Qual o percentual da população com pelo menos 1 dose da vacina ao longo do tempo?
Considere apenas os dados do Brasil
Usando Common Table Expressions (CTE) 
WITH PopvsVac (continent,location, date, population, new_vaccinations, TotalMovelVacinacao) AS
(
SELECT mortos.continent,
       mortos.location,
       mortos.date,
       mortos.population,
       vacinados.new_vaccinations,
       SUM(CAST(vacinados.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY mortos.location ORDER BY mortos.date) AS TotalMovelVacinacao
FROM cap07.covid_mortes mortos 
JOIN cap07.covid_vacinacao vacinados 
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.location = 'Brazil'
)
SELECT *, (TotalMovelVacinacao / population) * 100 AS Percentual_1_Dose FROM PopvsVac
LIMIT 10;
+---------------+----------+------------+------------+------------------+---------------------+-------------------+
| continent     | location | date       | population | new_vaccinations | TotalMovelVacinacao | Percentual_1_Dose |
+---------------+----------+------------+------------+------------------+---------------------+-------------------+
| South America | Brazil   | 2020-02-26 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-02-27 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-02-28 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-02-29 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-01 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-02 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-03 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-04 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-05 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-06 | 212559409  |                  |                   0 |                 0 |
+---------------+----------+------------+------------+------------------+---------------------+-------------------+
10 rows in set, 360 warnings (0.27 sec)



Durante o mês de Maio/2021 o percentual de vacinados com pelo menos uma dose aumentou ou diminuiu no Brasil?
WITH PopvsVac (continent, location, date, population, new_vaccinations, TotalMovelVacinacao) AS
(
SELECT mortos.continent,
       mortos.location,
       mortos.date,
       mortos.population,
       vacinados.new_vaccinations,
       SUM(CAST(vacinados.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY mortos.location ORDER BY mortos.date) AS TotalMovelVacinacao
FROM cap07.covid_mortes mortos 
JOIN cap07.covid_vacinacao vacinados 
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.location = 'Brazil'
)
SELECT *, (TotalMovelVacinacao / population) * 100 AS Percentual_1_Dose 
FROM PopvsVac
WHERE DATE_FORMAT(date, "%M/%Y") = 'May/2021'
AND location = 'Brazil'
LIMIT 10;
+---------------+----------+------------+------------+------------------+---------------------+--------------------+
| continent     | location | date       | population | new_vaccinations | TotalMovelVacinacao | Percentual_1_Dose  |
+---------------+----------+------------+------------+------------------+---------------------+--------------------+
| South America | Brazil   | 2021-05-01 | 212559409  | 337317           |            39336127 | 18.505944848576426 |
| South America | Brazil   | 2021-05-02 | 212559409  | 137177           |            39473304 | 18.570480688530704 |
| South America | Brazil   | 2021-05-03 | 212559409  | 788803           |            40262107 | 18.941578351866795 |
| South America | Brazil   | 2021-05-04 | 212559409  | 1311666          |            41573773 |  19.55866042137895 |
| South America | Brazil   | 2021-05-05 | 212559409  | 911864           |            42485637 | 19.987652957766738 |
| South America | Brazil   | 2021-05-06 | 212559409  | 356703           |            42842340 | 20.155466277195003 |
| South America | Brazil   | 2021-05-07 | 212559409  | 333068           |            43175408 | 20.312160352308844 |
| South America | Brazil   | 2021-05-08 | 212559409  |                  |            43175408 | 20.312160352308844 |
| South America | Brazil   | 2021-05-09 | 212559409  |                  |            43175408 | 20.312160352308844 |
| South America | Brazil   | 2021-05-10 | 212559409  |                  |            43175408 | 20.312160352308844 |
+---------------+----------+------------+------------+------------------+---------------------+--------------------+
10 rows in set, 360 warnings (0.31 sec)



Criando uma VIEW para armazenar a consulta e entregar o resultado
CREATE OR REPLACE VIEW cap07.PercentualPopVac AS 
WITH PopvsVac (continent, location, date, population, new_vaccinations, TotalMovelVacinacao) AS
(
SELECT mortos.continent,
       mortos.location,
       mortos.date,
       mortos.population,
       vacinados.new_vaccinations,
       SUM(CAST(vacinados.new_vaccinations AS UNSIGNED)) OVER (PARTITION BY mortos.location ORDER BY mortos.date) AS TotalMovelVacinacao
FROM cap07.covid_mortes mortos 
JOIN cap07.covid_vacinacao vacinados 
ON mortos.location = vacinados.location 
AND mortos.date = vacinados.date
WHERE mortos.location = 'Brazil'
)
SELECT *, (TotalMovelVacinacao / population) * 100 AS Percentual_1_Dose 
FROM PopvsVac
WHERE location = 'Brazil';
Query OK, 0 rows affected (0.01 sec)

Total de vacinados com pelo menos 1 dose ao longo do tempo
SELECT * FROM cap07.PercentualPopVac
LIMIT 10;
+---------------+----------+------------+------------+------------------+---------------------+-------------------+
| continent     | location | date       | population | new_vaccinations | TotalMovelVacinacao | Percentual_1_Dose |
+---------------+----------+------------+------------+------------------+---------------------+-------------------+
| South America | Brazil   | 2020-02-26 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-02-27 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-02-28 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-02-29 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-01 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-02 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-03 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-04 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-05 | 212559409  |                  |                   0 |                 0 |
| South America | Brazil   | 2020-03-06 | 212559409  |                  |                   0 |                 0 |
+---------------+----------+------------+------------+------------------+---------------------+-------------------+
10 rows in set, 360 warnings (0.27 sec)
