
 

  O objetivo será aplicar uma série de transformações a variáveis de um conjunto de dados
  de pacientes que desenvolveram câncer de mama. Estarei limpando e transformando os dados
  através de categorização, codificação e binarização e então gerar um novo dataset, que
  poderá ser usado mais a frente por outros profissionais da equipe de Ciência de Dados.

  Usaremos o conjunto de dados diponibilizado pelo UCI que é um repositório de dados usados
  para machine learning que é disponibilizado gratuitamente.

  link: archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer/
							                




							                Oque é categorização ?

					Vamos tomar como exemplo a tabela abaixo, a categorização visa
					converter uma variável para o tipo categórica, vamos usar o exemplo
					a variável idade do cliente, ao invés de pegarmos exatamente a idade do cliente
					podemos criar uma variável como faixa etária, e assim atribuir a idade
					em categoria, dessa forma fica muito mais fácil compreender a faixa
					etária dos clientes.		                


      Estado do Cliente          | Idade do Cliente       | Faixa Etária do Cliente |
+----------------------+-------------------------------------------------------------+
| São Paulo                |              28        |              De 21 a 30 Anos      |
| Santa Catarina           |              34        |              De 31 a 40 Anos      |             
| Amazonas                 |              45        |              De 41 a 50 Anos      |
| Goiás                    |              52        |              De 51 a 60 Anos      |
| Ceará                    |              21        |              De 21 a 30 Anos      |
|----------------------+-------------------------------------------------------------+
  Esta é uma variável      |  Esta é uma variável   |  Categorização é converter uma variável
  categórica que representa|  numérica (operações   |  para o tipo categórica a fim de obter
  classes ou categorias    |  matemáticas fazem     |  um novo tipo de informação.
                              sentido)              |


/* Criando a tabela */
CREATE TABLE `cap03`.`TB_DADOS` (
  `classe` VARCHAR(100) NULL,
  `idade` VARCHAR(45) NULL,
  `menopausa` VARCHAR(45) NULL,
  `tamanho_tumor` VARCHAR(45) NULL,
  `inv_nodes` VARCHAR(45) NULL,
  `node_caps` VARCHAR(3) NULL,
  `deg_malig` INT NULL,
  `seio` VARCHAR(5) NULL,
  `quadrante` VARCHAR(10) NULL,
  `irradiando` VARCHAR(3) NULL);

/* Após inserir o dataset baixado pelo UCI, e ter criado a tabela */
/* Vamos começar contando quantos registros tem na tabela */

/* CONTABILIZANDO O TOTAL DE REGISTROS */
SELECT COUNT(*) FROM cap03.tb_dados;
+----------+
| COUNT(*) |
+----------+
|      286 |
+----------+
1 row in set (0.01 sec)



/* BINARIZAÇÃO DA VARIÁVEL CLASSE (0/1)
O PRIMEIRO PASSO É CONTABILIZAR O TOTAL DE REGISTROS DISTINTOS
OU SEJA O TOTAL DE CATEGORIAS DA COLUNA CLASSE */
SELECT DISTINCT classe FROM cap03.tb_dados;
+----------------------+
| classe               |
+----------------------+
| no-recurrence-events |
| recurrence-events    |
+----------------------+
2 rows in set (0.00 sec)



/* Utilizando o comando CASE */
/* Vamos converter utilizando binarização da variável classe */
/* É uma boa pratica usar 0 para falso e 1 para verdadeiro */
/* O comando a baixo diz que caso o evento não seja recorrente aplico 0 */
/* E caso o evento seja recorrente aplico 1 */
SELECT 
	CASE
		WHEN classe = 'no-recurrence-events' THEN 0
		WHEN classe = 'recurrence-events' THEN 1
	END as classe
FROM cap03.tb_dados;

+--------+
| classe |
+--------+
|      0 |
|      0 |
|      0 |
|      0 |
|      1 |
|      1 |
|      1 |
|      1 |
+--------+
286 rows in set (0.00 sec)



/* Descobrindo os valores da variável */
SELECT DISTINCT irradiando FROM cap03.tb_dados;
+------------+
| irradiando |
+------------+
| no         |
| yes        |
+------------+
2 rows in set (0.00 sec)



