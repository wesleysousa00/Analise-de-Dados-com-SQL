Programação em SQL


# INSERT UPDATE DELETE
# O Insert inseri registros
# O Update sobrescreve os dados
# O Delete apaga os dados

INSERT INTO cap10.TB_CLIENTE 
	(NK_ID_CLIENTE, 
	NM_CLIENTE, 
	NM_CIDADE_CLIENTE, 
	BY_ACEITA_CAMPANHA, 
	DESC_CEP) 
VALUES 
	('A10984EDCF10092', 
	'Bob Marley', 
	'Rio de Janeiro', 
	'1', 
	'72132900');

UPDATE cap10.TB_PRODUTO
SET nm_marca_produto = 'LG'
WHERE sk_produto = 4;


DELETE FROM cap10.TB_PRODUTO
WHERE sk_produto = 10;


# Limpa a tabela
TRUNCATE cap10.TB_TEMPO;

# Store Procedure

DELIMITER //
CREATE PROCEDURE cap10.CARREGA_TB_TEMPO(IN startdate DATE, IN stopdate DATE)
BEGIN
    DECLARE currentdate DATE;
    SET currentdate = startdate;
    WHILE currentdate <= stopdate DO
        INSERT INTO cap10.TB_TEMPO VALUES (
           YEAR(currentdate)*10000+MONTH(currentdate)*100 + DAY(currentdate),
           currentdate,
           YEAR(currentdate),
           MONTH(currentdate),
           DAY(currentdate),
           QUARTER(currentdate),
           WEEKOFYEAR(currentdate),
           DATE_FORMAT(currentdate,'%W'),
           DATE_FORMAT(currentdate,'%M'),
           'f',
           CASE DAYOFWEEK(currentdate) WHEN 1 THEN 't' WHEN 7 then 't' ELSE 'f' END);
        SET currentdate = ADDDATE(currentdate,INTERVAL 1 DAY);
    END WHILE;
END
//
DELIMITER ;


# Executa a Stored Procedure
CALL cap10.CARREGA_TB_TEMPO('2010-01-01','2030-01-01');

OPTIMIZE TABLE cap10.TB_TEMPO;


# Criação de Stored Procedure

DELIMITER //
CREATE PROCEDURE cap10.NOME_SP()
BEGIN

...

END 
//
DELIMITER ;


# Criando uma STORE PROCEDURE para extrair clientes

DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES1()
BEGIN
	SELECT 
		NM_CLIENTE,
		NM_CIDADE_CLIENTE,
		ROUND(AVG(VALOR_VENDA),2) AS MEDIA_VALOR_VENDA
	FROM
		CAP10.TB_CLIENTE A,
		CAP10.TB_VENDA B
	WHERE 
	B.SK_CLIENTE = A.SK_CLIENTE
	GROUP BY NM_CLIENTE, NM_CIDADE_CLIENTE;
END
//
DELIMITER ;
Query OK, 0 rows affected (0.01 sec)


# EXECUTANDO A STORE PROCEDURE
CALL cap10.SP_EXTRAI_CLIENTES1();
+-------------------+-------------------+-------------------+
| NM_CLIENTE        | NM_CIDADE_CLIENTE | MEDIA_VALOR_VENDA |
+-------------------+-------------------+-------------------+
| Bob Marley        | Rio de Janeiro    |            426.48 |
| Elvis Presley     | Rio de Janeiro    |            178.15 |
| Chuck Berry       | Fortaleza         |            478.15 |
| James Brown       | Porto Alegre      |            540.53 |
| Aretha Franklin   | Natal             |            520.45 |
| Ray Charles       | Fortaleza         |            813.07 |
| Marvin Gaye       | Natal             |            891.10 |
| Bruce Springsteen | Porto Alegre      |            648.17 |
| Neil Young        | Rio de Janeiro    |            267.44 |
| John Lennon       | Rio de Janeiro    |            384.96 |
+-------------------+-------------------+-------------------+
10 rows in set (0.00 sec)

# CRIANDO UMA STORE PROCEDURE COM ARGUMENTO DE ENTRADA IN
DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES2(IN MEDIA INT)
BEGIN
	SELECT
		NM_CLIENTE,
		NM_CIDADE_CLIENTE,
		ROUND(AVG(VALOR_VENDA),2) AS MEDIA_VALOR_VENDA
	FROM
		cap10.TB_CLIENTE A,
		cap10.TB_VENDA B
	WHERE B.SK_CLIENTE = A.SK_CLIENTE
	GROUP BY NM_CLIENTE, NM_CIDADE_CLIENTE
	HAVING MEDIA_VALOR_VENDA > MEDIA;
