            
            Projeto Delivery Center
	    
	    Descrição dos datasets
	    
channels: Este dataset possui informações sobre os canais de venda (marketplaces) onde são vendidos os good e food de nossos lojistas.
deliveries: Este dataset possui informações sobre as entregas realizadas por nossos entregadores parceiros.
drivers: Este dataset possui informações sobre os entregadores parceiros. Eles ficam em nossos hubs e toda vez que um pedido é processado, são eles fazem as entregas na casa dos consumidores.
hubs: Este dataset possui informações sobre os hubs do Delivery Center. Entenda que os Hubs são os centros de distribuição dos pedidos e é dali que saem as entregas.
orders: Este dataset possui informações sobre as vendas processadas através da plataforma do Delivery Center.
payments: Este dataset possui informações sobre os pagamentos realizados ao Delivery Center.
stores: Este dataset possui informações sobre os lojistas. Eles utilizam a Plataforma do Delivery Center para vender seus itens (good e/ou food) nos marketplaces.

https://www.kaggle.com/nosbielcs/brazilian-delivery-center


1- Qual o número de hubs por cidade?

SELECT hub_city, COUNT(hub_name) AS contagem
FROM exec4.hubs
GROUP BY hub_city
ORDER BY contagem DESC;
+----------------+----------+
| hub_city       | contagem |
+----------------+----------+
| SÃO PAULO      |       15 |
| RIO DE JANEIRO |        9 |
| PORTO ALEGRE   |        4 |
| CURITIBA       |        4 |
+----------------+----------+
4 rows in set (0.05 sec)






2- Qual o número de pedidos (orders) por status?

SELECT order_status, COUNT(order_id) AS num_pedidos
FROM exec4.orders
GROUP BY order_status;
+--------------+-------------+
| order_status | num_pedidos |
+--------------+-------------+
| CANCELED     |       16979 |
| FINISHED     |      352020 |
+--------------+-------------+
2 rows in set (0.80 sec)






3- Qual o número de lojas (stores) por cidade dos hubs?

SELECT hub_city, COUNT(store_id) AS num_lojas
FROM exec4.hubs hubs, exec4.stores stores
WHERE hubs.hub_id = stores.hub_id
GROUP BY hub_city
ORDER BY num_lojas DESC;
+----------------+-----------+
| hub_city       | num_lojas |
+----------------+-----------+
| SÃO PAULO      |       460 |
| RIO DE JANEIRO |       326 |
| CURITIBA       |       117 |
| PORTO ALEGRE   |        48 |
+----------------+-----------+
4 rows in set (0.03 sec)






4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?

SELECT MAX(payment_amount), MIN(payment_amount) FROM exec4.payments;
+---------------------+---------------------+
| MAX(payment_amount) | MIN(payment_amount) |
+---------------------+---------------------+
|           100000.11 |                   0 |
+---------------------+---------------------+
1 row in set (0.27 sec)






5- Qual tipo de driver (driver_type) fez o maior número de entregas?

SELECT driver_type, COUNT(delivery_id) AS num_entregas
FROM exec4.deliveries deliveries, exec4.drivers drivers
WHERE drivers.driver_id = deliveries.driver_id
GROUP BY driver_type
ORDER BY num_entregas DESC;
+-------------------+--------------+
| driver_type       | num_entregas |
+-------------------+--------------+
| FREELANCE         |       259382 |
| LOGISTIC OPERATOR |       103575 |
+-------------------+--------------+
2 rows in set (0.73 sec)






6- Qual a distância média das entregas por modo de driver (driver_modal)?

SELECT driver_modal, ROUND(AVG(delivery_distance_meters),2) AS distancia_media
FROM exec4.deliveries deliveries, exec4.drivers drivers
WHERE drivers.driver_id = deliveries.driver_id
GROUP BY driver_modal;
+--------------+-----------------+
| driver_modal | distancia_media |
+--------------+-----------------+
| MOTOBOY      |         3447.11 |
| BIKER        |         1109.19 |
+--------------+-----------------+
2 rows in set (0.70 sec)






7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?

