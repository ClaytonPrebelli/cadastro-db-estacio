-- Inserir Usuários
INSERT INTO Usuarios (nome, senha) VALUES ('op1', 'op1');
INSERT INTO Usuarios (nome, senha) VALUES ('op2', 'op2');
GO

-- Inserir Produtos
INSERT INTO Produtos (nome, quantidade, preco_venda) VALUES ('Produto A', 100, 50.00);
INSERT INTO Produtos (nome, quantidade, preco_venda) VALUES ('Produto B', 200, 30.00);
INSERT INTO Produtos (nome, quantidade, preco_venda) VALUES ('Produto C', 150, 70.00);
GO

-- Inserir Pessoas Físicas
INSERT INTO Pessoa (nome, endereco, telefone, tipo_pessoa) VALUES ('João Silva', 'Rua A, 123', '1234567890', 'Física');
INSERT INTO PessoaFisica (id_pessoa, cpf) VALUES (1, '123.456.789-00');
GO

-- Inserir Pessoas Jurídicas
INSERT INTO Pessoa (nome, endereco, telefone, tipo_pessoa) VALUES ('Empresa X', 'Avenida B, 456', '9876543210', 'Jurídica');
INSERT INTO PessoaJuridica (id_pessoa, cnpj) VALUES (2, '12.345.678/0001-99');
GO

-- Inserir Movimentações (Compras e Vendas)
-- Movimentação de Compra
INSERT INTO Movimentacoes (tipo_movimentacao, id_produto, id_usuario, id_pessoa, quantidade, preco_unitario)
VALUES ('E', 1, 1, 2, 50, 40.00); -- Compra de 50 unidades do Produto A, pelo usuário op1 para a empresa X
-- Movimentação de Venda
INSERT INTO Movimentacoes (tipo_movimentacao, id_produto, id_usuario, id_pessoa, quantidade, preco_unitario)
VALUES ('S', 1, 2, 1, 20, 50.00); -- Venda de 20 unidades do Produto A, pelo usuário op2 para João Silva
GO
