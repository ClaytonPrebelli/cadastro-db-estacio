-- Dados completos de pessoas físicas
SELECT p.id_pessoa, p.nome, p.endereco, p.telefone, pf.cpf
FROM Pessoa p
INNER JOIN PessoaFisica pf ON p.id_pessoa = pf.id_pessoa
WHERE p.tipo_pessoa = 'Física';

-- Dados completos de pessoas jurídicas
SELECT p.id_pessoa, p.nome, p.endereco, p.telefone, pj.cnpj
FROM Pessoa p
INNER JOIN PessoaJuridica pj ON p.id_pessoa = pj.id_pessoa
WHERE p.tipo_pessoa = 'Jurídica';

-- Movimentações de entrada (compra)
SELECT m.tipo_movimentacao, p.nome AS produto, pj.nome AS fornecedor, m.quantidade, m.preco_unitario, m.valor_total
FROM Movimentacoes m
INNER JOIN Produtos p ON m.id_produto = p.id_produto
INNER JOIN PessoaJuridica pj ON m.id_pessoa = pj.id_pessoa
WHERE m.tipo_movimentacao = 'E';

-- Movimentações de saída (venda)
SELECT m.tipo_movimentacao, p.nome AS produto, pf.nome AS comprador, m.quantidade, m.preco_unitario, m.valor_total
FROM Movimentacoes m
INNER JOIN Produtos p ON m.id_produto = p.id_produto
INNER JOIN PessoaFisica pf ON m.id_pessoa = pf.id_pessoa
WHERE m.tipo_movimentacao = 'S';

-- Valor total das entradas agrupadas por produto
SELECT p.nome AS produto, SUM(m.valor_total) AS valor_total_entrada
FROM Movimentacoes m
INNER JOIN Produtos p ON m.id_produto = p.id_produto
WHERE m.tipo_movimentacao = 'E'
GROUP BY p.nome;

-- Valor total das saídas agrupadas por produto
SELECT p.nome AS produto, SUM(m.valor_total) AS valor_total_saida
FROM Movimentacoes m
INNER JOIN Produtos p ON m.id_produto = p.id_produto
WHERE m.tipo_movimentacao = 'S'
GROUP BY p.nome;

-- Operadores que não efetuaram movimentações de entrada (compra)
SELECT u.nome AS operador
FROM Usuarios u
WHERE NOT EXISTS (
    SELECT 1
    FROM Movimentacoes m
    WHERE m.id_usuario = u.id_usuario AND m.tipo_movimentacao = 'E'
);

-- Valor total de entrada, agrupado por operador
SELECT u.nome AS operador, SUM(m.valor_total) AS valor_total_entrada
FROM Movimentacoes m
INNER JOIN Usuarios u ON m.id_usuario = u.id_usuario
WHERE m.tipo_movimentacao = 'E'
GROUP BY u.nome;

-- Valor total de saída, agrupado por operador
SELECT u.nome AS operador, SUM(m.valor_total) AS valor_total_saida
FROM Movimentacoes m
INNER JOIN Usuarios u ON m.id_usuario = u.id_usuario
WHERE m.tipo_movimentacao = 'S'
GROUP BY u.nome;

-- Valor médio de venda por produto, utilizando média ponderada
SELECT p.nome AS produto, 
       SUM(m.valor_total) / SUM(m.quantidade) AS valor_medio_venda
FROM Movimentacoes m
INNER JOIN Produtos p ON m.id_produto = p.id_produto
WHERE m.tipo_movimentacao = 'S'
GROUP BY p.nome;
