-- Criação do Banco de Dados
CREATE DATABASE loja;
GO

-- Usar o banco de dados
USE loja;
GO

-- Criação das tabelas
-- Tabela de Usuários
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100),
    senha VARCHAR(100)
);
GO

-- Tabela de Produtos
CREATE TABLE Produtos (
    id_produto INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100),
    quantidade INT,
    preco_venda DECIMAL(10, 2)
);
GO

-- Tabela de Pessoa
CREATE TABLE Pessoa (
    id_pessoa INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(200),
    telefone VARCHAR(20),
    tipo_pessoa VARCHAR(20) -- Pessoa Física ou Jurídica
);
GO

-- Tabela de Pessoa Física
CREATE TABLE PessoaFisica (
    id_pessoa INT PRIMARY KEY,
    cpf VARCHAR(14),
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);
GO

-- Tabela de Pessoa Jurídica
CREATE TABLE PessoaJuridica (
    id_pessoa INT PRIMARY KEY,
    cnpj VARCHAR(18),
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);
GO

-- Tabela de Movimentações (Compra e Venda)
CREATE TABLE Movimentacoes (
    id_movimentacao INT IDENTITY PRIMARY KEY,
    tipo_movimentacao CHAR(1),  -- 'E' para entrada (compra), 'S' para saída (venda)
    id_produto INT,
    id_usuario INT,
    id_pessoa INT,
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    valor_total DECIMAL(10, 2) AS (quantidade * preco_unitario) PERSISTED, -- Valor total (quantidade * preço unitário)
    data_movimentacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);
GO
