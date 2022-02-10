Limpeza e Processamento de Dados com SQL



Principais Técnicas de Limpeza de Dados

1- Tratamento de Valores Ausentes
2- Detecção e Filtragem de Outliers (Valores Extremos)
3- Detecção e Remoção de Registros Duplicados
4- Correção de Erros Estruturais (Reorganização dos Dados)

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


								TRATAMENTO DE VALORES AUSENTES



Verificando os valores distintos da variável Resolution
Conseguimos identificar que existe um campo que está vazio
SELECT DISTINCT Resolution
FROM cap08.TB_INCIDENTES;
+----------------+
| Resolution     |
+----------------+
|                |
| LOCATED        |
| ARREST, BOOKED |
| UNFOUNDED      |
| ARREST, CITED  |
| NOT PROSECUTED |
+----------------+
6 rows in set (0.00 sec)


Verificando a quantidade de registros por categoria da variável Resolution
existem 717 registros vazios, neste caso podemos excluir a variável resolution
ou tentar realizar algum tipo de imputação
SELECT Resolution, COUNT(*) AS total
FROM cap08.TB_INCIDENTES
GROUP BY Resolution;
+----------------+-------+
| Resolution     | total |
+----------------+-------+
|                |   717 |
| LOCATED        |     1 |
| ARREST, BOOKED |   272 |
| UNFOUNDED      |     7 |
| ARREST, CITED  |     2 |
| NOT PROSECUTED |     1 |
+----------------+-------+
6 rows in set (0.00 sec)



há uma diferença entre NULO e vazio, por isto deu 0 registros NULOS
SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE Resolution IS NULL;
+----------+
| COUNT(*) |
+----------+
|        0 |
+----------+
1 row in set (0.00 sec)



O empty também é chamado de blank.
A principal diferença entre nulo e vazio é que o nulo é usado para se referir a nada, enquanto o vazio é usado para 
se referir a uma string única com comprimento zero.
SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE Resolution = '';
+----------+
| COUNT(*) |
+----------+
|      717 |
+----------+
1 row in set (0.00 sec)



A query abaixo converte o vazio para NULO
SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE NULLIF(Resolution, '') IS NULL;
+----------+
| COUNT(*) |
+----------+
|      717 |
+----------+
1 row in set (0.00 sec)



A função TRIM remove os espaços do lado direito e esquerdo da STRING
SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES
WHERE TRIM(COALESCE(Resolution, '')) = '';
+----------+
| COUNT(*) |
+----------+
|      717 |
+----------+
1 row in set (0.00 sec)



LTRIM remove os espaços da esquerda, o RTRIM remove os espaços da direita, e o LENGTH calcula o comprimento
SELECT COUNT(*) 
FROM cap08.TB_INCIDENTES 
WHERE LENGTH(RTRIM(LTRIM(Resolution))) = 0;
+----------+
| COUNT(*) |
+----------+
|      717 |
+----------+
1 row in set (0.00 sec)



Resolvendo o problema trocando o valor ausente por OTHER(outro)
Essa solução não altera a tabela, e sim a o resultado da query
SELECT 
    CASE 
     WHEN Resolution = '' THEN 'OTHER'
     ELSE Resolution
    END AS Resolution
FROM cap08.TB_INCIDENTES
LIMIT 10;
+----------------+
| Resolution     |
+----------------+
| OTHER          |
| OTHER          |
| OTHER          |
| OTHER          |
| LOCATED        |
| OTHER          |
| OTHER          |
| ARREST, BOOKED |
| OTHER          |
| OTHER          |
+----------------+
10 rows in set (0.00 sec)



Desativado o update de segurança da tabela, para podermos alterar os registros na própria tabela
SET SQL_SAFE_UPDATES = 0;

Essa solução atualiza a tabela, alterando na fonte aonde a variável resolution estive vazia ser trocado por OTHER
UPDATE cap08.TB_INCIDENTES
SET Resolution = 'OTHER'
WHERE Resolution = '';
Query OK, 717 rows affected (0.03 sec)
Rows matched: 717  Changed: 717  Warnings: 0

