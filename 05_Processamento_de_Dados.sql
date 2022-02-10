Principais Técnicas de Processamento de Dados


1- Transformação de Atributos e Parsing
2- Mapeamento (de-para)
3- Filtragem, Agregação e Sumarização
4- Enriquecimento e Imputação


Transformação de Atributos e Parsing
Transformamos atributos(variáveis) para facilitar o processo de análise e corrigir imperfeições nos dados
No Parsing queremos formatar os dados de modo a facilitar o processo de análise ou mesmo permitir agregações com a coluna


Mapeamento (de-para)
O objetivo é deixar os dados em um formato que facilite a interpretação e análise.





# Cria a tabela
CREATE TABLE cap08.TB_INCIDENTES (
  `PdId` bigint DEFAULT NULL,
  `IncidntNum` text,
  `Incident Code` text,
  `Category` text,
  `Descript` text,
  `DayOfWeek` text,
  `Date` text,
  `Time` text,
  `PdDistrict` text,
  `Resolution` text,
  `Address` text,
  `X` double DEFAULT NULL,
  `Y` double DEFAULT NULL,
  `location` text,
  `SF Find Neighborhoods 2 2` text,
  `Current Police Districts 2 2` text,
  `Current Supervisor Districts 2 2` text,
  `Analysis Neighborhoods 2 2` text,
  `DELETE - Fire Prevention Districts 2 2` text,
  `DELETE - Police Districts 2 2` text,
  `DELETE - Supervisor Districts 2 2` text,
  `DELETE - Zip Codes 2 2` text,
  `DELETE - Neighborhoods 2 2` text,
  `DELETE - 2017 Fix It Zones 2 2` text,
  `Civic Center Harm Reduction Project Boundary 2 2` text,
  `Fix It Zones as of 2017-11-06  2 2` text,
  `DELETE - HSOC Zones 2 2` text,
  `Fix It Zones as of 2018-02-07 2 2` text,
  `CBD, BID and GBD Boundaries as of 2017 2 2` text,
  `Areas of Vulnerability, 2016 2 2` text,
  `Central Market/Tenderloin Boundary 2 2` text,
  `Central Market/Tenderloin Boundary Polygon - Updated 2 2` text,
  `HSOC Zones as of 2018-06-05 2 2` text,
  `OWED Public Spaces 2 2` text,
  `Neighborhoods 2` text
);







                                       TRANSFORMAÇÃO DE ATRIBUTOS E PARSING



# Script 05

ALTER TABLE `cap08`.`TB_VENDAS` 
ADD COLUMN `comissao` DECIMAL(10,2) NULL AFTER `valor_venda`;

SET SQL_SAFE_UPDATES = 0;

UPDATE cap08.TB_VENDAS 
SET comissao = 5
WHERE empID = 1;

UPDATE cap08.TB_VENDAS 
SET comissao = 6
WHERE empID = 2;

UPDATE cap08.TB_VENDAS 
SET comissao = 8
WHERE empID = 3;

SET SQL_SAFE_UPDATES = 1;




# Calcule o valor da comissão a ser pago para cada funcionário
SELECT empID, ROUND((valor_venda * comissao) / 100, 0) AS valor_comissao
FROM cap08.TB_VENDAS;
+-------+----------------+
| empID | valor_comissao |
+-------+----------------+
|     1 |            600 |
|     1 |            900 |
|     1 |           1250 |
|     2 |            900 |
|     2 |            360 |
|     3 |           1600 |
|     3 |           1920 |
+-------+----------------+
7 rows in set (0.00 sec)



# Qual será o valor pago ao funcionário de empID 1 se a comissão for igual a 15%?
# FUNÇÃO GREATEST retorna o maior valor, ou 15 ou o valor da comissao
SELECT empID, GREATEST(15, comissao) AS comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;
+-------+----------+
| empID | comissao |
+-------+----------+
|     1 |    15.00 |
|     1 |    15.00 |
|     1 |    15.00 |
+-------+----------+
3 rows in set (0.00 sec)



# transformando o atributo sem modificar a tabela
SELECT empID, ROUND((valor_venda * GREATEST(15, comissao)) / 100, 0) AS valor_comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;
+-------+----------------+
| empID | valor_comissao |
+-------+----------------+
|     1 |           1800 |
|     1 |           2700 |
|     1 |           3750 |
+-------+----------------+
3 rows in set (0.00 sec)



# LEAST retorna o menos valor, 2 ou o valor da comissao
# Qual será o valor pago ao funcionário de empID 1 se a comissão for igual a 2%?
SELECT empID, LEAST(2, comissao) AS comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;
+-------+----------+
| empID | comissao |
+-------+----------+
|     1 |     2.00 |
|     1 |     2.00 |
|     1 |     2.00 |
+-------+----------+
3 rows in set (0.00 sec)




SELECT empID, ROUND((valor_venda * LEAST(2, comissao)) / 100, 0) AS valor_comissao
FROM cap08.TB_VENDAS
WHERE empID = 1;
+-------+----------------+
| empID | valor_comissao |
+-------+----------------+
|     1 |            240 |
|     1 |            360 |
|     1 |            500 |
+-------+----------------+
3 rows in set (0.00 sec)




