-- DROP DATABASE IF EXISTS comunidade;
-- CREATE DATABASE comunidade;
-- USE comunidade;

-- inserindo valores
INSERT INTO aluno (nome, nascimento) VALUES ('Isabela Martins', '1993-08-27');
INSERT INTO aluno (nome, nascimento) VALUES ('Marcos Costa', '1984-02-15');
INSERT INTO aluno (nome, nascimento) VALUES ('Gustavo Lopes', '1979-04-03');
INSERT INTO aluno (nome, nascimento) VALUES ('Patricia Alves', '1996-11-21');
INSERT INTO aluno (nome, nascimento) VALUES ('Nicolas Barbosa', '1999-04-10');

SELECT * FROM aluno;

-- TRUNCATE TABLE aluno;

-- criando tabelas
DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno(
	matricula INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    nascimento DATE NOT NULL,
    PRIMARY KEY (matricula)
);

DROP TABLE IF EXISTS professor;
CREATE TABLE professor(
	idProfessor INT PRIMARY KEY AUTO_INCREMENT,
    nome_professor VARCHAR(100)
);

DROP TABLE IF EXISTS curso;
CREATE TABLE curso(
	idCurso INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(50) NOT NULL,
    qtdAlunos INT NOT NULL,
    idProfessor INT, 
    FOREIGN KEY (idProfessor) REFERENCES professor(idProfessor)
		ON DELETE CASCADE
);

-- ALTER TABLE table_name
-- ADD new_column_name column_definition
-- AFTER column_name
