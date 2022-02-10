
Window Function PARTITION

Total de vendas por ano fiscal

SELECT ano_fiscal, SUM(valor_venda) total_venda
FROM cap06.tb_vendas
GROUP BY ano_fiscal
ORDER BY ano_fiscal;
+------------+-------------+
| ano_fiscal | total_venda |
+------------+-------------+
|       2020 |     5500.00 |
|       2021 |     5000.00 |
|       2022 |     7500.00 |
+------------+-------------+
3 rows in set (0.01 sec)


Total de vendas por funcionário
SELECT nome_funcionario, SUM(valor_venda) as total_venda
FROM cap06.TB_VENDAS
GROUP BY nome_funcionario
ORDER BY nome_funcionario;
+------------------+-------------+
| nome_funcionario | total_venda |
+------------------+-------------+
| Pele             |     6000.00 |
| Romario          |     7500.00 |
| Zico             |     4500.00 |
+------------------+-------------+
3 rows in set (0.00 sec)



Total de vendas por funcionário, por ano_
SELECT ano_fiscal, nome_funcionario, SUM(valor_venda) as total_venda
FROM cap06.tb_vendas
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;
+------------+------------------+-------------+
| ano_fiscal | nome_funcionario | total_venda |
+------------+------------------+-------------+
|       2020 | Pele             |     2000.00 |
|       2020 | Romario          |     2000.00 |
|       2020 | Zico             |     1500.00 |
|       2021 | Pele             |     1500.00 |
|       2021 | Romario          |     2500.00 |
|       2021 | Zico             |     1000.00 |
|       2022 | Pele             |     2500.00 |
|       2022 | Romario          |     3000.00 |
|       2022 | Zico             |     2000.00 |
+------------+------------------+-------------+
9 rows in set (0.00 sec)



Total de vendas por funcionário, por ano e total de vendas no ano_
SELECT ano_fiscal, nome_funcionario, valor_venda, SUM(valor_venda) OVER (PARTITION BY ano_fiscal) as total_venda_ano
FROM cap06.tb_vendas
ORDER BY ano_fiscal;
+------------+------------------+-------------+-----------------+
| ano_fiscal | nome_funcionario | valor_venda | total_venda_ano |
+------------+------------------+-------------+-----------------+
|       2020 | Pele             |     2000.00 |         5500.00 |
|       2020 | Romario          |     2000.00 |         5500.00 |
|       2020 | Zico             |     1500.00 |         5500.00 |
|       2021 | Pele             |     1500.00 |         5000.00 |
|       2021 | Romario          |     2500.00 |         5000.00 |
|       2021 | Zico             |     1000.00 |         5000.00 |
|       2022 | Pele             |     2500.00 |         7500.00 |
|       2022 | Romario          |     3000.00 |         7500.00 |
|       2022 | Zico             |     2000.00 |         7500.00 |
+------------+------------------+-------------+-----------------+
9 rows in set (0.00 sec)



Total de vendas por ano, por funcionário e total de vendas do funcionário
SELECT 
        ano_fiscal, 
        nome_funcionario, 
        valor_venda, 
        SUM(valor_venda) OVER (PARTITION BY nome_funcionario) AS TOTAL_VENDA
FROM cap06.tb_vendas
ORDER BY ano_fiscal;
+------------+------------------+-------------+-------------+
| ano_fiscal | nome_funcionario | valor_venda | TOTAL_VENDA |
+------------+------------------+-------------+-------------+
|       2020 | Pele             |     2000.00 |     6000.00 |
|       2020 | Romario          |     2000.00 |     7500.00 |
|       2020 | Zico             |     1500.00 |     4500.00 |
|       2021 | Pele             |     1500.00 |     6000.00 |
|       2021 | Romario          |     2500.00 |     7500.00 |
|       2021 | Zico             |     1000.00 |     4500.00 |
|       2022 | Pele             |     2500.00 |     6000.00 |
|       2022 | Romario          |     3000.00 |     7500.00 |
|       2022 | Zico             |     2000.00 |     4500.00 |
+------------+------------------+-------------+-------------+
9 rows in set (0.00 sec)





______________________________________________________________________________________________________________________________________________________________
______________________________________________________________________________________________________________________________________________________________
______________________________________________________________________________________________________________________________________________________________

FUNÇÃO OVER POR TODO DATASET



Total de vendas por ano, por funcionário e total de vendas geral
SELECT 
    ano_fiscal, 
    nome_funcionario,
    valor_venda,
    SUM(valor_venda) OVER() total_vendas_geral
FROM cap06.TB_VENDAS
ORDER BY ano_fiscal;
+------------+------------------+-------------+--------------------+
| ano_fiscal | nome_funcionario | valor_venda | total_vendas_geral |
+------------+------------------+-------------+--------------------+
|       2020 | Pele             |     2000.00 |           18000.00 |
|       2020 | Romario          |     2000.00 |           18000.00 |
|       2020 | Zico             |     1500.00 |           18000.00 |
|       2021 | Pele             |     1500.00 |           18000.00 |
|       2021 | Romario          |     2500.00 |           18000.00 |
|       2021 | Zico             |     1000.00 |           18000.00 |
|       2022 | Pele             |     2500.00 |           18000.00 |
|       2022 | Romario          |     3000.00 |           18000.00 |
|       2022 | Zico             |     2000.00 |           18000.00 |
+------------+------------------+-------------+--------------------+
9 rows in set (0.00 sec)



Número de vendas por ano, por funcionário e número total de vendas em todos os anos
SELECT 
    ano_fiscal, 
    nome_funcionario,
    COUNT(*) num_vendas_ano,
    COUNT(*) OVER() num_vendas_geral
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;
+------------+------------------+----------------+------------------+
| ano_fiscal | nome_funcionario | num_vendas_ano | num_vendas_geral |
+------------+------------------+----------------+------------------+
|       2020 | Pele             |              1 |                9 |
|       2020 | Romario          |              1 |                9 |
|       2020 | Zico             |              1 |                9 |
|       2021 | Pele             |              1 |                9 |
|       2021 | Romario          |              1 |                9 |
|       2021 | Zico             |              1 |                9 |
|       2022 | Pele             |              1 |                9 |
|       2022 | Romario          |              1 |                9 |
|       2022 | Zico             |              1 |                9 |
+------------+------------------+----------------+------------------+
9 rows in set (0.00 sec)



