-- Usando o banco de dados
USE LojaDB;
GO

-- 1. Dados completos de pessoas físicas
SELECT P.*, PF.CPF 
FROM Pessoas P
JOIN PessoasFisicas PF ON P.PessoaID = PF.PessoaID;

-- 2. Dados completos de pessoas jurídicas
SELECT P.*, PJ.CNPJ 
FROM Pessoas P
JOIN PessoasJuridicas PJ ON P.PessoaID = PJ.PessoaID;

-- 3. Movimentações de entrada (compras)
SELECT M.MovimentacaoID, M.DataMovimentacao, U.Nome AS Operador, P.Nome AS Produto, Pe.Nome AS Fornecedor, M.Quantidade, M.PrecoUnitario, (M.Quantidade * M.PrecoUnitario) AS ValorTotal
FROM Movimentacoes M
JOIN Usuarios U ON M.UsuarioID = U.UsuarioID
JOIN Produtos P ON M.ProdutoID = P.ProdutoID
JOIN Pessoas Pe ON M.PessoaID = Pe.PessoaID
WHERE M.Tipo = 'E';

-- 4. Movimentações de saída (vendas)
SELECT M.MovimentacaoID, M.DataMovimentacao, U.Nome AS Operador, P.Nome AS Produto, Pe.Nome AS Comprador, M.Quantidade, M.PrecoUnitario, (M.Quantidade * M.PrecoUnitario) AS ValorTotal
FROM Movimentacoes M
JOIN Usuarios U ON M.UsuarioID = U.UsuarioID
JOIN Produtos P ON M.ProdutoID = P.ProdutoID
JOIN Pessoas Pe ON M.PessoaID = Pe.PessoaID
WHERE M.Tipo = 'S';

-- 5. Valor total das entradas agrupadas por produto
SELECT P.Nome AS Produto, SUM(M.Quantidade * M.PrecoUnitario) AS ValorTotal
FROM Movimentacoes M
JOIN Produtos P ON M.ProdutoID = P.ProdutoID
WHERE M.Tipo = 'E'
GROUP BY P.Nome;

-- 6. Valor total das saídas agrupadas por produto
SELECT P.Nome AS Produto, SUM(M.Quantidade * M.PrecoUnitario) AS ValorTotal
FROM Movimentacoes M
JOIN Produtos P ON M.ProdutoID = P.ProdutoID
WHERE M.Tipo = 'S'
GROUP BY P.Nome;

-- 7. Operadores que não efetuaram movimentações de entrada
SELECT U.Nome 
FROM Usuarios U
WHERE U.UsuarioID NOT IN (SELECT DISTINCT UsuarioID FROM Movimentacoes WHERE Tipo = 'E');

-- 8. Valor total de entrada agrupado por operador
SELECT U.Nome AS Operador, SUM(M.Quantidade * M.PrecoUnitario) AS ValorTotal
FROM Movimentacoes M
JOIN Usuarios U ON M.UsuarioID = U.UsuarioID
WHERE M.Tipo = 'E'
GROUP BY U.Nome;

-- 9. Valor total de saída agrupado por operador
SELECT U.Nome AS Operador, SUM(M.Quantidade * M.PrecoUnitario) AS ValorTotal
FROM Movimentacoes M
JOIN Usuarios U ON M.UsuarioID = U.UsuarioID
WHERE M.Tipo = 'S'
GROUP BY U.Nome;

-- 10. Valor médio de venda por produto (média ponderada)
SELECT P.Nome AS Produto, SUM(M.Quantidade * M.PrecoUnitario) / NULLIF(SUM(M.Quantidade), 0) AS ValorMedioVenda
FROM Movimentacoes M
JOIN Produtos P ON M.ProdutoID = P.ProdutoID
WHERE M.Tipo = 'S'
GROUP BY P.Nome;