SELECT store_name, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores
WHERE stores.store_id = orders.store_id
GROUP BY store_name
ORDER BY media_pedido DESC;
+-----------------------------------+--------------+
| store_name                        | media_pedido |
+-----------------------------------+--------------+
| ZAMZIMU                           |      5266.63 |
| OIGAMA                            |      2412.67 |
| GRIME CRU                         |      2186.79 |
| SIRSUMG                           |      2096.59 |
| CEI                               |      1764.14 |
| VACMIR ZUGI                       |         1518 |
| CAI RIRAMARI                      |      1404.61 |
| GRUGIRO                           |      1350.67 |
| IPALUPAES ERAMGS                  |           25 |
| IAMUR                             |         23.6 |
| ARE PIMUAUR                       |        22.22 |
| AR FAM                            |        22.18 |
| ILZI I TRAPRIS                    |        16.97 |
| PILAS SUCIS                       |         14.5 |
| SUGIR PIGURO                      |        10.12 |
| PRIMGIPA                          |         0.01 |
+-----------------------------------+--------------+
480 rows in set (0.94 sec)






8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?

SELECT COALESCE(store_name, "Sem Loja"), COUNT(order_id) AS contagem
FROM exec4.orders orders LEFT JOIN exec4.stores stores
ON stores.store_id = orders.store_id
GROUP BY store_name
ORDER BY contagem DESC;	
+-----------------------------------+----------+
| COALESCE(store_name, "Sem Loja")  | contagem |
+-----------------------------------+----------+
| IUMPICA                           |    94730 |
| PAPA SUCIS                        |    20964 |
| PIGUE PIPACO                      |    16364 |
| IPUPIEMAI                         |    15575 |
| SALITO                            |    11992 |
| RC OUMILEES                       |    11029 |
| PAZZI ZUM                         |    10837 |
| SMIR PIAMU                        |        1 |
| PUZAMZI E CAI                     |        1 |
| AERUIR                            |        1 |
| RIRO RIUGU                        |        1 |
| SIGO                              |        1 |
| CILVAM GLUAM                      |        1 |
| IPALUPAES ERAMGS                  |        1 |
+-----------------------------------+----------+
480 rows in set (1.02 sec)






9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?

SELECT ROUND(sum(order_amount),2) AS total
FROM exec4.orders orders, exec4.channels channels
WHERE channels.channel_id = orders.channel_id
AND channel_name = 'FOOD PLACE';
+-------------+
| total       |
+-------------+
| 24703719.56 |
+-------------+
1 row in set (0.52 sec)






10- Quantos pagamentos foram cancelados (chargeback)?

SELECT payment_status, COUNT(payment_status) AS cancelados
FROM exec4.payments payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;
+----------------+------------+
| payment_status | cancelados |
+----------------+------------+
| CHARGEBACK     |        438 |
+----------------+------------+
1 row in set (0.30 sec)






11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?

SELECT payment_status, ROUND(AVG(payment_amount),2) AS media_cancelados
FROM exec4.payments payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;
+----------------+------------------+
| payment_status | media_cancelados |
+----------------+------------------+
| CHARGEBACK     |            16.35 |
+----------------+------------------+
1 row in set (0.31 sec)






12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?

SELECT payment_method, ROUND(AVG(payment_amount),2) AS media_pagamento
FROM exec4.payments
GROUP BY payment_method
ORDER BY media_pagamento DESC;
+--------------------------+-----------------+
| payment_method           | media_pagamento |
+--------------------------+-----------------+
| INSTALLMENT_CREDIT_STORE |          499.89 |
| STORE_DIRECT_PAYMENT     |          281.78 |
| VOUCHER_STORE            |          161.69 |
| CREDIT_STORE             |          134.46 |
| PAYMENT_LINK             |          122.76 |
| ONLINE                   |          101.98 |
| CREDIT                   |           97.12 |
| DEBIT_STORE              |           90.21 |
| VOUCHER_DC               |            83.9 |
| VOUCHER_OL               |           83.45 |
| BANK_TRANSFER_DC         |           76.27 |
| DEBIT                    |           66.67 |
| MEAL_BENEFIT             |           63.47 |
| MONEY                    |           33.89 |
| VOUCHER                  |           14.37 |
+--------------------------+-----------------+
15 rows in set (0.64 sec)






13- Quais métodos de pagamento tiveram valor médio superior a 100?

