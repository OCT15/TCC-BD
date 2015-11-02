USE master
IF EXISTS(SELECT * FROM sys.databases WHERE name='eclair')
DROP DATABASE eclair
CREATE DATABASE eclair
GO
USE eclair
GO

/** Mensagens dos clientes pelo site **/
CREATE TABLE mensagem(
	id_mensagem INT PRIMARY KEY,
	conteudo VARCHAR(300),
	dt_envio DATE
)
GO	

/** Dados dos clientes **/	
CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY,
	nome VARCHAR(50),
	senha VARCHAR(50),
	dt_nascim DATE,
	endereco VARCHAR(100),
	telefone CHAR(13),--(00)0000-0000
	celular CHAR(14),--(00)90000-0000
	cep CHAR(9), --00000-000
	cpf_cnpj CHAR(18), --000.000.000-00
	rg_ie CHAR(12), --00.000.000-0
	uf CHAR(2),
	email VARCHAR(254)
)
GO

/** Nível de permissão dos funcionários **/
CREATE TABLE permissao(
	id_permissao INT PRIMARY KEY,
	nm_permissao VARCHAR(15),
	lista_permissoes VARCHAR(150)
)
GO

/** Dados dos funcionários **/
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
	cpf_cnpj CHAR(18),
	rg_ie CHAR(12),
	uf CHAR(2),
	email VARCHAR(254)
)
GO

/** Lugares disponíveis para eventos **/
CREATE TABLE lugar(
	id_lugar INT PRIMARY KEY,
	nome_lugar VARCHAR(20),
	endereco VARCHAR(100),
	cep CHAR(9),
	qnt_max INT
)
GO

/** Lista de produtos do estoque **/
CREATE TABLE produto(
	id_produto INT PRIMARY KEY,
	nm_produto VARCHAR(50),
	preco DECIMAL(6,2),
	quantidade INT,
	tipo_produto VARCHAR(20)
)
GO

/** Dados do fornecedor de produtos perecíveis **/
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

