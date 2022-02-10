Agregando Dados para Análise




como verificar o character set do banco de dados

SELECT @@character_set_database, @@collation_database;

ou o seguinte comando

SHOW VARIABLES LIKE 'collation%';

verificando o collations das tabelas

SELECT
table_schema,
table_name,
table_collation
FROM information_schema.tables
WHERE table_schema = 'olimpiadas'



--------------------------------------------------------------------------------------------------------

CREATE SCHEMA `cap05` ;


CREATE TABLE `cap05`.`TB_CLIENTES` (
  `id_cliente` INT NULL,
  `nome_cliente` VARCHAR(50) NULL,
  `endereco_cliente` VARCHAR(50) NULL,
  `cidade_cliente` VARCHAR(50) NULL,
  `estado_cliente` VARCHAR(50) NULL);


INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (1, "Bob Silva", "Rua 67", "Fortaleza", "CE");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (2, "Ronaldo Azevedo", "Rua 64", "Campinas", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (3, "John Lenon", "Rua 42", "Rio de Janeiro", "RJ");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (4, "Billy Joel", "Rua 39", "Campos", "RJ");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (5, "Lady Gaga", "Rua 45", "Porto Alegre", "RS");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (6, "Zico Nunes", "Rua 67", "Fortaleza", "CE");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (7, "Maria Aparecida", "Rua 61", "Natal", "RN");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (8, "Elton John", "Rua 22", "Ubatuba", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (9, "Dario Maravilha", "Rua 14", "Ubatuba", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (10, "Lebron James", "Rua 29", "Fortaleza", "CE");


CREATE TABLE `cap05`.`TB_PEDIDOS` (
  `id_pedido` INT NULL,
  `id_cliente` INT NULL,
  `id_vendedor` INT NULL,
  `data_pedido` DATETIME NULL,
  `id_entrega` INT NULL,
  `valor_pedido` DECIMAL(10,2) NULL);


INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1001, 1, 5, now(), 23, 100.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1002, 1, 7, now(), 24, 112.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1003, 2, 5, now(), 23, 250.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1004, 3, 5, now(), 23, 340.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1005, 4, 7, now(), 24, 1290.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1006, 9, 5, now(), 23, 89.00);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1007, 5, 5, now(), 23, 468.50);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1008, 1, 7, now(), 24, 572.20);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1009, 8, 5, now(), 23, 187.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1010, 7, 7, now(), 24, 579.20);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1011, 10, 5, now(), 23, 192.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1012, 8, 5, now(), 23, 140.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1013, 5, 7, now(), 28, 573.20);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1014, 6, 5, now(), 27, 191.45);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1015, 6, 4, now(), 22, 154.37);


CREATE TABLE `cap05`.`TB_VENDEDOR` (
  `id_vendedor` INT NULL,
  `nome_vendedor` VARCHAR(50) NULL,
  `dept_vendedor` VARCHAR(50) NULL);


INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (1, "Vendedor 1", "Eletronicos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (2, "Vendedor 2", "Vestuario");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (3, "Vendedor 3", "Eletronicos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (4, "Vendedor 4", "Moveis");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (5, "Vendedor 5", "Eletrodomesticos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (6, "Vendedor 6", "Eletrodomesticos");

INSERT INTO `cap05`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`, `dept_vendedor`)
VALUES (7, "Vendedor 7", "Eletronicos");

# Lista os clientes
SELECT * FROM cap05.tb_clientes;
+------------+-----------------+------------------+----------------+----------------+
| id_cliente | nome_cliente    | endereco_cliente | cidade_cliente | estado_cliente |
+------------+-----------------+------------------+----------------+----------------+
|          1 | Bob Silva       | Rua 67           | Fortaleza      | CE             |
|          2 | Ronaldo Azevedo | Rua 64           | Campinas       | SP             |
|          3 | John Lenon      | Rua 42           | Rio de Janeiro | RJ             |
|          4 | Billy Joel      | Rua 39           | Campos         | RJ             |
|          5 | Lady Gaga       | Rua 45           | Porto Alegre   | RS             |
|          6 | Zico Nunes      | Rua 67           | Fortaleza      | CE             |
|          7 | Maria Aparecida | Rua 61           | Natal          | RN             |
|          8 | Elton John      | Rua 22           | Ubatuba        | SP             |
|          9 | Dario Maravilha | Rua 14           | Ubatuba        | SP             |
|         10 | Lebron James    | Rua 29           | Fortaleza      | CE             |
+------------+-----------------+------------------+----------------+----------------+
10 rows in set (0.00 sec)



# Contagem de clientes por cidade (Query incorreta)
SELECT COUNT(id_cliente), cidade_cliente
FROM cap05.tb_clientes;
+-------------------+----------------+
| COUNT(id_cliente) | cidade_cliente |
+-------------------+----------------+
|                10 | Fortaleza      |
+-------------------+----------------+
1 row in set (0.00 sec)




# Contagem de clientes por cidade (Query correta)
SELECT COUNT(id_cliente), cidade_cliente
FROM cap05.tb_clientes
GROUP BY cidade_cliente;
+-------------------+----------------+
| COUNT(id_cliente) | cidade_cliente |
+-------------------+----------------+
|                 1 | Campinas       |
|                 1 | Campos         |
|                 3 | Fortaleza      |
|                 1 | Natal          |
|                 1 | Porto Alegre   |
|                 1 | Rio de Janeiro |
|                 2 | Ubatuba        |
+-------------------+----------------+
7 rows in set (0.00 sec)



# Contagem de clientes por cidade ordenado pela contagem
SELECT COUNT(id_cliente) AS clientes, cidade_cliente
FROM cap05.tb_clientes
GROUP BY cidade_cliente
ORDER BY clientes DESC;
+----------+----------------+
| clientes | cidade_cliente |
+----------+----------------+
|        3 | Fortaleza      |
|        2 | Ubatuba        |
|        1 | Natal          |
|        1 | Rio de Janeiro |
|        1 | Porto Alegre   |
|        1 | Campinas       |
|        1 | Campos         |
+----------+----------------+
7 rows in set (0.00 sec)



# Lista os pedidos
SELECT * FROM cap05.tb_pedidos;
+-----------+------------+-------------+---------------------+------------+--------------+
| id_pedido | id_cliente | id_vendedor | data_pedido         | id_entrega | valor_pedido |
+-----------+------------+-------------+---------------------+------------+--------------+
|      1001 |          1 |           5 | 2021-11-10 09:54:46 |         23 |       100.00 |
|      1002 |          1 |           7 | 2021-11-10 09:54:46 |         24 |       112.00 |
|      1003 |          2 |           5 | 2021-11-10 09:54:46 |         23 |       250.00 |
|      1004 |          3 |           5 | 2021-11-10 09:54:46 |         23 |       340.00 |
|      1005 |          4 |           7 | 2021-11-10 09:54:46 |         24 |      1290.00 |
|      1006 |          9 |           5 | 2021-11-10 09:54:46 |         23 |        89.00 |
|      1007 |          5 |           5 | 2021-11-10 09:54:46 |         23 |       468.50 |
|      1008 |          1 |           7 | 2021-11-10 09:54:46 |         24 |       572.20 |
|      1009 |          8 |           5 | 2021-11-10 09:54:46 |         23 |       187.45 |
|      1010 |          7 |           7 | 2021-11-10 09:54:46 |         24 |       579.20 |
|      1011 |         10 |           5 | 2021-11-10 09:54:46 |         23 |       192.45 |
|      1012 |          8 |           5 | 2021-11-10 09:54:46 |         23 |       140.45 |
|      1013 |          5 |           7 | 2021-11-10 09:54:46 |         28 |       573.20 |
|      1014 |          6 |           5 | 2021-11-10 09:54:46 |         27 |       191.45 |
|      1015 |          6 |           4 | 2021-11-10 09:54:46 |         22 |       154.37 |
+-----------+------------+-------------+---------------------+------------+--------------+
15 rows in set (0.00 sec)



# Calculando a média do valor dos pedidos
SELECT AVG(valor_pedido) AS media
FROM cap05.tb_pedidos;
+------------+
| media      |
+------------+
| 349.351333 |
+------------+
1 row in set (0.00 sec)




# Media do valor dos pedidos por cidade
SELECT AVG(valor_pedido) AS media, cidade_cliente
FROM cap05.tb_pedidos AS P, cap05.tb_clientes AS C
WHERE P.id_cliente = C.id_cliente
GROUP BY cidade_cliente;
+-------------+----------------+
| media       | cidade_cliente |
+-------------+----------------+
|  250.000000 | Campinas       |
| 1290.000000 | Campos         |
|  220.411667 | Fortaleza      |
|  579.200000 | Natal          |
|  520.850000 | Porto Alegre   |
|  340.000000 | Rio de Janeiro |
|  138.966667 | Ubatuba        |
+-------------+----------------+
7 rows in set (0.00 sec)




# Media do valor dos pedidos por cidade arredondando a média
SELECT ROUND(AVG(valor_pedido),2) AS media, cidade_cliente
FROM cap05.tb_pedidos AS P, cap05.tb_clientes AS C
WHERE P.id_cliente = C.id_cliente
GROUP BY cidade_cliente
ORDER BY media DESC;
+---------+----------------+
| media   | cidade_cliente |
+---------+----------------+
| 1290.00 | Campos         |
|  579.20 | Natal          |
|  520.85 | Porto Alegre   |
|  340.00 | Rio de Janeiro |
|  250.00 | Campinas       |
|  220.41 | Fortaleza      |
|  138.97 | Ubatuba        |
+---------+----------------+
7 rows in set (0.00 sec)

# Inserindo um novo registro, que não tem pedido associado
INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (11, "Michael Jordan", "Rua 21", "Palmas", "TO");



# Agora vamos pegar todos os registro mesmo que não tenha pedido associado
SELECT ROUND(AVG(valor_pedido),2) AS media, cidade_cliente
FROM cap05.tb_pedidos AS P RIGHT JOIN cap05.tb_clientes AS C
USING(id_cliente)
GROUP BY cidade_cliente
ORDER BY media DESC;
+---------+----------------+
| media   | cidade_cliente |
+---------+----------------+
| 1290.00 | Campos         |
|  579.20 | Natal          |
|  520.85 | Porto Alegre   |
|  340.00 | Rio de Janeiro |
|  250.00 | Campinas       |
|  220.41 | Fortaleza      |
|  138.97 | Ubatuba        |
|    NULL | Palmas         |
+---------+----------------+
8 rows in set (0.00 sec)



# Para uma melhor apresentação, não se deve deixar o valor como NULL
# Podemos tratar esses regitros que não tem pedido associado com o valor 0
# Fica com uma melhor visualização para entregar ao gestor
SELECT
  CASE 
      WHEN ROUND(AVG(valor_pedido),2) IS NULL THEN 0
      ELSE ROUND(AVG(valor_pedido),2)
  END AS media,
  cidade_cliente
FROM cap05.tb_pedidos AS P RIGHT JOIN cap05.tb_clientes AS C
USING(id_cliente)
GROUP BY cidade_cliente
ORDER BY media DESC;
+---------+----------------+
| media   | cidade_cliente |
+---------+----------------+
| 1290.00 | Campos         |
|  579.20 | Natal          |
|  520.85 | Porto Alegre   |
|  340.00 | Rio de Janeiro |
|  250.00 | Campinas       |
|  220.41 | Fortaleza      |
|  138.97 | Ubatuba        |
|       0 | Palmas         |
+---------+----------------+
8 rows in set (0.00 sec)



#Soma os valores de uma determinada coluna
SELECT SUM(valor_pedido) AS total
FROM cap05.tb_pedidos;
+---------+
| total   |
+---------+
| 5240.27 |
+---------+
1 row in set (0.03 sec)



# Somar os valores dos pedidos por cidade
SELECT SUM(valor_pedido) AS total, cidade_cliente
FROM cap05.tb_pedidos AS P
INNER JOIN cap05.tb_clientes AS C
USING (id_cliente)
GROUP BY cidade_cliente
ORDER BY total DESC;
+---------+----------------+
| total   | cidade_cliente |
+---------+----------------+
| 1322.47 | Fortaleza      |
| 1290.00 | Campos         |
| 1041.70 | Porto Alegre   |
|  579.20 | Natal          |
|  416.90 | Ubatuba        |
|  340.00 | Rio de Janeiro |
|  250.00 | Campinas       |
+---------+----------------+
7 rows in set (0.00 sec)



# Inserindo mais 2 registros de clientes
INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (12, "Bill Gates", "Rua 14", "Santos", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (13, "Jeff Bezos", "Rua 29", "Osasco", "SP");




# Verificando se os 2 novos registros constam na tabela de clientes
SELECT * FROM cap05.tb_clientes;
+------------+-----------------+------------------+----------------+----------------+
| id_cliente | nome_cliente    | endereco_cliente | cidade_cliente | estado_cliente |
+------------+-----------------+------------------+----------------+----------------+
|          1 | Bob Silva       | Rua 67           | Fortaleza      | CE             |
|          2 | Ronaldo Azevedo | Rua 64           | Campinas       | SP             |
|          3 | John Lenon      | Rua 42           | Rio de Janeiro | RJ             |
|          4 | Billy Joel      | Rua 39           | Campos         | RJ             |
|          5 | Lady Gaga       | Rua 45           | Porto Alegre   | RS             |
|          6 | Zico Nunes      | Rua 67           | Fortaleza      | CE             |
|          7 | Maria Aparecida | Rua 61           | Natal          | RN             |
|          8 | Elton John      | Rua 22           | Ubatuba        | SP             |
|          9 | Dario Maravilha | Rua 14           | Ubatuba        | SP             |
|         10 | Lebron James    | Rua 29           | Fortaleza      | CE             |
|         11 | Michael Jordan  | Rua 21           | Palmas         | TO             |
|         12 | Bill Gates      | Rua 14           | Santos         | SP             |
|         13 | Jeff Bezos      | Rua 29           | Osasco         | SP             |
+------------+-----------------+------------------+----------------+----------------+
13 rows in set (0.00 sec)



# Iserindo mais 3 pedidos
INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1016, 11, 5, now(), 27, 234.09);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1017, 12, 4, now(), 22, 678.30);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1018, 13, 4, now(), 22, 978.30);



# Verificando se os pedidos foram registrados na tabela de pedidos
SELECT * FROM cap05.tb_pedidos;
+-----------+------------+-------------+---------------------+------------+--------------+
| id_pedido | id_cliente | id_vendedor | data_pedido         | id_entrega | valor_pedido |
+-----------+------------+-------------+---------------------+------------+--------------+
|      1001 |          1 |           5 | 2021-11-10 09:54:46 |         23 |       100.00 |
|      1002 |          1 |           7 | 2021-11-10 09:54:46 |         24 |       112.00 |
|      1003 |          2 |           5 | 2021-11-10 09:54:46 |         23 |       250.00 |
|      1004 |          3 |           5 | 2021-11-10 09:54:46 |         23 |       340.00 |
|      1005 |          4 |           7 | 2021-11-10 09:54:46 |         24 |      1290.00 |
|      1006 |          9 |           5 | 2021-11-10 09:54:46 |         23 |        89.00 |
|      1007 |          5 |           5 | 2021-11-10 09:54:46 |         23 |       468.50 |
|      1008 |          1 |           7 | 2021-11-10 09:54:46 |         24 |       572.20 |
|      1009 |          8 |           5 | 2021-11-10 09:54:46 |         23 |       187.45 |
|      1010 |          7 |           7 | 2021-11-10 09:54:46 |         24 |       579.20 |
|      1011 |         10 |           5 | 2021-11-10 09:54:46 |         23 |       192.45 |
|      1012 |          8 |           5 | 2021-11-10 09:54:46 |         23 |       140.45 |
|      1013 |          5 |           7 | 2021-11-10 09:54:46 |         28 |       573.20 |
|      1014 |          6 |           5 | 2021-11-10 09:54:46 |         27 |       191.45 |
|      1015 |          6 |           4 | 2021-11-10 09:54:46 |         22 |       154.37 |
|      1016 |         11 |           5 | 2021-11-11 11:35:18 |         27 |       234.09 |
|      1017 |         12 |           4 | 2021-11-11 11:35:18 |         22 |       678.30 |
|      1018 |         13 |           4 | 2021-11-11 11:35:18 |         22 |       978.30 |
+-----------+------------+-------------+---------------------+------------+--------------+
18 rows in set (0.00 sec)



# Calculando o faturamento de pedidos por Cidade e por Estado
SELECT SUM(valor_pedido) AS total, cidade_cliente, estado_cliente
FROM cap05.tb_pedidos AS P
INNER JOIN cap05.tb_clientes AS C
USING (id_cliente)
GROUP BY cidade_cliente, estado_cliente
ORDER BY estado_cliente;
+---------+----------------+----------------+
| total   | cidade_cliente | estado_cliente |
+---------+----------------+----------------+
| 1322.47 | Fortaleza      | CE             |
|  340.00 | Rio de Janeiro | RJ             |
| 1290.00 | Campos         | RJ             |
|  579.20 | Natal          | RN             |
| 1041.70 | Porto Alegre   | RS             |
|  250.00 | Campinas       | SP             |
|  978.30 | Osasco         | SP             |
|  416.90 | Ubatuba        | SP             |
|  678.30 | Santos         | SP             |
|  234.09 | Palmas         | TO             |
+---------+----------------+----------------+
10 rows in set (0.00 sec)



# Iserindo mais 2 registros na tabela clientes
INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (14, "Melinda Gates", "Rua 14", "Barueri", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (15, "Barack Obama", "Rua 29", "Barueri", "SP");




# Soma(total) do valor dos pedidos por cidade e estado com RIGHT JOIN e CASE
SELECT
  CASE 
    WHEN FLOOR(SUM(valor_pedido)) IS NULL THEN 0
    ELSE FLOOR(SUM(valor_pedido))
  END AS total,
  cidade_cliente,
  estado_cliente
FROM cap05.tb_pedidos AS P RIGHT JOIN cap05.tb_clientes AS C
USING(id_cliente)
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC; 
+-------+----------------+----------------+
| total | cidade_cliente | estado_cliente |
+-------+----------------+----------------+
|  1322 | Fortaleza      | CE             |
|  1290 | Campos         | RJ             |
|  1041 | Porto Alegre   | RS             |
|   978 | Osasco         | SP             |
|   678 | Santos         | SP             |
|   579 | Natal          | RN             |
|   416 | Ubatuba        | SP             |
|   340 | Rio de Janeiro | RJ             |
|   250 | Campinas       | SP             |
|   234 | Palmas         | TO             |
|     0 | Barueri        | SP             |
+-------+----------------+----------------+
11 rows in set (0.00 sec)



# Supondo que a comissão de cada vendedor seja de 10%, quanto cada vendedor ganhou de comissão nas vendas
# no estado do Ceará ?
# Retorne 0 se não houve ganho de comissão
# Nessa QUERY conseguimos trazer a comissão de cada vendedor do CE, porém ainda não foi suficiente
# Para trazer vendedores que não fizeram vendas no CE
SELECT SUM(valor_pedido * 0.10) AS comissao, nome_vendedor, estado_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C, cap05.tb_vendedor V
WHERE P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'CE'
GROUP BY nome_vendedor, estado_cliente
ORDER BY estado_cliente;
+----------+---------------+----------------+
| comissao | nome_vendedor | estado_cliente |
+----------+---------------+----------------+
|  15.4370 | Vendedor 4    | CE             |
|  48.3900 | Vendedor 5    | CE             |
|  68.4200 | Vendedor 7    | CE             |
+----------+---------------+----------------+
3 rows in set (0.00 sec)




# Supondo que a comissão de cada vendedor seja de 10%, quanto cada vendedor ganhou de comissão nas vendas
# no estado do Ceará ?
# Retorne 0 se não houve ganho de comissão
# Agora com essa Query conseguimos trazer informações dos outros vendedores
# Más ainda os valores NULL não foram alterados!
SELECT SUM(valor_pedido * 0.10) AS comissao, nome_vendedor, estado_cliente
FROM cap05.tb_pedidos P INNER JOIN cap05.tb_clientes C RIGHT JOIN cap05.tb_vendedor V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'CE'
GROUP BY nome_vendedor, estado_cliente
ORDER BY estado_cliente;
+----------+---------------+----------------+
| comissao | nome_vendedor | estado_cliente |
+----------+---------------+----------------+
|     NULL | Vendedor 2    | NULL           |
|     NULL | Vendedor 3    | NULL           |
|     NULL | Vendedor 6    | NULL           |
|     NULL | Vendedor 1    | NULL           |
|  68.4200 | Vendedor 7    | CE             |
|  15.4370 | Vendedor 4    | CE             |
|  48.3900 | Vendedor 5    | CE             |
+----------+---------------+----------------+
7 rows in set (0.00 sec)




# Supondo que a comissão de cada vendedor seja de 10%, quanto cada vendedor ganhou de comissão nas vendas
# no estado do Ceará ?
# Retorne 0 se não houve ganho de comissão
# Agora a Query está completa, alteramos os valores NULL para 0 e que não atua no CE
SELECT
  CASE
    WHEN ROUND(SUM(valor_pedido * 0.10),2) IS NULL THEN 0
    ELSE ROUND(SUM(valor_pedido * 0.10),2)
    END AS comissao,
    nome_vendedor,
  CASE 
   WHEN estado_cliente IS NULL THEN 'Não Atua no CE'
   ELSE estado_cliente
   END AS estado_cliente
FROM cap05.tb_pedidos AS P INNER JOIN cap05.tb_clientes AS C RIGHT JOIN cap05.tb_vendedor AS V 
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'CE'
GROUP BY nome_vendedor, estado_cliente
ORDER BY estado_cliente;
+----------+---------------+-----------------+
| comissao | nome_vendedor | estado_cliente  |
+----------+---------------+-----------------+
|    48.39 | Vendedor 5    | CE              |
|    15.44 | Vendedor 4    | CE              |
|    68.42 | Vendedor 7    | CE              |
|        0 | Vendedor 6    | Não Atua no CE  |
|        0 | Vendedor 3    | Não Atua no CE  |
|        0 | Vendedor 2    | Não Atua no CE  |
|        0 | Vendedor 1    | Não Atua no CE  |
+----------+---------------+-----------------+
7 rows in set, 1 warning (0.00 sec)




# Como trazer o maior valor da coluna de valor_pedido
SELECT MAX(valor_pedido) AS maximo
FROM cap05.tb_pedidos;
+---------+
| maximo  |
+---------+
| 1290.00 |
+---------+
1 row in set (0.00 sec)




# Como trazer o menor valor da coluna de valor_pedido
SELECT MIN(valor_pedido) AS maximo
FROM cap05.tb_pedidos;
+--------+
| maximo |
+--------+
|  89.00 |
+--------+
1 row in set (0.00 sec)



# Trazendo o total de pedidos
SELECT COUNT(*) as pedidos FROM cap05.tb_pedidos;
+---------+
| pedidos |
+---------+
|      18 |
+---------+
1 row in set (0.00 sec)




# Número de clientes que fizeram pedidos
SELECT COUNT(DISTINCT id_cliente) AS clientes FROM cap05.tb_pedidos;
+----------+
| clientes |
+----------+
|       13 |
+----------+
1 row in set (0.00 sec)




# Número de pedidos de clientes do CE
SELECT nome_cliente, cidade_cliente, COUNT(C.id_cliente) AS num_pedidos
FROM cap05.tb_pedidos P, cap05.tb_clientes C
WHERE P.id_cliente = C.id_cliente
AND estado_cliente = 'CE'
GROUP BY nome_cliente, cidade_cliente;
+--------------+----------------+-------------+
| nome_cliente | cidade_cliente | num_pedidos |
+--------------+----------------+-------------+
| Bob Silva    | Fortaleza      |           3 |
| Lebron James | Fortaleza      |           1 |
| Zico Nunes   | Fortaleza      |           2 |
+--------------+----------------+-------------+
3 rows in set (0.00 sec)




# Algum vendedor participou de vendas cujo valor pedido tenha sido superior a 600 no estado de SP?
SELECT nome_vendedor, valor_pedido, estado_cliente
FROM cap05.tb_vendedor AS V, cap05.tb_pedidos AS P, cap05.tb_clientes AS C
WHERE V.id_vendedor = P.id_vendedor
AND C.id_cliente = P.id_cliente
AND estado_cliente = 'SP'
AND valor_pedido > 600;
+---------------+--------------+----------------+
| nome_vendedor | valor_pedido | estado_cliente |
+---------------+--------------+----------------+
| Vendedor 4    |       678.30 | SP             |
| Vendedor 4    |       978.30 | SP             |
+---------------+--------------+----------------+
2 rows in set (0.00 sec)




# Cláusula HAVING
# Algum vendedor participou de vendas em que a média do valor_pedido por estado do cliente foi > 800?
SELECT estado_cliente, nome_vendedor, CEILING(AVG(valor_pedido)) AS media
FROM cap05.tb_pedidos P INNER JOIN cap05.tb_clientes C INNER JOIN cap05.tb_vendedor V  
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
GROUP BY estado_cliente, nome_vendedor
HAVING media > 800
ORDER BY nome_vendedor;
+----------------+---------------+-------+
| estado_cliente | nome_vendedor | media |
+----------------+---------------+-------+
| SP             | Vendedor 4    |   829 |
| RJ             | Vendedor 7    |  1290 |
+----------------+---------------+-------+
2 rows in set (0.05 sec)




# Qual estado teve mais de 5 pedidos ?
SELECT COUNT(id_pedido) AS total_pedido, estado_cliente
FROM cap05.tb_pedidos P INNER JOIN cap05.tb_clientes C
ON P.id_cliente = C.id_cliente
GROUP BY estado_cliente
HAVING total_pedido > 5
ORDER BY total_pedido DESC;
+--------------+----------------+
| total_pedido | estado_cliente |
+--------------+----------------+
|            6 | CE             |
|            6 | SP             |
+--------------+----------------+
2 rows in set (0.00 sec)




# Grouping Sets, CUBE, ROLLUP
# Vamos criar uma nova tabela e inserir novos registros nessa tabela
CREATE TABLE `cap05`.`TB_VENDAS` (
  `ano` INT NULL,
  `pais` VARCHAR(45) NULL,
  `produto` VARCHAR(45) NULL,
  `faturamento` INT NULL);

# Insere registros
INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Brasil', 'Geladeira', 1130);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Brasil', 'TV', 980);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Argentina', 'Geladeira', 2180);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Argentina', 'TV', 2240);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Portugal', 'Smartphone', 2310);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Portugal', 'TV', 1900);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2021, 'Inglaterra', 'Notebook', 1800);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Brasil', 'Geladeira', 1400);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Brasil', 'TV', 1345);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Argentina', 'Geladeira', 2180);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Argentina', 'TV', 1390);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Portugal', 'Smartphone', 2480);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Portugal', 'TV', 1980);

INSERT INTO `cap05`.`TB_VENDAS` (`ano`, `pais`, `produto`, `faturamento`)
VALUE (2022, 'Inglaterra', 'Notebook', 2300);


# Faturamento total por ano
SELECT ano, SUM(faturamento) AS faturamento
FROM cap05.tb_vendas
GROUP BY ano;
+------+-------------+
| ano  | faturamento |
+------+-------------+
| 2021 |       12540 |
| 2022 |       13075 |
+------+-------------+
2 rows in set (0.00 sec)



# Faturamento total geral de todos os anos
SELECT ano, SUM(faturamento) AS faturamento
FROM cap05.tb_vendas
GROUP BY ano WITH ROLLUP;
+------+-------------+
| ano  | faturamento |
+------+-------------+
| 2021 |       12540 |
| 2022 |       13075 |
| NULL |       25615 |
+------+-------------+
3 rows in set (0.00 sec)



# Faturamento total por ano e por País
SELECT ano, pais, SUM(faturamento) AS faturamento
FROM cap05.tb_vendas
GROUP BY ano, pais;
+------+------------+-------------+
| ano  | pais       | faturamento |
+------+------------+-------------+
| 2021 | Argentina  |        4420 |
| 2021 | Brasil     |        2110 |
| 2021 | Inglaterra |        1800 |
| 2021 | Portugal   |        4210 |
| 2022 | Argentina  |        3570 |
| 2022 | Brasil     |        2745 |
| 2022 | Inglaterra |        2300 |
| 2022 | Portugal   |        4460 |
+------+------------+-------------+
8 rows in set (0.00 sec)




# Faturamento total por ano e produto a total geral.
SELECT ano, produto, SUM(faturamento) AS faturamento
FROM cap05.tb_vendas
GROUP BY ano, produto WITH ROLLUP;
+------+------------+-------------+
| ano  | produto    | faturamento |
+------+------------+-------------+
| 2021 | Geladeira  |        3310 |
| 2021 | Notebook   |        1800 |
| 2021 | Smartphone |        2310 |
| 2021 | TV         |        5120 |
| 2021 | NULL       |       12540 |
| 2022 | Geladeira  |        3580 |
| 2022 | Notebook   |        2300 |
| 2022 | Smartphone |        2480 |
| 2022 | TV         |        4715 |
| 2022 | NULL       |       13075 |
| NULL | NULL       |       25615 |
+------+------------+-------------+
11 rows in set (0.00 sec)