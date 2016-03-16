USE MASTER
GO
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'eclair')
	DROP DATABASE [eclair]

CREATE DATABASE eclair
GO
USE eclair
GO

--Mensagens dos clientes pelo site
CREATE TABLE mensagem(
	id_mensagem INT PRIMARY KEY,
	conteudo VARCHAR(300),
	dt_envio DATE
)
GO

--Dados dos clientes
CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY,
	nome VARCHAR(50),
	senha VARCHAR(50),
	dt_nascim DATE,
	endereco VARCHAR(100),
	telefone CHAR(13),--(00)0000-0000
	celular CHAR(14),--(00)90000-0000
	cep CHAR(9), --00000-000
	cpf_cnpj VARCHAR(18), --000.000.000-00
	rg_ie VARCHAR(12), --00.000.000-0
	uf CHAR(2),
	email VARCHAR(254)
)
GO

--Nível de permissão dos funcionários
CREATE TABLE permissao(
	id_permissao INT PRIMARY KEY,
	nm_permissao VARCHAR(15),
	lista_permissoes VARCHAR(20)
)
GO

--Dados dos funcionários
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
	rg CHAR(12),
	uf CHAR(2),
	email VARCHAR(254)
)
GO

--Lugares disponíveis para eventos
CREATE TABLE lugar(
	id_lugar INT PRIMARY KEY,
	nome_lugar VARCHAR(20),
	endereco VARCHAR(100),
	cep CHAR(9),
	qnt_max INT
)
GO

--Lista de produtos do estoque
CREATE TABLE produto(
	id_produto INT PRIMARY KEY,
	nm_produto VARCHAR(50),
	preco DECIMAL(6,2),
	quantidade INT,
	tipo_produto VARCHAR(20)
)
GO

--Dados do fornecedor de produtos perecíveis
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

--Pedidos de produtos perecíveis
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

--Detalhes dos pedidos de produtos perecíveis
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


--Dados do fornecedor de produtos consumíveis
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

--Pedidos de produtos consumíveis
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

--Detalhes dos pedidos de produtos perecíveis
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

--Sugestões de pacotes para eventos
CREATE TABLE pacote(
	id_pacote INT PRIMARY KEY,
	nome VARCHAR(25),
	decoracao VARCHAR(200),
)
GO

-- Produtos acrescentados aos pacotes
CREATE TABLE produto_pacote(
	id_pacote INT FOREIGN KEY REFERENCES pacote(id_pacote),
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	qnt_produto INT
)
GO

-- Contas da empresa
CREATE TABLE contas(
	id_conta INT PRIMARY KEY,
	nm_conta VARCHAR(20),
	vencimento DATE,
	valor_conta DECIMAL(8,2),
	cod_conta VARCHAR(50)
)
GO

--Especificações dos orçamentos realizados
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
	hr_inicio TIME,
	acrescimos VARCHAR(300)
)
GO



--Especificações dos eventos
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
	hr_inicio TIME,
	acrescimos VARCHAR(300)
)
GO

--Pratos disponíveis para os eventos
CREATE TABLE pratos_evento(
 id_orcamento INT FOREIGN KEY REFERENCES orcamento(id_orcamento),
 id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
 id_evento INT FOREIGN KEY REFERENCES evento(id_evento),
 qtd_produto INT
)

GO

--Detalhes dos cancelamentos
CREATE TABLE detalhe_cancelamento(
	id_detalhe_cancelamento INT PRIMARY KEY,
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	id_orcamento INT FOREIGN KEY REFERENCES orcamento(id_orcamento),
	motivo VARCHAR(150),
	dt_cancelamento DATE
)
GO

INSERT INTO mensagem(id_mensagem, conteudo, dt_envio) VALUES
(1, 'Olá, tudo bem?', '01/02/2015')

INSERT INTO cliente(id_cliente, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf_cnpj, rg_ie, uf, email) VALUES
(1, 'Ana Carolina', '210510','20/10/1978', 'Rua Doutor Arnaldo, 655, apt 15', '(11)3527-5598', '(11)97748-6995', '15936-784','846.149.580-28','32.601.112-2','RJ','aninha.mikanika@gmail.com')

INSERT INTO permissao(id_permissao, nm_permissao, lista_permissoes) VALUES
(1, 'Administrador', 'adm; atd; etq'),
(2, 'Atendente', 'atd; etq'),
(3, 'Estoquista','etq')


INSERT INTO funcionario(id_funcionario, id_permissao, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf, rg, uf, email) VALUES
(1,1, 'ADM', '123', '29/09/1991', 'Rua General Osório,10 apt 22', '(11)3390-0929', '(11)91822-8939', '19288-192', '783.939.376-48', '87.142.769-3', 'SP', 'tupladejose@gmail.com'),
(2,3, 'Cintia', '123', '28/01/1972', 'Rua Marco Veio, 69 apt 64', '(11)3902-0929', '(11)95988-1178', '29389-837', '128.721.472-17', '32.843.913-7', 'SP', 'cintiacorre@yahoo.com.br')


INSERT INTO lugar(id_lugar, nome_lugar, endereco, cep, qnt_max) VALUES
(1, 'Chácara', 'Rua aaa', '09383-039', 2000),
(2, 'Salão', 'Rua bbb', '28989-299', 800)