END
//
DELIMITER ;
Query OK, 0 rows affected (0.01 sec)

CALL cap10.SP_EXTRAI_CLIENTES2(500);
+-------------------+-------------------+-------------------+
| NM_CLIENTE        | NM_CIDADE_CLIENTE | MEDIA_VALOR_VENDA |
+-------------------+-------------------+-------------------+
| James Brown       | Porto Alegre      |            540.53 |
| Aretha Franklin   | Natal             |            520.45 |
| Ray Charles       | Fortaleza         |            813.07 |
| Marvin Gaye       | Natal             |            891.10 |
| Bruce Springsteen | Porto Alegre      |            648.17 |
+-------------------+-------------------+-------------------+
5 rows in set (0.01 sec)


CALL cap10.SP_EXTRAI_CLIENTES2(800);
+-------------+-------------------+-------------------+
| NM_CLIENTE  | NM_CIDADE_CLIENTE | MEDIA_VALOR_VENDA |
+-------------+-------------------+-------------------+
| Ray Charles | Fortaleza         |            813.07 |
| Marvin Gaye | Natal             |            891.10 |
+-------------+-------------------+-------------------+
2 rows in set (0.00 sec)




# Criando uma STORE PROCEDURE COM ARGUMENTO DE SAUDA OUT
DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES3(OUT Contagem_Clientes int)
BEGIN
    SELECT COUNT(*)
    INTO Contagem_Clientes
    FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B
    WHERE B.sk_cliente = A.sk_cliente
    AND valor_venda > 500;
END 
//
DELIMITER ;
Query OK, 0 rows affected (0.01 sec)


CALL cap10.SP_EXTRAI_CLIENTES3(@contagem);
SELECT @contagem AS CLIENTES


# NOVA STORED PROCEDURE COM VARIÁVEL DECLARADA
DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES4(IN cliente VARCHAR(20), OUT desconto VARCHAR(30))
BEGIN

    DECLARE MediaValorVenda INT DEFAULT 0;

    SELECT ROUND(AVG(valor_venda),2) AS media_valor_venda
    INTO MediaValorVenda
    FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B, cap10.TB_LOCALIDADE C, cap10.TB_PRODUTO D
    WHERE B.sk_cliente = A.sk_cliente
      AND B.sk_localidade = C.sk_localidade
      AND B.sk_produto = D.sk_produto
      AND nm_marca_produto IN ("LG", "Apple", "Canon", "Samsung")
      AND nm_regiao_localidade LIKE "S%" OR "N%"
    GROUP BY nk_id_cliente, nm_cliente, nm_regiao_localidade, nm_marca_produto
    HAVING media_valor_venda > 500
       AND nk_id_cliente = cliente;

    IF MediaValorVenda >= 500 AND MediaValorVenda <= 600 THEN
        SET desconto = "Plano Básico de Desconto";
    ELSEIF MediaValorVenda > 600 AND MediaValorVenda <= 800 THEN
        SET desconto = "Plano Premium de Desconto";
    ELSE
        SET desconto = "Plano Ouro de Desconto";
    END IF;
END 
//
DELIMITER ;



CALL cap10.SP_EXTRAI_CLIENTES4("A10984EDCF10092", @plano);
SELECT @plano AS CLIENTES;

CALL cap10.SP_EXTRAI_CLIENTES4("D10984EDCF10095", @plano);
SELECT @plano AS CLIENTES;

CALL cap10.SP_EXTRAI_CLIENTES4("G10984EDCF10098", @plano);
SELECT @plano AS CLIENTES;


# VIEWS


# Como criar uma view da query abaixo
SELECT * 
FROM cap10.TB_VENDA
WHERE valor_venda > 500;
+------------+------------+---------------+----------+-------------+------------------+
| sk_cliente | sk_produto | sk_localidade | sk_data  | valor_venda | quantidade_venda |
+------------+------------+---------------+----------+-------------+------------------+
|          1 |          4 |             5 | 20120922 |      550.43 |                7 |
|          4 |          1 |             4 | 20120924 |      745.30 |                2 |
|          4 |         10 |             1 | 20120918 |      645.30 |                2 |
|          5 |         10 |             2 | 20120920 |      540.90 |                6 |
|          6 |          1 |             6 | 20120925 |      680.23 |                5 |
|          6 |          2 |             7 | 20120926 |      945.91 |                2 |
|          7 |          6 |             1 | 20120926 |      891.10 |                4 |
|          8 |          4 |             5 | 20120926 |      850.43 |                7 |
|         10 |          9 |             2 | 20120925 |      629.01 |                1 |
+------------+------------+---------------+----------+-------------+------------------+
9 rows in set (0.00 sec)

