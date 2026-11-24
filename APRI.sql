CREATE DATABASE APRI
USE APRI;
GO
CREATE TABLE Parceiros (
Id_Parceiro INT IDENTITY(1,1) PRIMARY KEY,
Nome VARCHAR(167),
Contato VARCHAR(67),
Descricao VARCHAR(67),
Tipo_Apoio VARCHAR(67),
Tipo_Parceiro VARCHAR(67),
Parceiro_Inst BIT
);

CREATE TABLE Atividades_Institucionais (
Id_Atividade INT IDENTITY(1,1) PRIMARY KEY,
Titulo VARCHAR(67),
Descricao VARCHAR(67),
Data DATE,
Imagem VARCHAR(167)
);


CREATE TABLE Categoria_Cursos (
Id_Categoria INT IDENTITY(1,1) PRIMARY KEY,
Nome VARCHAR(30)
);

CREATE TABLE Usuarios (
Id_Usuario INT IDENTITY(1,1) PRIMARY KEY,
Nome VARCHAR(167),
Email VARCHAR(167),
Senha VARCHAR(67),
Telefone VARCHAR(15),
Data_Cadastro DATE,
Administrador BIT,
Tipo_Usuario CHAR(1),
CPF VARCHAR(15),
Data_Aprovacao DATE,
Data_Nasc DATE,
Nacionalidade VARCHAR(30),
Naturalidade VARCHAR(30),
Profissao VARCHAR(30)
);

CREATE TABLE Contribuicao(
Id_Parceiro INT,
Id_Atividade INT,
Id_Contribuicao INT IDENTITY(1,1) PRIMARY KEY
CONSTRAINT fk_Parceiros FOREIGN KEY (Id_Parceiro)
				REFERENCES Parceiros (Id_Parceiro)
		ON DELETE CASCADE, 
CONSTRAINT fk_Atividades_Institucionais FOREIGN KEY (Id_Atividade)
				REFERENCES Atividades_Institucionais(Id_Atividade)
		ON DELETE CASCADE
)

CREATE TABLE Centro_Conteudos(
Id_Contedos INT IDENTITY(1,1) PRIMARY KEY,
Tipo VARCHAR(50),
Tema VARCHAR(50),
Categoria VARCHAR(50),
Autor VARCHAR(100),
Id_Atividade INT,
CONSTRAINT fk_Atividades_InstitucionaisC FOREIGN KEY (Id_Atividade)
				REFERENCES Atividades_Institucionais(Id_Atividade)
				ON DELETE CASCADE
)

CREATE TABLE Cursos(
Id_Cursos INT IDENTITY(1,1) PRIMARY KEY,
Nome VARCHAR(100),
Carga_Horaria INT,
Responsavel_Curso VARCHAR(50),
Links VARCHAR(50),
Id_Atividades INT,
Id_Categoria_Cursos INT,
CONSTRAINT fk_Atividades_Institucionais_Cursos FOREIGN KEY (Id_Atividades)
					REFERENCES Atividades_Institucionais(Id_Atividade)
				ON DELETE CASCADE,
CONSTRAINT fk_Categoria_Curso FOREIGN KEY (Id_Categoria_Cursos)
					REFERENCES Categoria_Cursos(Id_Categoria)
					ON DELETE CASCADE
)

CREATE TABLE Cursos_Usuario_Realiza(
Id_Inscricao INT IDENTITY(1,1) PRIMARY KEY,
Date_Inscricao DATE,
Status_Curso VARCHAR(20),
Id_Curso INT,
Id_Usuario INT,
CONSTRAINT fk_Cursos FOREIGN KEY (Id_Curso)
				REFERENCES Cursos(Id_Cursos)
				ON DELETE CASCADE,
CONSTRAINT fk_Usuarios FOREIGN KEY (Id_Usuario)
				REFERENCES Usuarios(Id_Usuario)
)


CREATE TABLE Projetos(
Id_Projeto INT IDENTITY PRIMARY KEY,
Nome VARCHAR(100),
Status_Projetos VARCHAR(15),
Id_Atividade INT,
CONSTRAINT fk_Atv_Inst FOREIGN KEY (Id_Atividade)
			REFERENCES Atividades_Institucionais(Id_Atividade)
			ON DELETE CASCADE)

