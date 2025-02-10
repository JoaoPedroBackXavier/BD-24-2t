CREATE TABLE cliente(
	ID_cliente SERIAL Primary KEY,
	salario MONEY NOT NULL
	);
	drop table cliente
	
	INSERT INTO cliente (salario) VALUES
	(3200),
	(1200),
	(4000);

	select * FROM cliente;


	CREATE TABLE Historico_salarial(
		ID_Historico SERIAL PRIMARY KEY,
		ID_cliente int references cliente(ID_cliente),
		Data_Alteracao DATE,
		salario MONEY
	);
	drop table Historico_salarial

	CREATE OR REPLACE FUNCTION atualizacao_salario() RETURNS
	TRIGGER AS $$ BEGIN
	INSERT INTO Historico_salarial(ID_Cliente, Data_Alteracao, salario) VALUES
	(New.ID_Cliente, NOW(), New.salario);
	RETURN NULL; END; $$LANGUAGE plpgsql;

	CREATE OR REPLACE TRIGGER trigger_salario
	AFTER INSERT OR UPDATE ON Cliente
	FOR EACH ROW
	EXECUTE FUNCTION atualizacao_salario()








CREATE TABLE produto(
	ID_produto SERIAL Primary KEY,
	preco MONEY NOT NULL
	);
	
	CREATE TABLE Historico_preco(
		ID_Historico SERIAL PRIMARY KEY,
		ID_produto int references produto(ID_produto),
		Data_Alteracao DATE,
		preco MONEY
	);

		CREATE OR REPLACE FUNCTION atualizacao_preco() RETURNS
	TRIGGER AS $$ BEGIN
	INSERT INTO Historico_preco(ID_produto, Data_Alteracao, preco) VALUES
	(New.ID_produto, NOW(), New.preco);
	RETURN NULL; END; $$LANGUAGE plpgsql;

	CREATE OR REPLACE TRIGGER trigger_preco
	AFTER INSERT OR UPDATE ON produto
	FOR EACH ROW
	EXECUTE FUNCTION atualizacao_preco()

	insert into produto(preco)
	VALUES (10),(8),(9),(11),(9)

	select * from Historico_preco