# Criação de View
CREATE VIEW cap10.VW_VENDAS_MAIOR_500 AS
SELECT * 
FROM cap10.TB_VENDA
WHERE valor_venda > 500;
Query OK, 0 rows affected (0.01 sec)

# Executando a view
SELECT * FROM cap10.VW_VENDAS_MAIOR_500;
+------------+------------+---------------+----------+-------------+------------------+
| sk_cliente | sk_produto | sk_localidade | sk_data  | valor_venda | quantidade_venda |
+------------+------------+---------------+----------+-------------+------------------+
|          1 |          4 |             5 | 20120922 |      550.43 |                7 |
|          4 |          1 |             4 | 20120924 |      745.30 |                2 |
|          4 |         10 |             1 | 20120918 |      645.30 |                2 |
|          5 |         10 |             2 | 20120920 |      540.90 |                6 |
|          6 |          1 |             6 | 20120925 |      680.23 |                5 |
|          6 |          2 |             7 | 20120926 |      945.91 |                2 |
|          7 |          6 |             1 | 20120926 |      891.10 |                4 |
|          8 |          4 |             5 | 20120926 |      850.43 |                7 |
|         10 |          9 |             2 | 20120925 |      629.01 |                1 |
+------------+------------+---------------+----------+-------------+------------------+
9 rows in set (0.00 sec)


SELECT nm_cliente, nm_cidade_cliente, nm_localidade, nm_marca_produto, nr_dia, nr_mes, valor_venda
FROM cap10.TB_VENDA F, 
     cap10.TB_CLIENTE C, 
     cap10.TB_LOCALIDADE L, 
     cap10.TB_PRODUTO P,
     cap10.TB_TEMPO T
WHERE C.sk_cliente = F.sk_cliente
  AND L.sk_localidade = F.sk_localidade
  AND P.sk_produto = F.sk_produto
  AND T.sk_data = F.sk_data
  AND valor_venda > 500;
  +-------------------+-------------------+------------------+------------------+--------+--------+-------------+
| nm_cliente        | nm_cidade_cliente | nm_localidade    | nm_marca_produto | nr_dia | nr_mes | valor_venda |
+-------------------+-------------------+------------------+------------------+--------+--------+-------------+
| Bob Marley        | Rio de Janeiro    | Loja D           | LG               |     22 |      9 |      550.43 |
| James Brown       | Porto Alegre      | Loja C           | Apple            |     24 |      9 |      745.30 |
| Ray Charles       | Fortaleza         | Loja H           | Apple            |     25 |      9 |      680.23 |
| Ray Charles       | Fortaleza         | Ponto de Venda Y | Apple            |     26 |      9 |      945.91 |
| Marvin Gaye       | Natal             | Loja A           | Canon            |     26 |      9 |      891.10 |
| Bruce Springsteen | Porto Alegre      | Loja D           | LG               |     26 |      9 |      850.43 |
| John Lennon       | Rio de Janeiro    | Ponto de Venda X | Samsung          |     25 |      9 |      629.01 |
+-------------------+-------------------+------------------+------------------+--------+--------+-------------+
7 rows in set (0.00 sec)


# Cria ou altera a VIEW existente, cuidado pois a view antiga será deletada
CREATE OR REPLACE VIEW cap10.VW_VENDAS_MAIOR_500 AS
SELECT nm_cliente, nm_cidade_cliente, nm_localidade, nm_marca_produto, nr_dia, nr_mes, valor_venda
FROM cap10.TB_VENDA F, 
     cap10.TB_CLIENTE C, 
     cap10.TB_LOCALIDADE L, 
     cap10.TB_PRODUTO P,
     cap10.TB_TEMPO T
WHERE C.sk_cliente = F.sk_cliente
  AND L.sk_localidade = F.sk_localidade
  AND P.sk_produto = F.sk_produto
  AND T.sk_data = F.sk_data
  AND valor_venda > 500;
  Query OK, 0 rows affected (0.01 sec)

# Executando a VIEW alterada
SELECT * FROM cap10.VW_VENDAS_MAIOR_500;
+-------------------+-------------------+------------------+------------------+--------+--------+-------------+
| nm_cliente        | nm_cidade_cliente | nm_localidade    | nm_marca_produto | nr_dia | nr_mes | valor_venda |
+-------------------+-------------------+------------------+------------------+--------+--------+-------------+
| Bob Marley        | Rio de Janeiro    | Loja D           | LG               |     22 |      9 |      550.43 |
| James Brown       | Porto Alegre      | Loja C           | Apple            |     24 |      9 |      745.30 |
| Ray Charles       | Fortaleza         | Loja H           | Apple            |     25 |      9 |      680.23 |
| Ray Charles       | Fortaleza         | Ponto de Venda Y | Apple            |     26 |      9 |      945.91 |
| Marvin Gaye       | Natal             | Loja A           | Canon            |     26 |      9 |      891.10 |
| Bruce Springsteen | Porto Alegre      | Loja D           | LG               |     26 |      9 |      850.43 |
| John Lennon       | Rio de Janeiro    | Ponto de Venda X | Samsung          |     25 |      9 |      629.01 |
+-------------------+-------------------+------------------+------------------+--------+--------+-------------+
7 rows in set (0.00 sec)


						Diferença Entre View e View Materializada


