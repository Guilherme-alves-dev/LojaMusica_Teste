-- Script SQL para o Banco de Dados da Loja de Músicas

-- 1. Criação do Banco de Dados
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'LojaMusicaDB')
BEGIN
    CREATE DATABASE LojaMusicaDB;
END;
GO

USE LojaMusicaDB;
GO

-- 2. Criação das Tabelas

-- Tabela Artistas
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Artistas]') AND type in (N'U'))
BEGIN
CREATE TABLE Artistas (
    ArtistaID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL
);
END;
GO

-- Tabela Generos
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Generos]') AND type in (N'U'))
BEGIN
CREATE TABLE Generos (
    GeneroID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(50) NOT NULL
);
END;
GO

-- Tabela Albuns
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Albuns]') AND type in (N'U'))
BEGIN
CREATE TABLE Albuns (
    AlbumID INT PRIMARY KEY IDENTITY(1,1),
    Titulo VARCHAR(100) NOT NULL,
    AnoLancamento INT,
    ArtistaID INT NOT NULL,
    FOREIGN KEY (ArtistaID) REFERENCES Artistas(ArtistaID)
);
END;
GO

-- Tabela Musicas
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Musicas]') AND type in (N'U'))
BEGIN
CREATE TABLE Musicas (
    MusicaID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Duracao DECIMAL(4,2), -- Duração em minutos (ex: 3.45 para 3 minutos e 45 segundos)
    AlbumID INT NOT NULL,
    GeneroID INT NOT NULL,
    FOREIGN KEY (AlbumID) REFERENCES Albuns(AlbumID),
    FOREIGN KEY (GeneroID) REFERENCES Generos(GeneroID)
);
END;
GO

-- Tabela Clientes
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Clientes]') AND type in (N'U'))
BEGIN
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DataCadastro DATE DEFAULT GETDATE()
);
END;
GO

-- 3. Inserção de Dados de Exemplo

-- Inserir Artistas
INSERT INTO Artistas (Nome) VALUES
('Queen'),
('Michael Jackson'),
('Adele'),
('Ed Sheeran'),
('Metallica');
GO

-- Inserir Generos
INSERT INTO Generos (Nome) VALUES
('Rock'),
('Pop'),
('Soul'),
('Heavy Metal'),
('Blues');
GO

-- Inserir Albuns
INSERT INTO Albuns (Titulo, AnoLancamento, ArtistaID) VALUES
('A Night at the Opera', 1975, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Queen')),
('Thriller', 1982, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Michael Jackson')),
('21', 2011, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Adele')),
('Divide', 2017, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Ed Sheeran')),
('Master of Puppets', 1986, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Metallica')),
('Queen II', 1974, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Queen')),
('The Game', 1980, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Queen')),
('A Day at the Races', 1976, (SELECT ArtistaID FROM Artistas WHERE Nome = 'Queen'));
GO

-- Inserir Musicas
INSERT INTO Musicas (Nome, Duracao, AlbumID, GeneroID) VALUES
('Bohemian Rhapsody', 5.55, (SELECT AlbumID FROM Albuns WHERE Titulo = 'A Night at the Opera'), (SELECT GeneroID FROM Generos WHERE Nome = 'Rock')),
('Billie Jean', 4.52, (SELECT AlbumID FROM Albuns WHERE Titulo = 'Thriller'), (SELECT GeneroID FROM Generos WHERE Nome = 'Pop')),
('Rolling in the Deep', 3.48, (SELECT AlbumID FROM Albuns WHERE Titulo = '21'), (SELECT GeneroID FROM Generos WHERE Nome = 'Soul')),
('Shape of You', 3.53, (SELECT AlbumID FROM Albuns WHERE Titulo = 'Divide'), (SELECT GeneroID FROM Generos WHERE Nome = 'Pop')),
('Master of Puppets', 8.35, (SELECT AlbumID FROM Albuns WHERE Titulo = 'Master of Puppets'), (SELECT GeneroID FROM Generos WHERE Nome = 'Heavy Metal')),
('Another One Bites the Dust', 3.35, (SELECT AlbumID FROM Albuns WHERE Titulo = 'The Game' AND ArtistaID = (SELECT ArtistaID FROM Artistas WHERE Nome = 'Queen')), (SELECT GeneroID FROM Generos WHERE Nome = 'Rock')),
('Somebody to Love', 4.56, (SELECT AlbumID FROM Albuns WHERE Titulo = 'A Day at the Races' AND ArtistaID = (SELECT ArtistaID FROM Artistas WHERE Nome = 'Queen')), (SELECT GeneroID FROM Generos WHERE Nome = 'Rock')),
('Beat It', 4.18, (SELECT AlbumID FROM Albuns WHERE Titulo = 'Thriller'), (SELECT GeneroID FROM Generos WHERE Nome = 'Pop')),
('Set Fire to the Rain', 4.01, (SELECT AlbumID FROM Albuns WHERE Titulo = '21'), (SELECT GeneroID FROM Generos WHERE Nome = 'Soul')),
('Castle on the Hill', 4.21, (SELECT AlbumID FROM Albuns WHERE Titulo = 'Divide'), (SELECT GeneroID FROM Generos WHERE Nome = 'Pop'));
GO

-- Inserir Clientes
INSERT INTO Clientes (Nome, Email) VALUES
('Ana Silva', 'ana.silva@email.com'),
('Bruno Costa', 'bruno.costa@email.com'),
('Carla Souza', 'carla.souza@email.com');
GO