/* Binarização da variável irradiando */
SELECT
	CASE
		WHEN irradiando = 'no' THEN 0
		WHEN irradiando = 'yes' THEN 1
	END AS irradiando
FROM cap03.tb_dados;
+------------+
| irradiando |
+------------+
|          0 |
|          0 |
|          0 |
|          0 |
|          0 |
|          1 |
|          0 |
|          0 |
|          0 |
+------------+
286 rows in set (0.00 sec)



/* Descobrindo os valores da variável */
SELECT DISTINCT node_caps FROM cap03.tb_dados;
+-----------+
| node_caps |
+-----------+
| no        |
| yes       |
| ?         |
+-----------+
3 rows in set (0.01 sec)




/* Binarização com valores nulos/ausentes */
SELECT 
	CASE
		WHEN node_caps = 'no' THEN 0
		WHEN node_caps = 'yes' THEN 1
		ELSE 2
	END AS node_caps
FROM cap03.tb_dados;
+-----------+
| node_caps |
+-----------+
|         0 |
|         0 |
|         0 |
|         0 |
|         0 |
|         2 |
|         0 |
|         0 |
+-----------+
286 rows in set (0.00 sec)




/* Categorização da variável seio (E/D) */
SELECT DISTINCT SEIO FROM CAP03.TB_DADOS;
+-------+
| SEIO  |
+-------+
| left  |
| right |
+-------+
2 rows in set (0.02 sec)


/* Categorização da variável seio (E/D) */
SELECT	
	CASE
		WHEN seio = 'left' THEN 'E'
		WHEN seio = 'right' THEN 'D'
	END AS SEIO
FROM CAP03.TB_DADOS;
+------+
| SEIO |
+------+
| E    |
| D    |
| E    |
| E    |
| E    |
| D    |
| E    |
| E    |
+------+
286 rows in set (0.00 sec)




/* Categorização da variável tamanho_tumor (6 CATEGORIAS) */
SELECT DISTINCT tamanho_tumor FROM CAP03.TB_DADOS;
+---------------+
| tamanho_tumor |
+---------------+
| 30-34         |
| 20-24         |
| 15-19         |
| 0-4           |
| 25-29         |
| 50-54         |
| 10-14         |
| 40-44         |
| 35-39         |
| 5-9           |
| 45-49         |
+---------------+
11 rows in set (0.00 sec)

/* Categorização da variável tamanho_tumor (6 CATEGORIAS) */
/* Aqui temos um exemplo de como a categorização facilita a visualização da variável */
/* Pois reduzimos o número de informação e categorizamos */
SELECT 
	CASE 
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
		WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
		WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
		WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
		WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
		WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente' 
	END AS tamanho_tumor
FROM CAP03.TB_DADOS;
+--------------------+
| tamanho_tumor      |
+--------------------+
| Grande             |
| Medio              |
| Medio              |
| Pequeno            |
| Muito Pequeno      |
| Medio              |
| Grande             |
| Grande             |
+--------------------+
286 rows in set (0.00 sec)





/* Utilizando o label encoding da variável qudrante (1,2,3,4,5) */
SELECT DISTINCT quadrante FROM CAP03.TB_DADOS;
+-----------+
| quadrante |
+-----------+
| left_low  |
| right_up  |
| left_up   |
| right_low |
| central   |
| ?         |
+-----------+
6 rows in set (0.00 sec)



/* Utilizando o label encoding da variável qudrante (1,2,3,4,5) */
SELECT
	CASE	
		WHEN quadrante = 'left_low' THEN 1
		WHEN quadrante = 'right_up' THEN 2
		WHEN quadrante = 'left_up' THEN 3
		WHEN quadrante = 'right_low' THEN 4
		WHEN quadrante = 'central' THEN 5
		ELSE 0
	END AS quadrante
FROM CAP03.TB_DADOS;
+-----------+
| quadrante |
+-----------+
|         1 |
|         2 |
|         1 |
|         3 |
|         3 |
|         3 |
|         1 |
|         1 |
+-----------+
286 rows in set (0.00 sec)