Uma VIEW (ou Visão) é uma consulta armazenada no banco de dados. Nós podemos, realizar consultas sobre uma VIEW como se fosse uma tabela. 
Muitas pessoas se referem às VIEWs como uma tabela virtual.

Uma  das  principais  funções  da  VIEW  é  controlar  a  segurança  do  banco  de  dados. 
Geralmente se cria a VIEW (uma consulta armazenada no banco de dados) com os campos que determinado perfil de usuário pode acessar, 
e concede-se ao usuário acesso apenas a essa VIEW e não à(s) tabela(s) diretamente.

Também utiliza-se VIEWs para apresentar informações mais organizadas para o usuário sem que ele precise elaborar uma consulta complexa. 
Esta já estaria pronta e armazenada no próprio banco de dados para uso.

A VIEW realiza uma consulta (query) em tempo de execução. Em uma VIEW simples essa consulta que é armazenada. Essa consulta pode ter condições próprias para restringir os dados que serão visualizados pelo usuário, tanto horizontal (colunas que serão apresentadas) quanto vertical (linhas que serão apresentadas).

Visão Materializada é uma viewa qual armazena-se a consulta e o resultado dela.

Isso implica algumas coisas muito importantes que devem ser entendidas quando for decidir entre criar uma VIEW ou uma MATERIALIZED VIEW.

Primeiro, uma MATERIALIZED VIEW é uma tabela real no banco de dados que é atualizada SEMPRE que ocorrer uma atualização em alguma tabela usada pela sua consulta. Por este motivo, no momento em que o usuário faz uma consulta nesta visão materializada o resultado será mais rápido que se ela não fosse materializada.

Basicamente a diferença no uso das duas é essa. A view realiza a consulta no momento que o usuário faz uma consulta nela e a materialized view realiza a consulta no momento em que uma das tabelas consultadas é atualizada(a frequência de atualização pode ser configurada).



# Criação de Materialized View (workaround no MySQL)

CREATE TABLE cap10.TB_VENDAS (
   id INT PRIMARY KEY AUTO_INCREMENT,
   id_vendedor INT,
   data_venda date,
   valor_venda INT
   );

INSERT INTO cap10.TB_VENDAS (id_vendedor, data_venda, valor_venda) 
VALUES (1001, "2022-01-05", 180), 
       (1002, "2022-01-05", 760), 
       (1003, "2021-01-05", 950), 
       (1004, "2022-01-05", 3200), 
       (1005, "2022-01-05", 2780);

SELECT * FROM cap10.TB_VENDAS;
+----+-------------+------------+-------------+
| id | id_vendedor | data_venda | valor_venda |
+----+-------------+------------+-------------+
|  1 |        1001 | 2022-01-05 |         180 |
|  2 |        1002 | 2022-01-05 |         760 |
|  3 |        1003 | 2021-01-05 |         950 |
|  4 |        1004 | 2022-01-05 |        3200 |
|  5 |        1005 | 2022-01-05 |        2780 |
+----+-------------+------------+-------------+
5 rows in set (0.00 sec)

# Comissão pago para cada vendedor por data
# Calculando a comissão de 10%
SELECT id_vendedor, data_venda, SUM(valor_venda * 0.10) as comissao 
FROM cap10.TB_VENDAS 
WHERE data_venda < CURRENT_DATE 
GROUP BY id_vendedor, data_venda
ORDER BY id_vendedor;
+-------------+------------+----------+
| id_vendedor | data_venda | comissao |
+-------------+------------+----------+
|        1001 | 2022-01-05 |    18.00 |
|        1002 | 2022-01-05 |    76.00 |
|        1003 | 2021-01-05 |    95.00 |
|        1004 | 2022-01-05 |   320.00 |
|        1005 | 2022-01-05 |   278.00 |
+-------------+------------+----------+
5 rows in set (0.00 sec)


