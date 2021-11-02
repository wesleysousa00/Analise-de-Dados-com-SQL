 

                       O que é um relacionamento entre dados ?


O relacionamento entre dados, é quando temos 2 tabelas diferentes, e queremos trazer informações
de ambas as tabelas, para isso utilizamos a cláusula JOIN, temos básicamente 4 tipos de JOIN mais utilizados,
são eles INNER JOIN, LEFT JOIN, RIGHT JOIN e FULL JOIN.
Existem outros tipos como Cross JOIN também, más focarei nos 4 tipos de Join mais utilizados.

(INNER) JOIN: Retorna registros que possuem valores correspondentes em ambas as tabelas. 
(LEFT) JOIN: Retorna todos os registros da tabela da esquerda e os registros correspondentes da tabela da direita.
(RIGHT) JOIN: Retorna todos os registros da tabela da direita e os registros correspondentes da tabela da esquerda.
(FULL) JOIN: Retorna todos os registros quando há uma correspondência na tabela da esquerda ou da direita.

				 
Primeiro vamos carregar os dados para realizarmos a junção de tabelas.

/* Criando uma base de dados */
CREATE SCHEMA `cap04` ;




/* Criando a primeira tabela */
CREATE TABLE `cap04`.`TB_CLIENTES` (
  `id_cliente` INT NULL,
  `nome_cliente` VARCHAR(50) NULL,
  `endereco_cliente` VARCHAR(50) NULL,
  `cidade_cliente` VARCHAR(50) NULL,
  `estado_cliente` VARCHAR(50) NULL);




/* Agora vamos inserir registros nessa tabela */
INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (1, "Bob Silva", "Rua 67", "Fortaleza", "CE");

INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (2, "Ronaldo Azevedo", "Rua 64", "Campinas", "SP");

INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (3, "John Lenon", "Rua 42", "Rio de Janeiro", "RJ");

INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (4, "Billy Joel", "Rua 39", "Campos", "RJ");

INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (5, "Lady Gaga", "Rua 45", "Porto Alegre", "RS");



/* Criação da segunda tabela */
CREATE TABLE `cap04`.`TB_PEDIDOS` (
  `id_pedido` INT NULL,
  `id_cliente` INT NULL,
  `id_vendedor` INT NULL,
  `data_pedido` DATETIME NULL,
  `id_entrega` INT NULL);




/* Inserindo registros na segunda tabela */
INSERT INTO `cap04`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`)
VALUES (1001, 1, 5, now(), 23);

INSERT INTO `cap04`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`)
VALUES (1002, 1, 7, now(), 24);

INSERT INTO `cap04`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`)
VALUES (1003, 2, 5, now(), 23);




/* Criando a terceira tabela */
CREATE TABLE `cap04`.`TB_VENDEDOR` (
  `id_vendedor` INT NULL,
  `nome_vendedor` VARCHAR(50) NULL);



/* Inserindo registros na terceira tabela */
INSERT INTO `cap04`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`)
VALUES (1, "Vendedor 1");

INSERT INTO `cap04`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`)
VALUES (2, "Vendedor 2");

INSERT INTO `cap04`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`)
VALUES (3, "Vendedor 3");

INSERT INTO `cap04`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`)
VALUES (4, "Vendedor 4");

INSERT INTO `cap04`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`)
VALUES (5, "Vendedor 5");

