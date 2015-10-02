Use master
IF EXISTS(select * from sys.databases where name='eclair')
Drop Database eclair
CREATE DATABASE eclair
GO
USE eclair
GO

CREATE TABLE mensagem(
	id_mensagem INT PRIMARY KEY,
	conteudo VARCHAR(300),
	dt_envio DATE
)
GO	
CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY,
	nome VARCHAR(50),
	senha VARCHAR(50),
	idade NUMERIC(3),
	dt_nascim DATE,
	endereco VARCHAR(100),
	telefone CHAR(13),--(00)0000-0000
	celular CHAR(14),--(00)90000-0000
	cep CHAR(9), --00000-000
	cpf CHAR(14), --000.000.000-00
	email VARCHAR(254)
)
GO
CREATE TABLE permissao(
	id_permissao INT PRIMARY KEY,
	nm_permissao VARCHAR(15),
	lista_permissoes VARCHAR(150)
)
GO
CREATE TABLE funcionario(
	id_funcionario INT PRIMARY KEY,
	id_permissao INT FOREIGN KEY REFERENCES permissao(id_permissao),
	nome VARCHAR(50),
	senha VARCHAR(50),
	idade NUMERIC(3),
	dt_nascim DATE,
	endereco VARCHAR(100),
	telefone CHAR(13),
	celular CHAR(14),
	cep CHAR(9),
	cpf CHAR(14),
	email VARCHAR(254)
)
GO	
CREATE TABLE lugar(
	id_lugar INT PRIMARY KEY,
	endereco VARCHAR(100),
	cep CHAR(9),
	qtd_max INT
)
GO
CREATE TABLE evento(
	id_evento INT PRIMARY KEY,
	dt_evento DATE,
	hr_inicio TIME
)
GO
CREATE TABLE produto(
	id_produto INT PRIMARY KEY,
	nm_produto VARCHAR(20),
	quantidade INT,
	preco DECIMAL(7,2),
	tipo_produto VARCHAR(20)
)
GO
CREATE TABLE pratos_evento(
	id_pratos_evento INT PRIMARY KEY,
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto)
)
GO
CREATE TABLE pedido_perecivel(
	id_pedido_perecivel INT PRIMARY KEY,
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_comida VARCHAR(20),
	qnt_comida INT,
	valor_comida DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(7,2)
)
GO
CREATE TABLE detalhe_pedido_perecivel(
	id_detalhe_pedido_perecivel INT PRIMARY KEY,
	id_pedido_perecivel INT FOREIGN KEY REFERENCES pedido_perecivel(id_pedido_perecivel),
	tipo_prato VARCHAR(50),
	nm_comida VARCHAR(50),
	qnt_comida INT,
	valor_comida DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(7,2)
)
GO
CREATE TABLE forenecedor_perecivel(
	id_fornecedor_perecivel INT PRIMARY KEY,
	id_detalhe_pedido_perecivel INT FOREIGN KEY REFERENCES detalhe_pedido_perecivel(id_detalhe_pedido_perecivel),
	id_pedido_perecivel INT FOREIGN KEY REFERENCES pedido_perecivel(id_pedido_perecivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	empresa VARCHAR(50),
	endereco VARCHAR(100),
	telefone CHAR(13),
	celular CHAR(14),
	cnpj CHAR(18),
	email VARCHAR(254),
	website VARCHAR(100),
	representante VARCHAR(50)
)
GO
CREATE TABLE pedido_consumivel(
	id_pedido_consumivel INT PRIMARY KEY,
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(7,2)
)
GO
CREATE TABLE detalhe_pedido_consumivel(
	id_detalhe_pedido_consumivel INT PRIMARY KEY,
	id_pedido_consumivel INT FOREIGN KEY REFERENCES pedido_consumivel(id_pedido_consumivel),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(7,2)
)
GO
CREATE TABLE fornecedor_consumivel(
	id_fornecedor_consumivel INT PRIMARY KEY,
	id_detalhe_pedido_consumivel INT FOREIGN KEY REFERENCES detalhe_pedido_consumivel(id_detalhe_pedido_consumivel),
	id_pedido_consumivel INT FOREIGN KEY REFERENCES pedido_consumivel(id_pedido_consumivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	empresa VARCHAR(50),
	endereco VARCHAR(100),
	telefone CHAR(13),
	celular CHAR(14),
	cnpj CHAR(18),
	email VARCHAR(254),
	website VARCHAR(100),
	representante VARCHAR(50)
)
GO
CREATE TABLE produto_pacote(
	id_produto_pacote INT PRIMARY KEY,
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	qnt_produto_pacote INT
)
GO
CREATE TABLE pacote(
	id_pacote INT PRIMARY KEY,
	id_produto_pacote INT FOREIGN KEY REFERENCES produto_pacote(id_produto_pacote),
	qnt_convidados_minimo INT,
	qnt_convidado_maximo INT
)
GO
CREATE TABLE contas(
	id_conta INT PRIMARY KEY,
	nm_conta VARCHAR(20),
	vencimento DATE,
	valor_conta DECIMAL(7,2),
	cod_conta VARCHAR(50)
)
	
CREATE TABLE detalhe_orcamento(
	id_detalhe_orcamento INT PRIMARY KEY,
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	valor_orcamento DECIMAL(7,2),
	num_convidados INT,
	dt_evento DATE,
	qnt_pratos INT,
	tipo_prato INT,
	local_evento VARCHAR(50),
	tema VARCHAR(50),
	email_cliente VARCHAR(254),
	dt_orcamento DATE
)
GO
CREATE TABLE orcamento(
	id_orcamento INT PRIMARY KEY,
	id_detalhe_orcamento INT FOREIGN KEY REFERENCES detalhe_orcamento(id_detalhe_orcamento),
	id_lugar INT FOREIGN KEY REFERENCES lugar(id_lugar),
	id_evento INT FOREIGN KEY REFERENCES evento(id_evento),
	id_pratos_evento INT FOREIGN KEY REFERENCES pratos_evento(id_pratos_evento),
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	id_permissao INT FOREIGN KEY REFERENCES permissao(id_permissao),
	id_funcionario INT FOREIGN KEY REFERENCES funcionario(id_funcionario),
	valor_orcamento DECIMAL(7,2),
	num_convidados INT,
	dt_evento DATE,
	qnt_pratos INT,
	tipo_prato INT,
	local_evento VARCHAR(50),
	tema VARCHAR(50),
	email_cliente VARCHAR(254),
	dt_orcamento DATE
)
GO
CREATE TABLE detalhe_cancelamento(
	id_detalhe_cancelamento INT PRIMARY KEY,
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	id_orcamento INT FOREIGN KEY REFERENCES orcamento(id_orcamento),
	motivo VARCHAR(150),
	dt_cancelamento DATE
)

