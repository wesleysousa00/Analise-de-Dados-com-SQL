
Usarei SQL para analisar dados de inspeções sanitárias em navios de cruzeiro, são
dados reais disponíveis publicamente fornecidos pela ANVISA.
O objetivo deste script é trazer algumas respostas e entender algumas caracteristicas dos dados,
como os navios com pior classificação de risco, os navios com índices de conformidade mais alto,
os navios com alta pontuação de risco entre outros detalhes.

link do dataset disponibilizado pela ANVISA:
dados.gov.br/dataset/dados-abertos-de-inspecao-em-navios-de-cruzeiro





/* Criando a tabela */
CREATE TABLE `cap02`.`tb_navios` (
  `nome_navio` VARCHAR(50) NULL,
  `mes_ano` VARCHAR(10) NULL,
  `classificacao_risco` VARCHAR(15) NULL,
  `indice_comformidade` VARCHAR(15) NULL,
  `pontuacao_risco` INT NULL,
  `temporada` VARCHAR(200) NULL);



/* Após ser criado a tabela, importamos o arquivo csv com os dados */
/* O arquivo possui 463 registros, estarei apenas demonstrando um parte da saida do comando */
/* para não ficar muito extenso */
/* Buscando todos os dados da tabela */

SELECT * FROM cap02.tb_navios;
nome_navio           | mes_ano | classificacao_risco | indice_conformidade | pontuacao_risco | temporada                                                           |
+----------------------+---------+---------------------+---------------------+-----------------+---------------------------------------------------------------------+
| HORIZON (PACIFIC DRE | 12/2010 | C                   | 90,76               |             310 | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Dezembro 2010   |
| SPLENDOUR OF THE SEA | 12/2012 | C                   | 91,71               |             415 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Dezembro 2012   |
| AZAMARA JOURNEY      | 02/2012 | A                   | 97,98               |              80 | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Fevereiro 2012  |
| BOUDICCA             | 01/2013 | A                   | 100,00              |               0 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Janeiro 2013    |
| NATIONAL GEOGRAPHIC  | 10/2014 | A                   | 97,43               |             125 | Programa de Inspecao Navios de Cruzeiro 2014/2015 - Outubro 2014    |
| COSTA PACIFICA       | 11/2019 | A                   | 98,20               |              90 | Programa de Inspecao Navios de Cruzeiro 2019/2020 - Novembro 2019   |
463 rows in set (0.01 sec)





/* Valores unicos    */
SELECT DISTINCT classificacao_risco
FROM cap02.tb_navios;
classificacao_risco |
+---------------------+
| C                   |
| A                   |
| D                   |
| B                   |
+---------------------+
	




/*  Filtando classificação D */
SELECT nome_navio, temporada, classificacao_risco
FROM cap02.tb_navios
WHERE classificacao_risco = 'D';

| nome_navio           | temporada                                                           | classificacao_risco |
+----------------------+---------------------------------------------------------------------+---------------------+
| OCEAN DREAM          | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Janeiro 2014    | D                   |
| SEABOURN ODYSSEY     | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Fevereiro 2011  | D                   |
| VOYAGER              | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Marco 2013      | D                   |
| ORIENT QUEEN II      | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Dezembro 2013   | D                   |
| CRYSTAL SYMPHONY     | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Fevereiro 2011  | D                   |
| MSC ORCHESTRA        | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Novembro 2010   | D                   |
| GRAND CELEBRATION    | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Novembro 2010   | D                   |
| BLEU DE FRANCE       | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Novembro 2010   | D                   |
| ASUKA II             | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Maio 2012       | D                   |
| SILVER WHISPER       | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Novembro 2010   | D                   |
| ALBATROS             | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Dezembro 2010   | D                   |
| MAASDAM              | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Fevereiro 2013  | D                   |
| BLEU DE FRANCE       | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Maio 2011       | D                   |
50 rows in set (0.00 sec)





/* Filtrando classificação com ordenamento pelo nome do navio */
SELECT nome_navio, temporada, classificacao_risco
FROM cap02.tb_navios
WHERE classificacao_risco = 'D'
ORDER BY nome_navio ASC;

nome_navio           | temporada                                                           | classificacao_risco |
+----------------------+---------------------------------------------------------------------+---------------------+
| AIDA CARA            | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Janeiro 2011    | D                   |
| ALBATROS             | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Dezembro 2010   | D                   |
| ALBATROS             | Programa de Inspecao Navios de Cruzeiro 2011/2012  - Outubro 2011   | D                   |
| AMERA (PRINSENDAM)   | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Janeiro 2011    | D                   |
| ASTOR                | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Fevereiro 2012  | D                   |
| ASUKA II             | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Maio 2012       | D                   |
| AUSTRAL              | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Marco 2014      | D                   |
| AZAMARA QUEST        | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Dezembro 2012   | D                   |
| BALMORAL             | Programa de Inspecao Navios de Cruzeiro 2017/2018 -  Fevereiro 2018 | D                   |
| BLACK WATCH          | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Janeiro 2011    | D                   |
| BLEU DE FRANCE       | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Maio 2011       | D                   |
50 rows in set (0.01 sec)





/* Filtrando utilizando operador lógico AND */
SELECT nome_navio, temporada, classificacao_risco, pontuacao_risco
FROM cap02.tb_navios
WHERE classificacao_risco = 'D' AND pontuacao_risco > 1000
ORDER BY nome_navio ASC;

nome_navio           | temporada                                                         | classificacao_risco | pontuacao_risco |
+----------------------+-------------------------------------------------------------------+---------------------+-----------------+
| ORIENT QUEEN II      | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Dezembro 2013 | D                   |            1065 |
| SEA EXPLORER         | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Marco 2014    | D                   |            1230 |
| SOVEREIGN (SOBERANO) | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Dezembro 2012 | D                   |            1035 |
| STAR PRINCESS        | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Janeiro 2012  | D                   |            1115 |
+----------------------+-------------------------------------------------------------------+---------------------+-----------------+
4 rows in set (0.00 sec)





/* Filtrando utilizando operador lógico OR */
SELECT nome_navio, temporada, classificacao_risco, pontuacao_risco
FROM cap02.tb_navios
WHERE classificacao_risco = 'D' OR pontuacao_risco > 3000
ORDER BY nome_navio ASC;

 nome_navio           | temporada                                                           | classificacao_risco | pontuacao_risco |
+----------------------+---------------------------------------------------------------------+---------------------+-----------------+
| AIDA CARA            | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Janeiro 2011    | D                   |             690 |
| ALBATROS             | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Dezembro 2010   | D                   |             740 |
| ALBATROS             | Programa de Inspecao Navios de Cruzeiro 2011/2012  - Outubro 2011   | D                   |             755 |
| AMERA (PRINSENDAM)   | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Janeiro 2011    | D                   |             600 |
| ASTOR                | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Fevereiro 2012  | D                   |             508 |
| ASUKA II             | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Maio 2012       | D                   |             726 |
| AUSTRAL              | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Marco 2014      | D                   |             765 |
| AZAMARA QUEST        | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Dezembro 2012   | D                   |             639 |
| BALMORAL             | Programa de Inspecao Navios de Cruzeiro 2017/2018 -  Fevereiro 2018 | D                   |             760 |
50 rows in set (0.00 sec)





/* Mais operadores lógicos */
SELECT nome_navio, temporada, classificacao_risco, indice_conformidade
FROM cap02.tb_navios
WHERE classificacao_risco IN ('A', 'B') AND indice_conformidade > 98
ORDER BY nome_navio ASC;

nome_navio           | temporada                                                           | classificacao_risco | indice_conformidade |
+----------------------+---------------------------------------------------------------------+---------------------+---------------------+
| ADONIA               | Programa de Inspecao Navios de Cruzeiro 2017/2018 -  Novembro 2017  | A                   | 100,00              |
| ADONIA               | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Janeiro 2013    | A                   | 100,00              |
| ADONIA               | Programa de Inspecao Navios de Cruzeiro 2015/2016 - Novembro 2015   | A                   | 100,00              |
| AIDA CARA            | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Fevereiro 2012  | A                   | 100,00              |
| AIDA CARA            | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Novembro 2011   | A                   | 99,38               |
| AIDA VITA            | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Marco 2012      | A                   | 100,00              |
| AIDA VITA            | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Fevereiro 2013  | A                   | 100,00              |
| AIDA VITA            | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Novembro 2012   | A                   | 100,00              |
| AIDA VITA            | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Janeiro 2012    | A                   | 100,00              |
165 rows in set, 365 warnings (0.00 sec)





/* Limitar o número de linhas exibidas pela Query */
SELECT nome_navio, temporada, classificacao_risco, indice_conformidade
FROM cap02.tb_navios
WHERE classificacao_risco IN ('A', 'B') AND indice_conformidade > 90
ORDER BY indice_conformidade
LIMIT 10;

nome_navio           | temporada                                                          | classificacao_risco | indice_conformidade |
+----------------------+--------------------------------------------------------------------+---------------------+---------------------+
| SILVER CLOUD         | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Novembro 2011  | A                   | 100,00              |
| BOUDICCA             | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Janeiro 2013   | A                   | 100,00              |
| INSIGNIA             | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Novembro 2016  | A                   | 100,00              |
| COSTA FAVOLOSA       | Programa de Inspecao Navios de Cruzeiro 2014/2015 - Dezembro 2014  | A                   | 100,00              |
| SEABOURN QUEST       | Programa de Inspecao Navios de Cruzeiro 2015/2016 - Novembro 2015  | A                   | 100,00              |
| AIDA VITA            | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Marco 2012     | A                   | 100,00              |
| REGATTA              | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Fevereiro 2017 | A                   | 100,00              |
| SOVEREIGN (SOBERANO) | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Marco 2012     | A                   | 100,00              |
| VIKING SUN           | Programa de Inspecao Navios de Cruzeiro 2019/2020 - Novembro 2019  | A                   | 100,00              |
| AIDA VITA            | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Fevereiro 2013 | A                   | 100,00              |
+----------------------+--------------------------------------------------------------------+---------------------+---------------------+
10 rows in set, 365 warnings (0.00 sec)





/* Filtrando Utilizando 2 AND */
SELECT nome_navio, temporada, classificacao_risco, indice_conformidade, pontuacao_risco
FROM cap02.tb_navios
WHERE indice_conformidade > 90 AND pontuacao_risco = 0 AND mes_ano = '04/2018'
ORDER BY indice_conformidade;

------------+-----------------------------------------------------------------+---------------------+---------------------+-----------------+
| nome_navio | temporada                                                       | classificacao_risco | indice_conformidade | pontuacao_risco |
+------------+-----------------------------------------------------------------+---------------------+---------------------+-----------------+
| BREMEN     | Programa de Inspecao Navios de Cruzeiro 2017/2018 -  Abril 2018 | A                   | 100,00              |               0 |
+------------+-----------------------------------------------------------------+---------------------+---------------------+-----------------+
1 row in set, 131 warnings (0.00 sec)





/* FILTRANDO USANDO SUBQUERY */
/* NÃO É RECOMENDADO USAR O OPERADOR IN ELE COMPROMETE A PERFORMACE DO BANCO */
/* SUBQUERY DEVE SER EVITADA */
SELECT nome_navio, classificacao_risco, indice_conformidade, pontuacao_risco, temporada
FROM cap02.tb_navios
WHERE indice_conformidade IN (SELECT indice_conformidade
								FROM cap02.tb_navios
								WHERE indice_conformidade > 90)
								AND pontuacao_risco = 0
								AND mes_ano = '04/2018'
ORDER BY indice_conformidade;

------------+---------------------+---------------------+-----------------+-----------------------------------------------------------------+
| nome_navio | classificacao_risco | indice_conformidade | pontuacao_risco | temporada                                                       |
+------------+---------------------+---------------------+-----------------+-----------------------------------------------------------------+
| BREMEN     | A                   | 100,00              |               0 | Programa de Inspecao Navios de Cruzeiro 2017/2018 -  Abril 2018 |
+------------+---------------------+---------------------+-----------------+-----------------------------------------------------------------+
1 row in set, 463 warnings (0.01 sec)





/* Respondendo algumas perguntas */
/* 1-Quais embarcações possuem pontuação de risco igual a 310? */
SELECT *
FROM cap02.tb_navios
WHERE pontuacao_risco = 310;

---------------------+---------+---------------------+---------------------+-----------------+-------------------------------------------------------------------+
| nome_navio           | mes_ano | classificacao_risco | indice_conformidade | pontuacao_risco | temporada                                                         |
+----------------------+---------+---------------------+---------------------+-----------------+-------------------------------------------------------------------+
| HORIZON (PACIFIC DRE | 12/2010 | C                   | 90,76               |             310 | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Dezembro 2010 |
| AIDA CARA            | 11/2013 | C                   | 93,52               |             310 | Programa de Inspecao Navios de Cruzeiro 2013/2014 - novembro 2013 |
+----------------------+---------+---------------------+---------------------+-----------------+-------------------------------------------------------------------+
2 rows in set (0.00 sec)





/* 2-Quais embarcações tem classificação de risco A e índice de conformidade maior ou igual a 95%?  */
SELECT *
FROM cap02.tb_navios
WHERE classificacao_risco = 'A' 
AND indice_conformidade >= 95;

nome_navio           | mes_ano | classificacao_risco | indice_conformidade | pontuacao_risco | temporada                                                           |
+----------------------+---------+---------------------+---------------------+-----------------+---------------------------------------------------------------------+
| AZAMARA JOURNEY      | 02/2012 | A                   | 97,98               |              80 | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Fevereiro 2012  |
| BOUDICCA             | 01/2013 | A                   | 100,00              |               0 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Janeiro 2013    |
| NATIONAL GEOGRAPHIC  | 10/2014 | A                   | 97,43               |             125 | Programa de Inspecao Navios de Cruzeiro 2014/2015 - Outubro 2014    |
| COSTA PACIFICA       | 11/2019 | A                   | 98,20               |              90 | Programa de Inspecao Navios de Cruzeiro 2019/2020 - Novembro 2019   |
| SPLENDOUR OF THE SEA | 03/2013 | A                   | 99,40               |              30 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Marco 2013      |
| SOVEREIGN (SOBERANO) | 10/2015 | A                   | 98,65               |              65 | Programa de Inspecao Navios de Cruzeiro 2015/2016 - Dezembro 2015   |
| SOVEREIGN (SOBERANO) | 12/2016 | A                   | 97,60               |             120 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016   |
| REGATTA              | 02/2017 | A                   | 100,00              |               0 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Fevereiro 2017  |
259 rows in set, 261 warnings (0.00 sec)





/* 3-Quais embarcações tem classificação de risco C ou D e índice de conformidade menor ou igual a 95%? */
SELECT *
FROM cap02.tb_navios
WHERE indice_conformidade <= 95 AND (classificacao_risco = 'C' OR classificacao_risco = 'D');

nome_navio           | mes_ano | classificacao_risco | indice_conformidade | pontuacao_risco | temporada                                                           |
+----------------------+---------+---------------------+---------------------+-----------------+---------------------------------------------------------------------+
| HORIZON (PACIFIC DRE | 12/2010 | C                   | 90,76               |             310 | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Dezembro 2010   |
| SPLENDOUR OF THE SEA | 12/2012 | C                   | 91,71               |             415 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Dezembro 2012   |
| SEVEN SEAS MARINER   | 03/2016 | C                   | 92,70               |             365 | Programa de Inspecao Navios de Cruzeiro 2015/2016 - Marco 2016      |
| OCEAN DREAM          | 01/2014 | D                   | 85,56               |             715 | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Janeiro 2014    |
| SEABOURN ODYSSEY     | 02/2011 | D                   | 77,05               |             770 | Programa de Inspecao Navios de Cruzeiro 2010/2011 - Fevereiro 2011  |
| VOYAGER              | 03/2013 | D                   | 88,01               |             600 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Marco 2013      |
| ORIENT QUEEN II      | 12/2013 | D                   | 63,89               |            1065 | Programa de Inspecao Navios de Cruzeiro 2013/2014 - Dezembro 2013   |
98 rows in set, 463 warnings (0.00 sec)





/* 4-Quais embarcações tem classificação de risco A ou pontuação de risco igual a 0? */
SELECT *
FROM cap02.tb_navios
WHERE classificacao_risco = 'A'
OR pontuacao_risco = 0;

 nome_navio           | mes_ano | classificacao_risco | indice_conformidade | pontuacao_risco | temporada                                                           |
+----------------------+---------+---------------------+---------------------+-----------------+---------------------------------------------------------------------+
| AZAMARA JOURNEY      | 02/2012 | A                   | 97,98               |              80 | Programa de Inspecao Navios de Cruzeiro 2011/2012 - Fevereiro 2012  |
| BOUDICCA             | 01/2013 | A                   | 100,00              |               0 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Janeiro 2013    |
| NATIONAL GEOGRAPHIC  | 10/2014 | A                   | 97,43               |             125 | Programa de Inspecao Navios de Cruzeiro 2014/2015 - Outubro 2014    |
| COSTA PACIFICA       | 11/2019 | A                   | 98,20               |              90 | Programa de Inspecao Navios de Cruzeiro 2019/2020 - Novembro 2019   |
| SPLENDOUR OF THE SEA | 03/2013 | A                   | 99,40               |              30 | Programa de Inspecao Navios de Cruzeiro 2012/2013 - Marco 2013      |
| SOVEREIGN (SOBERANO) | 10/2015 | A                   | 98,65               |              65 | Programa de Inspecao Navios de Cruzeiro 2015/2016 - Dezembro 2015   |
| SOVEREIGN (SOBERANO) | 12/2016 | A                   | 97,60               |             120 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016   |
| COSTA LUMINOSA       | 01/2017 | A                   | 79,17               |             125 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Janeiro 2017    |
261 rows in set (0.00 sec)





/* 5-[DESAFIO]Quais embarcações foram inspecionadas em Dezembro de 2016? */
SELECT *
FROM cap02.tb_navios
WHERE mes_ano = '12/2016';

 nome_navio           | mes_ano | classificacao_risco | indice_conformidade | pontuacao_risco | temporada                                                         |
+----------------------+---------+---------------------+---------------------+-----------------+-------------------------------------------------------------------+
| SOVEREIGN (SOBERANO) | 12/2016 | A                   | 97,60               |             120 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016 |
| MSC PREZIOSA         | 12/2016 | A                   | 98,80               |              60 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016 |
| COSTA PACIFICA       | 12/2016 | A                   | 99,00               |              50 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016 |
| MSC MUSICA           | 12/2016 | A                   | 97,00               |             150 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016 |
| SILVER SPIRIT        | 12/2016 | A                   | 100,00              |               0 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Novembro 2016 |
| HAMBURG              | 12/2016 | C                   | 92,80               |             360 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016 |
| MARINA               | 12/2016 | B                   | 96,70               |             165 | Programa de Inspecao Navios de Cruzeiro 2016/2017 - Dezembro 2016 |
+----------------------+---------+---------------------+---------------------+-----------------+-------------------------------------------------------------------+
7 rows in set (0.00 sec)