/* Após realizar as mudanças necessárias, podemos realizar uma grande Query, para criar um novo dataset */
CREATE TABLE CAP03.TB_DADOS2
AS
SELECT 
	CASE
		WHEN classe = 'no-recurrence-events' THEN 0
		WHEN classe = 'recurrence-events' THEN 1
	END as classe,
	idade,
	menopausa,
	CASE 
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
		WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
		WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
		WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
		WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
		WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente' 
	END AS tamanho_tumor,
	inv_nodes,
	CASE
		WHEN node_caps = 'no' THEN 0
		WHEN node_caps = 'yes' THEN 1
		ELSE 2
	END AS node_caps,
	deg_malig,
	CASE
		WHEN seio = 'left' THEN 'E'
		WHEN seio = 'right' THEN 'D'
	END AS seio,
	CASE	
		WHEN quadrante = 'left_low' THEN 1
		WHEN quadrante = 'right_up' THEN 2
		WHEN quadrante = 'left_up' THEN 3
		WHEN quadrante = 'right_low' THEN 4
		WHEN quadrante = 'central' THEN 5
		ELSE 0
	END AS quadrante,
	CASE
		WHEN irradiando = 'no' THEN 0
		WHEN irradiando = 'yes' THEN 1
	END AS irradiando
FROM CAP03.TB_DADOS;
Query OK, 286 rows affected (0.08 sec)
Records: 286  Duplicates: 0  Warnings: 0





/* Verificando se nenhum registro foi perdido */
SELECT COUNT(*) FROM CAP03.TB_DADOS2;
+----------+
| COUNT(*) |
+----------+
|      286 |
+----------+
1 row in set (0.00 sec)



/* Agora podemos exportar a nova tabela categorizada para que a equipe de Ciência de Dados possa continuar os trabalhos */
/* EXPORTANDO OS DADOS, BOTAO DIREITO NA TABELA, 'TABLE DATA EXPORT WIZARD' */



/* Trabalhando com o datasetversão final após as transformações feitas durante as aulas neste capítulo */
/* crie instruções SQL que resolvam às questões abaixo: */

1-Aplique label encoding à variável menopausa, e a cada modificação crie uma nova tabela. 
SELECT DISTINCT menopausa FROM CAP03.TB_DADOS2;
+-----------+
| menopausa |
+-----------+
| premeno   |
| ge40      |
| lt40      |
+-----------+
3 rows in set (0.00 sec)


CREATE TABLE cap03.tb_dados3
AS
SELECT
classe,
idade,
	CASE	
		WHEN menopausa = 'premeno' THEN 1
		WHEN menopausa = 'ge40' THEN 2
		WHEN menopausa = 'lt40' THEN 3
	END AS menopausa,
tamanho_tumor,
inv_nodes,
node_caps,
deg_malig,
seio,
quadrante,
irradiando
FROM CAP03.TB_DADOS2;
Query OK, 286 rows affected (0.08 sec)
Records: 286  Duplicates: 0  Warnings: 0


 2-[Desafio] Crie uma nova coluna chamada posicao_tumor concatenando as colunas inv_nodes e quadrante.

CREATE TABLE CAP03.TB_DADOS4
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
CONCAT (inv_nodes, '-', quadrante) AS posicao_tumor,
node_caps,
deg_malig,
seio,
irradiando
FROM CAP03.TB_DADOS3;
Query OK, 286 rows affected (0.08 sec)
Records: 286  Duplicates: 0  Warnings: 0



 3-[Desafio] Aplique One-Hot-Encoding à coluna deg_malig.

SELECT DISTINCT deg_malig FROM CAP03.TB_DADOS4;
+-----------+
| deg_malig |
+-----------+
|         3 |
|         2 |
|         1 |
+-----------+
3 rows in set (0.00 sec)


CREATE TABLE CAP03.TB_DADOS5
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
posicao_tumor,
node_caps,
CASE WHEN deg_malig = 1 THEN 1 ELSE 0 END AS deg_malig_cat1,
CASE WHEN deg_malig = 2 THEN 1 ELSE 0 END AS deg_malig_cat2,
CASE WHEN deg_malig = 3 THEN 1 ELSE 0 END AS deg_malig_cat3,
seio,
irradiando
FROM CAP03.TB_DADOS4;
Query OK, 286 rows affected (0.06 sec)
Records: 286  Duplicates: 0  Warnings: 0