# Como o MYSQL não possue a VIEW MATERIALIZADA, podemos criar uma nova tabela com resultado da query
# Assim contornando o problema da falta da VIEW MATERIALIZADA faltando no MYSQL.
CREATE TABLE cap10.VW_MATERIALIZED (
SELECT id_vendedor, data_venda, SUM(valor_venda * 0.10) as comissao 
FROM cap10.TB_VENDAS 
WHERE data_venda < CURRENT_DATE 
GROUP BY id_vendedor, data_venda
ORDER BY id_vendedor);
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0


# Executando a 'VIEW MATERIALIZADA'
SELECT * FROM cap10.VW_MATERIALIZED;
+-------------+------------+----------+
| id_vendedor | data_venda | comissao |
+-------------+------------+----------+
|        1001 | 2022-01-05 |    18.00 |
|        1002 | 2022-01-05 |    76.00 |
|        1003 | 2021-01-05 |    95.00 |
|        1004 | 2022-01-05 |   320.00 |
|        1005 | 2022-01-05 |   278.00 |
+-------------+------------+----------+
5 rows in set (0.00 sec)


# Inserindo registros de vendas
INSERT INTO cap10.TB_VENDAS (id_vendedor, data_venda, valor_venda) 
VALUES (1004, "2022-01-05", 450), 
       (1002, "2022-01-05", 520), 
       (1007, "2021-01-05", 640), 
       (1005, "2022-01-05", 1200), 
       (1008, "2022-01-05", 1700);


# Veja que após atualizar novas vendas, a tabela da VIEW MATERIALIZADA não foi atualizada
# Caso a função tivesse diposnivel para o MYSQL a tabela seria atualizada automaticamente
SELECT * FROM cap10.VW_MATERIALIZED;
+-------------+------------+----------+
| id_vendedor | data_venda | comissao |
+-------------+------------+----------+
|        1001 | 2022-01-05 |    18.00 |
|        1002 | 2022-01-05 |    76.00 |
|        1003 | 2021-01-05 |    95.00 |
|        1004 | 2022-01-05 |   320.00 |
|        1005 | 2022-01-05 |   278.00 |
+-------------+------------+----------+
5 rows in set (0.00 sec)


# Com isso podemos criar uma STORE PROCEDURE para fazer o processo de atualização
DELIMITER //
CREATE PROCEDURE cap10.SP_VW_MATERIALIZED(OUT dev INT)
BEGIN
    TRUNCATE TABLE cap10.VW_MATERIALIZED;
    INSERT INTO cap10.VW_MATERIALIZED
        SELECT id_vendedor, data_venda, SUM(valor_venda * 0.10) as comissao
        FROM cap10.TB_VENDAS
        WHERE data_venda 
        GROUP BY id_vendedor, data_venda;
END
//
DELIMITER ;
Query OK, 0 rows affected (0.01 sec)

# Executando a STORE PROCEDURE
CALL cap10.SP_VW_MATERIALIZED(@dev);


SELECT * FROM cap10.VW_MATERIALIZED;
+-------------+------------+----------+
| id_vendedor | data_venda | comissao |
+-------------+------------+----------+
|        1001 | 2022-01-05 |    18.00 |
|        1002 | 2022-01-05 |   128.00 |
|        1003 | 2021-01-05 |    95.00 |
|        1004 | 2022-01-05 |   365.00 |
|        1005 | 2022-01-05 |   398.00 |
|        1007 | 2021-01-05 |    64.00 |
|        1008 | 2022-01-05 |   170.00 |
+-------------+------------+----------+
7 rows in set (0.00 sec)



FUNCTIONS


# Criação de Functions

# As FUNCTIONS são normalmente usadas para cálculos, enquanto as STORED PROCEDURES são normalmente 
# usados para executar a lógica de negócios.

CREATE PROCEDURE proc_name ([parametros])
BEGIN
corpo_da_procedure
END


CREATE FUNCTION func_name ([parametros])
RETURNS data_type      
BEGIN
corpo_da_funcao
END


# Uma função determinística sempre retorna o mesmo resultado com os mesmos parâmetros de entrada no mesmo estado 
# do banco de dados. Por exemplo: POW, SUBSTR(), UCASE(). 
# Uma função não determinística não retorna necessariamente sempre o mesmo resultado com os mesmos parâmetros 
# de entrada no mesmo estado do banco de dados.


DELIMITER //

CREATE FUNCTION func_name ( numero INT )
RETURNS INT
DETERMINISTIC
BEGIN

   

END 
//
DELIMITER ;



ALTER TABLE cap10.TB_CLIENTE 
DROP COLUMN limite_credito;


ALTER TABLE cap10.TB_CLIENTE 
ADD COLUMN limite_credito INT NULL AFTER desc_cep;