# Vendedores devem ser separados em categorias
# De 3 a 5 de comissão = Categoria 1
# De 5.1 a 7.9 = Categoria 2
# Igual ou acima de 8 = Categoria 3
SELECT 
  empID,
  valor_venda,
  CASE 
   WHEN comissao BETWEEN 2 AND 5 THEN 'Categoria 1'
   WHEN comissao BETWEEN 5.1 AND 7.9 THEN 'Categoria 2'
   WHEN comissao >= 8 THEN 'Categoria 3' 
  END AS 'Categoria'
FROM cap08.TB_VENDAS;
+-------+-------------+-------------+
| empID | valor_venda | Categoria   |
+-------+-------------+-------------+
|     1 |    12000.00 | Categoria 1 |
|     1 |    18000.00 | Categoria 1 |
|     1 |    25000.00 | Categoria 1 |
|     2 |    15000.00 | Categoria 2 |
|     2 |     6000.00 | Categoria 2 |
|     3 |    20000.00 | Categoria 3 |
|     3 |    24000.00 | Categoria 3 |
+-------+-------------+-------------+
7 rows in set (0.00 sec)





# Transformando os dados
CREATE TABLE cap08.TB_ACOES (dia INT, num_vendas INT, valor_acao DECIMAL(10,2));

INSERT INTO cap08.TB_ACOES VALUES 
(1, 32, 0.3),
(1, 4, 70),
(1, 44, 200),
(1, 9, 0.01),
(1, 8, 0.03),
(1, 41, 0.03),
(2, 52, 0.4),
(2, 10, 70),
(2, 53, 200),
(2, 5, 0.01),
(2, 25, 0.55),
(2, 7, 50);



# Vamos separa os dados em 3 categorias.
# Queremos os registros por dia.
# Se o valor_acao for entre 0 e 10 queremos o maior num_vendas desse range e chamaremos de Grupo 1
# Se o valor_acao for entre 10 e 100 queremos o maior num_vendas desse range e chamaremos de Grupo 2
# Se o valor_acao for maior que 100 queremos o maior num_vendas desse range e chamaremos de Grupo 3
SELECT dia,
  MAX(CASE WHEN valor_acao BETWEEN 0 AND 9 THEN num_vendas ELSE 0 END) AS 'Grupo 1',
  MAX(CASE WHEN valor_acao BETWEEN 10 AND 99 THEN num_vendas ELSE 0 END) AS 'Grupo 2',
  MAX(CASE WHEN valor_acao > 100 THEN num_vendas ELSE 0 END) AS 'Grupo 3'
FROM cap08.TB_ACOES
GROUP BY dia;
+------+---------+---------+---------+
| dia  | Grupo 1 | Grupo 2 | Grupo 3 |
+------+---------+---------+---------+
|    1 |      41 |       4 |      44 |
|    2 |      52 |      10 |      53 |
+------+---------+---------+---------+
2 rows in set (0.00 sec)




# Parsing
ALTER TABLE `cap08`.`TB_VENDAS` 
ADD COLUMN `data_venda` DATETIME NULL AFTER `comissao`;

SET SQL_SAFE_UPDATES = 0;

UPDATE cap08.TB_VENDAS 
SET data_venda = '2022-03-15'
WHERE empID = 1;

UPDATE cap08.TB_VENDAS 
SET data_venda = '2022-03-16'
WHERE empID = 2;

UPDATE cap08.TB_VENDAS 
SET data_venda = '2022-03-17'
WHERE empID = 3;

SET SQL_SAFE_UPDATES = 1;

# https://www.w3resource.com/mysql/date-and-time-functions/mysql-date_format-function.php


# FORMATANDO A DATA
SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%d-%b-%y') AS data_venda_p
FROM cap08.TB_VENDAS;
+-------+-------------+----------+---------------------+--------------+
| empID | valor_venda | comissao | data_venda          | data_venda_p |
+-------+-------------+----------+---------------------+--------------+
|     1 |    12000.00 |     5.00 | 2022-03-15 00:00:00 | 15-Mar-22    |
|     1 |    18000.00 |     5.00 | 2022-03-15 00:00:00 | 15-Mar-22    |
|     1 |    25000.00 |     5.00 | 2022-03-15 00:00:00 | 15-Mar-22    |
|     2 |    15000.00 |     6.00 | 2022-03-16 00:00:00 | 16-Mar-22    |
|     2 |     6000.00 |     6.00 | 2022-03-16 00:00:00 | 16-Mar-22    |
|     3 |    20000.00 |     8.00 | 2022-03-17 00:00:00 | 17-Mar-22    |
|     3 |    24000.00 |     8.00 | 2022-03-17 00:00:00 | 17-Mar-22    |
+-------+-------------+----------+---------------------+--------------+
7 rows in set (0.00 sec)



SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%d-%b-%Y') AS data_venda_p
FROM cap08.TB_VENDAS;
+-------+-------------+----------+---------------------+--------------+
| empID | valor_venda | comissao | data_venda          | data_venda_p |
+-------+-------------+----------+---------------------+--------------+
|     1 |    12000.00 |     5.00 | 2022-03-15 00:00:00 | 15-Mar-2022  |
|     1 |    18000.00 |     5.00 | 2022-03-15 00:00:00 | 15-Mar-2022  |
|     1 |    25000.00 |     5.00 | 2022-03-15 00:00:00 | 15-Mar-2022  |
|     2 |    15000.00 |     6.00 | 2022-03-16 00:00:00 | 16-Mar-2022  |
|     2 |     6000.00 |     6.00 | 2022-03-16 00:00:00 | 16-Mar-2022  |
|     3 |    20000.00 |     8.00 | 2022-03-17 00:00:00 | 17-Mar-2022  |
|     3 |    24000.00 |     8.00 | 2022-03-17 00:00:00 | 17-Mar-2022  |
+-------+-------------+----------+---------------------+--------------+
7 rows in set (0.00 sec)



SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y') AS data_venda_p
FROM cap08.TB_VENDAS;
+-------+-------------+----------+---------------------+--------------+
| empID | valor_venda | comissao | data_venda          | data_venda_p |
+-------+-------------+----------+---------------------+--------------+
|     1 |    12000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022 |
|     1 |    18000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022 |
|     1 |    25000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022 |
|     2 |    15000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022 |
|     2 |     6000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022 |
|     3 |    20000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022 |
|     3 |    24000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022 |
+-------+-------------+----------+---------------------+--------------+
7 rows in set (0.00 sec)





SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y-%f') AS data_venda_p
FROM cap08.TB_VENDAS;
+-------+-------------+----------+---------------------+---------------------+
| empID | valor_venda | comissao | data_venda          | data_venda_p        |
+-------+-------------+----------+---------------------+---------------------+
|     1 |    12000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-000000 |
|     1 |    18000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-000000 |
|     1 |    25000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-000000 |
|     2 |    15000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022-000000 |
|     2 |     6000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022-000000 |
|     3 |    20000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022-000000 |
|     3 |    24000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022-000000 |
+-------+-------------+----------+---------------------+---------------------+
7 rows in set (0.00 sec)




SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y-%j') AS data_venda_p
FROM cap08.TB_VENDAS;
+-------+-------------+----------+---------------------+------------------+
| empID | valor_venda | comissao | data_venda          | data_venda_p     |
+-------+-------------+----------+---------------------+------------------+
|     1 |    12000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-074 |
|     1 |    18000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-074 |
|     1 |    25000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-074 |
|     2 |    15000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022-075 |
|     2 |     6000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022-075 |
|     3 |    20000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022-076 |
|     3 |    24000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022-076 |
+-------+-------------+----------+---------------------+------------------+
7 rows in set (0.00 sec)




SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%a-%b-%Y-%u') AS data_venda_p
FROM cap08.TB_VENDAS;
+-------+-------------+----------+---------------------+-----------------+
| empID | valor_venda | comissao | data_venda          | data_venda_p    |
+-------+-------------+----------+---------------------+-----------------+
|     1 |    12000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-11 |
|     1 |    18000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-11 |
|     1 |    25000.00 |     5.00 | 2022-03-15 00:00:00 | Tue-Mar-2022-11 |
|     2 |    15000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022-11 |
|     2 |     6000.00 |     6.00 | 2022-03-16 00:00:00 | Wed-Mar-2022-11 |
|     3 |    20000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022-11 |
|     3 |    24000.00 |     8.00 | 2022-03-17 00:00:00 | Thu-Mar-2022-11 |
+-------+-------------+----------+---------------------+-----------------+
7 rows in set (0.00 sec)




SELECT empID, valor_venda, comissao, data_venda, DATE_FORMAT(data_venda, '%d/%c/%Y') AS data_venda_p
FROM cap08.TB_VENDAS;
+-------+-------------+----------+---------------------+--------------+
| empID | valor_venda | comissao | data_venda          | data_venda_p |
+-------+-------------+----------+---------------------+--------------+
|     1 |    12000.00 |     5.00 | 2022-03-15 00:00:00 | 15/3/2022    |
|     1 |    18000.00 |     5.00 | 2022-03-15 00:00:00 | 15/3/2022    |
|     1 |    25000.00 |     5.00 | 2022-03-15 00:00:00 | 15/3/2022    |
|     2 |    15000.00 |     6.00 | 2022-03-16 00:00:00 | 16/3/2022    |
|     2 |     6000.00 |     6.00 | 2022-03-16 00:00:00 | 16/3/2022    |
|     3 |    20000.00 |     8.00 | 2022-03-17 00:00:00 | 17/3/2022    |
|     3 |    24000.00 |     8.00 | 2022-03-17 00:00:00 | 17/3/2022    |
+-------+-------------+----------+---------------------+--------------+
7 rows in set (0.00 sec)




                                          MAPEAMENTO DE DADOS




# Criando a tabela e inserindo registros