Reescrevendo a query anterior usando subquery
SELECT 
    ano_fiscal, 
    nome_funcionario,
    COUNT(*) num_vendas_ano,
(SELECT COUNT(*) FROM cap06.TB_VENDAS) as num_vendas_geral
FROM cap06.TB_VENDAS
GROUP BY ano_fiscal, nome_funcionario
ORDER BY ano_fiscal;
+------------+------------------+----------------+------------------+
| ano_fiscal | nome_funcionario | num_vendas_ano | num_vendas_geral |
+------------+------------------+----------------+------------------+
|       2020 | Pele             |              1 |                9 |
|       2020 | Romario          |              1 |                9 |
|       2020 | Zico             |              1 |                9 |
|       2021 | Pele             |              1 |                9 |
|       2021 | Romario          |              1 |                9 |
|       2021 | Zico             |              1 |                9 |
|       2022 | Pele             |              1 |                9 |
|       2022 | Romario          |              1 |                9 |
|       2022 | Zico             |              1 |                9 |
+------------+------------------+----------------+------------------+
9 rows in set (0.00 sec)


______________________________________________________________________________________________________________________________________________________________
______________________________________________________________________________________________________________________________________________________________
______________________________________________________________________________________________________________________________________________________________




Duração total do aluguel das bikes (em horas)
SELECT ROUND(SUM(duracao_segundos/60/60),2) AS duracao_total_horas
FROM cap06.tb_bikes;
+---------------------+
| duracao_total_horas |
+---------------------+
|            94690.72 |
+---------------------+
1 row in set (0.42 sec)



Duração total do aluguel das bikes em horas, ao longo do tempo soma acumulada
SELECT duracao_segundos,
        SUM(duracao_segundos/60/60) OVER (ORDER BY data_inicio) AS duracao_total_horas
FROM cap06.tb_bikes
LIMIT 10;
+------------------+---------------------+
| duracao_segundos | duracao_total_horas |
+------------------+---------------------+
|              475 |          0.13194444 |
|             1162 |          0.45472222 |
|             1145 |          0.77277778 |
|              485 |          0.90750000 |
|              471 |          1.03833333 |
|              358 |          1.13777777 |
|             1754 |          1.62499999 |
|              259 |          1.69694443 |
|              516 |          1.84027776 |
|              913 |          2.09388887 |
+------------------+---------------------+
10 rows in set (0.88 sec)


