-- visualizar 10 linhas do banco de dados
SELECT * FROM mkt.bank LIMIT 10;

-- quantidade de profissões cadastradas (12 profissões)
SELECT COUNT(DISTINCT job) FROM mkt.bank;

-- nome de todas as profissões cadastradas
SELECT DISTINCT job FROM mkt.bank;

-- quantidade de pessoas desempregadas
SELECT COUNT(*) FROM mkt.bank
WHERE job = 'unemployed';

SELECT * FROM mkt.bank;

-- entramos em contato com 128 pessoas desempregadas
-- número de pessoas desempregadas contatadas no mês de abril (5 pessoas)
SELECT COUNT(*) FROM mkt.bank
WHERE job = 'unemployed' AND month = 'apr';

-- número de pessoas desempregadas contatadas no mês de abril E que aceitaram a proposta (2 pessoas)
SELECT COUNT(*) FROM mkt.bank
WHERE job = 'unemployed' AND month = 'apr' AND y = 'yes';

-- 2 pessoas estavam desempregadas, foram contatadas em abril e aceitaram nosso produto!!!!

-- número de pessoas  emprego que estão desempregadas OU que a profissão é estudante
SELECT COUNT(*) FROM mkt.bank
WHERE job = 'unemployed' OR job = 'student';

-- número de pessoas com as profissões entre parenteses 
SELECT COUNT(*) FROM mkt.bank
WHERE job IN ('unemployed','student', 'blue collar');

-- pessoas desempregadas OU estudantes, que foram contatadas em abril E aceitaram a proposta
SELECT * FROM mkt.bank
WHERE (job = 'unemployed' OR job='student') AND month = 'apr' AND y = 'yes';

-- pessoas contatadas em janeiro E negaram a proposta OU pessoas contatadas em fevereiro E aceitaram a proposta
SELECT * FROM mkt.bank
WHERE (month = 'jan' AND y='no') OR (month = 'feb' AND y = 'yes');


-- pessoas que NÃO aceitaram a proposta, profissão NÃO é desempregado ou estudante e que tem idade entre 18 e 30 anos
SELECT * FROM mkt.bank
WHERE NOT  y = 'yes' AND job NOT in ('unemployed', 'student') AND age BETWEEN 18 AND 30;

-- WHERE age IS NULL / WHERE job IS NOT NULL


-- FILTRO DE STRINGS
CREATE TABLE mkt.nomes (
    primeiro_nome VARCHAR(50),
    ultimo_nome VARCHAR(50)
);

INSERT INTO mkt.nomes (primeiro_nome, ultimo_nome) VALUES 
('Ana', 'Silva'),
('Antônio', 'Costa'),
('Aline', 'Machado'),
('André', 'Lima'),
('Alice', 'Santos'),
('Alberto', 'Oliveira'),
('Amanda', 'Pereira'),
('Alex', 'Martins'),
('Aurora', 'Souza'),
('Arthur', 'Rocha'),
('Augusto', 'Almeida'),
('Ariel', 'Barros'),
('Anita', 'Carvalho'),
('Anderson', 'Dias'),
('Aurélio', 'Fernandes'),
('Afonso', 'Gonçalves'),
('Alessandra', 'Henriques'),
('Alan', 'Ishida'),
('Alana', 'Jardim'),
('Alexandre', 'Kuwabara');

SELECT * FROM mkt.nomes;

-- filtro de string
SELECT * FROM mkt.nomes
WHERE UPPER(primeiro_nome) = 'ANA'; -- filtra Ana, ANA< ana 

-- filtro com nome que contem ___
SELECT * FROM mkt.nomes 
WHERE UPPER(primeiro_nome) LIKE 'GUSTO%';

-- BETWEEN com STRING
SELECT * FROM mkt.nomes 
WHERE UPPER(primeiro_nome) BETWEEN 'AB' AND 'AR';