UPDATE cap10.TB_CLIENTE
SET limite_credito = 1000
WHERE sk_cliente = 1;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 0
WHERE sk_cliente = 3;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 2500
WHERE sk_cliente = 4;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 15000
WHERE sk_cliente = 6;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 60000
WHERE sk_cliente = 7;



DELIMITER //

CREATE FUNCTION cap10.FN_NIVEL_CLIENTE(credito DECIMAL(10,2)) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE nivel_cliente VARCHAR(20);

    IF credito > 50000 THEN
        SET nivel_cliente = 'PLATINUM';
    ELSEIF (credito <= 50000 AND credito > 10000) THEN
        SET nivel_cliente = 'GOLD';
    ELSEIF credito <= 10000 THEN
        SET nivel_cliente = 'SILVER';
    END IF;
   
    RETURN (nivel_cliente);
END
//
DELIMITER ;
Query OK, 0 rows affected (0.00 sec)



SELECT nm_cliente, 
       cap10.FN_NIVEL_CLIENTE(limite_credito) AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;
+-------------------+----------+
| nm_cliente        | status   |
+-------------------+----------+
| Aretha Franklin   | NULL     |
| Bob Marley        | SILVER   |
| Bruce Springsteen | NULL     |
| Chuck Berry       | SILVER   |
| Elvis Presley     | NULL     |
| James Brown       | SILVER   |
| John Lennon       | NULL     |
| Marvin Gaye       | PLATINUM |
| Neil Young        | NULL     |
| Ray Charles       | GOLD     |
+-------------------+----------+
10 rows in set (0.00 sec)



# Verificando junto com a coluna limite credito
SELECT nm_cliente, 
       limite_credito,
       cap10.FN_NIVEL_CLIENTE(limite_credito) AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;
+-------------------+----------------+----------+
| nm_cliente        | limite_credito | status   |
+-------------------+----------------+----------+
| Aretha Franklin   |           NULL | NULL     |
| Bob Marley        |           1000 | SILVER   |
| Bruce Springsteen |           NULL | NULL     |
| Chuck Berry       |              0 | SILVER   |
| Elvis Presley     |           NULL | NULL     |
| James Brown       |           2500 | SILVER   |
| John Lennon       |           NULL | NULL     |
| Marvin Gaye       |          60000 | PLATINUM |
| Neil Young        |           NULL | NULL     |
| Ray Charles       |          15000 | GOLD     |
+-------------------+----------------+----------+
10 rows in set (0.00 sec)



# Podemos usar uma função dentro da FUNCTION
SELECT nm_cliente, 
       COALESCE(cap10.FN_NIVEL_CLIENTE(limite_credito), "Não Definido") AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;
+-------------------+--------------+
| nm_cliente        | status       |
+-------------------+--------------+
| Aretha Franklin   | Não Definido |
| Bob Marley        | SILVER       |
| Bruce Springsteen | Não Definido |
| Chuck Berry       | SILVER       |
| Elvis Presley     | Não Definido |
| James Brown       | SILVER       |
| John Lennon       | Não Definido |
| Marvin Gaye       | PLATINUM     |
| Neil Young        | Não Definido |
| Ray Charles       | GOLD         |
+-------------------+--------------+
10 rows in set (0.00 sec)



# Gravando a Query dentro da VIEW
CREATE VIEW cap10.VW_NIVEL_CLIENTE AS
SELECT nm_cliente, 
       COALESCE(cap10.FN_NIVEL_CLIENTE(limite_credito), "Não Definido") AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;


SELECT * FROM cap10.vw_nivel_cliente;
+-------------------+--------------+
| nm_cliente        | status       |
+-------------------+--------------+
| Aretha Franklin   | Não Definido |
| Bob Marley        | SILVER       |
| Bruce Springsteen | Não Definido |
| Chuck Berry       | SILVER       |
| Elvis Presley     | Não Definido |
| James Brown       | SILVER       |
| John Lennon       | Não Definido |
| Marvin Gaye       | PLATINUM     |
| Neil Young        | Não Definido |
| Ray Charles       | GOLD         |
+-------------------+--------------+
10 rows in set (0.00 sec)



# Ao invez de retornar todos os clients para saber o status
# Podemos criar uma stored procedure e retornar 1 cliente por vez
# Retornando 1 cliente com seu respectivo status
DELIMITER //

CREATE PROCEDURE cap10.SP_GET_NIVEL_CLIENTE(
    IN  id_cliente INT,  
    OUT nivel_cliente VARCHAR(20)
)
BEGIN

    DECLARE credito DEC(10,2) DEFAULT 0;
    
    -- Extrai o limite de crédito do cliente
    SELECT limite_credito 
    INTO credito
    FROM cap10.TB_CLIENTE
    WHERE sk_cliente = id_cliente;
    
    -- Executa a função
    SET nivel_cliente = cap10.FN_NIVEL_CLIENTE(credito);
