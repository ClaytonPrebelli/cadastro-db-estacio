-- Criando o banco de dados
CREATE DATABASE Loja;
GO

-- Usando o banco de dados
USE Loja;
GO

-- Criando a sequence para os IDs de Pessoa
CREATE SEQUENCE Seq_PessoaID
    START WITH 1
    INCREMENT BY 1;
GO

-- Criando a tabela de Usuários
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(100) NOT NULL,
    Senha NVARCHAR(100) NOT NULL
);

-- Criando a tabela de Pessoas
CREATE TABLE Pessoas (
    PessoaID INT PRIMARY KEY DEFAULT (NEXT VALUE FOR Seq_PessoaID),
    Nome NVARCHAR(100) NOT NULL,
    Endereco NVARCHAR(255),
    Telefone NVARCHAR(20)
);

-- Criando a tabela de Pessoas Físicas
CREATE TABLE PessoasFisicas (
    PessoaID INT PRIMARY KEY,
    CPF CHAR(11) UNIQUE NOT NULL,
    FOREIGN KEY (PessoaID) REFERENCES Pessoas(PessoaID) ON DELETE CASCADE
);

-- Criando a tabela de Pessoas Jurídicas
CREATE TABLE PessoasJuridicas (
    PessoaID INT PRIMARY KEY,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    FOREIGN KEY (PessoaID) REFERENCES Pessoas(PessoaID) ON DELETE CASCADE
);

-- Criando a tabela de Produtos
CREATE TABLE Produtos (
    ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
    Nome NVARCHAR(100) NOT NULL,
    Quantidade INT NOT NULL,
    PrecoVenda DECIMAL(10,2) NOT NULL
);

-- Criando a tabela de Movimentações
CREATE TABLE Movimentacoes (
    MovimentacaoID INT IDENTITY(1,1) PRIMARY KEY,
    Tipo CHAR(1) CHECK (Tipo IN ('E', 'S')) NOT NULL,
    UsuarioID INT NOT NULL,
    ProdutoID INT NOT NULL,
    PessoaID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    DataMovimentacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID),
    FOREIGN KEY (PessoaID) REFERENCES Pessoas(PessoaID)
);