# Retornando a trava de segurança de update da tabela.
SET SQL_SAFE_UPDATES = 1;




								DETECÇÃO E TRATAMENTO DE VALORES OUTLIERS



# Cria a tabela
CREATE TABLE cap08.TB_CRIANCAS(nome varchar(20), idade int, peso float);

# Insere os dados
INSERT INTO cap08.TB_CRIANCAS 
VALUES ('Bob', 3, 15), ('Maria', 42, 98), ('Julia', 3, 16), ('Maximiliano', 2, 12), ('Roberto', 1, 11), ('Jamil', 2, 14), ('Alberto', 3, 17);

SELECT * FROM cap08.TB_CRIANCAS;
+-------------+-------+------+
| nome        | idade | peso |
+-------------+-------+------+
| Bob         |     3 |   15 |
| Maria       |    42 |   98 |
| Julia       |     3 |   16 |
| Maximiliano |     2 |   12 |
| Roberto     |     1 |   11 |
| Jamil       |     2 |   14 |
| Alberto     |     3 |   17 |
+-------------+-------+------+
7 rows in set (0.00 sec)



# Calculando a MÉDIA com a função AVG e calculando o devio padrão com a função STDDEV
SELECT AVG(idade) AS media_idade, STDDEV(idade) AS desvio_padrao_idade
FROM cap08.TB_CRIANCAS;
+-------------+---------------------+
| media_idade | desvio_padrao_idade |
+-------------+---------------------+
|      8.0000 |  13.897584579446068 |
+-------------+---------------------+
1 row in set (0.00 sec)


# Calculando a média e o desvio padrão com filtro, desconsiderando o Outlier, veja como muda significativamente
# os valores
SELECT AVG(idade) AS media_idade, STDDEV(idade) AS desvio_padrao_idade 
FROM cap08.TB_CRIANCAS 
WHERE idade < 5;
+-------------+---------------------+
| media_idade | desvio_padrao_idade |
+-------------+---------------------+
|      2.3333 |  0.7453559924999298 |
+-------------+---------------------+
1 row in set (0.00 sec)



# Calculando a MÉDIA com a função AVG e calculando o devio padrão com a função STDDEV
SELECT AVG(peso) AS media_peso, STDDEV(peso) AS desvio_padrao_peso
FROM cap08.TB_CRIANCAS;
+--------------------+--------------------+
| media_peso         | desvio_padrao_peso |
+--------------------+--------------------+
| 26.142857142857142 | 29.400819091741408 |
+--------------------+--------------------+
1 row in set (0.00 sec)



# Calculando a média e o desvio padrão com filtro, desconsiderando o Outlier, veja como muda significativamente
# os valores
SELECT AVG(peso) AS media_peso, STDDEV(peso) AS desvio_padrao_peso 
FROM cap08.TB_CRIANCAS 
WHERE idade < 5;
+--------------------+--------------------+
| media_peso         | desvio_padrao_peso |
+--------------------+--------------------+
| 14.166666666666666 | 2.1147629234082537 |
+--------------------+--------------------+
1 row in set (0.00 sec)



SELECT * FROM cap08.TB_CRIANCAS ORDER BY idade;
+-------------+-------+------+
| nome        | idade | peso |
+-------------+-------+------+
| Roberto     |     1 |   11 |
| Maximiliano |     2 |   12 |
| Jamil       |     2 |   14 |
| Bob         |     3 |   15 |
| Julia       |     3 |   16 |
| Alberto     |     3 |   17 |
| Maria       |    42 |   98 |
+-------------+-------+------+
7 rows in set (0.00 sec)



# Calcula a mediana da variável idade
# Rowindex é o indice de cada linha
# Realizando programação em SQL para descobrir o valor da mediana
SET @rowindex := -1;
 
SELECT
   AVG(idade) AS mediana 
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex, cap08.TB_CRIANCAS.idade AS idade
    FROM cap08.TB_CRIANCAS
    ORDER BY cap08.TB_CRIANCAS.idade) AS d
