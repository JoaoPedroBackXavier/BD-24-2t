/* simulado logico arquivo: */

CREATE TABLE usuario (
    e_mail string(50),
    preferencias .json,
    tipo_de_assinatura string(25),
    ID_usuario number(300000000) PRIMARY KEY
);

CREATE TABLE filme (
    titulo string(50),
    ID_filme number(20000) PRIMARY KEY,
    idiomas_disponiveis array(50),
    atores array(100),
    genero string(50)
);

CREATE TABLE avaliacao (
    avaliacao string(500),
    Campo number(300000000),
    ID_filme number(20000)
);

CREATE TABLE lista (
    fk_filme_ID_filme number(20000),
    fk_usuario_ID_usuario number(300000000),
    data_de_salvamento number(8)
);

CREATE TABLE assiste (
    fk_usuario_ID_usuario number(300000000),
    fk_filme_ID_filme number(20000)
);
 
ALTER TABLE avaliacao ADD CONSTRAINT FK_avaliacao_1
    FOREIGN KEY (Campo)
    REFERENCES usuario (ID_usuario);
 
ALTER TABLE avaliacao ADD CONSTRAINT FK_avaliacao_2
    FOREIGN KEY (ID_filme)
    REFERENCES filme (ID_filme);
 
ALTER TABLE lista ADD CONSTRAINT FK_lista_1
    FOREIGN KEY (fk_filme_ID_filme)
    REFERENCES filme (ID_filme);
 
ALTER TABLE lista ADD CONSTRAINT FK_lista_2
    FOREIGN KEY (fk_usuario_ID_usuario)
    REFERENCES usuario (ID_usuario);
 
ALTER TABLE assiste ADD CONSTRAINT FK_assiste_1
    FOREIGN KEY (fk_usuario_ID_usuario)
    REFERENCES usuario (ID_usuario)
    ON DELETE SET NULL;
 
ALTER TABLE assiste ADD CONSTRAINT FK_assiste_2
    FOREIGN KEY (fk_filme_ID_filme)
    REFERENCES filme (ID_filme)
    ON DELETE SET NULL;