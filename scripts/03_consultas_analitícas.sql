-- ==========================================================
-- ANÁLISE 1: PRODUTO MAIS VENDIDO NO PERÍODO
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual produto apresentou a maior quantidade de vendas
-- durante o período analisado?
--
-- Objetivo:
-- Identificar os produtos mais vendidos para auxiliar no
-- planejamento de estoque e compras.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================

SELECT produtos.nome_produto,
    SUM(itens_venda.quantidade) AS total_vendido
FROM produtos JOIN itens_venda 
ON produtos.id_produto = itens_venda.id_produto
GROUP BY produtos.id_produto, produtos.nome_produto
ORDER BY total_vendido DESC;



-- ==========================================================
-- ANÁLISE 2: PRODUTOS MAIS VENDIDOS POR MÊS
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Como foi o desempenho dos produtos em cada mês?
--
-- Objetivo:
-- Comparar a quantidade vendida de cada produto ao longo do
-- tempo para identificar tendências de venda.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ DATE_FORMAT()
-- ✔ SUM()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT date_format(v.data_venda_hora, '%Y-%m') AS mes,
    p.nome_produto,
    SUM(iv.quantidade) AS total_vendido
FROM produtos p 
JOIN itens_venda iv ON p.id_produto = iv.id_produto
JOIN vendas v ON iv.id_venda = v.id_venda
GROUP BY date_format(v.data_venda_hora, '%Y-%m'), p.id_produto, p.nome_produto
ORDER BY mes, total_vendido DESC;



-- ==========================================================
-- ANÁLISE 3: PRODUTOS COM BAIXO ESTOQUE E ALTO VOLUME DE VENDAS
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Quais produtos possuem baixo estoque e, ao mesmo tempo,
-- apresentam alto volume de vendas?
--
-- Objetivo:
-- Identificar produtos com maior risco de ruptura de estoque,
-- auxiliando o planejamento de reposição e evitando a falta
-- de produtos para os clientes.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT p.nome_produto, p.estoque,
    SUM(iv.quantidade) AS Total_Vendido
FROM produtos p JOIN itens_venda iv
ON p.id_produto = iv.id_produto
GROUP BY  p.id_produto,p.nome_produto, p.estoque
ORDER BY estoque ASC, total_vendido DESC;



-- ==========================================================
-- ANÁLISE 4: PRODUTOS COM MAIOR FATURAMENTO
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Quais produtos geraram o maior faturamento durante o
-- período analisado?
--
-- Objetivo:
-- Identificar os produtos que mais contribuíram para a
-- receita da empresa, auxiliando na definição de estratégias
-- comerciais, estoque e investimentos.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ Operação matemática (quantidade * preco_unitario)
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT p.nome_produto,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento
FROM produtos p JOIN itens_venda iv
ON p.id_produto = iv.id_produto
GROUP BY p.id_produto, p.nome_produto
ORDER BY faturamento DESC;



-- ==========================================================
-- ANÁLISE 5: PRODUTOS COM MENOR VOLUME DE VENDAS
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Quais produtos apresentaram o menor volume de vendas durante
-- o período analisado?
--
-- Objetivo:
-- Identificar os produtos com menor saída para auxiliar na
-- avaliação do portfólio, definição de estratégias comerciais
-- e planejamento de estoque.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ✔ LIMIT
-- ==========================================================


SELECT p.nome_produto,
    SUM(iv.quantidade) AS volume_vendas
FROM produtos p JOIN itens_venda iv
ON p.id_produto = iv.id_produto
GROUP BY p.id_produto, p.nome_produto
ORDER BY volume_vendas ASC LIMIT 5;



-- ==========================================================
-- ANÁLISE 6: FATURAMENTO MENSAL
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual foi o faturamento obtido em cada mês durante o período
-- analisado?
--
-- Objetivo:
-- Analisar a evolução do faturamento ao longo do período,
-- identificando variações mensais e o desempenho financeiro
-- do negócio.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ DATE_FORMAT()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT date_format(v.data_venda_hora, '%Y-%m') AS mes,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento
FROM vendas v JOIN itens_venda iv
ON v.id_venda = iv.id_venda
GROUP BY mes
ORDER BY mes;



-- ==========================================================
-- ANÁLISE 7: TICKET MÉDIO DAS VENDAS
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual foi o ticket médio das vendas realizadas durante o
-- período analisado?
--
-- Objetivo:
-- Calcular o valor médio gasto por venda para avaliar o
-- comportamento de compra dos clientes e o desempenho
-- financeiro do negócio.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ COUNT()
-- ✔ ROUND()
-- ==========================================================


SELECT 
    COUNT(distinct v.id_venda) AS total_venda,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento_total,
    ROUND(SUM(iv.quantidade * iv.preco_unitario)/ COUNT(DISTINCT v.id_venda),2) AS ticket_medio
FROM itens_venda iv JOIN vendas v
ON iv.id_venda = v.id_venda;



-- ==========================================================
-- ANÁLISE 8: MÉDIA DE PRODUTOS POR VENDA
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual foi a média de produtos vendidos por venda durante o
-- período analisado?
--
-- Objetivo:
-- Calcular a quantidade média de produtos por venda para
-- compreender o comportamento de compra dos clientes e o
-- volume médio de itens adquiridos em cada transação.
--
-- Conceitos utilizados:
-- ✔ SUM()
-- ✔ COUNT()
-- ✔ DISTINCT
-- ✔ ROUND()
-- ==========================================================


SELECT 
    COUNT(DISTINCT iv.id_venda) AS total_venda,
    SUM(iv.quantidade) AS unidades_vendidas,
    ROUND(SUM(iv.quantidade)/ COUNT(DISTINCT iv.id_venda),2) AS media_produtos_por_venda