WHERE d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));
+---------+
| mediana |
+---------+
|  3.0000 |
+---------+
1 row in set, 1 warning (0.00 sec)



SELECT * FROM cap08.TB_CRIANCAS ORDER BY peso;
+-------------+-------+------+
| nome        | idade | peso |
+-------------+-------+------+
| Roberto     |     1 |   11 |
| Maximiliano |     2 |   12 |
| Jamil       |     2 |   14 |
| Bob         |     3 |   15 |
| Julia       |     3 |   16 |
| Alberto     |     3 |   17 |
| Maria       |    42 |   98 |
+-------------+-------+------+
7 rows in set (0.00 sec)


# Calcula a mediana da variável peso
SET @rowindex := -1;
 
SELECT
   AVG(peso) AS mediana 
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex, cap08.TB_CRIANCAS.peso AS peso
    FROM cap08.TB_CRIANCAS
    ORDER BY cap08.TB_CRIANCAS.peso) AS d
WHERE d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));
+---------+
| mediana |
+---------+
|      15 |
+---------+
1 row in set, 1 warning (0.00 sec)



# Resolve o problema do outlier com imputação da mediana
SET SQL_SAFE_UPDATES = 0;
Query OK, 0 rows affected (0.00 sec)


UPDATE cap08.TB_CRIANCAS
SET idade = 3
WHERE idade = 42;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0


UPDATE cap08.TB_CRIANCAS
SET peso = 15
WHERE peso = 98;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0


SET SQL_SAFE_UPDATES = 1;
Query OK, 0 rows affected (0.00 sec)


SELECT AVG(idade) AS media_idade, STDDEV(idade) AS desvio_padrao_idade
FROM cap08.TB_CRIANCAS;
+-------------+---------------------+
| media_idade | desvio_padrao_idade |
+-------------+---------------------+
|      2.4286 |  0.7284313590846836 |
+-------------+---------------------+
1 row in set (0.00 sec)



SELECT AVG(peso) AS media_peso, STDDEV(peso) AS desvio_padrao_peso
FROM cap08.TB_CRIANCAS;
+--------------------+--------------------+
| media_peso         | desvio_padrao_peso |
+--------------------+--------------------+
| 14.285714285714286 |  1.979486637221574 |
+--------------------+--------------------+
1 row in set (0.00 sec)


	


										DETECÇÃO DE REMOÇÃO DE REGISTROS DUPLICADOS





# Script 03