CREATE TABLE Macro(
Orgao_Responsavel VARCHAR(50),
Contato_Responsavel VARCHAR(50),
Id_Projeto INT,
CONSTRAINT fk_Projetos FOREIGN KEY (Id_Projeto)
			REFERENCES Projetos(Id_Projeto)
			ON DELETE CASCADE
)

CREATE TABLE Micro(
Prioridade VARCHAR(15),
Meta_Arrecadacao VARCHAR(50),
Prazo_Estimado DATE,
Id_Projeto INT,
CONSTRAINT fk_Projeto_Micro FOREIGN KEY (Id_Projeto)
			REFERENCES Projetos(Id_Projeto)
			ON DELETE CASCADE
)

CREATE TABLE Atualizacao(
Id_Atualizacao INT IDENTITY(1,1) PRIMARY KEY,
Titulo VARCHAR(50),
Data_Atualizacao DATE,
Visibilidade BIT NOT NULL DEFAULT 1,
Id_Projeto INT, 
CONSTRAINT fk_Projeto FOREIGN KEY (Id_Projeto)
			REFERENCES Projetos(Id_Projeto)
			ON DELETE CASCADE
)


-- Parceiros
INSERT INTO Parceiros (Nome, Contato, Descricao, Tipo_Apoio, Tipo_Parceiro, Parceiro_Inst) VALUES
('Prefeitura de Itu', 'cultura@itu.sp.gov.br', 'Apoio institucional para ações de restauro', 'Financeiro', 'Órgão Público', 1),
('Instituto Histórico de Itu', 'contato@ihitu.org.br', 'Pesquisa e documentação histórica', 'Técnico', 'Instituição de Pesquisa', 1),
('Construtora Pedra Viva Ltda', '(11) 4023-1500', 'Doação de materiais de construção', 'Material', 'Empresa Privada', 0),
('FATEC Itu', 'extensao@fatecitu.edu.br', 'Voluntariado de estudantes e docentes', 'Voluntariado', 'Instituição de Ensino', 1),
('Maria Aparecida Souza', '(11) 99876-5432', 'Doação financeira mensal', 'Financeiro', 'Pessoa Física', 0);

-- Atividades_Institucionais
INSERT INTO Atividades_Institucionais (Titulo, Descricao, Data, Imagem) VALUES
('Restauro da Fachada da Igreja Matriz', 'Restauração da fachada principal do prédio histórico', '2026-03-15', 'img/atividades/restauro-fachada.jpg'),
('Oficina de Técnicas de Restauro', 'Oficina prática de restauro de madeira e pedra', '2026-04-20', 'img/atividades/oficina-restauro.jpg'),
('Palestra Patrimônio Histórico de Itu', 'Palestra aberta sobre a importância da preservação', '2026-05-10', 'img/atividades/palestra-patrimonio.jpg'),
('Campanha de Arrecadação Solidária', 'Campanha para arrecadar fundos para obras de restauro', '2026-06-05', 'img/atividades/campanha-solidaria.jpg'),
('Visita Guiada ao Centro Histórico', 'Passeio educativo com estudantes da rede pública', '2026-08-22', 'img/atividades/visita-guiada.jpg');

-- Categoria_Cursos
INSERT INTO Categoria_Cursos (Nome) VALUES
('Restauro e Conservação'),
('Patrimônio Histórico'),
('Tecnologia'),
('Gestão Cultural'),
('Artes e Ofícios');