FROM itens_venda iv;



-- ==========================================================
-- ANÁLISE 9: QUANTIDADE DE VENDAS POR VENDEDOR
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Quantas vendas foram realizadas por cada vendedor durante o
-- período analisado?
--
-- Objetivo:
-- Avaliar o desempenho dos vendedores por meio da quantidade
-- de vendas realizadas, identificando aqueles que obtiveram
-- maior produtividade no período.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ COUNT()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT vend.nome,
    COUNT(v.id_venda) AS total_vendas
FROM vendas v JOIN vendedores vend
ON v.id_vendedor = vend.id_vendedor
GROUP BY v.id_vendedor, vend.nome
ORDER BY total_vendas DESC;



-- ==========================================================
-- ANÁLISE 10: FATURAMENTO POR VENDEDOR
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual foi o faturamento gerado por cada vendedor durante o
-- período analisado?
--
-- Objetivo:
-- Avaliar o desempenho financeiro dos vendedores por meio do
-- faturamento obtido, identificando aqueles que mais
-- contribuíram para a receita da empresa.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT vend.nome,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento
FROM vendas v JOIN vendedores vend
ON v.id_vendedor = vend.id_vendedor
JOIN itens_venda iv
ON iv.id_venda = v.id_venda
GROUP BY vend.nome, vend.id_vendedor
ORDER BY faturamento DESC;



-- ==========================================================
-- ANÁLISE 11: MÉDIA DE VENDAS POR CLIENTE
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual foi a média de vendas realizadas por cliente durante o
-- período analisado?
--
-- Objetivo:
-- Calcular a média de vendas por cliente para compreender a
-- frequência média de compras e avaliar o comportamento de
-- consumo da base de clientes.
--
-- Conceitos utilizados:
-- ✔ COUNT()
-- ✔ DISTINCT
-- ✔ ROUND()
-- ✔ Operações com funções de agregação
-- ==========================================================


SELECT
    COUNT(v.id_venda) AS total_vendas,
    COUNT(DISTINCT v.id_cliente) AS total_clientes,
    ROUND(COUNT(v.id_venda) / COUNT(DISTINCT v.id_cliente),2) AS media_vendas_por_cliente
FROM vendas v;



-- ==========================================================
-- ANÁLISE 12: CLIENTES ACIMA DA MÉDIA DE COMPRAS
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Quais clientes realizaram uma quantidade de compras acima
-- da média durante o período analisado?
--
-- Objetivo:
-- Identificar os clientes com frequência de compras superior
-- à média, auxiliando na identificação de clientes mais
-- recorrentes e na definição de estratégias de fidelização.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ COUNT()
-- ✔ AVG()
-- ✔ GROUP BY
-- ✔ HAVING
-- ✔ Subconsulta
-- ✔ ORDER BY
-- ==========================================================


SELECT c.nome,
    COUNT(v.id_venda) AS quantidade_comprada
FROM clientes c JOIN vendas v 
ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING COUNT(v.id_venda) > (SELECT AVG(total_compras) 
FROM (SELECT COUNT(id_venda) AS total_compras
FROM vendas 
GROUP BY id_cliente) AS media_clientes )
ORDER BY quantidade_comprada DESC;



-- ==========================================================
-- ANÁLISE 13: FORMA DE PAGAMENTO MAIS UTILIZADA
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual foi a forma de pagamento mais utilizada durante o
-- período analisado?
--
-- Objetivo:
-- Identificar as formas de pagamento mais utilizadas pelos
-- clientes, auxiliando na compreensão do comportamento de
-- compra e no apoio às decisões comerciais.
--
-- Conceitos utilizados:
-- ✔ COUNT()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT forma_pagamento,
    COUNT(id_venda) AS quantidade_utilizada
FROM vendas
GROUP BY forma_pagamento
ORDER BY quantidade_utilizada;



-- ==========================================================
-- ANÁLISE 14: FATURAMENTO POR FORMA DE PAGAMENTO
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Qual foi o faturamento gerado por cada forma de pagamento
-- durante o período analisado?
--
-- Objetivo:
-- Analisar o faturamento por forma de pagamento para
-- identificar quais meios de pagamento geraram maior receita
-- e compreender o comportamento de pagamento dos clientes.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ GROUP BY
-- ✔ ORDER BY
-- ==========================================================


SELECT forma_pagamento,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento
FROM vendas v
JOIN itens_venda iv
ON iv.id_venda = v.id_venda
GROUP BY forma_pagamento
ORDER BY faturamento DESC;



-- ==========================================================
-- ANÁLISE 15: RESUMO GERAL DO NEGÓCIO
-- ----------------------------------------------------------
-- Pergunta de negócio:
-- Quais são os principais indicadores de desempenho do negócio
-- durante o período analisado?
--
-- Objetivo:
-- Consolidar os principais indicadores de vendas, faturamento,
-- clientes e produtos em uma única visão geral, permitindo uma
-- análise rápida do desempenho do negócio.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ COUNT()
-- ✔ DISTINCT
-- ✔ SUM()
-- ✔ ROUND()
-- ==========================================================


SELECT
    COUNT(DISTINCT v.id_venda) AS Total_Vendas,
    COUNT(DISTINCT v.id_cliente) AS Total_Clientes,
    FORMAT(SUM(iv.quantidade * iv.preco_unitario), 0) AS faturamento,
    SUM(iv.quantidade) AS Produtos_Vendidos,
    ROUND(SUM(iv.quantidade * iv.preco_unitario) / COUNT(DISTINCT v.id_venda), 2) AS Ticket_Medio
FROM vendas v JOIN itens_venda iv
ON v.id_venda = iv.id_venda;