INSERT INTO `cap04`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`)
VALUES (6, "Vendedor 6");

INSERT INTO `cap04`.`TB_VENDEDOR` (`id_vendedor`, `nome_vendedor`)
VALUES (7, "Vendedor 7");



/* Pronto agora com as 3 tabelas criando e com registros, podemos começar a realizar a junção de tabelas */
/* Primeiro vamos dar um show tables, pra verificar se todas as tabelas estão criadas */
SHOW TABLES;
+-----------------+
| Tables_in_cap04 |
+-----------------+
| tb_clientes     |
| tb_pedidos      |
| tb_vendedor     |
+-----------------+
3 rows in set (0.00 sec)




/* Primeiro desafio é retornar o id do pedido e o nome do cliente */
/* O id do pedido fica na tabela TB_PEDIDOS e o nome do cliente fica na tabela TB_CLIENTE */
/* Vamos começar utilizando o INNER JOIN Padrão ANSI */

SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P
INNER JOIN CAP04.TB_CLIENTES AS C
ON P.id_cliente = C.id_cliente;
+-----------+-----------------+
| id_pedido | nome_cliente    |
+-----------+-----------------+
|      1001 | Bob Silva       |
|      1002 | Bob Silva       |
|      1003 | Ronaldo Azevedo |
+-----------+-----------------+
3 rows in set (0.06 sec)



/* Quando o nome da coluna que faz o relacionamento é o mesmo em ambas as tabelas */
/* Podemos utilizar a cláusula USING */
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P
INNER JOIN CAP04.TB_CLIENTES AS C
USING (id_cliente);
+-----------+-----------------+
| id_pedido | nome_cliente    |
+-----------+-----------------+
|      1001 | Bob Silva       |
|      1002 | Bob Silva       |
|      1003 | Ronaldo Azevedo |
+-----------+-----------------+
3 rows in set (0.00 sec)




/* Também podemos utilizar a junção de tabelas utilizando o WHERE */
SELECT P.id_pedido, C.nome_cliente
FROM cap04.TB_PEDIDOS AS P, cap04.TB_CLIENTES AS C
WHERE P.id_cliente = C.id_cliente;
+-----------+-----------------+
| id_pedido | nome_cliente    |
+-----------+-----------------+
|      1001 | Bob Silva       |
|      1002 | Bob Silva       |
|      1003 | Ronaldo Azevedo |
+-----------+-----------------+
3 rows in set (0.00 sec)




/* Agora vamos utilizar o INNER JOIN em 3 tabelas diferentes */
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM ((cap04.TB_PEDIDOS AS P
INNER JOIN cap04.TB_CLIENTES AS C ON P.id_cliente = C.id_cliente)
INNER JOIN cap04.TB_VENDEDOR AS V ON P.id_vendedor = V.id_vendedor);
+-----------+-----------------+---------------+
| id_pedido | nome_cliente    | nome_vendedor |
+-----------+-----------------+---------------+
|      1001 | Bob Silva       | Vendedor 5    |
|      1003 | Ronaldo Azevedo | Vendedor 5    |
|      1002 | Bob Silva       | Vendedor 7    |
+-----------+-----------------+---------------+
3 rows in set (0.02 sec)





/* Também podemos utilizar a junção de 3 tabelas com o WHERE */
SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM cap04.TB_PEDIDOS AS P, cap04.TB_CLIENTES AS C, cap04.TB_VENDEDOR AS V
WHERE P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor;
+-----------+-----------------+---------------+
| id_pedido | nome_cliente    | nome_vendedor |
+-----------+-----------------+---------------+
|      1001 | Bob Silva       | Vendedor 5    |
|      1003 | Ronaldo Azevedo | Vendedor 5    |
|      1002 | Bob Silva       | Vendedor 7    |
+-----------+-----------------+---------------+
3 rows in set (0.00 sec)




/* Agora vamos aumentando a complexidade da Query utilizando o ORDER BY, e o LIKE */
/* O LIKE significa traga aquele nome que vem primeiro e o simbolo de % siginifica qualquer coisa */
/* Ou seja começa com BOB e termina com qualquer coisa */
SELECT P.id_pedido, C.id_cliente
FROM CAP04.TB_PEDIDOS AS P
INNER JOIN CAP04.TB_CLIENTES AS C
USING (id_cliente)
WHERE C.nome_cliente LIKE 'Bob%'
ORDER BY P.id_pedido DESC;
+-----------+------------+
| id_pedido | id_cliente |
+-----------+------------+
|      1002 |          1 |
|      1001 |          1 |
+-----------+------------+
2 rows in set (0.00 sec)




/* LEFT JOIN */
/* Indica que queremos todos os dados da tabela da esquerda */
/* Mesmo sem correspondente na tabela da direita */
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
LEFT JOIN cap04.TB_PEDIDOS AS P
ON C.id_cliente = P.id_cliente;
+-----------------+-----------+
| nome_cliente    | id_pedido |
+-----------------+-----------+
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Ronaldo Azevedo |      1003 |
| John Lenon      |      NULL |
| Billy Joel      |      NULL |
| Lady Gaga       |      NULL |
| Madona          |      NULL |
+-----------------+-----------+
7 rows in set (0.00 sec)




/* Se invertermos a ordem das tabelas o resultado é diferente */
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_PEDIDOS AS P
LEFT JOIN cap04.TB_CLIENTES AS C
ON C.id_cliente = P.id_cliente;
+-----------------+-----------+
| nome_cliente    | id_pedido |
+-----------------+-----------+
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Ronaldo Azevedo |      1003 |
| NULL            |      1004 |
+-----------------+-----------+
4 rows in set (0.00 sec)




/* RIGHT JOIN */
/* Indica que queremos todos os dados da tabela da direita */
/* Mesmo sem correspondente na tabela da esquerda */
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_PEDIDOS AS P
RIGHT JOIN cap04.TB_CLIENTES AS C
ON C.id_cliente = P.id_cliente;
+-----------------+-----------+
| nome_cliente    | id_pedido |
+-----------------+-----------+
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Ronaldo Azevedo |      1003 |
| John Lenon      |      NULL |
| Billy Joel      |      NULL |
| Lady Gaga       |      NULL |
| Madona          |      NULL |
+-----------------+-----------+
7 rows in set (0.00 sec)




/* Se invertermos a ordem das tabelas o resultado é diferente */
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
RIGHT JOIN cap04.TB_PEDIDOS AS P
ON C.id_cliente = P.id_cliente;
+-----------------+-----------+
| nome_cliente    | id_pedido |
+-----------------+-----------+
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Ronaldo Azevedo |      1003 |
| NULL            |      1004 |
+-----------------+-----------+
4 rows in set (0.00 sec)



/* Retornar a data do pedido, o nome do cliente, todos os vendedores */
/* com ou sem pedido associado, e ordenar o resultado pelo nome do cliente */

SELECT P.data_pedido, C.nome_cliente, V.nome_vendedor
FROM ((CAP04.TB_PEDIDOS AS P
JOIN CAP04.TB_CLIENTES AS C ON P.id_cliente = C.id_cliente)
RIGHT JOIN CAP04.TB_VENDEDOR AS V ON P.id_vendedor = V.id_vendedor)
ORDER BY C.nome_cliente;
+---------------------+-----------------+---------------+
| data_pedido         | nome_cliente    | nome_vendedor |
+---------------------+-----------------+---------------+
| NULL                | NULL            | Vendedor 6    |
| NULL                | NULL            | Vendedor 1    |
| NULL                | NULL            | Vendedor 2    |
| NULL                | NULL            | Vendedor 3    |
| NULL                | NULL            | Vendedor 4    |
| 2021-10-25 10:49:02 | Bob Silva       | Vendedor 5    |
| 2021-10-25 10:49:02 | Bob Silva       | Vendedor 7    |
| 2021-10-25 10:49:02 | Ronaldo Azevedo | Vendedor 5    |
+---------------------+-----------------+---------------+
8 rows in set (0.00 sec)




/* Veja que entregar uma query assim com valores NULOS não fica muito agradável */
/* Podemos tratar esses valores NULOS para ter uma maior legibilidade */
SELECT
	CASE
		WHEN P.data_pedido IS NULL THEN 'Sem Pedido'
			ELSE P.data_pedido
	END AS data_pedido,
	CASE
		WHEN C.nome_cliente IS NULL THEN 'Sem Pedido'
			ELSE C.nome_cliente
	END AS nome_cliente,
	V.nome_vendedor
FROM ((CAP04.TB_PEDIDOS AS P
JOIN CAP04.TB_CLIENTES AS C ON P.id_cliente = C.id_cliente)
RIGHT JOIN CAP04.TB_VENDEDOR AS V ON P.id_vendedor = V.id_vendedor)
ORDER BY C.nome_cliente;
+---------------------+-----------------+---------------+
| data_pedido         | nome_cliente    | nome_vendedor |
+---------------------+-----------------+---------------+
| Sem Pedido          | Sem Pedido      | Vendedor 1    |
| Sem Pedido          | Sem Pedido      | Vendedor 2    |
| Sem Pedido          | Sem Pedido      | Vendedor 3    |
| Sem Pedido          | Sem Pedido      | Vendedor 4    |
| Sem Pedido          | Sem Pedido      | Vendedor 6    |
| 2021-10-25 10:49:02 | Bob Silva       | Vendedor 5    |
| 2021-10-25 10:49:02 | Bob Silva       | Vendedor 7    |
| 2021-10-25 10:49:02 | Ronaldo Azevedo | Vendedor 5    |
+---------------------+-----------------+---------------+
8 rows in set (0.00 sec)




/* No MYSQL não temos o FULL JOIN, então utilizamos o LEFT JOIN com o RIGHT JOIN */
/* E para unir as duas querys utilizamos a cláusula UNION, fazendo assim o FULL JOIN do MYSQL */
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
LEFT JOIN cap04.TB_PEDIDOS AS P
ON C.id_cliente = P.id_cliente
UNION
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
RIGHT JOIN cap04.TB_PEDIDOS AS P
ON C.id_cliente = P.id_cliente;
+-----------------+-----------+
| nome_cliente    | id_pedido |
+-----------------+-----------+
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Ronaldo Azevedo |      1003 |
| John Lenon      |      NULL |
| Billy Joel      |      NULL |
| Lady Gaga       |      NULL |
| Madona          |      NULL |
| NULL            |      1004 |
+-----------------+-----------+
8 rows in set (0.00 sec)




/* O UNION ALL retorna tudo, até os valores duplicados */
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
LEFT JOIN cap04.TB_PEDIDOS AS P
ON C.id_cliente = P.id_cliente
UNION ALL
SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES AS C
RIGHT JOIN cap04.TB_PEDIDOS AS P
ON C.id_cliente = P.id_cliente;
+-----------------+-----------+
| nome_cliente    | id_pedido |
+-----------------+-----------+
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Ronaldo Azevedo |      1003 |
| John Lenon      |      NULL |
| Billy Joel      |      NULL |
| Lady Gaga       |      NULL |
| Madona          |      NULL |
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Ronaldo Azevedo |      1003 |
| NULL            |      1004 |
+-----------------+-----------+
11 rows in set (0.00 sec)




/* Retornar clientes que sejam da mesma cidade sem informar qual é a cidade */
SELECT A.nome_cliente, A.cidade_cliente
FROM cap04.tb_clientes A, cap04.tb_clientes B
WHERE A.id_cliente <> B.id_cliente
AND A.cidade_cliente = B.cidade_cliente;
+--------------+----------------+
| nome_cliente | cidade_cliente |
+--------------+----------------+
| Madona       | Campos         |
| Billy Joel   | Campos         |
+--------------+----------------+
2 rows in set (0.00 sec)




/* CROOS JOIN retornar todos os dados de todas as tabelas da consulta */ 
SELECT C.nome_cliente, P.id_pedido
FROM cap04.tb_clientes AS C
CROSS JOIN cap04.tb_pedidos AS P;
+-----------------+-----------+
| nome_cliente    | id_pedido |
+-----------------+-----------+
| Bob Silva       |      1001 |
| Bob Silva       |      1002 |
| Bob Silva       |      1003 |
| Bob Silva       |      1004 |
| Ronaldo Azevedo |      1001 |
| Ronaldo Azevedo |      1002 |
| Ronaldo Azevedo |      1003 |
| Ronaldo Azevedo |      1004 |
| John Lenon      |      1001 |
| John Lenon      |      1002 |
| John Lenon      |      1003 |
| John Lenon      |      1004 |
| Billy Joel      |      1001 |
| Billy Joel      |      1002 |
| Billy Joel      |      1003 |
| Billy Joel      |      1004 |
| Lady Gaga       |      1001 |
| Lady Gaga       |      1002 |
| Lady Gaga       |      1003 |
| Lady Gaga       |      1004 |
| Madona          |      1001 |
| Madona          |      1002 |
| Madona          |      1003 |
| Madona          |      1004 |
+-----------------+-----------+
24 rows in set (0.00 sec)