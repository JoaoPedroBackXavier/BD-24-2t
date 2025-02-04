CREATE DATABASE Hogwarts

CREATE TABLE Casa(
    pk_ID_casa INT primary key,
    casa_nome varchar(30)
);

CREATE TABLE Materia(
    pk_ID_materia INT primary key,
    materia_nome varchar(50)
);
drop table Materia


CREATE TABLE Professor(
    pk_ID_professor INT primary key,
    professor_nome varchar(30),
    professor_anosDeExperiencia INT,
    materia INT,
    foreign key (materia) references Materia(pk_ID_materia)
);
drop table Professor

CREATE TABLE Feitico(
    pk_ID_feitico INT primary key,
    feitico_nome VARCHAR(30),
    feitico_tipo varchar(50)
);

CREATE TABLE Personagem(
    pk_ID_personagem INT primary key,
    personagem_nome varchar(30),
    personagem_dataDeNascimento INT,
    fk_casa INT,
    fk_professor INT,
    fk_Feitico INT,
    foreign key (fk_casa) references casa(pk_ID_casa),
    foreign key (fk_professor) references Professor(pk_ID_professor),
    foreign key (fk_Feitico) references Feitico(pk_ID_feitico)
);
drop table Personagem

INSERT INTO Casa (pk_ID_casa, casa_nome) VALUES
(1, 'Lufa-Lufa'),
(2, 'Sonserina'),
(3, 'Grifinória'),
(4, 'Corvinal');

INSERT INTO Materia (pk_ID_materia, materia_nome) VALUES
(1, 'Poções'),
(2, 'Defesa Contra as Artes das Trevas'),
(3, 'Transfiguração'),
(4, 'Astronomia');

INSERT INTO Professor (pk_ID_professor, professor_nome, professor_anosDeExperiencia, materia) VALUES
(1, 'Severus Snape', 20, 3),
(2, 'Minerva McGonagall', 30, 2),
(3, 'Filius Flitwick', 25, 1),
(4, 'Pomona Sprout', 15, 4);

INSERT INTO Feitico (pk_ID_feitico, feitico_nome, feitico_tipo) VALUES
(1, 'Expelliarmus', 'Desarmante'),
(2, 'Avada Kedavra', 'Mortal'),
(3, 'Wingardium Leviosa', 'Levitação'),
(4, 'Lumos', 'Iluminação');

INSERT INTO Personagem (pk_ID_personagem, personagem_nome, personagem_dataDeNascimento, fk_casa, fk_professor, fk_Feitico) VALUES
(1, 'Harry Potter', '19800731', 1, 4, 2),
(2, 'Hermione Granger', '19790919', 3, 1, 2),
(3, 'Draco Malfoy', '19800605', 2, 2, 1),
(4, 'Luna Lovegood', '19810213', 4, 3, 4);

SELECT Personagem.personagem_nome AS aluno, Casa.casa_nome AS casa  FROM Personagem
JOIN Casa ON personagem.fk_Casa = Casa.pk_ID_Casa;

SELECT Personagem.personagem_nome AS aluno, Casa.casa_nome AS casa FROM Personagem
JOIN Casa ON personagem.fk_Casa = Casa.pk_ID_Casa
WHERE personagem.fk_Casa = 1;

CREATE VIEW view_personagens_grifinoria AS
SELECT Personagem.personagem_nome AS aluno, Personagem.personagem_dataDeNascimento AS data_nascimento, Casa.casa_nome AS casa  FROM Personagem
JOIN Casa ON personagem.fk_Casa = Casa.pk_ID_Casa
WHERE personagem.fk_Casa = 3;

CREATE INDEX indiceLegal
ON Personagem(personagem_nome);