CREATE TABLE cap08.TB_ANIMAIS (
  id INT NOT NULL,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

INSERT INTO cap08.TB_ANIMAIS (id, nome)
VALUES (1, 'Zebra'), (2, 'Elefante'), (3, 'Girafa'), (4, 'Tigre');

CREATE TABLE cap08.TB_ZOOS (
  id INT NOT NULL,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

INSERT INTO cap08.TB_ZOOS (id, nome)
VALUES (1000, 'Zoo do Rio de Janeiro'), (1001, 'Zoo de Recife'), (1002, 'Zoo de Palmas');

CREATE TABLE cap08.TB_MAP_ANIMAL_ZOO (
  id_animal INT NOT NULL,
  id_zoo INT NOT NULL,
  PRIMARY KEY (`id_animal`, `id_zoo`));

INSERT INTO cap08.TB_MAP_ANIMAL_ZOO (id_animal, id_zoo)
VALUES (1, 1001), (1, 1002), (2, 1001), (3, 1000), (4, 1001);




# ALTERNATIVA 1 JOIN
SELECT A.nome AS animal, B.nome AS zoo
FROM cap08.TB_ANIMAIS AS A, cap08.TB_ZOOS AS B, cap08.TB_MAP_ANIMAL_ZOO AS C
WHERE A.id = C.id_animal
AND B.id = C.id_zoo
ORDER BY animal;
+----------+-----------------------+
| animal   | zoo                   |
+----------+-----------------------+
| Elefante | Zoo de Recife         |
| Girafa   | Zoo do Rio de Janeiro |
| Tigre    | Zoo de Recife         |
| Zebra    | Zoo de Recife         |
| Zebra    | Zoo de Palmas         |
+----------+-----------------------+
5 rows in set (0.00 sec)



# ALTERNATIVA 2
SELECT A.nome as animal, B.nome as zoo 
FROM cap08.TB_ANIMAIS AS A, cap08.TB_MAP_ANIMAL_ZOO AS AtoB, cap08.TB_ZOOS AS B
WHERE AtoB.id_animal = A.ID AND B.ID = AtoB.id_zoo 
UNION
SELECT C.nome as Animal, B.nome as Zoo 
FROM cap08.TB_ANIMAIS AS C, cap08.TB_MAP_ANIMAL_ZOO AS CtoB, cap08.TB_ZOOS AS B
WHERE CtoB.id_animal = C.ID AND B.ID = CtoB.id_zoo
ORDER BY animal;
+----------+-----------------------+
| animal   | zoo                   |
+----------+-----------------------+
| Elefante | Zoo de Recife         |
| Girafa   | Zoo do Rio de Janeiro |
| Tigre    | Zoo de Recife         |
| Zebra    | Zoo de Recife         |
| Zebra    | Zoo de Palmas         |
+----------+-----------------------+
5 rows in set (0.00 sec)





INSERT INTO cap08.TB_ANIMAIS (id, nome)
VALUES (5, 'Macaco');



SELECT A.nome AS animal, COALESCE(C.nome, 'Sem Zoo') AS zoo
FROM cap08.TB_ANIMAIS AS A 
LEFT OUTER JOIN (cap08.TB_MAP_ANIMAL_ZOO AS B INNER JOIN cap08.TB_ZOOS AS C ON C.id = B.id_zoo)
ON B.id_animal = A.id
ORDER BY animal;
+----------+-----------------------+
| animal   | zoo                   |
+----------+-----------------------+
| Elefante | Zoo de Recife         |
| Girafa   | Zoo do Rio de Janeiro |
| Macaco   | Sem Zoo               |
| Tigre    | Zoo de Recife         |
| Zebra    | Zoo de Recife         |
| Zebra    | Zoo de Palmas         |
+----------+-----------------------+
6 rows in set (0.00 sec)




                                                FILTRAGEM AGREGAÇÃO E SUMARIZAÇÃO



# Cria a tabela
CREATE TABLE cap08.TB_PIPELINE_VENDAS (
  `Account` text,
  `Opportunity_ID` text,
  `Sales_Agent` text,
  `Deal_Stage` text,
  `Product` text,
  `Created_Date` text,
  `Close_Date` text,
  `Close_Value` text DEFAULT NULL
);

# Carregue o dataset3.csv na tabela anterior a partir do MySQL Workbench

# Cria a tabela
CREATE TABLE cap08.TB_VENDEDORES (
  `Sales_Agent` text,
  `Manager` text,
  `Regional_Office` text,
  `Status` text
);

# Carregue o dataset4.csv na tabela anterior a partir do MySQL Workbench

# 1- Total de vendas
SELECT COUNT(*)
FROM CAP08.TB_PIPELINE_VENDAS;
+----------+
| COUNT(*) |
+----------+
|     1000 |
+----------+
1 row in set (0.00 sec)



# 2- Valor total vendido
SELECT SUM(CAST(CLOSE_VALUE AS UNSIGNED)) AS TOTAL_VENDAS
FROM CAP08.TB_PIPELINE_VENDAS;
+--------------+
| TOTAL_VENDAS |
+--------------+
|      1363333 |
+--------------+
1 row in set, 186 warnings (0.00 sec)



# 3- Número de vendas concluídas com sucesso
SELECT DISTINCT DEAL_STAGE, COUNT(DEAL_STAGE) AS TOTAL
FROM CAP08.TB_PIPELINE_VENDAS
GROUP BY DEAL_STAGE;
+-------------+-------+
| DEAL_STAGE  | TOTAL |
+-------------+-------+
| Won         |   598 |
| In Progress |   186 |
| Lost        |   216 |
+-------------+-------+
3 rows in set (0.00 sec)



# 4- Média do valor das vendas concluídas com sucesso
SELECT DEAL_STAGE, ROUND(AVG(CAST(CLOSE_VALUE AS UNSIGNED)),2) AS MEDIA_TOTAL_VENDAS
FROM CAP08.TB_PIPELINE_VENDAS
WHERE DEAL_STAGE = 'Won';
+------------+--------------------+
| DEAL_STAGE | MEDIA_TOTAL_VENDAS |
+------------+--------------------+
| Won        |            2279.82 |
+------------+--------------------+
1 row in set (0.00 sec)



# 5- Valos máximo vendido
SELECT MAX(CAST(CLOSE_VALUE AS UNSIGNED)) AS VALOR_MAXIMO
FROM CAP08.TB_PIPELINE_VENDAS;
+--------------+
| VALOR_MAXIMO |
+--------------+
|        30288 |
+--------------+
1 row in set, 186 warnings (0.00 sec)



# 6- Valor mínimo vendido entre as vendas concluídas com sucesso
SELECT MIN(CAST(CLOSE_VALUE AS UNSIGNED)) AS VALOR_MINIMO
FROM CAP08.TB_PIPELINE_VENDAS
WHERE DEAL_STAGE = 'Won';
+--------------+
| VALOR_MINIMO |
+--------------+
|           41 |
+--------------+
1 row in set (0.00 sec)



# 7- Valor médio das vendas concluídas com sucesso por agente de vendas
SELECT sales_agent, ROUND(AVG(CAST(close_value AS UNSIGNED)),2) AS valor_medio
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
GROUP BY sales_agent
ORDER BY valor_medio DESC;
+--------------------+-------------+
| sales_agent        | valor_medio |
+--------------------+-------------+
| Rosalina Dieter    |     4596.90 |
| Cecily Lampkin     |     3892.50 |
| Elease Gluck       |     3487.50 |
| James Ascencio     |     3441.52 |
| Donn Cantrell      |     3119.15 |
| Cassey Cress       |     3075.71 |
| Daniell Hammack    |     3063.70 |
| Zane Levy          |     2935.89 |
| Darcel Schlecht    |     2874.65 |
| Boris Faz          |     2835.25 |
| Wilburn Farren     |     2834.50 |
| Corliss Cosme      |     2701.12 |
| Maureen Marcano    |     2546.35 |
| Rosie Papadopoulos |     2543.75 |
| Garret Kinder      |     2443.00 |
| Marty Freudenburg  |     2340.50 |
| Kary Hendrixson    |     2165.64 |
| Vicki Laflamme     |     2112.69 |
| Markita Hansen     |     2101.00 |
| Hayden Neloms      |     2094.36 |
| Gladys Colclough   |     2070.00 |
| Reed Clapper       |     1938.96 |
| Anna Snelling      |     1923.96 |
| Jonathan Berthelot |     1805.41 |
| Kami Bicknell      |     1700.11 |
| Niesha Huffines    |     1433.15 |
| Lajuana Vencill    |     1334.81 |
| Moses Frase        |      919.11 |
| Versie Hillebrand  |      905.29 |
| Violet Mclelland   |      893.30 |
+--------------------+-------------+
30 rows in set (0.00 sec)



# 8- Valor médio das vendas concluídas com sucesso por gerente do agente de vendas
SELECT tbl1.manager, ROUND(AVG(CAST(tbl2.close_value AS UNSIGNED)),2) AS valor_medio
FROM cap08.TB_VENDEDORES AS tbl1
JOIN cap08.TB_PIPELINE_VENDAS AS tbl2 ON (tbl1.sales_agent = tbl2.sales_agent)
WHERE tbl2.deal_stage = "Won"
GROUP BY tbl1.manager;
+------------------+-------------+
| manager          | valor_medio |
+------------------+-------------+
| Dustin Brinkmann |     1481.95 |
| Melvin Marxen    |     2306.89 |
| Summer Sewald    |     2469.79 |
| Celia Rouche     |     2561.47 |
| Cara Losch       |     2150.04 |
| Rocco Neubert    |     2762.90 |
+------------------+-------------+
6 rows in set (0.00 sec)



# 9- Total do valor de fechamento da venda por agente de venda e por conta das vendas concluídas com sucesso
SELECT sales_agent, account, SUM(CAST(close_value AS UNSIGNED)) AS total
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
GROUP BY sales_agent, account
ORDER BY sales_agent, account;
+--------------------+------------------------------+-------+
| sales_agent        | account                      | total |
+--------------------+------------------------------+-------+
| Anna Snelling      | Betatech                     |  5426 |
| Anna Snelling      | Bioholding                   |    53 |
| Anna Snelling      | Cancity                      |    55 |
| Anna Snelling      | Codehow                      |  5087 |
| Anna Snelling      | Condax                       |    52 |
| Zane Levy          | Lexiqvolax                   |  4869 |
| Zane Levy          | Newex                        |  4313 |
| Zane Levy          | Scotfind                     |   598 |
| Zane Levy          | Singletechno                 |  4012 |
| Zane Levy          | Sonron                       |  5743 |
| Zane Levy          | Xx-holding                   |  4818 |
| Zane Levy          | Y-corporation                |  1654 |
+--------------------+------------------------------+-------+
431 rows in set (0.00 sec)



# 10- Número de vendas por agente de venda para as vendas concluídas com sucesso e valor de venda superior a 1000
# Há uma função para filtro chamada FILTER(), mas que não está disponível no MySQL
# https://modern-sql.com/feature/filter

# ! Não funciona no MySQL
SELECT sales_agent,
       COUNT(tbl.close_value) AS total,
       COUNT(tbl.close_value)
FILTER(WHERE tbl.close_value > 1000) AS `Acima de 1000`
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
GROUP BY tbl.sales_agent;

# Solução no MySQL
SELECT sales_agent,
       COUNT(tbl.close_value) AS total
FROM cap08.TB_PIPELINE_VENDAS AS tbl
WHERE tbl.deal_stage = "Won"
AND tbl.close_value > 1000
GROUP BY tbl.sales_agent;
+--------------------+-------+
| sales_agent        | total |
+--------------------+-------+
| Moses Frase        |     4 |
| Darcel Schlecht    |    34 |
| Niesha Huffines    |     8 |
| James Ascencio     |    16 |
| Maureen Marcano    |    17 |
| Hayden Neloms      |    10 |
| Rosalina Dieter    |     5 |
| Zane Levy          |    13 |
| Jonathan Berthelot |     9 |
| Daniell Hammack    |     9 |
| Markita Hansen     |     8 |
| Versie Hillebrand  |     7 |
| Reed Clapper       |    13 |
+--------------------+-------+
30 rows in set (0.00 sec)



# 11- Número de vendas e a média do valor de venda por agente de vendas
SELECT sales_agent,
       COUNT(tbl.close_value) AS contagem,
       ROUND(AVG(CAST(tbl.close_value AS UNSIGNED)),2) AS media
FROM cap08.TB_PIPELINE_VENDAS AS tbl
GROUP BY tbl.sales_agent
ORDER BY contagem DESC;
+--------------------+----------+---------+
| sales_agent        | contagem | media   |
+--------------------+----------+---------+
| Darcel Schlecht    |       70 | 1889.06 |
| Vicki Laflamme     |       63 | 1173.71 |
| Kary Hendrixson    |       61 | 1278.08 |
| Kami Bicknell      |       60 |  793.38 |
| Corliss Cosme      |       44 | 1534.73 |
| Maureen Marcano    |       42 | 1394.43 |
| Rosalina Dieter    |       20 | 2298.45 |
| Garret Kinder      |       20 | 1710.10 |
| Rosie Papadopoulos |       18 | 1130.56 |
| Boris Faz          |       15 | 1512.13 |
| Cecily Lampkin     |       12 | 2595.00 |
| Wilburn Farren     |       11 | 1546.09 |
+--------------------+----------+---------+
30 rows in set, 186 warnings (0.00 sec)



# 12- Quais agentes de vendas tiveram mais de 30 vendas?
SELECT SALES_AGENT,
       COUNT(tbl.close_value) AS num_vendas_sucesso
FROM cap08.TB_PIPELINE_VENDAS AS tbl
GROUP BY tbl.sales_agent
HAVING COUNT(tbl.close_value) > 30;
+--------------------+--------------------+
| SALES_AGENT        | num_vendas_sucesso |
+--------------------+--------------------+
| Darcel Schlecht    |                 70 |
| Zane Levy          |                 37 |
| Anna Snelling      |                 40 |
| Vicki Laflamme     |                 63 |
| Markita Hansen     |                 38 |
| James Ascencio     |                 36 |
| Maureen Marcano    |                 42 |
| Versie Hillebrand  |                 34 |
| Daniell Hammack    |                 32 |
| Violet Mclelland   |                 37 |
| Kami Bicknell      |                 60 |
| Kary Hendrixson    |                 61 |
| Cassey Cress       |                 38 |
| Lajuana Vencill    |                 31 |
| Donn Cantrell      |                 36 |
| Corliss Cosme      |                 44 |
| Jonathan Berthelot |                 32 |
+--------------------+--------------------+
17 rows in set (0.00 sec)



# Cria tabela
CREATE TABLE cap08.TB_CLIENTES_LOC (
  nome_cliente text,
  faturamento double DEFAULT NULL,
  numero_funcionarios int DEFAULT NULL
);


# Carregando dados o dataset5.csv na tabela anterior a partir do MySQL Workbench
CREATE TABLE cap08.TB_CLIENTES_INT (
  nome_cliente text,
  faturamento double DEFAULT NULL,
  numero_funcionarios int DEFAULT NULL,
  localidade_sede text
);

# Carregando dados dataset6.csv na tabela anterior a partir do MySQL Workbench
SELECT * FROM cap08.TB_CLIENTES_LOC;
SELECT * FROM cap08.TB_CLIENTES_INT;


# Retornar todos os clientes e suas localidades. Clientes locais estão nos EUA.
SELECT A.nome_cliente, A.localidade_sede AS localidade_sede
FROM cap08.TB_CLIENTES_INT AS A
UNION
SELECT B.nome_cliente, "USA" AS localidade_sede
FROM cap08.TB_CLIENTES_LOC AS B;
+------------------------------+-----------------+
| nome_cliente                 | localidade_sede |
+------------------------------+-----------------+
| Ganjaflex                    | Japan           |
| Genco Pura Olive Oil Company | Italy           |
| Globex Corporation           | Norway          |
| Betatech                     | Kenya           |
| Bioholding                   | Philipines      |
| Revolution Spanners          | USA             |
| Time Out Electrical          | USA             |
| World Robots                 | USA             |
| Toasters R Us                | USA             |
| Calamity Mixers              | USA             |
| AWOLEX                       | USA             |
| Temp Solutions               | USA             |
+------------------------------+-----------------+
111 rows in set (0.00 sec)



# O cliente 'Ganjaflex' aparece nas duas tabelas de clientes?
SELECT nome_cliente, faturamento, localidade_sede 
FROM cap08.TB_CLIENTES_INT 
WHERE nome_cliente = 'Ganjaflex'
UNION
SELECT nome_cliente, faturamento, 'USA' AS localidade_sede 
FROM cap08.TB_CLIENTES_LOC 
WHERE nome_cliente = 'Ganjaflex'; 
+--------------+-------------+-----------------+
| nome_cliente | faturamento | localidade_sede |
+--------------+-------------+-----------------+
| Ganjaflex    |     5158.71 | Japan           |
| Ganjaflex    |     5158.71 | USA             |
+--------------+-------------+-----------------+
2 rows in set (0.00 sec)



# Quais os clientes internacionais que aparecem na tabela de clientes locais?
SELECT nome_cliente
FROM cap08.TB_CLIENTES_INT
WHERE nome_cliente IN (SELECT nome_cliente FROM cap08.TB_CLIENTES_LOC);
+------------------------------+
| nome_cliente                 |
+------------------------------+
| Ganjaflex                    |
| Genco Pura Olive Oil Company |
| Globex Corporation           |
| Betatech                     |
| Bioholding                   |
| Hottechi                     |
| Streethex                    |
| Sumace                       |
| Zencorporation               |
| Sunnamplex                   |
| Rangreen                     |
| Nam-zim                      |
| Newex                        |
| Mathtouch                    |
+------------------------------+
14 rows in set (0.00 sec)



SELECT nome_cliente
FROM cap08.TB_CLIENTES_INT
WHERE TRIM(nome_cliente) IN (SELECT TRIM(nome_cliente) FROM cap08.TB_CLIENTES_LOC);
+------------------------------+
| nome_cliente                 |
+------------------------------+
| Ganjaflex                    |
| Genco Pura Olive Oil Company |
| Globex Corporation           |
| Betatech                     |
| Bioholding                   |
| Hottechi                     |
| Streethex                    |
| Sumace                       |
| Zencorporation               |
| Sunnamplex                   |
| Rangreen                     |
| Nam-zim                      |
| Newex                        |
| Mathtouch                    |
+------------------------------+
14 rows in set (0.00 sec)



# Qual a média de faturamento por localidade? 
# Os clientes locais estão nos EUA e o resultado deve ser ordenado pela média de faturamento
SELECT ROUND(AVG(A.faturamento),2) AS media_faturamento, A.localidade_sede AS localidade_sede
FROM cap08.TB_CLIENTES_INT AS A
GROUP BY localidade_sede
UNION
SELECT ROUND(AVG(B.faturamento),2) AS media_faturamento, "USA" AS localidade_sede
FROM cap08.TB_CLIENTES_LOC AS B
GROUP BY localidade_sede
ORDER BY media_faturamento;
+-------------------+-----------------+
| media_faturamento | localidade_sede |
+-------------------+-----------------+
|             40.79 | China           |
|            167.89 | Romania         |
|            405.59 | Brazil          |
|            587.34 | Philipines      |
|            647.18 | Kenya           |
|            894.33 | Italy           |
|            894.37 | Poland          |
|           1012.72 | Germany         |
|           1223.72 | Norway          |
|            1376.8 | Belgium         |
|           1824.82 | USA             |
|           2938.67 | Panama          |
|           3027.46 | Jordan          |
|           5158.71 | Japan           |
|           8170.38 | Korea           |
|             22780 | France          |
|            123996 | Switzerland     |
+-------------------+-----------------+
17 rows in set (0.00 sec)



# Use as tabelas TB_PIPELINE_VENDAS e TB_VENDEDORES
# Retorne o total do valor de venda de todos os agentes de vendas e os sub-totais por escritório regional
# Retorne o resultado somente das vendas concluídas com sucesso
SELECT COALESCE(B.regional_office, "Total") AS "Escritório Regional",
       COALESCE(A.sales_agent, "Total") AS "Agente de Vendas",
       SUM(A.close_value) AS Total
FROM cap08.TB_PIPELINE_VENDAS AS A, cap08.TB_VENDEDORES AS B
WHERE A.sales_agent = B.sales_agent
AND A.deal_stage = "Won"
GROUP BY B.regional_office, A.sales_agent WITH ROLLUP;
+---------------------+--------------------+---------+
| Escritório Regional | Agente de Vendas   | Total   |
+---------------------+--------------------+---------+
| Central             | Anna Snelling      |   53871 |
| Central             | Cecily Lampkin     |   31140 |
| Central             | Darcel Schlecht    |  132234 |
| Central             | Gladys Colclough   |   37260 |
| Central             | Jonathan Berthelot |   39719 |
| Central             | Lajuana Vencill    |   28031 |
| Central             | Marty Freudenburg  |   37448 |
| Central             | Moses Frase        |   17463 |
| Central             | Niesha Huffines    |   18631 |
| Central             | Versie Hillebrand  |   28064 |
| Central             | Total              |  423861 |
| East                | Boris Faz          |   22682 |
| East                | Cassey Cress       |   64590 |
| East                | Corliss Cosme      |   67528 |
| East                | Daniell Hammack    |   30637 |
| East                | Donn Cantrell      |   84217 |
| East                | Garret Kinder      |   34202 |
| East                | Reed Clapper       |   46535 |
| East                | Rosie Papadopoulos |   20350 |
| East                | Violet Mclelland   |   17866 |
| East                | Wilburn Farren     |   17007 |
| East                | Total              |  405614 |
| West                | Elease Gluck       |   34875 |
| West                | Hayden Neloms      |   29321 |
| West                | James Ascencio     |   79155 |
| West                | Kami Bicknell      |   47603 |
| West                | Kary Hendrixson    |   77963 |
| West                | Markita Hansen     |   33616 |
| West                | Maureen Marcano    |   58566 |
| West                | Rosalina Dieter    |   45969 |
| West                | Vicki Laflamme     |   73944 |
| West                | Zane Levy          |   52846 |
| West                | Total              |  533858 |
| Total               | Total              | 1363333 |
+---------------------+--------------------+---------+
34 rows in set (0.00 sec)



# Use as tabelas TB_PIPELINE_VENDAS e TB_VENDEDORES
# Retorne o gerente, o escritório regional, o cliente, o número de vendas e os sub-totais do número de vendas 
# Faça isso apenas para as vendas concluídas com sucesso
SELECT COALESCE(A.manager, "Total") AS Gerente,
       COALESCE(A.regional_office, "Total") AS "Escritório Regional",
       COALESCE(B.account, "Total") AS Cliente,
       COUNT(B.close_value) AS numero_vendas
FROM cap08.TB_VENDEDORES AS A, cap08.TB_PIPELINE_VENDAS AS B
WHERE (B.sales_agent = A.sales_agent)
AND deal_stage = "Won"
GROUP BY A.manager, A.regional_office, B.account WITH ROLLUP;
+------------------+---------------------+------------------------------+---------------+
| Gerente          | Escritório Regional | Cliente                      | numero_vendas |
+------------------+---------------------+------------------------------+---------------+
| Cara Losch       | East                | Acme Corporation             |             1 |
| Cara Losch       | East                | Betasoloin                   |             5 |
| Cara Losch       | East                | Bioplex                      |             3 |
| Cara Losch       | East                | Bubba Gump                   |             2 |
| Cara Losch       | East                | Condax                       |             3 |
| Cara Losch       | East                | Donquadtech                  |             2 |
| Summer Sewald    | West                | Y-corporation                |             5 |
| Summer Sewald    | West                | Zoomit                       |             1 |
| Summer Sewald    | West                | Total                        |           128 |
| Summer Sewald    | Total               | Total                        |           128 |
| Total            | Total               | Total                        |           598 |
+------------------+---------------------+------------------------------+---------------+
181 rows in set (0.00 sec)




# Use as tabelas TB_PIPELINE_VENDAS e TB_VENDEDORES
# Retorne o gerente, o escritório regional, o cliente, o número de vendas e os sub-totais do número de vendas 
# Faça isso apenas para as vendas concluídas com sucesso
# Use CTE
WITH temp_table AS 
(
SELECT A.manager,
       A.regional_office,
       B.account,
       B.deal_stage
FROM cap08.TB_VENDEDORES AS A, cap08.TB_PIPELINE_VENDAS AS B
WHERE (B.sales_agent = A.sales_agent)
)
SELECT COALESCE(manager, "Total") AS Gerente, 
       COALESCE(regional_office, "Total") AS "Escritório Regional",
       COALESCE(account, "Total") AS Cliente,
       COUNT(*) AS numero_vendas
FROM temp_table
WHERE deal_stage = "Won"
GROUP BY manager, regional_office, account WITH ROLLUP;
+------------------+---------------------+------------------------------+---------------+
| Gerente          | Escritório Regional | Cliente                      | numero_vendas |
+------------------+---------------------+------------------------------+---------------+
| Cara Losch       | East                | Acme Corporation             |             1 |
| Cara Losch       | East                | Betasoloin                   |             5 |
| Cara Losch       | East                | Bioplex                      |             3 |
| Cara Losch       | East                | Bubba Gump                   |             2 |
| Cara Losch       | East                | Condax                       |             3 |
| Summer Sewald    | West                | Y-corporation                |             5 |
| Summer Sewald    | West                | Zoomit                       |             1 |
| Summer Sewald    | West                | Total                        |           128 |
| Summer Sewald    | Total               | Total                        |           128 |
| Total            | Total               | Total                        |           598 |
+------------------+---------------------+------------------------------+---------------+
181 rows in set (0.00 sec)
