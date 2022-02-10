Adicionar o caminho do mysql nas variáveis de ambiente do windows
para que o CMD aceita o comando mysql,
dentro das variáveis de ambiente clicar no path em seguida em novo e adiciona o caminho
conforme abaixo.
/Program Files/MySQL/MySQL Server 8.0/bin 

após abre o cmd e digita o comando abaixo, para conseguir entrar no banco de dados
mysql -u root -p --local-infile

O comando a baixo não teve muito efeito, más deixo registrado
SET GLOBAL local_infile = true;

O comando abaixo, carrega os registros do csv direto pela linha de comando
economizando muito tempo!!!
LOAD DATA LOCAL INFILE '/Users/Wesley/Documents/Analise_de_dados/covid19.csv' 
INTO TABLE `exec4`.`covid19` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY
  '\r\n' IGNORE 1 LINES;

