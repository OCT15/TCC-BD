USE master
IF EXISTS(SELECT * FROM sys.databases WHERE name='eclair')
DROP DATABASE eclair
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
	qnt_max INT
)
GO

CREATE TABLE evento(
	id_evento INT PRIMARY KEY,
	dt_evento DATE,
	hr_inicio CHAR(8),
	acrescimos DECIMAL(7,2)
)
GO

CREATE TABLE produto(
	id_produto INT PRIMARY KEY,
	nm_produto VARCHAR(50),
	preço DECIMAL(6,2),
	quantidade INT,
	tipo_produto VARCHAR(20)
)
GO

CREATE TABLE pratos_evento(
	id_pratos_evento INT PRIMARY KEY,
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto)
)
GO

CREATE TABLE fornecedor_perecivel(
	id_fornecedor_perecivel INT PRIMARY KEY,
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

CREATE TABLE pedido_perecivel(
	id_pedido_perecivel INT PRIMARY KEY,
	id_fornecedor_perecivel INT FOREIGN KEY REFERENCES fornecedor_perecivel(id_fornecedor_perecivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO

CREATE TABLE detalhe_pedido_perecivel(
	id_detalhe_pedido_perecivel INT PRIMARY KEY,
	id_fornecedor_perecivel INT FOREIGN KEY REFERENCES fornecedor_perecivel(id_fornecedor_perecivel),
	id_pedido_perecivel INT FOREIGN KEY REFERENCES pedido_perecivel(id_pedido_perecivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO

CREATE TABLE fornecedor_consumivel(
	id_fornecedor_consumivel INT PRIMARY KEY,
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
	id_fornecedor_consumivel INT FOREIGN KEY REFERENCES fornecedor_consumivel(id_fornecedor_consumivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO

CREATE TABLE detalhe_pedido_consumivel(
	id_detalhe_pedido_consumivel INT PRIMARY KEY,
	id_fornecedor_consumivel INT FOREIGN KEY REFERENCES fornecedor_consumivel(id_fornecedor_consumivel),
	id_pedido_consumivel INT FOREIGN KEY REFERENCES pedido_consumivel(id_pedido_consumivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO

CREATE TABLE pacote(
	id_pacote INT PRIMARY KEY,
)
GO

CREATE TABLE produto_pacote(
	id_produto_pacote INT PRIMARY KEY,
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	id_pacote INT FOREIGN KEY REFERENCES pacote(id_pacote),
	qnt_produto_pacote_unitario INT,
	decoracao VARCHAR(200)
)
GO

CREATE TABLE contas(
	id_conta INT PRIMARY KEY,
	nm_conta VARCHAR(20),
	vencimento DATE,
	valor_conta DECIMAL(7,2),
	cod_conta VARCHAR(50)
)
GO
	
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

INSERT INTO mensagem(id_mensagem, conteudo, dt_envio) VALUES
(1, 'Olá, tudo bem?', '01/02/2015'),
(2, 'Olá, tudo bem?', '02/02/2015'),
(3, 'Olá, tudo bem?', '03/02/2015'),
(4, 'Olá, tudo bem?', '04/02/2015'),
(5, 'Olá, tudo bem?', '05/02/2015'),
(6, 'Olá, tudo bem?', '06/02/2015'),
(7, 'Olá, tudo bem?', '07/02/2015'),
(8, 'Olá, tudo bem?', '08/02/2015'),
(9, 'Olá, tudo bem?', '09/02/2015'),
(10, 'Olá, tudo bem?', '10/02/2015')

INSERT INTO cliente(id_cliente, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf, email) VALUES
(1, 'João', '123', '09/07/1997', 'Rua 123', '(11)2345-8767', '(11)98378-3787', '28738-578', '122.443.165-09', 'abc@abc.com'),
(2, 'Maria', '123', '09/07/1996', 'Rua 234', '(11)3542-8176', '(11)93847-1262', '18273-489', '129.187.938-37', 'bcd@abc.com'),
(3, 'José', '123', '09/07/1995', 'Rua 345', '(11)3565-7887', '(11)92389-1287', '18273-190', '546.289.298-19', 'cde@abc.com'),
(4, 'Irene', '123', '09/07/1994', 'Rua 456', '(11)1276-9189', '(11)90238-4562', '39384-083', '938.187.374-29', 'def@abc.com'),
(5, 'Odete', '123', '09/07/1993', 'Rua 567', '(11)7368-3287', '(11)92030-0929', '56373-827', '198.378.218-90', 'efg@abc.com'),
(6, 'Rosana', '123', '09/07/1992', 'Rua 678', '(11)2365-6739', '(11)92030-2877', '12728-278', '128.384.390-69', 'fgh@abc.com'),
(7, 'Claudia', '123', '09/07/1991', 'Rua 789', '(11)3873-0098', '(11)93030-2787', '19283-467', '598.129.198-03', 'ghi@abc.com'),
(8, 'Roberto', '123', '09/07/1990', 'Rua 890', '(11)3268-2837', '(11)91276-0939', '57839-128', '489.209.188-30', 'hij@abc.com'),
(9, 'Robson', '123', '09/07/1989', 'Rua 901', '(11)2398-2398', '(11)92363-8399', '93847-938', '982.127.189-64', 'ijk@abc.com'),
(10, 'Mário', '123', '09/07/1988', 'Rua 012', '(11)2099-2788', '(11)94673-1828', '17263-748', '289.489.093-90', 'jkl@abc.com')

INSERT INTO permissao(id_permissao, nm_permissao, lista_permissoes) VALUES
(1, 'Administrador', 'adm; atd; etq'),
(2, 'Atendente', 'atd; etq'),
(3, 'Estoquista','etq')

INSERT INTO funcionario(id_funcionario, id_permissao, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf, email) VALUES
(1, 1, 'Rita', '123', '05/07/1970', 'Rua abc', '(11)3782-0929', '(11)94893-3878', '01918-019', '898.234.824-83', 'rita@abc.com'),
(2, 1, 'Rúbia', '123', '31/07/1980', 'Rua bcd', '(11)3453-0929', '(11)99938-1102', '01343-439', '898.238.298-57', 'rubia@abc.com'),
(3, 1, 'Claudio', '123', '24/02/1972', 'Rua cde', '(11)2289-0929', '(11)92988-2993', '01323-019', '328.838.928-70', 'claudio@abc.com'),
(4, 2, 'Lúcia', '123', '05/08/1976', 'Rua def', '(11)2930-0929', '(11)92923-8393', '33318-390', '129.832.838-38', 'lucia@abc.com'),
(5, 2, 'João', '123', '04/03/1983', 'Rua efg', '(11)2918-0929', '(11)92039-1099', '01323-109', '647.763.872-83', 'joao@abc.com'),
(6, 2, 'Maria', '123', '16/11/1980', 'Rua fgh', '(11)2010-0929', '(11)93983-3300', '01238-129', '278.88.672-83', 'neusa@abc.com'),
(8, 3, 'Paulo', '123', '15/07/1989', 'Rua hij', '(11)3398-0929', '(11)99090-3198', '11912-129', '784.978.478-80', 'maria@abc.com'),
(7, 2, 'Neusa', '123', '19/12/1977', 'Rua ghi', '(11)3893-0929', '(11)94109-3838', '32318-192', '738.929.273.93', 'paulo@abc.com'),
(9, 3, 'Moisés', '123', '22/03/1991', 'Rua ijk', '(11)3390-0929', '(11)91822-8939', '19288-192', '783.939.376-48', 'moises@abc.com'),
(10, 3, 'Cíntia', '123', '28/01/1972', 'Rua jkl', '(11)3902-0929', '(11)95988-1178', '29389-837', '128.721.472-17', 'cintia@abc.com')

INSERT INTO lugar(id_lugar, endereco, cep, qnt_max) VALUES
(1, 'Rua aaa', '09383-039', 2000),
(2, 'Rua bbb', '28989-299', 800)

INSERT INTO evento(id_evento, dt_evento, hr_inicio) VALUES
(1, '12/12/2015', '19:00:00'),
(2, '20/12/2015', '20:00:00'),
(3, '18/11/2015', '18:00:00'),
(4, '29/12/2015', '22:00:00'),
(5, '01/12/2015', '21:00:00'),
(6, '24/12/2015', '22:00:00'),
(7, '29/11/2015', '20:00:00'),
(8, '10/12/2015', '17:00:00'),
(9, '27/11/2015', '19:00:00'),
(10, '03/12/2015', '19:30:00')

INSERT INTO produto(id_produto, nm_produto, preço, quantidade, tipo_produto) VALUES
(1, 'Pastel', 1.40, 1000, 'perecivel'),
(2, 'Coxinha', 0.14, 1000, 'perecivel'),
(3, 'Bolinha de queijo', 0.12, 1000, 'perecivel'),
(4, 'Mini-pizza', 0.78, 1000, 'perecivel'),
(5, 'Pipoca', 1.20, 1000, 'perecivel'),
(6, 'Hot dog', 1.60, 1000, 'perecivel'),
(7, 'Croquete', 1.1, 1000, 'perecivel'),
(8, 'Empadinha', 1.1, 1000, 'perecivel'),
(9, 'Brigadeiro', 1.1, 1000, 'perecivel'),
(10, 'Pé-de-moleque', 1.1, 1000, 'perecivel'),
(11, 'Beijinho', 1.1, 1000, 'perecivel'),
(12, 'Bala de côco', 1.1, 1000, 'perecivel'),
(13, 'Sorvete', 1.1, 1000, 'perecivel'),
(14, 'Torta de chocolate', 1.1, 1000, 'perecivel'),
(15, 'Torta de morango', 1.1, 1000, 'perecivel'),
(16, 'Pavê', 1.1, 1000, 'perecivel'),
(17, 'Água', 1.1, 1000, 'perecivel'),
(18, 'Refrigerante', 1.1, 1000, 'perecivel'),
(19, 'Suco', 1.1, 1000, 'perecivel'),
(20, 'Cerveja', 1.1, 1000, 'perecivel'),
(21, 'Vinho', 1.1, 1000, 'perecivel'),
(22, 'Champagne', 1.1, 1000, 'perecivel'),
(23, 'Pé-de-moleque', 1.1, 1000, 'perecivel'),
(24, 'Centro de mesa', 1.1, 1000, 'consumivel'),
(25, 'Enfeite de parede', 1.1, 1000, 'consumivel'),
(26, 'Bexigas coloridas', 1.1, 1000, 'consumivel'),
(27, 'Decoração para mesa', 1.1, 1000, 'consumivel'),
(28, 'Guardanapo', 1.1, 1000, 'consumivel'),
(29, 'Prato', 1.1, 1000, 'consumivel'),
(30, 'Copo', 1.1, 1000, 'consumivel'),
(31, 'Talher', 1.1, 1000, 'consumivel'),
(32, 'Toalha', 1.1, 1000, 'consumivel'),
(33, 'Cadeira', 1.1, 1000, 'consumivel'),
(34, 'Mesa', 1.1, 1000, 'consumivel'),
(35, 'Flores', 1.1, 1000, 'consumivel'),
(36, 'Lanterna', 1.1, 1000, 'consumivel'),
(37, 'Glow sticks', 1.1, 1000, 'consumivel'),
(38, 'Feijoada', 1.1, 300, 'perecivel'),
(39, 'Escondidinho de queijo', 1.1, 1000, 'perecivel'),
(40, 'Macarrão ao molho branco', 1.1, 1000, 'perecivel')

INSERT INTO pratos_evento(id_pratos_evento, id_produto) VALUES
(1, 38),
(2, 39),
(3, 40)

INSERT INTO fornecedor_perecivel(id_fornecedor_perecivel, empresa, endereco, telefone, celular, cnpj, email, website, representante) VALUES
(1, 'abc', 'Rua 123', '(11)5852-8565', '(11)95856-8457', '78.425.986/0036-15', 'abcd@abc.com', 'www.abc.com', 'Jorge')


INSERT INTO pedido_perecivel(id_pedido_perecivel, id_fornecedor_perecivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 1, 'Pastel', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(2, 1, 2, 'Coxinha', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(3, 1, 3, 'Bolinha de queijo', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(4, 1, 4, 'Mini-pizza', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(5, 1, 5, 'Pipoca', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(6, 1, 6, 'Hot Dog', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(7, 1, 7, 'Croquete', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(8, 1, 8, 'Empadinha', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(9, 1, 9, 'Brigadeiro', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(10, 1, 10, 'Pé-de-moleque', 1000, 1, '10/12/2015', '20/12/2015', 1000)

INSERT INTO detalhe_pedido_perecivel(id_detalhe_pedido_perecivel, id_pedido_perecivel, id_fornecedor_perecivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 1, 1, 'Pastel', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(2, 2, 1, 2, 'Coxinha', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(3, 3, 1, 3, 'Bolinha de queijo', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(4, 4, 1, 4, 'Mini-pizza', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(5, 5, 1, 5, 'Pipoca', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(6, 6, 1, 6, 'Hot Dog', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(7, 7, 1, 7, 'Croquete', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(8, 8, 1, 8, 'Empadinha', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(9, 9, 1, 9, 'Brigadeiro', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(10, 10, 1, 10, 'Pé-de-moleque', 1000, 1, '10/12/2015', '20/12/2015', 1000)


INSERT INTO fornecedor_consumivel(id_fornecedor_consumivel, empresa, endereco, telefone, celular, cnpj, email, website, representante) VALUES
(1, 'def', 'Rua 234', '(11)6549-2456', '(11)98755-8645', '32.365.542/0042-11', 'efjk@abc.com', 'www.def.com', 'Alberto') 

INSERT INTO pedido_consumivel(id_pedido_consumivel, id_fornecedor_consumivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 24, 'Centro de mesa', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(2, 1, 25, 'Enfeite de parede', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(3, 1, 26, 'Bexigas coloridas', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(4, 1, 27, 'Decoração para mesa', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(5, 1, 28, 'Guardanapo', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(6, 1, 29, 'Prato', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(7, 1, 30, 'Copo', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(8, 1, 31, 'Talher', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(9, 1, 32, 'Toalha', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(10, 1, 33, 'Cadeira', 1000, 1, '10/12/2015', '20/12/2015', 1000)

INSERT INTO detalhe_pedido_consumivel(id_detalhe_pedido_consumivel, id_pedido_consumivel, id_fornecedor_consumivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 1, 24, 'Centro de mesa', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(2, 2, 1, 25, 'Enfeite de parede', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(3, 3, 1, 26, 'Bexigas coloridas', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(4, 4, 1, 27, 'Decoração para mesa', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(5, 5, 1, 28, 'Guardanapo', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(6, 6, 1, 29, 'Prato', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(7, 7, 1, 30, 'Copo', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(8, 8, 1, 31, 'Talher', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(9, 9, 1, 32, 'Toalha', 1000, 1, '10/12/2015', '20/12/2015', 1000),
(10, 10, 1, 33, 'Cadeira', 1000, 1, '10/12/2015', '20/12/2015', 1000)



SELECT * FROM produto

SELECT * FROM evento 
