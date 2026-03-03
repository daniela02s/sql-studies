-- DROP DATABASE IF EXISTS comunidade;
-- CREATE DATABASE comunidade;
-- USE comunidade;

SELECT * FROM aluno;
SELECT * FROM curso;
SELECT * FROM professor;

-- criando tabelas
DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno(
	matricula INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    nascimento DATE NOT NULL,
    PRIMARY KEY (matricula)
);

DROP TABLE IF EXISTS curso;
CREATE TABLE curso(
	cod_curso VARCHAR(50) NOT NULL,
    nome_curso VARCHAR(50) NOT NULL,
    materia VARCHAR(50),
    matricula INT, 
    FOREIGN KEY (matricula) 
		REFERENCES aluno(matricula)
			ON DELETE CASCADE
);

-- inserindo valores
INSERT INTO aluno (nome, nascimento) VALUES ('Isabela Martins', '1993-08-27'),
											('Marcos Costa', '1984-02-15'),
                                            ('Gustavo Lopes', '1979-04-03'),
                                            ('Patricia Alves', '1996-11-21'),
                                            ('Nicolas Barbosa', '1999-04-10');
                                            
INSERT INTO curso (cod_curso, nome_curso, materia, matricula) VALUES ('ENQ20241', 'Engenharia Química', 'Processos', 4),
																	 ('MAT20241', 'Matemática', 'Algebra Linear', 5),
                                                                     ('FIS20242', 'Física', 'Física I', 2),
                                                                     ('MED20241', 'Medicina', 'Anatomia', 3),
                                                                     ('ARQ20242', 'Arquitetura', 'Cálculo II', 1);


-- alunos em ordem alfabética
SELECT *
FROM aluno
ORDER BY nome;


-- quantidade de alunos cadastrados
SELECT COUNT(*) 
AS 'Registros'
FROM aluno;


/*
1 = Domingo,
2 = Segunda,
3 = Terça,
4 = Quarta,
5 = Quinta,
6 = Sexta,
7 = Sábado
*/


SELECT 
		nome,
        EXTRACT(YEAR FROM nascimento) AS 'Ano_Nascimento',
        EXTRACT(MONTH FROM nascimento) AS 'Mês_Nascimento',
        EXTRACT(DAY FROM nascimento) AS 'Dia_Nascimento',
        DAYOFWEEK(nascimento) AS 'Dia_da_Semana',
	CASE
		WHEN DAYOFWEEK(nascimento) = 1 THEN 'Domingo'
		WHEN DAYOFWEEK(nascimento) = 2 THEN 'Segunda'
		WHEN DAYOFWEEK(nascimento) = 3 THEN 'Terça'
		WHEN DAYOFWEEK(nascimento) = 4 THEN 'Quarta'
		WHEN DAYOFWEEK(nascimento) = 5 THEN 'Quinta'
		WHEN DAYOFWEEK(nascimento) = 6 THEN 'Sexta'
		WHEN DAYOFWEEK(nascimento) = 7 THEN 'Sábado'
	END AS 'Dia_da_Semana',
        EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM nascimento) AS 'Idade',
        c.*
FROM aluno
-- WHERE DAYOFWEEK(nascimento) BETWEEN 2 AND 6; -- excluir sábado e domingo
LEFT JOIN curso c -- inclui valores vazios
-- INNER JOIN == JOIN curso c não considera valores vazios
		ON aluno.matricula = c.matricula;


SELECT 
		EXTRACT(YEAR FROM CURRENT_DATE) AS 'Ano_Atual',
        EXTRACT(YEAR FROM nascimento) AS 'Ano_Nascimento',
        EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM nascimento) AS 'Idade'
FROM aluno;
 
 
 -- mais valores
INSERT INTO aluno (nome, nascimento) VALUES ('Beatriz Ferreira', '1995-12-05'),
                                            ('Rodrigo Sanches', '1988-06-18'),
                                            ('Camila Oliveira', '2001-03-22'),
                                            ('Thiago Souza', '1992-09-30'),
                                            ('Larissa Mendes', '1997-07-14'),
                                            ('Felipe Antunes', '2000-01-25'),
                                            ('Debora Peixoto', '1982-11-02');
                                            
INSERT INTO curso (cod_curso, nome_curso, materia, matricula) VALUES ('DIR20241', 'Direito', 'Direito Civil', 6),
                                                                     ('ADM20242', 'Administração', 'Gestão Financeira', 7),
                                                                     ('BIO20241', 'Biologia', 'Genética', 8),
                                                                     ('ADS20242', 'Análise de Sistemas', 'Estrutura de Dados', 9),
																	 ('PSICO20241', 'Psicologia', 'Neurociência', 10),
                                                                     ('GEO20242', 'Geografia', 'Cartografia', 11),
                                                                     ('HIST20241', 'História', 'Brasil Colônia', 12);