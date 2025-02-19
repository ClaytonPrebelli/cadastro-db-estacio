-- Usando o banco de dados
USE Loja;
GO

-- Inserindo usuários
INSERT INTO Usuarios (Nome, Senha) VALUES ('op1', 'op1');
INSERT INTO Usuarios (Nome, Senha) VALUES ('op2', 'op2');

-- Inserindo produtos
INSERT INTO Produtos (Nome, Quantidade, PrecoVenda) VALUES ('Produto A', 50, 10.00);
INSERT INTO Produtos (Nome, Quantidade, PrecoVenda) VALUES ('Produto B', 30, 20.50);
INSERT INTO Produtos (Nome, Quantidade, PrecoVenda) VALUES ('Produto C', 100, 5.75);

-- Inserindo pessoas físicas
DECLARE @PessoaID INT = NEXT VALUE FOR Seq_PessoaID;
INSERT INTO Pessoas (PessoaID, Nome, Endereco, Telefone) VALUES (@PessoaID, 'João Silva', 'Rua 1, 100', '11987654321');
INSERT INTO PessoasFisicas (PessoaID, CPF) VALUES (@PessoaID, '12345678901');

SET @PessoaID = NEXT VALUE FOR Seq_PessoaID;
INSERT INTO Pessoas (PessoaID, Nome, Endereco, Telefone) VALUES (@PessoaID, 'Maria Souza', 'Rua 2, 200', '11976543210');
INSERT INTO PessoasFisicas (PessoaID, CPF) VALUES (@PessoaID, '98765432100');

-- Inserindo pessoas jurídicas
SET @PessoaID = NEXT VALUE FOR Seq_PessoaID;
INSERT INTO Pessoas (PessoaID, Nome, Endereco, Telefone) VALUES (@PessoaID, 'Empresa XYZ', 'Av. Industrial, 500', '1133324455');
INSERT INTO PessoasJuridicas (PessoaID, CNPJ) VALUES (@PessoaID, '11222333444455');

SET @PessoaID = NEXT VALUE FOR Seq_PessoaID;
INSERT INTO Pessoas (PessoaID, Nome, Endereco, Telefone) VALUES (@PessoaID, 'Empresa ABC', 'Av. Central, 600', '1144455566');
INSERT INTO PessoasJuridicas (PessoaID, CNPJ) VALUES (@PessoaID, '55667788990011');

-- Inserindo movimentações de entrada (compra de produtos)
INSERT INTO Movimentacoes (Tipo, UsuarioID, ProdutoID, PessoaID, Quantidade, PrecoUnitario)
VALUES ('E', 1, 1, 3, 20, 9.50);

INSERT INTO Movimentacoes (Tipo, UsuarioID, ProdutoID, PessoaID, Quantidade, PrecoUnitario)
VALUES ('E', 2, 2, 4, 10, 19.00);

-- Inserindo movimentações de saída (venda de produtos)
INSERT INTO Movimentacoes (Tipo, UsuarioID, ProdutoID, PessoaID, Quantidade, PrecoUnitario)
VALUES ('S', 1, 1, 1, 5, 10.00);

INSERT INTO Movimentacoes (Tipo, UsuarioID, ProdutoID, PessoaID, Quantidade, PrecoUnitario)
VALUES ('S', 2, 2, 2, 3, 20.50);
