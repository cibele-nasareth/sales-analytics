--- ==========================================================
-- VALIDAÇÃO: CONSISTÊNCIA DO VALOR TOTAL DAS VENDAS
-- ----------------------------------------------------------
-- Objetivo:
-- Verificar se o valor total registrado na tabela de vendas
-- corresponde ao valor calculado a partir dos itens vendidos,
-- garantindo a consistência financeira dos dados.
--
-- Regra de validação:
-- Comparar o valor_total da venda com a soma dos itens
-- (quantidade × preço_unitário), considerando diferenças
-- superiores a 1 centavo como inconsistências.
--
-- Conceitos utilizados:
-- ✔ JOIN
-- ✔ SUM()
-- ✔ ROUND()
-- ✔ GROUP BY
-- ✔ HAVING
-- ✔ ABS()
-- ==========================================================




SELECT v.id_venda,
v.valor_total,
ROUND(SUM(iv.quantidade * iv.preco_unitario),2) AS valor_calculado
FROM vendas v JOIN itens_venda iv
ON v.id_venda = iv.id_venda
GROUP BY v.id_venda, v.valor_total
HAVING ABS(v.valor_total - valor_calculado) > 0.01;