# Cria a tabela
CREATE TABLE cap08.TB_INCIDENTES_DUP (
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

# Carregue o dataset2.csv via MySQL Workbench

SELECT PdId, Category
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category
LIMIT 10;
+----------------+----------------+
| PdId           | Category       |
+----------------+----------------+
|  3114751606302 | LARCENY/THEFT  |
|  5069701104134 | ASSAULT        |
|  6074729204104 | ASSAULT        |
|  7103536315201 | ASSAULT        |
| 11082415274000 | MISSING PERSON |
|  4037801104134 | ASSAULT        |
|  4147669007025 | VEHICLE THEFT  |
| 16010127305073 | BURGLARY       |
| 17004924306243 | LARCENY/THEFT  |
| 16065828006244 | LARCENY/THEFT  |
+----------------+----------------+
10 rows in set (0.00 sec)



# Buscando valores duplicados
SELECT PdId, Category, COUNT(*)
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category
LIMIT 10;
+----------------+----------------+----------+
| PdId           | Category       | COUNT(*) |
+----------------+----------------+----------+
|  3114751606302 | LARCENY/THEFT  |        1 |
|  5069701104134 | ASSAULT        |        1 |
|  6074729204104 | ASSAULT        |        1 |
|  7103536315201 | ASSAULT        |        1 |
| 11082415274000 | MISSING PERSON |        2 |
|  4037801104134 | ASSAULT        |        2 |
|  4147669007025 | VEHICLE THEFT  |        2 |
| 16010127305073 | BURGLARY       |        2 |
| 17004924306243 | LARCENY/THEFT  |        2 |
| 16065828006244 | LARCENY/THEFT  |        2 |
+----------------+----------------+----------+
10 rows in set (0.00 sec)




SELECT *
FROM cap08.TB_INCIDENTES_DUP
WHERE PdId = 11082415274000;
11082415274000	110824152	74000	MISSING PERSON	MISSING ADULT	Saturday	09/24/2011	11:00	TARAVAL	LOCATED
11082415274000	110824152	74000	MISSING PERSON	MISSING ADULT	Saturday	09/24/2011	11:00	TARAVAL	LOCATED



# Identificando os registros duplicados (e retornando uma linha para duplicidade)
SELECT PdId, Category, COUNT(*) AS numero
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category
HAVING numero > 1;
+----------------+----------------+--------+
| PdId           | Category       | numero |
+----------------+----------------+--------+
| 11082415274000 | MISSING PERSON |      2 |
|  4037801104134 | ASSAULT        |      2 |
|  4147669007025 | VEHICLE THEFT  |      2 |
| 16010127305073 | BURGLARY       |      2 |
| 17004924306243 | LARCENY/THEFT  |      2 |
| 16065828006244 | LARCENY/THEFT  |      2 |
| 17601600606372 | LARCENY/THEFT  |      2 |
| 16101765507026 | VEHICLE THEFT  |      2 |
| 17002873603474 | ROBBERY        |      2 |
| 16042274064020 | NON-CRIMINAL   |      2 |
+----------------+----------------+--------+
10 rows in set (0.00 sec)



# Identificando os registros duplicados (e retornando cada linha em duplicidade)
SELECT PdId, Category
FROM cap08.TB_INCIDENTES_DUP
WHERE PdId in (SELECT PdId FROM cap08.TB_INCIDENTES_DUP GROUP BY PdId HAVING COUNT(*) > 1)
ORDER BY PdId;
+----------------+----------------+
| PdId           | Category       |
+----------------+----------------+
|  4037801104134 | ASSAULT        |
|  4037801104134 | ASSAULT        |
|  4147669007025 | VEHICLE THEFT  |
|  4147669007025 | VEHICLE THEFT  |
| 11082415274000 | MISSING PERSON |
| 11082415274000 | MISSING PERSON |
| 16010127305073 | BURGLARY       |
| 16010127305073 | BURGLARY       |
| 16042274064020 | NON-CRIMINAL   |
| 16042274064020 | NON-CRIMINAL   |
| 16065828006244 | LARCENY/THEFT  |
| 16065828006244 | LARCENY/THEFT  |
| 16101765507026 | VEHICLE THEFT  |
| 16101765507026 | VEHICLE THEFT  |
| 17002873603474 | ROBBERY        |
| 17002873603474 | ROBBERY        |
| 17004924306243 | LARCENY/THEFT  |
| 17004924306243 | LARCENY/THEFT  |
| 17601600606372 | LARCENY/THEFT  |
| 17601600606372 | LARCENY/THEFT  |
+----------------+----------------+
20 rows in set (0.00 sec)



# Identificando os registros duplicados (e retornando uma linha para duplicidade) com função window
SELECT *
FROM (
 SELECT primeiro_resultado.*,      
        ROW_NUMBER() OVER (PARTITION BY PdId, Category ORDER BY PdId) AS numero
 FROM cap08.TB_INCIDENTES_DUP AS primeiro_resultado) AS segundo_resultado
WHERE numero > 1;
4037801104134	040378011	04134	ASSAULT	BATTERY	Friday	12/12/2003	12:00	SOUTHERN
4147669007025	041476690	07025	VEHICLE THEFT	STOLEN TRUCK	Thursday	12/30/2004	19:00	BAYVIEW
11082415274000	110824152	74000	MISSING PERSON	MISSING ADULT	Saturday	09/24/2011	11:00	TARAVAL
16010127305073	160101273	05073	BURGLARY	BURGLARY, UNLAWFUL ENTRY	Wednesday	02/03/2016	20:30	MISSION
16042274064020	160422740	64020	NON-CRIMINAL	AIDED CASE, MENTAL DISTURBED	Tuesday	05/24/2016	00:11	MISSION
16065828006244	160658280	06244	LARCENY/THEFT	GRAND THEFT FROM LOCKED AUTO	Sunday	08/14/2016	21:00	TARAVAL
16101765507026	161017655	07026	VEHICLE THEFT	STOLEN MISCELLANEOUS VEHICLE	Wednesday	12/14/2016	23:00	BAYVIEW
17002873603474	170028736	03474	ROBBERY	ATTEMPTED ROBBERY WITH BODILY FORCE	Wednesday	01/11/2017	14:30	INGLESIDE
17004924306243	170049243	06243	LARCENY/THEFT	PETTY THEFT FROM LOCKED AUTO	Wednesday	01/18/2017	18:20	TARAVAL
17601600606372	176016006	06372	LARCENY/THEFT	PETTY THEFT OF PROPERTY	Monday	01/16/2017	14:35	NORTHERN



# Identificando os registros duplicados com CTE
WITH cte_table
AS
(
 SELECT PdId, Category, ROW_NUMBER() over(PARTITION BY PdId, Category ORDER BY PdId) AS contagem 
 FROM cap08.TB_INCIDENTES_DUP
)
SELECT * FROM cte_table WHERE contagem > 1
+----------------+----------------+----------+
| PdId           | Category       | contagem |
+----------------+----------------+----------+
|  4037801104134 | ASSAULT        |        2 |
|  4147669007025 | VEHICLE THEFT  |        2 |
| 11082415274000 | MISSING PERSON |        2 |
| 16010127305073 | BURGLARY       |        2 |
| 16042274064020 | NON-CRIMINAL   |        2 |
| 16065828006244 | LARCENY/THEFT  |        2 |
| 16101765507026 | VEHICLE THEFT  |        2 |
| 17002873603474 | ROBBERY        |        2 |
| 17004924306243 | LARCENY/THEFT  |        2 |
| 17601600606372 | LARCENY/THEFT  |        2 |
+----------------+----------------+----------+
10 rows in set (0.00 sec)



# Deletando os registros duplicados com CTE
SET SQL_SAFE_UPDATES = 0;
Query OK, 0 rows affected (0.00 sec)



WITH cte_table
AS
(
 SELECT PdId, Category, ROW_NUMBER() over(PARTITION BY PdId, Category ORDER BY PdId) AS contagem 
 FROM cap08.TB_INCIDENTES_DUP
)
DELETE FROM cap08.TB_INCIDENTES_DUP 
USING cap08.TB_INCIDENTES_DUP 
JOIN cte_table ON cap08.TB_INCIDENTES_DUP.PdId = cte_table.PdId
WHERE cte_table.contagem > 1; 
Query OK, 20 rows affected (0.01 sec)




SET SQL_SAFE_UPDATES = 1;
Query OK, 0 rows affected (0.00 sec)



#verificando se os registros duplicados foram removidos
SELECT PdId, Category, COUNT(*) AS numero
FROM cap08.TB_INCIDENTES_DUP
GROUP BY PdId, Category
HAVING numero > 1;
Empty set (0.00 sec)



# Deletando os registros duplicados com subquery
SET SQL_SAFE_UPDATES = 0;

DELETE FROM cap08.TB_INCIDENTES_DUP
WHERE 
    PdId IN (
    SELECT PdId 
    FROM (
        SELECT                         
            PdId, ROW_NUMBER() OVER (PARTITION BY PdId, Category ORDER BY PdId) AS row_num
        FROM cap08.TB_INCIDENTES_DUP) alias
    WHERE row_num > 1
);
Query OK, 20 rows affected (0.01 sec)



# Cria a tabela
CREATE TABLE cap08.TB_ALUNOS (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL
);

# Insere os dados
INSERT INTO cap08.TB_ALUNOS (nome, sobrenome, email) 
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net'),
       ('Jean','King','jean.king@me.com'),
       ('Peter','Ferguson','peter.ferguson@google.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com'),
       ('Julie','Murphy','julie.murphy@yahoo.com'),
       ('Kwai','Lee','kwai.lee@google.com'),
       ('Jean','King','jean.king@me.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com');

SELECT * FROM cap08.TB_ALUNOS
ORDER BY email;
+----+----------+-----------------+---------------------------------+
| id | nome     | sobrenome       | email                           |
+----+----------+-----------------+---------------------------------+
|  1 | Carine   | Schmitt         | carine.schmitt@verizon.net      |
|  4 | Janine   | Labrune         | janine.labrune@aol.com          |
|  6 | Janine   | Labrune         | janine.labrune@aol.com          |
|  2 | Jean     | King            | jean.king@me.com                |
| 12 | Jean     | King            | jean.king@me.com                |
|  5 | Jonas    | Bergulfsen      | jonas.bergulfsen@mac.com        |
| 10 | Julie    | Murphy          | julie.murphy@yahoo.com          |
| 11 | Kwai     | Lee             | kwai.lee@google.com             |
|  3 | Peter    | Ferguson        | peter.ferguson@google.com       |
|  9 | Roland   | Keitel          | roland.keitel@yahoo.com         |
| 14 | Roland   | Keitel          | roland.keitel@yahoo.com         |
|  7 | Susan    | Nelson          | susan.nelson@comcast.net        |
| 13 | Susan    | Nelson          | susan.nelson@comcast.net        |
|  8 | Zbyszek  | Piestrzeniewicz | zbyszek.piestrzeniewicz@att.net |
+----+----------+-----------------+---------------------------------+
14 rows in set (0.00 sec)




SELECT email, COUNT(email) AS contagem
FROM cap08.TB_ALUNOS
GROUP BY email
HAVING contagem > 1;
+--------------------------+----------+
| email                    | contagem |
+--------------------------+----------+
| jean.king@me.com         |        2 |
| janine.labrune@aol.com   |        2 |
| susan.nelson@comcast.net |        2 |
| roland.keitel@yahoo.com  |        2 |
+--------------------------+----------+
4 rows in set (0.00 sec)



    
SET SQL_SAFE_UPDATES = 0;
Query OK, 0 rows affected (0.00 sec)



USE cap08;
DELETE n1 
FROM TB_ALUNOS n1, TB_ALUNOS n2 
WHERE n1.id > n2.id 
AND n1.email = n2.email
Query OK, 4 rows affected (0.01 sec)


SET SQL_SAFE_UPDATES = 1;
Query OK, 0 rows affected (0.00 sec)


SELECT email, COUNT(email) AS contagem
FROM cap08.TB_ALUNOS
GROUP BY email
HAVING contagem > 1;
Empty set (0.00 sec)




               
                                    REORGANIZAÇÃO DOS DADOS E PIVOT TABLE COM SQL




# Script 04

# Este script trata da transformação dos dados de uma tabela, de linhas em colunas. 
# Essa transformação é chamada de tabelas dinâmicas (ou pivot table). 
# Frequentemente, o resultado do pivô é uma tabela de resumo na qual os dados estatísticos são apresentados na forma adequada 
# ou exigida para um relatório.

# Exemplo 1
CREATE TABLE cap08.TB_GESTORES( id INT, colID INT, nome CHAR(20) );



INSERT INTO cap08.TB_GESTORES VALUES
  (1, 1, 'Bob'),
  (1, 2, 'Silva'),
  (1, 3, 'Office Manager'),
  (2, 1, 'Mary'),
  (2, 2, 'Luz'),
  (2, 3, 'Vice Presidente');




# Veja que a tabela foi desenhada de forma incorreta, pois fica muito dificil de analisar os dados dessa forma
# o id aparece muitas vezes algo desnecessário, iremos transformar essa tabela, para que fique de forma mais organizada
SELECT * FROM cap08.tb_gestores;
+------+-------+-----------------+
| id   | colID | nome            |
+------+-------+-----------------+
|    1 |     1 | Bob             |
|    1 |     2 | Silva           |
|    1 |     3 | Office Manager  |
|    2 |     1 | Mary            |
|    2 |     2 | Luz             |
|    2 |     3 | Vice Presidente |
+------+-------+-----------------+
6 rows in set (0.00 sec)



# Transformando a tabela - DEPOIS
SELECT 
  id, 
  GROUP_CONCAT( if(colID = 1, nome, NULL) ) AS 'nome',
  GROUP_CONCAT( if(colID = 2, nome, NULL) ) AS 'sobrenome',
  GROUP_CONCAT( if(colID = 3, nome, NULL) ) AS 'titulo'
FROM cap08.TB_GESTORES
GROUP BY id;
+------+------+-----------+-----------------+
| id   | nome | sobrenome | titulo          |
+------+------+-----------+-----------------+
|    1 | Bob  | Silva     | Office Manager  |
|    2 | Mary | Luz       | Vice Presidente |
+------+------+-----------+-----------------+
2 rows in set (0.00 sec)





# Exemplo 2
CREATE TABLE cap08.TB_RECURSOS ( emp varchar(8), recurso varchar(8), quantidade int );

INSERT INTO cap08.TB_RECURSOS VALUES
  ('Mary', 'email', 5),
  ('Bob', 'email', 7),
  ('Juca', 'print', 2),
  ('Mary', 'sms', 14),
  ('Bob', 'sms', 2);



# Verificando a tabela
mysql> SELECT * FROM cap08.tb_recursos;
+------+---------+------------+
| emp  | recurso | quantidade |
+------+---------+------------+
| Mary | email   |          5 |
| Bob  | email   |          7 |
| Juca | print   |          2 |
| Mary | sms     |         14 |
| Bob  | sms     |          2 |
+------+---------+------------+
5 rows in set (0.00 sec)



# Reorganizando os dados
SELECT 
  emp,
  SUM( if(recurso = 'email', quantidade, 0) ) AS 'emails',
  SUM( if(recurso = 'print', quantidade, 0) ) AS 'printings',
  SUM( if(recurso = 'sms', quantidade, 0) )   AS 'sms msgs'
FROM cap08.TB_RECURSOS
GROUP BY emp;
+------+--------+-----------+----------+
| emp  | emails | printings | sms msgs |
+------+--------+-----------+----------+
| Mary |      5 |         0 |       14 |
| Bob  |      7 |         0 |        2 |
| Juca |      0 |         2 |        0 |
+------+--------+-----------+----------+
3 rows in set (0.00 sec)



# Outra forma de organizar a tabela é com o CONCAT, o resultado é ligeiramente diferente
# foi os falores ficam com ,
SELECT 
  emp,
  GROUP_CONCAT( if(recurso = 'email', quantidade, 0) ) AS 'emails',
  GROUP_CONCAT( if(recurso = 'print', quantidade, 0) ) AS 'printings',
  GROUP_CONCAT( if(recurso = 'sms', quantidade, 0) )   AS 'sms msgs'
FROM cap08.TB_RECURSOS
GROUP BY emp;
+------+--------+-----------+----------+
| emp  | emails | printings | sms msgs |
+------+--------+-----------+----------+
| Bob  | 7,0    | 0,0       | 0,2      |
| Juca | 0      | 2         | 0        |
| Mary | 5,0    | 0,0       | 0,14     |
+------+--------+-----------+----------+
3 rows in set (0.00 sec)




# Exemplo 3
CREATE TABLE cap08.TB_VENDAS (empID INT, ano SMALLINT, valor_venda DECIMAL(10,2));

INSERT cap08.TB_VENDAS VALUES
(1, 2020, 12000),
(1, 2021, 18000),
(1, 2022, 25000),
(2, 2021, 15000),
(2, 2022, 6000),
(3, 2021, 20000),
(3, 2022, 24000);



# dados desorganizados
mysql> SELECT * FROM cap08.tb_vendas;
+-------+------+-------------+
| empID | ano  | valor_venda |
+-------+------+-------------+
|     1 | 2020 |    12000.00 |
|     1 | 2021 |    18000.00 |
|     1 | 2022 |    25000.00 |
|     2 | 2021 |    15000.00 |
|     2 | 2022 |     6000.00 |
|     3 | 2021 |    20000.00 |
|     3 | 2022 |    24000.00 |
+-------+------+-------------+
7 rows in set (0.00 sec)




# Organizando os dados com totais
SELECT                                
    COALESCE(EmpID, 'Total') AS EmpID,
    SUM( IF(ano = 2020, valor_venda, 0) ) As '2020',
    SUM( IF(ano = 2021, valor_venda, 0) ) As '2021',
    SUM( IF(ano = 2022, valor_venda, 0) ) As '2022'
FROM cap08.TB_VENDAS
GROUP BY EmpID WITH ROLLUP;
+-------+----------+----------+----------+
| EmpID | 2020     | 2021     | 2022     |
+-------+----------+----------+----------+
| 1     | 12000.00 | 18000.00 | 25000.00 |
| 2     |     0.00 | 15000.00 |  6000.00 |
| 3     |     0.00 | 20000.00 | 24000.00 |
| Total | 12000.00 | 53000.00 | 55000.00 |
+-------+----------+----------+----------+
4 rows in set, 1 warning (0.00 sec)



# Exemplo 4
CREATE TABLE cap08.TB_PEDIDOS (
  id_pedido INT NOT NULL,
  id_funcionario INT NOT NULL,
  id_fornecedor INT NOT NULL,
  PRIMARY KEY (id_pedido)
);

INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (1, 258, 1580);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (2, 254, 1496);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (3, 257, 1494);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (4, 261, 1650);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (5, 251, 1654);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (6, 253, 1664);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (7, 255, 1678);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (8, 256, 1616);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (9, 259, 1492);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (10, 250, 1602);
INSERT cap08.TB_PEDIDOS(id_pedido, id_funcionario, id_fornecedor) VALUES (11, 258, 1540);



mysql> SELECT * FROM cap08.tb_pedidos;
+-----------+----------------+---------------+
| id_pedido | id_funcionario | id_fornecedor |
+-----------+----------------+---------------+
|         1 |            258 |          1580 |
|         2 |            254 |          1496 |
|         3 |            257 |          1494 |
|         4 |            261 |          1650 |
|         5 |            251 |          1654 |
|         6 |            253 |          1664 |
|         7 |            255 |          1678 |
|         8 |            256 |          1616 |
|         9 |            259 |          1492 |
|        10 |            250 |          1602 |
|        11 |            258 |          1540 |
+-----------+----------------+---------------+
11 rows in set (0.00 sec)



# Tabela cruzada
SELECT
  id_fornecedor,
  COUNT(IF(id_funcionario = 250, id_pedido, NULL)) AS Emp250,
  COUNT(IF(id_funcionario = 251, id_pedido, NULL)) AS Emp251,
  COUNT(IF(id_funcionario = 252, id_pedido, NULL)) AS Emp252,
  COUNT(IF(id_funcionario = 253, id_pedido, NULL)) AS Emp253,
  COUNT(IF(id_funcionario = 254, id_pedido, NULL)) AS Emp254
FROM
  cap08.TB_PEDIDOS p
WHERE
  p.id_funcionario BETWEEN 250 AND 254
GROUP BY
  id_fornecedor;
+---------------+--------+--------+--------+--------+--------+
| id_fornecedor | Emp250 | Emp251 | Emp252 | Emp253 | Emp254 |
+---------------+--------+--------+--------+--------+--------+
|          1496 |      0 |      0 |      0 |      0 |      1 |
|          1654 |      0 |      1 |      0 |      0 |      0 |
|          1664 |      0 |      0 |      0 |      1 |      0 |
|          1602 |      1 |      0 |      0 |      0 |      0 |
+---------------+--------+--------+--------+--------+--------+
4 rows in set (0.00 sec)