INSERT INTO produto(id_produto, nm_produto, preco, quantidade, tipo_produto) VALUES
(1, 'Pastel', 3.40, 1000, 'perecivel'),
(2, 'Coxinha', 1.10, 1000, 'perecivel'),
(3, 'Bolinha de queijo', 1.00, 1000, 'perecivel'),
(4, 'Mini-pizza', 2.50, 1000, 'perecivel'),
(5, 'Pipoca', 2.20, 1000, 'perecivel'),
(6, 'Hot dog', 5.00, 1000, 'perecivel'),
(7, 'Croquete', 3.16, 1000, 'perecivel'),
(8, 'Empadinha', 2.16, 1000, 'perecivel'),
(9, 'Brigadeiro', 2.10, 1000, 'perecivel'),
(10, 'Pé-de-moleque', 1.25, 1000, 'perecivel'),
(11, 'Beijinho', 2.10, 1000, 'perecivel'),
(12, 'Bala de côco', 0.50, 1000, 'perecivel'),
(13, 'Sorvete', 5.20, 1000, 'perecivel'),
(14, 'Torta de chocolate', 10.00, 1000, 'perecivel'),
(15, 'Torta de morango', 10.00, 1000, 'perecivel'),
(16, 'Pavê', 5.10, 1000, 'perecivel'),
(17, 'Água', 5.50, 1000, 'perecivel'),
(18, 'Refrigerante', 6.50, 1000, 'perecivel'),
(19, 'Suco', 6.00, 1000, 'perecivel'),
(20, 'Whisky', 15.00, 1000, 'perecivel'),
(21, 'Vinho', 12.15, 1000, 'perecivel'),
(22, 'Champagne', 25.20, 1000, 'perecivel'),
(23, 'Vodka', 15.50, 1000, 'perecivel'),
(24, 'Centro de mesa', 5.80, 1000, 'consumivel'),
(25, 'Enfeite de parede', 10.00, 1000, 'consumivel'),
(26, 'Bexigas coloridas', 3.10, 1000, 'consumivel'),
(27, 'Decoração para mesa', 20.10, 1000, 'consumivel'),
(28, 'Guardanapo', 1.50, 1000, 'consumivel'),
(29, 'Prato', 35.00, 1000, 'consumivel'),
(30, 'Copo', 25.00, 1000, 'consumivel'),
(31, 'Talher', 15.00, 1000, 'consumivel'),
(32, 'Toalha', 15.00, 1000, 'consumivel'),
(33, 'Cadeira', 100.00, 1000, 'consumivel'),
(34, 'Mesa', 350.00, 1000, 'consumivel'),
(35, 'Flores', 15.00, 1000, 'consumivel'),
(36, 'Lanterna', 15.00, 1000, 'consumivel'),
(37, 'Glow sticks', 3.50, 1000, 'consumivel'),
(38, 'Feijoada', 50.00, 1000, 'perecivel'),
(39, 'Escondidinho de queijo', 45.00, 1000, 'perecivel'),
(40, 'Macarrão ao molho branco', 60.00, 1000, 'perecivel'),
(41, 'Red Bull', 8.20, 1000, 'perecivel'),
(42, 'Monster', 9.10, 1000, 'perecivel'),
(43, 'Absynto', 22.10, 1000, 'perecivel'),
(44, 'Jonnie Walker', 50.00, 1000, 'perecivel')

INSERT INTO fornecedor_perecivel(id_fornecedor_perecivel, empresa, endereco, telefone, celular, cnpj, email, website, representante) VALUES
(1, 'abc', 'Rua 123', '(11)5852-8565', '(11)95856-8457', '78.425.986/0036-15', 'abcd@abc.com', 'www.abc.com', 'Jorg_iee')

INSERT INTO pedido_perecivel(id_pedido_perecivel, id_fornecedor_perecivel, id_produto, nm_produto, qnt_produto, valor_produto, dt_pedido, dt_entrega, valor_pedido) VALUES
(1, 1, 1, 'Pastel', 1000, 1.40, '10/12/2015', '20/12/2015', 1400),
(2, 1, 2, 'Coxinha', 1000, 0.14, '10/12/2015', '20/12/2015', 140),
(3, 1, 3, 'Bolinha de queijo', 1000, 0.12, '10/12/2015', '20/12/2015', 120),
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
(3, 3, 1, 3, 'Bolinha de queijo', 1000, 0.12, '10/12/2015', '20/12/2015', 120),
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
(2, 'Infantil', 'Infantil'),
(3, 'Allnighter', 'Balada'),
(4, 'Debutante', 'Debutante')

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

--INSERT INTO orcamento(id_orcamento, id_lugar, id_cliente, id_funcionario, valor_orcamento, num_convidados, dt_evento, qnt_pratos, tema, email_cliente, dt_orcamento, hr_inicio) VALUES


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
(10, 6, 100),
(11, 7, 500),
(11,4, 36800) 

INSERT INTO evento(id_evento, id_lugar, id_cliente, id_funcionario, valor_orcamento, num_convidados, dt_evento, qnt_pratos, tema, email_cliente, dt_orcamento, hr_inicio) VALUES
(1, 2, 1, 1, 22675.36, 736, '25/05/2017', 2, 'Debutante', 'aninha.mikanika@gmail.com', '29/11/2015', '20:30:00')



select * from pratos_evento
