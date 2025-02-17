-- Criar o banco de dados
CREATE DATABASE SistemaDeVendas;
GO

-- Usar o banco de dados
USE SistemaDeVendas;
GO

-- Criar o logon para o usuário 'loja'
CREATE LOGIN loja WITH PASSWORD = 'loja';
GO

-- Criar o usuário 'loja' e associá-lo ao banco de dados
CREATE USER loja FOR LOGIN loja;
GO

-- Permitir a criação de tabelas e objetos
ALTER ROLE db_owner ADD MEMBER loja;
GO

-- Criar uma Sequence para geração dos identificadores de pessoas
CREATE SEQUENCE seq_pessoa_id
    START WITH 1
    INCREMENT BY 1;
GO

-- Tabela de Usuários
CREATE TABLE usuarios (
    usuario_id INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100),
    login VARCHAR(50) UNIQUE,
    senha VARCHAR(50)
);
GO

-- Tabela de Pessoas (Pessoas Físicas e Jurídicas)
CREATE TABLE pessoas (
    pessoa_id INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    email VARCHAR(100),
    tipo CHAR(1),  -- 'F' para pessoa física e 'J' para pessoa jurídica
    cpf VARCHAR(15) NULL,
    cnpj VARCHAR(18) NULL
);
GO

-- Tabela de Produtos
CREATE TABLE produtos (
    produto_id INT IDENTITY PRIMARY KEY,
    nome VARCHAR(100),
    quantidade INT,
    preco_venda DECIMAL(10, 2)
);
GO

-- Tabela de Movimentos de Compra (compras realizadas para pessoa jurídica)
CREATE TABLE movimentos_compra (
    movimento_id INT IDENTITY PRIMARY KEY,
    usuario_id INT,  -- Quem fez a compra
    produto_id INT,  -- Qual produto foi comprado
    pessoa_id INT,  -- Para qual pessoa jurídica foi comprada
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    data_compra DATETIME,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoas(pessoa_id)
);
GO

-- Tabela de Movimentos de Venda (vendas realizadas para pessoa física)
CREATE TABLE movimentos_venda (
    movimento_id INT IDENTITY PRIMARY KEY,
    usuario_id INT,  -- Quem fez a venda
    produto_id INT,  -- Qual produto foi vendido
    pessoa_id INT,  -- Para qual pessoa física foi vendida
    quantidade INT,
    preco_venda DECIMAL(10, 2),
    data_venda DATETIME,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
    FOREIGN KEY (pessoa_id) REFERENCES pessoas(pessoa_id)
);
GO