SELECT payment_method, ROUND(AVG(payment_amount),2) AS media_pagamento
FROM exec4.payments
GROUP BY payment_method
HAVING media_pagamento > 100
ORDER BY media_pagamento DESC;
+--------------------------+-----------------+
| payment_method           | media_pagamento |
+--------------------------+-----------------+
| INSTALLMENT_CREDIT_STORE |          499.89 |
| STORE_DIRECT_PAYMENT     |          281.78 |
| VOUCHER_STORE            |          161.69 |
| CREDIT_STORE             |          134.46 |
| PAYMENT_LINK             |          122.76 |
| ONLINE                   |          101.98 |
+--------------------------+-----------------+
6 rows in set (0.64 sec)






14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?

SELECT hub_state, store_segment, channel_type, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
GROUP BY hub_state, store_segment, channel_type
ORDER BY hub_state;
+-----------+---------------+--------------+--------------+
| hub_state | store_segment | channel_type | media_pedido |
+-----------+---------------+--------------+--------------+
| PR        | FOOD          | MARKETPLACE  |        52.23 |
| PR        | FOOD          | OWN CHANNEL  |        47.47 |
| PR        | GOOD          | MARKETPLACE  |       135.02 |
| PR        | GOOD          | OWN CHANNEL  |       233.56 |
| RJ        | FOOD          | MARKETPLACE  |        81.55 |
| RJ        | FOOD          | OWN CHANNEL  |         74.6 |
| RJ        | GOOD          | MARKETPLACE  |       139.62 |
| RJ        | GOOD          | OWN CHANNEL  |       211.41 |
| RS        | FOOD          | MARKETPLACE  |         71.9 |
| RS        | FOOD          | OWN CHANNEL  |        64.08 |
| RS        | GOOD          | MARKETPLACE  |        75.45 |
| RS        | GOOD          | OWN CHANNEL  |       358.66 |
| SP        | FOOD          | MARKETPLACE  |        95.71 |
| SP        | FOOD          | OWN CHANNEL  |        86.99 |
| SP        | GOOD          | MARKETPLACE  |        138.9 |
| SP        | GOOD          | OWN CHANNEL  |       421.04 |
+-----------+---------------+--------------+--------------+
16 rows in set (1.54 sec)






15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?

SELECT hub_state, store_segment, channel_type, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
GROUP BY hub_state, store_segment, channel_type
HAVING media_pedido > 450
ORDER BY hub_state;
Empty set (1.50 sec)






16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
Demonstre os totais intermediários e formate o resultado.

SELECT 
	IF(GROUPING(hub_state), 'Total Hub State', hub_state) AS hub_state,
    IF(GROUPING(store_segment), 'Total Segmento', store_segment) AS store_segment,
    IF(GROUPING(channel_type), 'Total Tipo de Canal', channel_type) AS channel_type,
    ROUND(SUM(order_amount),2) total_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
GROUP BY hub_state, store_segment, channel_type WITH ROLLUP;
+-----------------+----------------+---------------------+--------------+
| hub_state       | store_segment  | channel_type        | total_pedido |
+-----------------+----------------+---------------------+--------------+
| PR              | FOOD           | MARKETPLACE         |   1335699.48 |
| PR              | FOOD           | OWN CHANNEL         |     24306.68 |
| PR              | FOOD           | Total Tipo de Canal |   1360006.16 |
| PR              | GOOD           | MARKETPLACE         |    118544.08 |
| PR              | GOOD           | OWN CHANNEL         |    566142.84 |
| PR              | GOOD           | Total Tipo de Canal |    684686.92 |
| PR              | Total Segmento | Total Tipo de Canal |   2044693.08 |
| RJ              | FOOD           | MARKETPLACE         |   9987907.72 |
| RJ              | FOOD           | OWN CHANNEL         |    349569.35 |
| RJ              | FOOD           | Total Tipo de Canal |  10337477.07 |
| RJ              | GOOD           | MARKETPLACE         |     444284.4 |
| RJ              | GOOD           | OWN CHANNEL         |    1532948.3 |
| RJ              | GOOD           | Total Tipo de Canal |    1977232.7 |
| RJ              | Total Segmento | Total Tipo de Canal |  12314709.77 |
| RS              | FOOD           | MARKETPLACE         |   2206522.86 |
| RS              | FOOD           | OWN CHANNEL         |     83950.95 |
| RS              | FOOD           | Total Tipo de Canal |   2290473.81 |
| RS              | GOOD           | MARKETPLACE         |     44664.93 |
| RS              | GOOD           | OWN CHANNEL         |    658861.84 |
| RS              | GOOD           | Total Tipo de Canal |    703526.77 |
| RS              | Total Segmento | Total Tipo de Canal |   2994000.58 |
| SP              | FOOD           | MARKETPLACE         |  12751358.96 |
| SP              | FOOD           | OWN CHANNEL         |    287250.68 |
| SP              | FOOD           | Total Tipo de Canal |  13038609.64 |
| SP              | GOOD           | MARKETPLACE         |   2298534.46 |
| SP              | GOOD           | OWN CHANNEL         |    6110183.2 |
| SP              | GOOD           | Total Tipo de Canal |   8408717.66 |
| SP              | Total Segmento | Total Tipo de Canal |   21447327.3 |
| Total Hub State | Total Segmento | Total Tipo de Canal |  38800730.73 |
+-----------------+----------------+---------------------+--------------+
29 rows in set, 3 warnings (1.45 sec)