/** Pedidos de produtos perecíveis **/
CREATE TABLE pedido_perecivel(
	id_pedido_perecivel INT PRIMARY KEY,
	id_fornecedor_perecivel INT FOREIGN KEY REFERENCES fornecedor_perecivel(id_fornecedor_perecivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(8,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO

/** Detalhes dos pedidos de produtos perecíveis **/
CREATE TABLE detalhe_pedido_perecivel(
	id_detalhe_pedido_perecivel INT PRIMARY KEY,
	id_fornecedor_perecivel INT FOREIGN KEY REFERENCES fornecedor_perecivel(id_fornecedor_perecivel),
	id_pedido_perecivel INT FOREIGN KEY REFERENCES pedido_perecivel(id_pedido_perecivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(8,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO


/** Dados do fornecedor de produtos consumíveis **/
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

/** Pedidos de produtos consumíveis **/
CREATE TABLE pedido_consumivel(
	id_pedido_consumivel INT PRIMARY KEY,
	id_fornecedor_consumivel INT FOREIGN KEY REFERENCES fornecedor_consumivel(id_fornecedor_consumivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(8,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO

/** Detalhes dos pedidos de produtos perecíveis **/
CREATE TABLE detalhe_pedido_consumivel(
	id_detalhe_pedido_consumivel INT PRIMARY KEY,
	id_fornecedor_consumivel INT FOREIGN KEY REFERENCES fornecedor_consumivel(id_fornecedor_consumivel),
	id_pedido_consumivel INT FOREIGN KEY REFERENCES pedido_consumivel(id_pedido_consumivel),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(8,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(10,2)
)
GO

/** Sugestões de pacotes para eventos **/
CREATE TABLE pacote(
	id_pacote INT PRIMARY KEY,
	nome VARCHAR(25),
	decoracao VARCHAR(200),
)
GO

/** Produtos acrescentados aos pacotes **/
CREATE TABLE produto_pacote(
	id_pacote INT FOREIGN KEY REFERENCES pacote(id_pacote),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	qnt_produto INT
)
GO

/** Contas da empresa **/
CREATE TABLE contas(
	id_conta INT PRIMARY KEY,
	nm_conta VARCHAR(20),
	vencimento DATE,
	valor_conta DECIMAL(8,2),
	cod_conta VARCHAR(50)
)
GO

/** Especificações dos orçamentos realizados **/
CREATE TABLE orcamento(
	id_orcamento INT PRIMARY KEY,
	id_lugar INT FOREIGN KEY REFERENCES lugar(id_lugar),
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	id_permissao INT FOREIGN KEY REFERENCES permissao(id_permissao),
	id_funcionario INT FOREIGN KEY REFERENCES funcionario(id_funcionario),
	valor_orcamento DECIMAL(8,2),
	num_convidados INT,
	dt_evento DATE,
	qnt_pratos INT,
	local_evento VARCHAR(50),
	tema VARCHAR(50),
	email_cliente VARCHAR(254),
	dt_orcamento DATE,
	hr_inicio TIME
)
GO

/** Pratos disponíveis para os eventos **/
CREATE TABLE pratos_evento(
	id_orcamento INT FOREIGN KEY REFERENCES orcamento(id_orcamento),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	qtd_produto INT
)
GO

/** Especificações dos eventos **/
CREATE TABLE evento(
	id_evento INT PRIMARY KEY,
	id_lugar INT FOREIGN KEY REFERENCES lugar(id_lugar),
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	id_permissao INT FOREIGN KEY REFERENCES permissao(id_permissao),
	id_funcionario INT FOREIGN KEY REFERENCES funcionario(id_funcionario),
	valor_orcamento DECIMAL(8,2),
	num_convidados INT,
	dt_evento DATE,
	qnt_pratos INT,
	local_evento VARCHAR(50),
	tema VARCHAR(50),
	email_cliente VARCHAR(254),
	dt_orcamento DATE,
	hr_inicio TIME
)
GO

/** Detalhes dos cancelamentos **/
CREATE TABLE detalhe_cancelamento(
	id_detalhe_cancelamento INT PRIMARY KEY,
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	id_orcamento INT FOREIGN KEY REFERENCES orcamento(id_orcamento),
	motivo VARCHAR(150),
	dt_cancelamento DATE
)
GO

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

INSERT INTO cliente(id_cliente, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf_cnpj, rg_ie, uf, email) VALUES
(1, 'João', '123', '09/07/1997', 'Rua 123', '(11)2345-8767', '(11)98378-3787', '28738-578', '122.443.165-09', '11.586.854-8', 'SP', 'abc@abc.com'),
(2, 'Maria', '123', '09/07/1996', 'Rua 234', '(11)3542-8176', '(11)93847-1262', '18273-489', '129.187.938-37', '22.528.785-4', 'SP', 'bcd@abc.com'),
(3, 'José', '123', '09/07/1995', 'Rua 345', '(11)3565-7887', '(11)92389-1287', '18273-190', '546.289.298-19', '21.856.888-9', 'SP', 'cde@abc.com'),
(4, 'Irene', '123', '09/07/1994', 'Rua 456', '(11)1276-9189', '(11)90238-4562', '39384-083', '938.187.374-29', '30.856.745.5', 'SP', 'def@abc.com'),
(5, 'Odete', '123', '09/07/1993', 'Rua 567', '(11)7368-3287', '(11)92030-0929', '56373-827', '198.378.218-90', '50.958.758-4', 'SP', 'efg@abc.com'),
(6, 'Rosana', '123', '09/07/1992', 'Rua 678', '(11)2365-6739', '(11)92030-2877', '12728-278', '128.384.390-69', '19.875.953.3', 'SP', 'fgh@abc.com'),
(7, 'Claudia', '123', '09/07/1991', 'Rua 789', '(11)3873-0098', '(11)93030-2787', '19283-467', '598.129.198-03', '40.685.859-7', 'SP', 'ghi@abc.com'),
(8, 'Roberto', '123', '09/07/1990', 'Rua 890', '(11)3268-2837', '(11)91276-0939', '57839-128', '489.209.188-30', '32.956.859-6', 'SP', 'hij@abc.com'),
(9, 'Robson', '123', '09/07/1989', 'Rua 901', '(11)2398-2398', '(11)92363-8399', '93847-938', '982.127.189-64', '11.548.852.7', 'SP', 'ijk@abc.com'),
(10, 'Mário', '123', '09/07/1988', 'Rua 012', '(11)2099-2788', '(11)94673-1828', '17263-748', '289.489.093-90', '13.856.747-9', 'SP', 'jkl@abc.com')

INSERT INTO permissao(id_permissao, nm_permissao, lista_permissoes) VALUES
(1, 'Administrador', 'adm; atd; etq'),
(2, 'Atendente', 'atd; etq'),
(3, 'Estoquista','etq')

INSERT INTO funcionario(id_funcionario, id_permissao, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf_cnpj, rg_ie, uf, email) VALUES
(1, 1, 'Rita', '123', '05/07/1970', 'Rua abc', '(11)3782-0929', '(11)94893-3878', '01918-019', '898.234.824-83', '17.859.968-8', 'SP', 'rita@abc.com'),
(2, 1, 'Rúbia', '123', '31/07/1980', 'Rua bcd', '(11)3453-0929', '(11)99938-1102', '01343-439', '898.238.298-57', '11.758.858-4', 'SP', 'rubia@abc.com'),
(3, 1, 'Claudio', '123', '24/02/1972', 'Rua cde', '(11)2289-0929', '(11)92988-2993', '01323-019', '328.838.928-70', '39.969.851-9', 'SP', 'claudio@abc.com'),
(4, 2, 'Lúcia', '123', '05/08/1976', 'Rua def', '(11)2930-0929', '(11)92923-8393', '33318-390', '129.832.838-38', '21.859.871-1', 'SP', 'lucia@abc.com'),
(5, 2, 'João', '123', '04/03/1983', 'Rua efg', '(11)2918-0929', '(11)92039-1099', '01323-109', '647.763.872-83', '41.856.412-9', 'SP', 'joao@abc.com'),
(6, 2, 'Maria', '123', '16/11/1980', 'Rua fgh', '(11)2010-0929', '(11)93983-3300', '01238-129', '278.88.672-83', '14.845.966-9', 'SP', 'neusa@abc.com'),
(8, 3, 'Paulo', '123', '15/07/1989', 'Rua hij', '(11)3398-0929', '(11)99090-3198', '11912-129', '784.978.478-80', '25.847.412-2', 'SP', 'maria@abc.com'),
(7, 2, 'Neusa', '123', '19/12/1977', 'Rua ghi', '(11)3893-0929', '(11)94109-3838', '32318-192', '738.929.273.93', '17.854.992-1', 'SP', 'paulo@abc.com'),
(9, 3, 'Moisés', '123', '22/03/1991', 'Rua ijk', '(11)3390-0929', '(11)91822-8939', '19288-192', '783.939.376-48', '87.142.769-3', 'SP', 'moises@abc.com'),
(10, 3, 'Cíntia', '123', '28/01/1972', 'Rua jkl', '(11)3902-0929', '(11)95988-1178', '29389-837', '128.721.472-17', '32.843.913-7', 'SP', 'cintia@abc.com')

INSERT INTO lugar(id_lugar, nome_lugar, endereco, cep, qnt_max) VALUES
(1, 'Chácara', 'Rua aaa', '09383-039', 2000),
(2, 'Salão', 'Rua bbb', '28989-299', 800)

INSERT INTO produto(id_produto, nm_produto, preco, quantidade, tipo_produto) VALUES
(1, 'Pastel', 1.40, 1000, 'perecivel'),
(2, 'Coxinha', 0.14, 1000, 'perecivel'),
(3, 'Bolinha de queijo', 0.12, 1000, 'perecivel'),
(4, 'Mini-pizza', 0.78, 1000, 'perecivel'),
(5, 'Pipoca', 1.20, 1000, 'perecivel'),
(6, 'Hot dog', 1.60, 1000, 'perecivel'),
(7, 'Croquete', 0.16, 1000, 'perecivel'),
(8, 'Empadinha', 1.16, 1000, 'perecivel'),
(9, 'Brigadeiro', 0.10, 1000, 'perecivel'),
(10, 'Pé-de-moleque', 0.10, 1000, 'perecivel'),
(11, 'Beijinho', 0.10, 1000, 'perecivel'),
(12, 'Bala de côco', 0.05, 1000, 'perecivel'),
(13, 'Sorvete', 1.20, 1000, 'perecivel'),
(14, 'Torta de chocolate', 1.00, 1000, 'perecivel'),
(15, 'Torta de morango', 1.00, 1000, 'perecivel'),
(16, 'Pavê', 1.50, 1000, 'perecivel'),
(17, 'Água', 0.50, 1000, 'perecivel'),
(18, 'Refrigerante', 1.00, 1000, 'perecivel'),
(19, 'Suco', 1.00, 1000, 'perecivel'),
(20, 'Cerveja', 1.00, 1000, 'perecivel'),
(21, 'Vinho', 1.1, 1000, 'perecivel'),
(22, 'Champagne', 1.1, 1000, 'perecivel'),
(23, 'Energético', 1.1, 1000, 'perecivel'),
(24, 'Centro de mesa', 0.80, 1000, 'consumivel'),
(25, 'Enfeite de parede', 3.00, 1000, 'consumivel'),
(26, 'Bexigas coloridas', 0.10, 1000, 'consumivel'),
(27, 'Decoração para mesa', 1.1, 1000, 'consumivel'),
(28, 'Guardanapo', 0.50, 1000, 'consumivel'),
(29, 'Prato', 15.00, 1000, 'consumivel'),
(30, 'Copo', 10.00, 1000, 'consumivel'),
(31, 'Talher', 5.00, 1000, 'consumivel'),
(32, 'Toalha', 5.00, 1000, 'consumivel'),
(33, 'Cadeira', 50.00, 1000, 'consumivel'),
(34, 'Mesa', 100.00, 1000, 'consumivel'),
(35, 'Flores', 10.00, 1000, 'consumivel'),
(36, 'Lanterna', 10.00, 1000, 'consumivel'),
(37, 'Glow sticks', 50.00, 1000, 'consumivel'),
(38, 'Feijoada', 10.00, 1000, 'perecivel'),
(39, 'Escondidinho de queijo', 10.00, 1000, 'perecivel'),
(40, 'Macarrão ao molho branco', 10.00, 1000, 'perecivel')

INSERT INTO fornecedor_perecivel(id_fornecedor_perecivel, empresa, endereco, telefone, celular, cnpj, email, website, representante) VALUES
(1, 'abc', 'Rua 123', '(11)5852-8565', '(11)95856-8457', '78.425.986/0036-15', 'abcd@abc.com', 'www.abc.com', 'Jorg_iee')

INSERT INTO pedido_perecivel(id_pedido_perecivel, id_fornecedor_perecivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 1, 'Pastel', 1000, 1.40, '10/12/2015', '20/12/2015', 1400),
(2, 1, 2, 'Coxinha', 1000, 0.14, '10/12/2015', '20/12/2015', 140),
(3, 1, 3, 'Bolinha de queijo', 1000, 12, '10/12/2015', '20/12/2015', 120),
(4, 1, 4, 'Mini-pizza', 1000, 0.78, '10/12/2015', '20/12/2015', 780),
(5, 1, 5, 'Pipoca', 1000, 1.20, '10/12/2015', '20/12/2015', 1200),
(6, 1, 6, 'Hot Dog', 1000, 1.60, '10/12/2015', '20/12/2015', 1600),
(7, 1, 7, 'Croquete', 1000, 0.16, '10/12/2015', '20/12/2015', 160),
(8, 1, 8, 'Empadinha', 1000, 1.16, '10/12/2015', '20/12/2015', 1160),
(9, 1, 9, 'Brigadeiro', 1000, 0.10, '10/12/2015', '20/12/2015', 100),
(10, 1, 10, 'Pé-de-moleque', 1000, 0.10, '10/12/2015', '20/12/2015', 100)

INSERT INTO detalhe_pedido_perecivel(id_detalhe_pedido_perecivel, id_pedido_perecivel, id_fornecedor_perecivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 1, 1, 'Pastel', 1000, 1.40, '10/12/2015', '20/12/2015', 1400),
(2, 2, 1, 2, 'Coxinha', 1000, 0.14, '10/12/2015', '20/12/2015', 140),
(3, 3, 1, 3, 'Bolinha de queijo', 1000, 12, '10/12/2015', '20/12/2015', 120),
(4, 4, 1, 4, 'Mini-pizza', 1000, 0.78, '10/12/2015', '20/12/2015', 780),
(5, 5, 1, 5, 'Pipoca', 1000, 1.20, '10/12/2015', '20/12/2015', 1200),
(6, 6, 1, 6, 'Hot Dog', 1000, 1.60, '10/12/2015', '20/12/2015', 1600),
(7, 7, 1, 7, 'Croquete', 1000, 0.16, '10/12/2015', '20/12/2015', 160),
(8, 8, 1, 8, 'Empadinha', 1000, 1.16, '10/12/2015', '20/12/2015', 1160),
(9, 9, 1, 9, 'Brigadeiro', 1000, 0.10, '10/12/2015', '20/12/2015', 100),
(10, 10, 1, 10, 'Pé-de-moleque', 1000, 0.10, '10/12/2015', '20/12/2015', 100)

INSERT INTO fornecedor_consumivel(id_fornecedor_consumivel, empresa, endereco, telefone, celular, cnpj, email, website, representante) VALUES
(1, 'def', 'Rua 234', '(11)6549-2456', '(11)98755-8645', '32.365.542/0042-11', 'efjk@abc.com', 'www.def.com', 'Alberto') 

INSERT INTO pedido_consumivel(id_pedido_consumivel, id_fornecedor_consumivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 24, 'Centro de mesa', 1000, 0.80, '10/12/2015', '20/12/2015', 800),
(2, 1, 25, 'Enfeite de parede', 1000, 3.00, '10/12/2015', '20/12/2015', 3000),
(3, 1, 26, 'Bexigas coloridas', 1000, 0.10, '10/12/2015', '20/12/2015', 100),
(4, 1, 27, 'Decoração para mesa', 1000, 1.10, '10/12/2015', '20/12/2015', 1100),
(5, 1, 28, 'Guardanapo', 1000, 0.50, '10/12/2015', '20/12/2015', 500),
(6, 1, 29, 'Prato', 1000, 15.00, '10/12/2015', '20/12/2015', 15000),
(7, 1, 30, 'Copo', 1000, 10.00, '10/12/2015', '20/12/2015', 10000),
(8, 1, 31, 'Talher', 1000, 5.00, '10/12/2015', '20/12/2015', 5000),
(9, 1, 32, 'Toalha', 1000, 5.00, '10/12/2015', '20/12/2015', 5000),
(10, 1, 33, 'Cadeira', 1000, 50.00, '10/12/2015', '20/12/2015', 50000)

INSERT INTO detalhe_pedido_consumivel(id_detalhe_pedido_consumivel, id_pedido_consumivel, id_fornecedor_consumivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 1, 24, 'Centro de mesa', 1000, 0.80, '10/12/2015', '20/12/2015', 800),
(2, 2, 1, 25, 'Enfeite de parede', 1000, 3.00, '10/12/2015', '20/12/2015', 3000),
(3, 3, 1, 26, 'Bexigas coloridas', 1000, 0.10, '10/12/2015', '20/12/2015', 100),
(4, 4, 1, 27, 'Decoração para mesa', 1000, 1.10, '10/12/2015', '20/12/2015', 1100),
(5, 5, 1, 28, 'Guardanapo', 1000, 0.50, '10/12/2015', '20/12/2015', 500),
(6, 6, 1, 29, 'Prato', 1000, 15.00, '10/12/2015', '20/12/2015', 15000),
(7, 7, 1, 30, 'Copo', 1000, 10.00, '10/12/2015', '20/12/2015', 10000),
(8, 8, 1, 31, 'Talher', 1000, 5.00, '10/12/2015', '20/12/2015', 5000),
(9, 9, 1, 32, 'Toalha', 1000, 5.00, '10/12/2015', '20/12/2015', 5000),
(10, 10, 1, 33, 'Cadeira', 1000, 50.00, '10/12/2015', '20/12/2015', 50000)

INSERT INTO pacote(id_pacote, nome, decoracao) VALUES
(1, 'Casamento', 'Casamento'),
(2, 'Festa de criança', 'Infantil'),
(3, 'Rave', 'Balada'),
(4, 'Festa de 15 anos', '15 anos')

INSERT INTO produto_pacote(id_pacote, id_produto, qnt_produto) VALUES
(1, 1, 200),
(1, 2, 500),
(1, 3, 400),
(1, 7, 450),
(1, 9, 800),
(1, 11, 800),
(1, 17, 900),
(1, 18, 900),
(1, 19, 500),
(1, 22, 300),
(1, 39, 300),
(1, 40, 300),
(2, 1, 500),
(2, 2, 500),
(2, 3, 500),
(2, 4, 200),
(2, 5, 140),
(2, 6, 400),
(2, 7, 100),
(2, 9, 500),
(2, 10, 200),
(2, 11, 500),
(2, 12, 700),
(2, 13, 250),
(2, 14, 100),
(2, 15, 100),
(2, 16, 200),
(2, 17, 100),
(2, 18, 300),
(2, 19, 150),
(2, 26, 200),
(3, 18, 400),
(3, 22, 200),
(3, 1, 250),
(3, 2, 500),
(3, 3, 340),
(3, 4, 500),
(4, 1, 300),
(4, 2, 300),
(4, 3, 300),
(4, 4, 200),
(4, 6, 250),
(4, 7, 100),
(4, 9, 250),
(4, 10, 100),
(4, 11, 250),
(4, 18, 270),
(4, 19, 190),
(4, 22, 100)

INSERT INTO contas(id_conta, nm_conta, vencimento, valor_conta, cod_conta) VALUES
(1, 'Luz', '30/12/2015', 1000.00, '52451224854125854878542158874582521598754821596542'),
(2, 'Água', '30/12/2015', 1000.00, '52451254854125326548542158745874521598754821596542'),
(3, 'Telefone/Internet', '30/12/2015', 2000.00, '78548751548962548521456985254965213654875215842365'),
(4, 'Gás', '30/12/2015', 1000.00, '87548512546985236548541254875412896584857521569820')

INSERT INTO orcamento(id_orcamento, id_lugar, id_cliente, id_funcionario, valor_orcamento, num_convidados, dt_evento, qnt_pratos, tema, email_cliente, dt_orcamento, hr_inicio) VALUES
(1, 2, 1, 1, 10000.00, 300, '01/04/2016', 2, 'Festa de criança', 'abc@abc.com', '20/11/2015', '19:00:00'),
(2, 1, 2, 1, 20000.00, 1500, '02/04/2016', 2, 'Casamento', 'abc@abc.com', '21/11/2015', '19:00:00'),
(3, 1, 3, 1, 20000.00, 1000, '03/04/2016', 2, 'Casamento', 'abc@abc.com', '22/11/2015', '19:00:00'),
(4, 2, 4, 1, 10000.00, 800, '04/04/2016', 2, 'Casamento', 'abc@abc.com', '23/11/2015', '19:00:00'),
(5, 2, 5, 1, 10000.00, 500, '05/04/2016', 2, 'Festa de 15 anos', 'abc@abc.com', '24/11/2015', '19:00:00'),
(6, 1, 6, 1, 20000.00, 1200, '06/04/2016', 2, 'Casamento', 'abc@abc.com', '25/11/2015', '19:00:00'),
(7, 1, 7, 1, 20000.00, 1000, '07/04/2016', 2, 'Casamento', 'abc@abc.com', '26/11/2015', '19:00:00'),
(8, 2, 8, 1, 10000.00, 800, '08/04/2016', 2, 'Festa de criança', 'abc@abc.com', '27/11/2015', '19:00:00'),
(9, 2, 9, 1, 10000.00, 500, '09/04/2016', 2, 'Festa de criança', 'abc@abc.com', '28/11/2015', '19:00:00'),
(10, 1, 10, 1, 20000.00, 1000, '10/04/2016', 2, 'Casamento', 'abc@abc.com', '29/11/2015', '19:00:00')


INSERT INTO pratos_evento(id_orcamento, id_produto, qtd_produto) VALUES
(1, 1, 100),
(1, 2, 100),
(2, 1, 100),
(2, 2, 100),
(3, 2, 100),
(3, 3, 100),
(4, 2, 100),
(4, 5, 100),
(5, 2, 100),
(5, 4, 100),
(6, 7, 100),
(6, 8, 100),
(7, 1, 100),
(7, 2, 100),
(8, 1, 100),
(8, 4, 100),
(9, 2, 100),
(9, 3, 100),
(10, 5, 100),
(10, 6, 100)

INSERT INTO evento(id_evento, id_lugar, id_cliente, id_funcionario, valor_orcamento, num_convidados, dt_evento, qnt_pratos, tema, email_cliente, dt_orcamento, hr_inicio) VALUES
(1, 2, 2, 1, 10000.00, 300, '01/04/2016', 2, 'Festa de criança', 'abc@abc.com', '20/11/2015', '19:00:00'),
(2, 1, 1, 1, 20000.00, 1500, '02/04/2016', 2, 'Casamento', 'abc@abc.com', '21/11/2015', '19:00:00'),
(3, 1, 1, 1, 20000.00, 1000, '03/04/2016', 2, 'Casamento', 'abc@abc.com', '22/11/2015', '19:00:00'),
(4, 2, 1, 1, 10000.00, 800, '04/04/2016', 2, 'Casamento', 'abc@abc.com', '23/11/2015', '19:00:00'),
(5, 2, 2, 1, 10000.00, 500, '05/04/2016', 2, 'Festa de 15 anos', 'abc@abc.com', '24/11/2015', '19:00:00'),
(6, 1, 3, 1, 20000.00, 1200, '06/04/2016', 2, 'Casamento', 'abc@abc.com', '25/11/2015', '19:00:00'),
(7, 1, 1, 1, 20000.00, 1000, '07/04/2016', 2, 'Casamento', 'abc@abc.com', '26/11/2015', '19:00:00'),
(8, 2, 2, 1, 10000.00, 800, '08/04/2016', 2, 'Festa de criança', 'abc@abc.com', '27/11/2015', '19:00:00'),
(9, 2, 2, 1, 10000.00, 500, '09/04/2016', 2, 'Festa de criança', 'abc@abc.com', '28/11/2015', '19:00:00'),
(10, 1, 1, 1, 20000.00, 1000, '10/04/2016', 2, 'Casamento', 'abc@abc.com', '29/11/2015', '19:00:00')