END
//
DELIMITER ;
Query OK, 0 rows affected (0.01 sec)



CALL cap10.SP_GET_NIVEL_CLIENTE(7, @nivel_cliente);
SELECT @nivel_cliente;

CALL cap10.SP_GET_NIVEL_CLIENTE(4, @nivel_cliente);
SELECT @nivel_cliente;


# Criando uma VIEW para filtrar os registros NULOS
CREATE VIEW cap10.VW_CLIENTE AS
SELECT *
FROM cap10.TB_CLIENTE
WHERE limite_credito IS NOT NULL
ORDER BY nm_cliente;



# Executando a VIEW
SELECT * FROM cap10.VW_CLIENTE;
+------------+-----------------+-------------+-------------------+--------------------+----------+----------------+
| sk_cliente | nk_id_cliente   | nm_cliente  | nm_cidade_cliente | by_aceita_campanha | desc_cep | limite_credito |
+------------+-----------------+-------------+-------------------+--------------------+----------+----------------+
|          1 | A10984EDCF10092 | Bob Marley  | Rio de Janeiro    | 1                  | 72132900 |           1000 |
|          3 | C10984EDCF10094 | Chuck Berry | Fortaleza         | 0                  | 65132900 |              0 |
|          4 | D10984EDCF10095 | James Brown | Porto Alegre      | 0                  | 82132900 |           2500 |
|          7 | G10984EDCF10098 | Marvin Gaye | Natal             | 1                  | 12132900 |          60000 |
|          6 | F10984EDCF10097 | Ray Charles | Fortaleza         | 1                  | 67332900 |          15000 |
+------------+-----------------+-------------+-------------------+--------------------+----------+----------------+
5 rows in set (0.00 sec)



# Colocando uma VIEW dentro de uma STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE cap10.SP_GET_NIVEL_CLIENTE2(
    IN  id_cliente INT,  
    OUT nivel_cliente VARCHAR(20)
)
BEGIN

    DECLARE credito DEC(10,2) DEFAULT 0;
    
    -- Extrai o limite de crédito do cliente
    SELECT limite_credito 
    INTO credito
    FROM cap10.VW_CLIENTE 
    WHERE sk_cliente = id_cliente;
    
    -- Executa a função
    SET nivel_cliente = cap10.FN_NIVEL_CLIENTE(credito);
END
//
DELIMITER ;


CALL cap10.SP_GET_NIVEL_CLIENTE2(7, @nivel_cliente);
SELECT @nivel_cliente;

CALL cap10.SP_GET_NIVEL_CLIENTE2(4, @nivel_cliente);
SELECT @nivel_cliente;





# Excluindo uma TRIGGER
DROP TRIGGER IF EXISTS cap10.upd_check;



# Criação de Triggers
DELIMITER //
CREATE TRIGGER cap10.upd_check BEFORE UPDATE ON cap10.TB_CLIENTE
FOR EACH ROW
BEGIN
    IF NEW.limite_credito < 0 THEN
        SET NEW.limite_credito = 0;
    ELSEIF NEW.limite_credito > 100000 THEN
        SET NEW.limite_credito = 100000;
    END IF;
END
//
DELIMITER ;


# Verificando se ao atualizar a tabela, a trigger entra em ação
UPDATE cap10.TB_CLIENTE
SET limite_credito = -10
WHERE sk_cliente = 8;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 120000
WHERE sk_cliente = 9;


# Criando nova colunas na tabela CLIENTE
# Este tipo de alteração é comum para ter auditoria na tabela
# Saber quem cadastrou tal cliente, e quem atualizou tal cliente
ALTER TABLE cap10.TB_CLIENTE 
ADD COLUMN data_cadastro DATETIME NULL AFTER limite_credito,
ADD COLUMN cadastrado_por VARCHAR(45) NULL AFTER data_cadastro,
ADD COLUMN atualizado_por VARCHAR(45) NULL AFTER cadastrado_por;


# Excluindo a TRIGGER se existir
DROP TRIGGER IF EXISTS cap10.insert_check;


# Criando a TRIGGER
DELIMITER //
CREATE TRIGGER cap10.insert_check BEFORE INSERT ON cap10.TB_CLIENTE FOR EACH ROW
BEGIN
    DECLARE vUser varchar(50);

    -- Usuário que realizou o INSERT
    SELECT USER() INTO vUser;

    -- Obtém a data do sistema e registra na coluna data_cadastro 
    SET NEW.data_cadastro = SYSDATE();

    -- Registra na tabela o usuário que fez o INSERT
    SET NEW.cadastrado_por = vUser;