17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', 
tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?

SELECT hub_state, store_segment, channel_type, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
AND order_status = 'CANCELED'
AND store_segment = 'FOOD'
AND channel_type = 'MARKETPLACE'
AND hub_state = 'RJ'
GROUP BY hub_state, store_segment, channel_type;
+-----------+---------------+--------------+--------------+
| hub_state | store_segment | channel_type | media_pedido |
+-----------+---------------+--------------+--------------+
| RJ        | FOOD          | MARKETPLACE  |        66.49 |
+-----------+---------------+--------------+--------------+
1 row in set (0.51 sec)






18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado,
algum hub_state teve total de valor do pedido superior a 100.000?

SELECT hub_state, store_segment, channel_type, ROUND(SUM(order_amount),2) AS total_pedido
FROM exec4.orders orders, exec4.stores stores, exec4.channels channels, exec4.hubs hubs
WHERE stores.store_id = orders.store_id
AND channels.channel_id = orders.channel_id
AND hubs.hub_id = stores.hub_id
AND order_status = 'CANCELED'
AND store_segment = 'GOOD'
AND channel_type = 'MARKETPLACE'
GROUP BY hub_state, store_segment, channel_type
HAVING total_pedido > 100000;
+-----------+---------------+--------------+--------------+
| hub_state | store_segment | channel_type | total_pedido |
+-----------+---------------+--------------+--------------+
| SP        | GOOD          | MARKETPLACE  |    496669.48 |
+-----------+---------------+--------------+--------------+
1 row in set (0.54 sec)






19- Em que data houve a maior média de valor do pedido (order_amount)?

SELECT SUBSTRING(order_moment_created, 1, 9) AS data_pedido, ROUND(AVG(order_amount),2) AS media_pedido
FROM exec4.orders orders
GROUP BY data_pedido
ORDER BY media_pedido DESC;
+-------------+--------------+
| data_pedido | media_pedido |
+-------------+--------------+
| 3/18/2021   |       619.83 |
| 3/31/2021   |       136.02 |
| 3/29/2021   |       133.53 |
| 3/13/2021   |       127.01 |
| 4/1/2021    |       127.01 |
| 4/3/2021    |       125.31 |
| 3/30/2021   |       122.85 |
| 3/2/2021    |        80.83 |
| 1/18/2021   |        79.74 |
| 1/11/2021   |        78.86 |
| 2/22/2021   |        78.25 |
| 1/5/2021    |        78.06 |
| 2/8/2021    |        77.83 |
| 3/1/2021    |         75.7 |
+-------------+--------------+
120 rows in set (0.61 sec)






20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)?

SELECT SUBSTRING(order_moment_created, 1, 9) AS data_pedido, MIN(order_amount) AS min_pedido
FROM exec4.orders orders
GROUP BY data_pedido
HAVING min_pedido = 0
ORDER BY data_pedido ASC;
+-------------+------------+
| data_pedido | min_pedido |
+-------------+------------+
| 1/11/2021   |          0 |
| 1/12/2021   |          0 |
| 1/13/2021   |          0 |
| 1/14/2021   |          0 |
| 1/15/2021   |          0 |
| 1/16/2021   |          0 |
| 1/17/2021   |          0 |
| 1/19/2021   |          0 |
| 4/6/2021    |          0 |
| 4/7/2021    |          0 |
| 4/8/2021    |          0 |
| 4/9/2021    |          0 |
+-------------+------------+
111 rows in set (0.62 sec)