-- Usuarios
INSERT INTO Usuarios (Nome, Email, Senha, Telefone, Data_Cadastro, Administrador, Tipo_Usuario, CPF, Data_Aprovacao, Data_Nasc, Nacionalidade, Naturalidade, Profissao) VALUES
('Carlos Eduardo Mendes', 'carlos.mendes@email.com', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'Senha@123'), 2), '(15) 99123-4567', '2026-01-10', 1, 'A', '123.456.789-09', '2026-01-11', '1985-04-23', 'Brasileira', 'Itu - SP', 'Arquiteto'),
('Juliana Ferreira Costa', 'juliana.costa@email.com', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'Senha@456'), 2), '(11) 98765-4321', '2026-01-25', 0, 'S', '234.567.890-10', '2026-01-27', '1992-09-14', 'Brasileira', 'Sorocaba - SP', 'Professora'),
('Roberto Alves Pinto', 'roberto.pinto@email.com', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'Senha@789'), 2), '(11) 97654-3210', '2026-02-03', 0, 'P', '345.678.901-21', '2026-02-05', '1978-12-02', 'Brasileira', 'Campinas - SP', 'Engenheiro Civil'),
('Fernanda Oliveira Santos', 'fernanda.santos@email.com', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'Senha@321'), 2), '(11) 96543-2109', '2026-03-12', 0, 'S', '456.789.012-32', '2026-03-14', '2000-06-30', 'Brasileira', 'Itu - SP', 'Estudante'),
('Lucas Gabriel Rocha', 'lucas.rocha@email.com', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', 'Senha@654'), 2), '(11) 95432-1098', '2026-10-20', 0, 'P', '567.890.123-43', NULL, '1995-02-18', 'Brasileira', 'São Paulo - SP', 'Fotógrafo');

-- Contribuicao (Id_Parceiro, Id_Atividade)
INSERT INTO Contribuicao (Id_Parceiro, Id_Atividade) VALUES
(1, 1),
(1, 4),
(2, 3),
(3, 1),
(5, 4);

-- Centro_Conteudos
INSERT INTO Centro_Conteudos (Tipo, Tema, Categoria, Autor, Id_Atividade) VALUES
('Artigo', 'História da Igreja Matriz de Itu', 'Patrimônio Histórico', 'Dr. Paulo Henrique Martins', 1),
('Vídeo', 'Técnicas de restauro em madeira', 'Restauro', 'Equipe APRI', 2),
('Apresentação', 'Preservação do patrimônio na cidade', 'Educação Patrimonial', 'Profa. Helena Duarte', 3),
('Cartilha', 'Como contribuir com o restauro', 'Captação de Recursos', 'Equipe APRI', 4),
('Podcast', 'Memórias do centro histórico', 'Memória e Cultura', 'Marcos Vinícius Tavares', 5);

-- Cursos
INSERT INTO Cursos (Nome, Carga_Horaria, Responsavel_Curso, Links, Id_Atividades, Id_Categoria_Cursos) VALUES
('Introdução ao Restauro de Edificações', 40, 'Eng. Ricardo Menezes', 'https://apri.org.br/cursos/restauro-basico', 2, 1),
('Educação Patrimonial para Professores', 20, 'Profa. Helena Duarte', 'https://apri.org.br/cursos/edu-patrimonial', 3, 2),
('Fotografia e Documentação Digital', 30, 'Tiago Nogueira', 'https://apri.org.br/cursos/documentacao', 5, 3),
('Captação de Recursos para Projetos Culturais', 25, 'Camila Barbosa', 'https://apri.org.br/cursos/captacao', 4, 4),
('Oficina de Pintura Decorativa Histórica', 60, 'Mestre Antônio Silveira', 'https://apri.org.br/cursos/pintura', 2, 5);

-- Cursos_Usuario_Realiza
INSERT INTO Cursos_Usuario_Realiza (Date_Inscricao, Status_Curso, Id_Curso, Id_Usuario) VALUES
('2026-02-01', 'Em andamento', 1, 2),
('2026-02-05', 'Concluído', 2, 3),
('2026-03-12', 'Em andamento', 3, 4),
('2026-04-02', 'Cancelado', 4, 5),
('2026-05-18', 'Concluído', 1, 3);

-- Projetos
INSERT INTO Projetos (Nome, Status_Projetos, Id_Atividade) VALUES
('Restauro da Fachada da Matriz', 'Em andamento', 1),
('Biblioteca Digital do Patrimônio', 'Planejado', 3),
('Escola de Ofícios Tradicionais', 'Em andamento', 2),
('Fundo Solidário de Restauro', 'Concluído', 4),
('Roteiro Cultural do Centro Histórico', 'Planejado', 5);

-- Macro
INSERT INTO Macro (Orgao_Responsavel, Contato_Responsavel, Id_Projeto) VALUES
('Prefeitura de Itu', 'cultura@itu.sp.gov.br', 1),
('Secretaria Estadual de Cultura', 'contato.cultura@sp.gov.br', 2),
('Conselho Municipal do Patrimônio', '(11) 4022-0000', 3),
('Fundação Cultural de Itu', 'fundacao@culturaitu.org.br', 4),
('Secretaria Municipal de Turismo', 'turismo@itu.sp.gov.br', 5);

-- Micro
INSERT INTO Micro (Prioridade, Meta_Arrecadacao, Prazo_Estimado) VALUES
('Alta', 'R$ 150.000,00', '2026-12-31'),
('Média', 'R$ 40.000,00', '2027-03-31'),
('Alta', 'R$ 80.000,00', '2027-06-30'),
('Baixa', 'R$ 25.000,00', '2026-09-30'),
('Média', 'R$ 35.000,00', '2027-01-31');

-- Atualizacao
INSERT INTO Atualizacao (Titulo, Data_Atualizacao, Visibilidade, Id_Projeto) VALUES
('Andaimes instalados na fachada', '2026-04-02', 1, 1),
('Início da digitalização do acervo', '2026-05-15', 1, 2),
('Turma 1 da escola de ofícios formada', '2026-06-20', 1, 3),
('Meta da campanha atingida', '2026-07-10', 1, 4),
('Rascunho do roteiro em revisão', '2026-08-01', 0, 5);


-- Todos os registros de uma tabela
SELECT * FROM Parceiros;

-- Parceiros institucionais
SELECT Nome, Contato, Tipo_Apoio
FROM Parceiros
WHERE Parceiro_Inst = 1;

-- Atividades de 2026 ordenadas por data (mais recentes primeiro)
SELECT Titulo, Data
FROM Atividades_Institucionais
WHERE Data BETWEEN '2026-01-01' AND '2026-12-31'
ORDER BY Data DESC;

-- Usuários com cadastro pendente de aprovação
SELECT Nome, Email, Data_Cadastro
FROM Usuarios
WHERE Data_Aprovacao IS NULL;

-- Busca por texto (LIKE): cursos que contenham "Restauro" ou "Patrimônio"
SELECT Nome, Carga_Horaria
FROM Cursos
WHERE Nome LIKE '%Restauro%' OR Nome LIKE '%Patrimônio%';

-- Cursos com o nome da categoria
SELECT c.Nome AS Curso, cc.Nome AS Categoria, c.Carga_Horaria
FROM Cursos c
INNER JOIN Categoria_Cursos cc ON cc.Id_Categoria = c.Id_Categoria_Cursos
ORDER BY cc.Nome;

-- Parceiros que contribuíram em cada atividade
SELECT a.Titulo AS Atividade, p.Nome AS Parceiro, p.Tipo_Apoio
FROM Contribuicao ct
INNER JOIN Parceiros p ON p.Id_Parceiro = ct.Id_Parceiro
INNER JOIN Atividades_Institucionais a ON a.Id_Atividade = ct.Id_Atividade
ORDER BY a.Titulo;

-- Inscrições com nome do usuário, curso e status
SELECT u.Nome AS Usuario, c.Nome AS Curso, i.Date_Inscricao, i.Status_Curso
FROM Cursos_Usuario_Realiza i
INNER JOIN Usuarios u ON u.Id_Usuario = i.Id_Usuario
INNER JOIN Cursos c ON c.Id_Cursos = i.Id_Curso
ORDER BY i.Date_Inscricao;

-- Quantidade de inscrições por curso
SELECT c.Nome AS Curso, COUNT(i.Id_Inscricao) AS Total_Inscricoes
FROM Cursos c
LEFT JOIN Cursos_Usuario_Realiza i ON i.Id_Curso = c.Id_Cursos
GROUP BY c.Nome
ORDER BY Total_Inscricoes DESC;

-- Visão completa dos projetos (Projetos + Macro + Micro + Atividade)
SELECT p.Nome AS Projeto, p.Status_Projetos, m.Orgao_Responsavel,
       mi.Prioridade, mi.Meta_Arrecadacao, mi.Prazo_Estimado,
       a.Titulo AS Atividade
FROM Projetos p
INNER JOIN Macro m ON m.Id_Projeto = p.Id_Projeto
INNER JOIN Micro mi ON mi.Id_Projeto = p.Id_Projeto
INNER JOIN Atividades_Institucionais a ON a.Id_Atividade = p.Id_Atividade
ORDER BY mi.Prazo_Estimado;

-- Atualizações visíveis ao público, com o projeto correspondente
SELECT p.Nome AS Projeto, at.Titulo, at.Data_Atualizacao
FROM Atualizacao at
INNER JOIN Projetos p ON p.Id_Projeto = at.Id_Projeto
WHERE at.Visibilidade = 1
ORDER BY at.Data_Atualizacao DESC;

-- Usuários que concluíram algum curso
SELECT Nome, Email
FROM Usuarios
WHERE Id_Usuario IN (
    SELECT Id_Usuario
    FROM Cursos_Usuario_Realiza
    WHERE Status_Curso = 'Concluído'
);