Duração total do aluguel de bikes (em horas), ao longo do tempo, por estação de início do aluguel da bike,
quando a data de início foi inferior a '2012-01-08'
SELECT estacao_inicio,
        duracao_segundos,
        SUM(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS tempo_total_horas
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
LIMIT 10;
+---------------------+------------------+-------------------+
| estacao_inicio      | duracao_segundos | tempo_total_horas |
+---------------------+------------------+-------------------+
| 10th & Monroe St NE |              933 |        0.25916667 |
| 10th & Monroe St NE |             1032 |        0.54583334 |
| 10th & Monroe St NE |             1159 |        0.86777778 |
| 10th & Monroe St NE |             1138 |        1.18388889 |
| 10th & Monroe St NE |              670 |        1.37000000 |
| 10th & Monroe St NE |             1597 |        1.81361111 |
| 10th & Monroe St NE |              865 |        2.05388889 |
| 10th & Monroe St NE |             1517 |        2.47527778 |
| 10th & Monroe St NE |             1287 |        2.83277778 |
| 10th & Monroe St NE |              641 |        3.01083334 |
+---------------------+------------------+-------------------+
10 rows in set (0.43 sec)


______________________________________________________________________________________________________________________________________________________________
______________________________________________________________________________________________________________________________________________________________
______________________________________________________________________________________________________________________________________________________________



Calculando Estatística com Window Function
SELECT estacao_inicio,
        AVG(duracao_segundos/60/60) AS tempo_medio_aluguel
FROM CAP06.tb_bikes
WHERE numero_estacao_inicio = 31017
GROUP BY estacao_inicio
LIMIT 10;
+-------------------------+---------------------+
| estacao_inicio          | tempo_medio_aluguel |
+-------------------------+---------------------+
| Wilson Blvd & N Uhle St |      0.285722366135 |
+-------------------------+---------------------+
1 row in set (0.35 sec)



Qual a média móvel de tempo em horas de aluguel da estação de início 31017
SELECT estacao_inicio, 
        AVG(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS media_tempo_aluguel
FROM CAP06.tb_bikes
WHERE numero_estacao_inicio = 31017
LIMIT 10;
+-------------------------+---------------------+
| estacao_inicio          | media_tempo_aluguel |
+-------------------------+---------------------+
| Wilson Blvd & N Uhle St |      0.099444440000 |
| Wilson Blvd & N Uhle St |      0.319861110000 |
| Wilson Blvd & N Uhle St |      0.243055553333 |
| Wilson Blvd & N Uhle St |      0.196180555000 |
| Wilson Blvd & N Uhle St |      0.175777778000 |
| Wilson Blvd & N Uhle St |      0.157175926667 |
| Wilson Blvd & N Uhle St |      0.142896825714 |
| Wilson Blvd & N Uhle St |      0.167881945000 |
| Wilson Blvd & N Uhle St |      0.198024692222 |
| Wilson Blvd & N Uhle St |      0.182055556000 |
+-------------------------+---------------------+
10 rows in set (0.37 sec)




Estação de início, data de inicio e duração de cada aluguel de bike em segundos
Duração total de aluguel das bikes ao longo do tempo por estação de estacao_inicio
duração média do aluguel de bikes ao longo do tempo por estacao_inicio
numero de alugueis de bikes por estação ao longo do tempo_total_horas
somente os registros quando a data de inicio for inferior a 2012-01-08
SELECT estacao_inicio, data_inicio, duracao_segundos,
        ROUND(SUM(duracao_segundos/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio),2) AS duracao_total_minutos,
        ROUND(AVG(duracao_segundos/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio),2) AS media_total_minutos,
        COUNT(estacao_inicio) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08'
LIMIT 10;
+---------------------+---------------------+------------------+-----------------------+---------------------+-----------------+
| estacao_inicio      | data_inicio         | duracao_segundos | duracao_total_minutos | media_total_minutos | numero_alugueis |
+---------------------+---------------------+------------------+-----------------------+---------------------+-----------------+
| 10th & Monroe St NE | 2012-01-01 13:01:34 |              933 |                 15.55 |               15.55 |               1 |
| 10th & Monroe St NE | 2012-01-01 14:26:28 |             1032 |                 32.75 |               16.38 |               2 |
| 10th & Monroe St NE | 2012-01-01 16:41:03 |             1159 |                 52.07 |               17.36 |               3 |
| 10th & Monroe St NE | 2012-01-01 16:55:58 |             1138 |                 71.03 |               17.76 |               4 |
| 10th & Monroe St NE | 2012-01-01 21:14:29 |              670 |                 82.20 |               16.44 |               5 |
| 10th & Monroe St NE | 2012-01-02 12:19:25 |             1597 |                108.82 |               18.14 |               6 |
| 10th & Monroe St NE | 2012-01-02 18:07:31 |              865 |                123.23 |               17.60 |               7 |
| 10th & Monroe St NE | 2012-01-03 08:17:43 |             1517 |                148.52 |               18.56 |               8 |
| 10th & Monroe St NE | 2012-01-03 08:26:07 |             1287 |                169.97 |               18.89 |               9 |
| 10th & Monroe St NE | 2012-01-03 09:13:24 |              641 |                180.65 |               18.07 |              10 |
+---------------------+---------------------+------------------+-----------------------+---------------------+-----------------+
10 rows in set (0.63 sec)



Estação de início, data de inicio de cada aluguel e duração de cada aluguel em segundos
Número de alugueis de bikes (independente da estacao) ao longo do tempo
Somente os registros quando a data de inicio for inferior a '2012-01-08'
SOLUÇÃO 1
SELECT estacao_inicio, 
        data_inicio, 
        duracao_segundos,
        COUNT(duracao_segundos/60/60) OVER (ORDER BY data_inicio) AS numero_alugueis
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+---------------------+------------------+-----------------+
| estacao_inicio      | data_inicio         | duracao_segundos | numero_alugueis |
+---------------------+---------------------+------------------+-----------------+
| Eads St & 15th St S | 2012-01-01 15:32:44 |               74 |               1 |
| Eads St & 15th St S | 2012-01-02 12:40:08 |              291 |               2 |
| Eads St & 15th St S | 2012-01-02 19:15:22 |              520 |               3 |
| Eads St & 15th St S | 2012-01-03 07:22:09 |              447 |               4 |
| Eads St & 15th St S | 2012-01-03 07:22:23 |              424 |               5 |
| Eads St & 15th St S | 2012-01-03 12:32:06 |             1422 |               6 |
| Eads St & 15th St S | 2012-01-04 17:36:51 |              348 |               7 |
| Eads St & 15th St S | 2012-01-05 15:13:36 |              277 |               8 |
| Eads St & 15th St S | 2012-01-05 17:25:44 |             3340 |               9 |
| Eads St & 15th St S | 2012-01-06 07:28:10 |              414 |              10 |
| Eads St & 15th St S | 2012-01-06 07:28:29 |              398 |              11 |
| Eads St & 15th St S | 2012-01-06 11:36:38 |              412 |              12 |
| Eads St & 15th St S | 2012-01-06 11:36:46 |              399 |              13 |
| Eads St & 15th St S | 2012-01-06 17:29:55 |             2661 |              14 |
| Eads St & 15th St S | 2012-01-06 22:10:22 |              393 |              15 |
| Eads St & 15th St S | 2012-01-06 22:10:31 |              387 |              16 |
+---------------------+---------------------+------------------+-----------------+
16 rows in set (0.36 sec)



SOLUÇÃO 2 COM ROW_NUMBER (LISTA O NUMERO DE CADA LINHA, AO LONGO DO TEMPO):
SELECT estacao_inicio, 
        data_inicio, 
        duracao_segundos,
        ROW_NUMBER() OVER (ORDER BY data_inicio) AS numero_alugueis
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+---------------------+------------------+-----------------+
| estacao_inicio      | data_inicio         | duracao_segundos | numero_alugueis |
+---------------------+---------------------+------------------+-----------------+
| Eads St & 15th St S | 2012-01-01 15:32:44 |               74 |               1 |
| Eads St & 15th St S | 2012-01-02 12:40:08 |              291 |               2 |
| Eads St & 15th St S | 2012-01-02 19:15:22 |              520 |               3 |
| Eads St & 15th St S | 2012-01-03 07:22:09 |              447 |               4 |
| Eads St & 15th St S | 2012-01-03 07:22:23 |              424 |               5 |
| Eads St & 15th St S | 2012-01-03 12:32:06 |             1422 |               6 |
| Eads St & 15th St S | 2012-01-04 17:36:51 |              348 |               7 |
| Eads St & 15th St S | 2012-01-05 15:13:36 |              277 |               8 |
| Eads St & 15th St S | 2012-01-05 17:25:44 |             3340 |               9 |
| Eads St & 15th St S | 2012-01-06 07:28:10 |              414 |              10 |
| Eads St & 15th St S | 2012-01-06 07:28:29 |              398 |              11 |
| Eads St & 15th St S | 2012-01-06 11:36:38 |              412 |              12 |
| Eads St & 15th St S | 2012-01-06 11:36:46 |              399 |              13 |
| Eads St & 15th St S | 2012-01-06 17:29:55 |             2661 |              14 |
| Eads St & 15th St S | 2012-01-06 22:10:22 |              393 |              15 |
| Eads St & 15th St S | 2012-01-06 22:10:31 |              387 |              16 |
+---------------------+---------------------+------------------+-----------------+
16 rows in set (0.36 sec)



E se quisermos o mesmo resultado anterior mas a contagem por estação se utiliza o PARTITION:
SELECT estacao_inicio, 
        data_inicio, 
        duracao_segundos,
        ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) AS numero_alugueis
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+---------------------+------------------+-----------------+
| estacao_inicio      | data_inicio         | duracao_segundos | numero_alugueis |
+---------------------+---------------------+------------------+-----------------+
| Eads St & 15th St S | 2012-01-01 15:32:44 |               74 |               1 |
| Eads St & 15th St S | 2012-01-02 12:40:08 |              291 |               2 |
| Eads St & 15th St S | 2012-01-02 19:15:22 |              520 |               3 |
| Eads St & 15th St S | 2012-01-03 07:22:09 |              447 |               4 |
| Eads St & 15th St S | 2012-01-03 07:22:23 |              424 |               5 |
| Eads St & 15th St S | 2012-01-03 12:32:06 |             1422 |               6 |
| Eads St & 15th St S | 2012-01-04 17:36:51 |              348 |               7 |
| Eads St & 15th St S | 2012-01-05 15:13:36 |              277 |               8 |
| Eads St & 15th St S | 2012-01-05 17:25:44 |             3340 |               9 |
| Eads St & 15th St S | 2012-01-06 07:28:10 |              414 |              10 |
| Eads St & 15th St S | 2012-01-06 07:28:29 |              398 |              11 |
| Eads St & 15th St S | 2012-01-06 11:36:38 |              412 |              12 |
| Eads St & 15th St S | 2012-01-06 11:36:46 |              399 |              13 |
| Eads St & 15th St S | 2012-01-06 17:29:55 |             2661 |              14 |
| Eads St & 15th St S | 2012-01-06 22:10:22 |              393 |              15 |
| Eads St & 15th St S | 2012-01-06 22:10:31 |              387 |              16 |
+---------------------+---------------------+------------------+-----------------+
16 rows in set (0.36 sec)



FUNÇÃO CAST CONVERTE UMA COLUNA PARA O TIPO QUE VOCÊ DESEJAR EXEMPLO
Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo:
Para a estação de id 31000 e data inicio '2012-01-08', com a coluna de data_inicio convertida para o formato date(FUNÇÃO CAST)
SELECT estacao_inicio, 
        CAST(data_inicio as date) AS data_inicio, 
        duracao_segundos,
        ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+-------------+------------------+-----------------+
| estacao_inicio      | data_inicio | duracao_segundos | numero_alugueis |
+---------------------+-------------+------------------+-----------------+
| Eads St & 15th St S | 2012-01-01  |               74 |               1 |
| Eads St & 15th St S | 2012-01-02  |              291 |               2 |
| Eads St & 15th St S | 2012-01-02  |              520 |               3 |
| Eads St & 15th St S | 2012-01-03  |              447 |               4 |
| Eads St & 15th St S | 2012-01-03  |              424 |               5 |
| Eads St & 15th St S | 2012-01-03  |             1422 |               6 |
| Eads St & 15th St S | 2012-01-04  |              348 |               7 |
| Eads St & 15th St S | 2012-01-05  |              277 |               8 |
| Eads St & 15th St S | 2012-01-05  |             3340 |               9 |
| Eads St & 15th St S | 2012-01-06  |              414 |              10 |
| Eads St & 15th St S | 2012-01-06  |              398 |              11 |
| Eads St & 15th St S | 2012-01-06  |              412 |              12 |
| Eads St & 15th St S | 2012-01-06  |              399 |              13 |
| Eads St & 15th St S | 2012-01-06  |             2661 |              14 |
| Eads St & 15th St S | 2012-01-06  |              393 |              15 |
| Eads St & 15th St S | 2012-01-06  |              387 |              16 |
+---------------------+-------------+------------------+-----------------+
16 rows in set (3.63 sec)



FUNÇÃO DENSE_RANK
Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo:
Para a estação de id 31000 e data inicio '2012-01-08', com a coluna de data_inicio convertida para o formato date(FUNÇÃO CAST)
SELECT estacao_inicio, 
        CAST(data_inicio as date) AS data_inicio, 
        duracao_segundos,
        DENSE_RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+-------------+------------------+-----------------+
| estacao_inicio      | data_inicio | duracao_segundos | numero_alugueis |
+---------------------+-------------+------------------+-----------------+
| Eads St & 15th St S | 2012-01-01  |               74 |               1 |
| Eads St & 15th St S | 2012-01-02  |              291 |               2 |
| Eads St & 15th St S | 2012-01-02  |              520 |               2 |
| Eads St & 15th St S | 2012-01-03  |              447 |               3 |
| Eads St & 15th St S | 2012-01-03  |              424 |               3 |
| Eads St & 15th St S | 2012-01-03  |             1422 |               3 |
| Eads St & 15th St S | 2012-01-04  |              348 |               4 |
| Eads St & 15th St S | 2012-01-05  |              277 |               5 |
| Eads St & 15th St S | 2012-01-05  |             3340 |               5 |
| Eads St & 15th St S | 2012-01-06  |              414 |               6 |
| Eads St & 15th St S | 2012-01-06  |              398 |               6 |
| Eads St & 15th St S | 2012-01-06  |              412 |               6 |
| Eads St & 15th St S | 2012-01-06  |              399 |               6 |
| Eads St & 15th St S | 2012-01-06  |             2661 |               6 |
| Eads St & 15th St S | 2012-01-06  |              393 |               6 |
| Eads St & 15th St S | 2012-01-06  |              387 |               6 |
+---------------------+-------------+------------------+-----------------+
16 rows in set (0.36 sec)



FUNÇÃO RANK
Estação, data de início, duração em segundos do aluguel e número de aluguéis ao longo do tempo:
Para a estação de id 31000 e data inicio '2012-01-08', com a coluna de data_inicio convertida para o formato date(FUNÇÃO CAST)
SELECT estacao_inicio, 
        CAST(data_inicio as date) AS data_inicio, 
        duracao_segundos,
        RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+-------------+------------------+-----------------+
| estacao_inicio      | data_inicio | duracao_segundos | numero_alugueis |
+---------------------+-------------+------------------+-----------------+
| Eads St & 15th St S | 2012-01-01  |               74 |               1 |
| Eads St & 15th St S | 2012-01-02  |              291 |               2 |
| Eads St & 15th St S | 2012-01-02  |              520 |               2 |
| Eads St & 15th St S | 2012-01-03  |              447 |               4 |
| Eads St & 15th St S | 2012-01-03  |              424 |               4 |
| Eads St & 15th St S | 2012-01-03  |             1422 |               4 |
| Eads St & 15th St S | 2012-01-04  |              348 |               7 |
| Eads St & 15th St S | 2012-01-05  |              277 |               8 |
| Eads St & 15th St S | 2012-01-05  |             3340 |               8 |
| Eads St & 15th St S | 2012-01-06  |              414 |              10 |
| Eads St & 15th St S | 2012-01-06  |              398 |              10 |
| Eads St & 15th St S | 2012-01-06  |              412 |              10 |
| Eads St & 15th St S | 2012-01-06  |              399 |              10 |
| Eads St & 15th St S | 2012-01-06  |             2661 |              10 |
| Eads St & 15th St S | 2012-01-06  |              393 |              10 |
| Eads St & 15th St S | 2012-01-06  |              387 |              10 |
+---------------------+-------------+------------------+-----------------+
16 rows in set (0.36 sec)



FUNÇÃO NTILE
A função NTILE() é uma função de janela window que distribui linhas de uma partição ordenada em um número predefinido
de grupos aproximadamente iguais. a função distribui a cada grupo um número a partir de 1
Basicamente ele divide o total pelo número de grupos que foi defino no NTILE()

SELECT estacao_inicio,
        duracao_segundos,
        ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_alugueis,
        NTILE(2) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_dois,
        NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_quatro,
        NTILE(5) OVER (PARTITION BY estacao_inicio ORDER BY duracao_segundos) AS numero_grupo_cinco
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+------------------+-----------------+-------------------+---------------------+--------------------+
| estacao_inicio      | duracao_segundos | numero_alugueis | numero_grupo_dois | numero_grupo_quatro | numero_grupo_cinco |
+---------------------+------------------+-----------------+-------------------+---------------------+--------------------+
| Eads St & 15th St S |               74 |               1 |                 1 |                   1 |                  1 |
| Eads St & 15th St S |              277 |               2 |                 1 |                   1 |                  1 |
| Eads St & 15th St S |              291 |               3 |                 1 |                   1 |                  1 |
| Eads St & 15th St S |              348 |               4 |                 1 |                   1 |                  1 |
| Eads St & 15th St S |              387 |               5 |                 1 |                   2 |                  2 |
| Eads St & 15th St S |              393 |               6 |                 1 |                   2 |                  2 |
| Eads St & 15th St S |              398 |               7 |                 1 |                   2 |                  2 |
| Eads St & 15th St S |              399 |               8 |                 1 |                   2 |                  3 |
| Eads St & 15th St S |              412 |               9 |                 2 |                   3 |                  3 |
| Eads St & 15th St S |              414 |              10 |                 2 |                   3 |                  3 |
| Eads St & 15th St S |              424 |              11 |                 2 |                   3 |                  4 |
| Eads St & 15th St S |              447 |              12 |                 2 |                   3 |                  4 |
| Eads St & 15th St S |              520 |              13 |                 2 |                   4 |                  4 |
| Eads St & 15th St S |             1422 |              14 |                 2 |                   4 |                  5 |
| Eads St & 15th St S |             2661 |              15 |                 2 |                   4 |                  5 |
| Eads St & 15th St S |             3340 |              16 |                 2 |                   4 |                  5 |
+---------------------+------------------+-----------------+-------------------+---------------------+--------------------+
16 rows in set (0.36 sec)



FUNÇÃO NTILE() COM O CAST
SELECT estacao_inicio,
        CAST(data_inicio as date) AS data_inicio,
        duracao_segundos,
        ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_alugueis,
        NTILE(2) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo_dois,
        NTILE(4) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo_quatro,
        NTILE(16) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS numero_grupo_dezeseis
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;
+---------------------+-------------+------------------+-----------------+--------------+--------------+--------------+
| estacao_inicio      | data_inicio | duracao_segundos | numero_alugueis | numero_grupo | numero_grupo | numero_grupo |
+---------------------+-------------+------------------+-----------------+--------------+--------------+--------------+
| Eads St & 15th St S | 2012-01-01  |               74 |               1 |            1 |            1 |            1 |
| Eads St & 15th St S | 2012-01-02  |              291 |               2 |            1 |            1 |            2 |
| Eads St & 15th St S | 2012-01-02  |              520 |               3 |            1 |            1 |            3 |
| Eads St & 15th St S | 2012-01-03  |              447 |               4 |            1 |            1 |            4 |
| Eads St & 15th St S | 2012-01-03  |              424 |               5 |            1 |            2 |            5 |
| Eads St & 15th St S | 2012-01-03  |             1422 |               6 |            1 |            2 |            6 |
| Eads St & 15th St S | 2012-01-04  |              348 |               7 |            1 |            2 |            7 |
| Eads St & 15th St S | 2012-01-05  |              277 |               8 |            1 |            2 |            8 |
| Eads St & 15th St S | 2012-01-05  |             3340 |               9 |            2 |            3 |            9 |
| Eads St & 15th St S | 2012-01-06  |              414 |              10 |            2 |            3 |           10 |
| Eads St & 15th St S | 2012-01-06  |              398 |              11 |            2 |            3 |           11 |
| Eads St & 15th St S | 2012-01-06  |              412 |              12 |            2 |            3 |           12 |
| Eads St & 15th St S | 2012-01-06  |              399 |              13 |            2 |            4 |           13 |
| Eads St & 15th St S | 2012-01-06  |             2661 |              14 |            2 |            4 |           14 |
| Eads St & 15th St S | 2012-01-06  |              393 |              15 |            2 |            4 |           15 |
| Eads St & 15th St S | 2012-01-06  |              387 |              16 |            2 |            4 |           16 |
+---------------------+-------------+------------------+-----------------+--------------+--------------+--------------+
16 rows in set (0.36 sec)



FUNÇÃO LAG(MOVE PARA A FRENTE) E LEAD(MOVE PARA TRÁS)
Qual a diferença da duração do aluguel de bikes de um registro para outro?
SELECT estacao_inicio,
        CAST(data_inicio as date) AS data_inicio,
        duracao_segundos,
        duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS DIFERENCA
FROM CAP06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;



FUNÇÃO DE MANIPULAÇÃO DE DATAS
Extraindo itens específicos da data
SELECT data_inicio,
        DATE(data_inicio),
        TIMESTAMP(data_inicio),
        YEAR(data_inicio),
        MONTH(data_inicio),
        DAY(data_inicio)
FROM CAP06.tb_bikes
WHERE numero_estacao_inicio = 31000
AND data_inicio < '2012-01-08';
+---------------------+-------------------+----------------------------+-------------------+--------------------+------------------+
| data_inicio         | DATE(data_inicio) | TIMESTAMP(data_inicio)     | YEAR(data_inicio) | MONTH(data_inicio) | DAY(data_inicio) |
+---------------------+-------------------+----------------------------+-------------------+--------------------+------------------+
| 2012-01-01 15:32:44 | 2012-01-01        | 2012-01-01 15:32:44.000000 |              2012 |                  1 |                1 |
| 2012-01-02 12:40:08 | 2012-01-02        | 2012-01-02 12:40:08.000000 |              2012 |                  1 |                2 |
| 2012-01-02 19:15:22 | 2012-01-02        | 2012-01-02 19:15:22.000000 |              2012 |                  1 |                2 |
| 2012-01-03 07:22:09 | 2012-01-03        | 2012-01-03 07:22:09.000000 |              2012 |                  1 |                3 |
| 2012-01-03 07:22:23 | 2012-01-03        | 2012-01-03 07:22:23.000000 |              2012 |                  1 |                3 |
| 2012-01-03 12:32:06 | 2012-01-03        | 2012-01-03 12:32:06.000000 |              2012 |                  1 |                3 |
| 2012-01-04 17:36:51 | 2012-01-04        | 2012-01-04 17:36:51.000000 |              2012 |                  1 |                4 |
| 2012-01-05 15:13:36 | 2012-01-05        | 2012-01-05 15:13:36.000000 |              2012 |                  1 |                5 |
| 2012-01-05 17:25:44 | 2012-01-05        | 2012-01-05 17:25:44.000000 |              2012 |                  1 |                5 |
| 2012-01-06 07:28:10 | 2012-01-06        | 2012-01-06 07:28:10.000000 |              2012 |                  1 |                6 |
| 2012-01-06 07:28:29 | 2012-01-06        | 2012-01-06 07:28:29.000000 |              2012 |                  1 |                6 |
| 2012-01-06 11:36:38 | 2012-01-06        | 2012-01-06 11:36:38.000000 |              2012 |                  1 |                6 |
| 2012-01-06 11:36:46 | 2012-01-06        | 2012-01-06 11:36:46.000000 |              2012 |                  1 |                6 |
| 2012-01-06 17:29:55 | 2012-01-06        | 2012-01-06 17:29:55.000000 |              2012 |                  1 |                6 |
| 2012-01-06 22:10:22 | 2012-01-06        | 2012-01-06 22:10:22.000000 |              2012 |                  1 |                6 |
| 2012-01-06 22:10:31 | 2012-01-06        | 2012-01-06 22:10:31.000000 |              2012 |                  1 |                6 |
+---------------------+-------------------+----------------------------+-------------------+--------------------+------------------+
16 rows in set (0.33 sec)



Extraindo o mês da data
SELECT EXTRACT(MONTH FROM data_inicio) AS mes, duracao_segundos
FROM CAP06.tb_bikes
WHERE numero_estacao_inicio = 31000;
+------+------------------+
| mes  | duracao_segundos |
+------+------------------+
|    1 |               74 |
|    1 |              291 |
|    1 |              520 |
|    1 |              447 |
|    3 |             1652 |
|    3 |             1732 |
|    3 |              246 |
|    3 |              161 |
|    3 |             1652 |
|    3 |             2168 |
|    3 |             2092 |
|    3 |             1686 |
|    3 |             2256 |
|    3 |             1385 |
|    3 |             1398 |
|    3 |             1297 |
|    3 |              605 |
|    3 |              554 |
|    3 |             1393 |
+------+------------------+
268 rows in set (0.34 sec)





1-Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro?
SELECT AVG(duracao_segundos) AS Media_segundos, tipo_membro
FROM exec5.tb_bikes
GROUP BY tipo_membro
ORDER BY Media_segundos DESC;
+----------------+-------------+
| Media_segundos | tipo_membro |
+----------------+-------------+
|      2549.6267 | Casual      |
|      1251.5000 | Unknown     |
|       748.2134 | Member      |
+----------------+-------------+
3 rows in set (1.14 sec)



2-Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim (onde as bikes são entregues após o aluguel)?
SELECT AVG(duracao_segundos) AS Media_segundos, tipo_membro, estacao_fim
FROM exec5.tb_bikes
GROUP BY tipo_membro, estacao_fim
ORDER BY Media_segundos DESC;
----------------+-------------+-------------------------------------------------------+
| Media_segundos | tipo_membro | estacao_fim                                           |
+----------------+-------------+-------------------------------------------------------+
|     11190.1429 | Casual      | Randle Circle & Minnesota Ave SE                      |
|      5527.6667 | Casual      | Congress Heights Metro                                |
|      4718.8750 | Casual      | Minnesota Ave Metro/DOES                              |
|      4653.2289 | Casual      | Pentagon City Metro / 12th & S Hayes St               |
|      4527.3581 | Casual      | Ward Circle / American University                     |
|      4421.6000 | Casual      | 21st St & Pennsylvania Ave NW                         |
|       490.7116 | Member      | Eads & 22nd St S                                      |
|       475.9677 | Member      | 27th & Crystal Dr                                     |
|       475.2980 | Member      | Wilson Blvd & N Quincy St                             |
|       464.1920 | Member      | Wilson Blvd & N Edgewood St                           |
|       453.6634 | Member      | Fairfax Dr & Wilson Blvd                              |
|       384.0000 | Unknown     | M St & Pennsylvania Ave NW                            |
+----------------+-------------+-------------------------------------------------------+
349 rows in set (1.61 sec)



3-Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim 
(onde as bikes são entregues após o aluguel) ao longo do tempo?
SELECT  estacao_fim,
        tipo_membro,
        AVG(duracao_segundos) OVER (PARTITION BY tipo_membro ORDER BY data_inicio) AS media_tempo_aluguel
FROM exec5.tb_bikes
LIMIT 10;
+--------------------------------------+-------------+---------------------+
| estacao_fim                          | tipo_membro | media_tempo_aluguel |
+--------------------------------------+-------------+---------------------+
| Rhode Island & Connecticut Ave NW    | Casual      |            408.0000 |
| Harvard St & Adams Mill Rd NW        | Casual      |            285.5000 |
| 15th & P St NW                       | Casual      |           1942.3333 |
| 25th St & Pennsylvania Ave NW        | Casual      |           1575.2500 |
| Massachusetts Ave & Dupont Circle NW | Casual      |           1336.2000 |
| 16th & Harvard St NW                 | Casual      |           1380.3333 |
| D St & Maryland Ave NE               | Casual      |           1219.4286 |
| 20th & E St NW                       | Casual      |           2027.0000 |
| 21st & I St NW                       | Casual      |           2411.6667 |
| M St & Pennsylvania Ave NW           | Casual      |           2265.6000 |
+--------------------------------------+-------------+---------------------+
10 rows in set (1.52 sec)



4-Qual hora do dia (independente do mês) a bike de número W01182 teve o maior número de aluguéis considerando a data de início?
SELECT EXTRACT(HOUR FROM data_inicio) AS hora,
        COUNT(duracao_segundos) AS numero_alugueis
FROM exec5.tb_bikes
WHERE numero_bike = 'W01182'
GROUP BY hora
ORDER BY numero_alugueis DESC;
+------+-----------------+
| hora | numero_alugueis |
+------+-----------------+
|   17 |              48 |
|   18 |              44 |
|   14 |              30 |
|   19 |              30 |
|    8 |              29 |
|    9 |              28 |
|   16 |              26 |
|    7 |              24 |
|   15 |              23 |
|   12 |              22 |
|   13 |              22 |
|   11 |              20 |
|   20 |              19 |
|   10 |              14 |
|   21 |              13 |
|   22 |              10 |
|    6 |               9 |
|    0 |               6 |
|   23 |               5 |
|    2 |               4 |
|    5 |               2 |
|    1 |               2 |
+------+-----------------+
22 rows in set (0.60 sec)


5-Qual o número de aluguéis da bike de número W01182 ao longo do tempo considerando a data de início?
SELECT CAST(data_inicio as date) AS data_inicio,
        COUNT(duracao_segundos) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS num_alugueis
FROM exec5.tb_bikes
WHERE numero_bike = 'W01182'
ORDER BY data_inicio;
+-------------+--------------+
| data_inicio | num_alugueis |
+-------------+--------------+
| 2012-04-01  |            1 |
| 2012-04-01  |            1 |
| 2012-04-01  |            1 |
| 2012-04-01  |            1 |
| 2012-04-01  |            1 |
| 2012-04-01  |            1 |
| 2012-06-26  |            6 |
| 2012-06-26  |            8 |
| 2012-06-26  |            4 |
| 2012-06-27  |            7 |
| 2012-06-27  |            9 |
+-------------+--------------+
430 rows in set (0.63 sec)



6-Retornar:
Estação fim, data fim de cada aluguel de bike e duração de cada aluguel em segundos
Número de aluguéis de bikes (independente da estação) ao longo do tempo 
Somente os registros quando a data fim foi no mês de Abril
SELECT 
        estacao_fim,
        data_fim,
        duracao_segundos,
        ROW_NUMBER() OVER (ORDER BY data_fim) AS numero_alugueis
FROM exec5.tb_bikes
WHERE EXTRACT(MONTH FROM data_fim) = 04
LIMIT 10;
+--------------------------------------+---------------------+------------------+-----------------+
| estacao_fim                          | data_fim            | duracao_segundos | numero_alugueis |
+--------------------------------------+---------------------+------------------+-----------------+
| 21st & M St NW                       | 2012-04-01 00:04:26 |              192 |               1 |
| Harvard St & Adams Mill Rd NW        | 2012-04-01 00:06:57 |              163 |               2 |
| Massachusetts Ave & Dupont Circle NW | 2012-04-01 00:09:45 |              187 |               3 |
| Rhode Island & Connecticut Ave NW    | 2012-04-01 00:10:26 |              408 |               4 |
| 20th St & Florida Ave NW             | 2012-04-01 00:11:23 |              188 |               5 |
| 25th St & Pennsylvania Ave NW        | 2012-04-01 00:13:15 |              474 |               6 |
| Rhode Island & Connecticut Ave NW    | 2012-04-01 00:14:25 |              492 |               7 |
| New Hampshire Ave & T St NW          | 2012-04-01 00:15:35 |              260 |               8 |
| New Hampshire Ave & T St NW          | 2012-04-01 00:15:43 |              504 |               9 |
| Harvard St & Adams Mill Rd NW        | 2012-04-01 00:16:11 |              169 |              10 |
+--------------------------------------+---------------------+------------------+-----------------+
10 rows in set (0.81 sec)



7-Retornar: Estação fim, data fim e duração em segundos do aluguel 
A data fim deve ser retornada no formato: 01/January/2012 00:00:00
Queremos a ordem (classificação ou ranking) dos dias de aluguel ao longo dotempo
Retornar os dados para os aluguéis entre 7 e 11 da manhã
SELECT
        estacao_fim,
        DATE_FORMAT(data_fim, "%d/%M/%Y %H:%I:%S") AS data_fim,
        duracao_segundos,
        DENSE_RANK() OVER (PARTITION BY estacao_fim ORDER BY CAST(data_fim as date)) AS ranking_aluguel
FROM exec5.tb_bikes
WHERE EXTRACT(HOUR FROM data_fim) BETWEEN 07 AND 11
LIMIT 10;
+---------------------+------------------------+------------------+-----------------+
| estacao_fim         | data_fim               | duracao_segundos | ranking_aluguel |
+---------------------+------------------------+------------------+-----------------+
| 10th & Monroe St NE | 01/April/2012 11:11:25 |              843 |               1 |
| 10th & Monroe St NE | 01/April/2012 11:11:53 |              869 |               1 |
| 10th & Monroe St NE | 01/April/2012 11:11:07 |              848 |               1 |
| 10th & Monroe St NE | 01/April/2012 11:11:10 |              902 |               1 |
| 10th & Monroe St NE | 03/April/2012 10:10:23 |              449 |               2 |
| 10th & Monroe St NE | 04/April/2012 09:09:09 |              758 |               3 |
| 10th & Monroe St NE | 06/April/2012 11:11:47 |             1542 |               4 |
| 10th & Monroe St NE | 09/April/2012 08:08:00 |              497 |               5 |
| 10th & Monroe St NE | 11/April/2012 09:09:58 |              856 |               6 |
| 10th & Monroe St NE | 13/April/2012 10:10:53 |              566 |               7 |
+---------------------+------------------------+------------------+-----------------+
10 rows in set (0.83 sec)



8-Qual a diferença da duração do aluguel de bikesao longo do tempo, de um registro para outro, 
considerando data de início do aluguel e estação de início?
A data de início deve ser retornada no formato: Sat/Jan/12 00:00:00 (Sat = Dia da semana abreviado e Jan igual mês abreviado). 
Retornar os dados para os aluguéis entre 01 e 03 da manhã
SELECT
        estacao_inicio,
        DATE_FORMAT(data_inicio, "%a/%b/%y %H:%i:%S") AS data_inicio,
        duracao_segundos,
        duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
FROM exec5.tb_bikes
WHERE EXTRACT(HOUR FROM data_fim) BETWEEN 01 AND 03
LIMIT 10;
+---------------------+---------------------+------------------+-----------+
| estacao_inicio      | data_inicio         | duracao_segundos | diferenca |
+---------------------+---------------------+------------------+-----------+
| 10th & Monroe St NE | Thu/Apr/12 02:23:32 |             1298 |      NULL |
| 10th & Monroe St NE | Thu/Apr/12 01:56:07 |             1635 |       337 |
| 10th & Monroe St NE | Sat/Apr/12 02:04:34 |              719 |      -916 |
| 10th & Monroe St NE | Sat/Apr/12 00:35:07 |             5379 |      4660 |
| 10th & Monroe St NE | Sat/Apr/12 02:17:57 |              808 |     -4571 |
| 10th & Monroe St NE | Thu/May/12 02:20:00 |              708 |      -100 |
| 10th & Monroe St NE | Sat/May/12 01:12:36 |             9139 |      8431 |
| 10th & Monroe St NE | Thu/May/12 23:56:10 |            11300 |      2161 |
| 10th & Monroe St NE | Sun/Jun/12 00:03:51 |             5488 |     -5812 |
| 10th & Monroe St NE | Sun/Jun/12 01:57:56 |             1329 |     -4159 |
+---------------------+---------------------+------------------+-----------+
10 rows in set (0.76 sec)



9-Retornar:
Estação fim, data fim e duração em segundos do aluguel 
A data fim deve ser retornada no formato: 01/January/2012 00:00:00
Queremos os registros divididos em 4 grupos ao longo do tempo por partição
Retornar os dados para os aluguéis entre 8 e 10 da manhã
Qual critério usado pela função NTILE para dividir os grupos?
SELECT
        estacao_fim,
        DATE_FORMAT(data_fim, "%d/%M/%Y %H:%i:%S") AS data_fim,
        duracao_segundos,
        NTILE(4) OVER (PARTITION BY estacao_fim ORDER BY CAST(data_fim as date)) AS ranking_aluguel
FROM exec5.tb_bikes
WHERE EXTRACT(HOUR FROM data_fim) BETWEEN 08 AND 11
LIMIT 10;
+---------------------+------------------------+------------------+-----------------+
| estacao_fim         | data_fim               | duracao_segundos | ranking_aluguel |
+---------------------+------------------------+------------------+-----------------+
| 10th & Monroe St NE | 01/April/2012 11:48:10 |              902 |               1 |
| 10th & Monroe St NE | 01/April/2012 11:48:25 |              843 |               1 |
| 10th & Monroe St NE | 01/April/2012 11:48:53 |              869 |               1 |
| 10th & Monroe St NE | 01/April/2012 11:48:07 |              848 |               1 |
| 10th & Monroe St NE | 03/April/2012 10:06:23 |              449 |               1 |
| 10th & Monroe St NE | 04/April/2012 09:29:09 |              758 |               1 |
| 10th & Monroe St NE | 06/April/2012 11:03:47 |             1542 |               1 |
| 10th & Monroe St NE | 09/April/2012 08:19:00 |              497 |               1 |
| 10th & Monroe St NE | 11/April/2012 09:24:58 |              856 |               1 |
| 10th & Monroe St NE | 13/April/2012 10:45:53 |              566 |               1 |
+---------------------+------------------------+------------------+-----------------+
10 rows in set (0.80 sec)



10-Quais estações tiveram mais de 35 horas de duração total do aluguel de bike ao longo do tempo considerando a data fim e estação fim?
Retorne os dados entre os dias '2012-04-01' e '2012-04-02'
Use função window e subquery
SELECT *
FROM
(SELECT estacao_fim,
        CAST(data_fim as date) AS data_fim,
        SUM(duracao_segundos/60/60) OVER (PARTITION BY estacao_fim ORDER BY CAST(data_fim as date)) AS tempo_total_horas
FROM exec5.tb_bikes
WHERE data_fim BETWEEN '2012-01-01' AND '2012-04-02') resultado
WHERE resultado.tempo_total_horas > 35
ORDER BY resultado.estacao_fim
LIMIT 10;
+-------------------------------+------------+-------------------+
| estacao_fim                   | data_fim   | tempo_total_horas |
+-------------------------------+------------+-------------------+
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
| 10th St & Constitution Ave NW | 2012-04-01 |       72.27388887 |
+-------------------------------+------------+-------------------+
10 rows in set (0.75 sec)