END
// 
DELIMITER ;


INSERT INTO cap10.TB_CLIENTE (NK_ID_CLIENTE, NM_CLIENTE, NM_CIDADE_CLIENTE, BY_ACEITA_CAMPANHA, DESC_CEP) 
VALUES ('S10984EDCF10101', 'Diana Ross', 'Rio de Janeiro', '1', '72132901');

INSERT INTO cap10.TB_CLIENTE (NK_ID_CLIENTE, NM_CLIENTE, NM_CIDADE_CLIENTE, BY_ACEITA_CAMPANHA, DESC_CEP) 
VALUES ('T10984EDCF10101', 'Tom Petty', 'Natal', '1', '72132902');




mysql> SELECT * FROM cap10.tb_cliente;
+------------+-----------------+-------------------+-------------------+--------------------+----------+----------------+---------------------+----------------+----------------+
| sk_cliente | nk_id_cliente   | nm_cliente        | nm_cidade_cliente | by_aceita_campanha | desc_cep | limite_credito | data_cadastro       | cadastrado_por | atualizado_por |
+------------+-----------------+-------------------+-------------------+--------------------+----------+----------------+---------------------+----------------+----------------+
|          1 | A10984EDCF10092 | Bob Marley        | Rio de Janeiro    | 1                  | 72132900 |           1000 | NULL                | NULL           | NULL           |
|          2 | B10984EDCF10093 | Elvis Presley     | Rio de Janeiro    | 1                  | 62132900 |           NULL | NULL                | NULL           | NULL           |
|          3 | C10984EDCF10094 | Chuck Berry       | Fortaleza         | 0                  | 65132900 |              0 | NULL                | NULL           | NULL           |
|          4 | D10984EDCF10095 | James Brown       | Porto Alegre      | 0                  | 82132900 |           2500 | NULL                | NULL           | NULL           |
|          5 | E10984EDCF10096 | Aretha Franklin   | Natal             | 1                  | 22132900 |           NULL | NULL                | NULL           | NULL           |
|          6 | F10984EDCF10097 | Ray Charles       | Fortaleza         | 1                  | 67332900 |          15000 | NULL                | NULL           | NULL           |
|          7 | G10984EDCF10098 | Marvin Gaye       | Natal             | 1                  | 12132900 |          60000 | NULL                | NULL           | NULL           |
|          8 | H10984EDCF10099 | Bruce Springsteen | Porto Alegre      | 0                  | 42132900 |              0 | NULL                | NULL           | NULL           |
|          9 | I10984EDCF10100 | Neil Young        | Rio de Janeiro    | 1                  | 92132900 |         100000 | NULL                | NULL           | NULL           |
|         10 | J10984EDCF10101 | John Lennon       | Rio de Janeiro    | 1                  | 72132900 |           NULL | NULL                | NULL           | NULL           |
|         11 | S10984EDCF10101 | Diana Ross        | Rio de Janeiro    | 1                  | 72132901 |           NULL | 2022-02-14 10:37:43 | root@localhost | NULL           |
|         12 | T10984EDCF10101 | Tom Petty         | Natal             | 1                  | 72132902 |           NULL | 2022-02-14 10:37:43 | root@localhost | NULL           |
+------------+-----------------+-------------------+-------------------+--------------------+----------+----------------+---------------------+----------------+----------------+
12 rows in set (0.00 sec)


# Criando uma auditoria para identificar quem fez delete na tabela 
# Vamos criar uma TRIGGER para monitorar o comando delete na tabela
CREATE TABLE cap10.TB_AUDITORIA 
(sk_cliente INTEGER, 
 nk_id_cliente VARCHAR(20),
 deleted_date DATE, 
 deleted_by VARCHAR(20));
Query OK, 0 rows affected (0.03 sec)


DROP TRIGGER IF EXISTS cap10.delete_check;
Query OK, 0 rows affected, 1 warning (0.00 sec)



DELIMITER //
CREATE TRIGGER cap10.delete_check AFTER DELETE ON cap10.TB_CLIENTE FOR EACH ROW
BEGIN

    DECLARE vUser VARCHAR(50);

    SELECT USER() into vUser;

    INSERT INTO cap10.TB_AUDITORIA (sk_cliente, nk_id_cliente, deleted_date, deleted_by)
    VALUES (OLD.sk_cliente, OLD.nk_id_cliente, SYSDATE(), vUser);

END; 
//
DELIMITER ; 
Query OK, 0 rows affected (0.01 sec)


DELETE FROM cap10.TB_CLIENTE WHERE sk_cliente = 5;









