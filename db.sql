USE master

IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name ='eclair')
	DROP DATABASE eclair

CREATE DATABASE eclair
GO
USE eclair
GO

/** Dados dos clientes **/
CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY,
	nome VARCHAR(50),
	senha CHAR(128),
	dt_nascim DATE,
	endereco VARCHAR(100),
	telefone CHAR(13),--(00)0000-0000
	celular CHAR(14),--(00)90000-0000
	cep CHAR(9), --00000-000
	cpf_cnpj VARCHAR(18), --000.000.000-00
	rg_ie VARCHAR(12), --00.000.000-0
	email VARCHAR(255)
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
	senha CHAR(128),
	dt_nascim DATE,
	endereco VARCHAR(100),
	telefone CHAR(13),
	celular CHAR(14),
	cep CHAR(9),
	cpf CHAR(14),
	rg CHAR(12),
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
	tipo_produto VARCHAR(20)
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
	data_conta DATE,
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
	tema VARCHAR(50),
	email_cliente VARCHAR(254),
	dt_orcamento DATE,
	hr_inicio TIME,
	duracao DECIMAL(5,2),
	acrescimos VARCHAR(300)
)
GO

/** Especificações dos eventos **/
CREATE TABLE evento(
	id_evento INT PRIMARY KEY,
	id_lugar INT FOREIGN KEY REFERENCES lugar(id_lugar),
	id_cliente INT FOREIGN KEY REFERENCES cliente(id_cliente),
	id_permissao INT FOREIGN KEY REFERENCES permissao(id_permissao),
	id_funcionario INT FOREIGN KEY REFERENCES funcionario(id_funcionario),
	valor_evento DECIMAL(8,2),
	num_convidados INT,
	dt_evento DATE,
	local_evento VARCHAR(50),
	tema VARCHAR(50),
	email_cliente VARCHAR(254),
	dt_orcamento DATE,
	dt_aprovado DATE,
	hr_inicio TIME,
	duracao DECIMAL(5,2),
	acrescimos VARCHAR(300)
)
GO

CREATE TABLE convidados(
	id_evento INT FOREIGN KEY REFERENCES evento(id_evento),
	id_convidado INT,
	PRIMARY KEY (id_evento,id_convidado),
	nome_convidado VARCHAR(50),
	email VARCHAR(255),
	compareceu BIT
)
GO

/** Pratos disponíveis para os eventos **/
CREATE TABLE pratos_evento(
	id_orcamento INT FOREIGN KEY REFERENCES orcamento(id_orcamento),
	id_evento INT FOREIGN KEY REFERENCES evento(id_evento) DEFAULT NULL,
	id_produto INT FOREIGN KEY REFERENCES produto(id_produto),
	qtd_produto INT
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

/** Registro Pós Festa **/
CREATE TABLE pos_evento(
	id_pos_evento INT PRIMARY KEY,
	id_evento INT FOREIGN KEY REFERENCES evento(id_evento),
	id_funcionario INT FOREIGN KEY REFERENCES funcionario(id_funcionario),
	adicionais varchar(255),
	valor_adicionais decimal(8,2),
)
GO

INSERT INTO cliente(id_cliente, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf_cnpj, rg_ie, email) VALUES
(1, 'João', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1997', 'Rua 123', '(11)2345-8767', '(11)98378-3787', '28738-578', '122.443.165-09', '11.586.854-8', 'abc@abc.com'),
(2, 'Maria', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1996', 'Rua 234', '(11)3542-8176', '(11)93847-1262', '18273-489', '129.187.938-37', '22.528.785-4', 'bcd@abc.com'),
(3, 'José', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1995', 'Rua 345', '(11)3565-7887', '(11)92389-1287', '18273-190', '546.289.298-19', '21.856.888-9', 'cde@abc.com'),
(4, 'Irene', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1994', 'Rua 456', '(11)1276-9189', '(11)90238-4562', '39384-083', '938.187.374-29', '30.856.745.5', 'def@abc.com'),
(5, 'Odete', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1993', 'Rua 567', '(11)7368-3287', '(11)92030-0929', '56373-827', '198.378.218-90', '50.958.758-4', 'efg@abc.com'),
(6, 'Rosana', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1992', 'Rua 678', '(11)2365-6739', '(11)92030-2877', '12728-278', '128.384.390-69', '19.875.953.3', 'fgh@abc.com'),
(7, 'Claudia', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1991', 'Rua 789', '(11)3873-0098', '(11)93030-2787', '19283-467', '598.129.198-03', '40.685.859-7', 'ghi@abc.com'),
(8, 'Roberto', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1990', 'Rua 890', '(11)3268-2837', '(11)91276-0939', '57839-128', '489.209.188-30', '32.956.859-6', 'hij@abc.com'),
(9, 'Robson', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1989', 'Rua 901', '(11)2398-2398', '(11)92363-8399', '93847-938', '982.127.189-64', '11.548.852.7', 'ijk@abc.com'),
(10, 'Mário', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '09/07/1988', 'Rua 012', '(11)2099-2788', '(11)94673-1828', '17263-748', '289.489.093-90', '13.856.747-9', 'jkl@abc.com')

INSERT INTO permissao(id_permissao, nm_permissao, lista_permissoes) VALUES
(1, 'Administrador', 'adm; atd; etq'),
(2, 'Atendente', 'atd; etq'),
(3, 'Estoquista','etq')

INSERT INTO funcionario(id_funcionario, id_permissao, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf, rg, email) VALUES
(1, 1, 'Rita', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '05/07/1970', 'Rua abc', '(11)3782-0929', '(11)94893-3878', '01918-019', '898.234.824-83', '17.859.968-8', 'rita@abc.com'),
(2, 1, 'Rúbia', 'bb4770d066049ebfb000aec863d8f994919c278039c7048e8944b4b459ab39f3db49a694c6d8514ac0090956fb3c5d710ab01a4ab7c30e1f6e0f18563b1b8d9c', '31/07/1980', 'Rua bcd', '(11)3453-0929', '(11)99938-1102', '01343-439', '898.238.298-57', '11.758.858-4', 'rubia@abc.com'),
(3, 1, 'Claudio', '6de43471cd4967b1528662e43004956126065b7a678d5e56160b33029ac7e7a684e353fd8e8d0ed2f963fa8e7225ef1f61f613681bd70c50dbf7b0c1783983ad', '24/02/1972', 'Rua cde', '(11)2289-0929', '(11)92988-2993', '01323-019', '328.838.928-70', '39.969.851-9', 'claudio@abc.com'),
(4, 2, 'Lúcia', '6de43471cd4967b1528662e43004956126065b7a678d5e56160b33029ac7e7a684e353fd8e8d0ed2f963fa8e7225ef1f61f613681bd70c50dbf7b0c1783983ad', '05/08/1976', 'Rua def', '(11)2930-0929', '(11)92923-8393', '33318-390', '129.832.838-38', '21.859.871-1', 'lucia@abc.com'),
(5, 2, 'João', 'eb2f6d6c3d0d1c9104d04facb613acd5d8c3eb74884c7f3fc2f3077bcecd8baced50b287a54ba9f823a4b47d3c247ed65a351983db5d48d6714291ebeb5c71ae', '04/03/1983', 'Rua efg', '(11)2918-0929', '(11)92039-1099', '01323-109', '647.763.872-83', '41.856.412-9', 'joao@abc.com'),
(6, 2, 'Maria', 'f6b07b6c1340e947b861def5f8b092d8ee710826dc56bd175bdc8f3a16b0b8acf853c64786a710dedf9d1524d61e32504e27d60de159af110bc3941490731578', '16/11/1980', 'Rua fgh', '(11)2010-0929', '(11)93983-3300', '01238-129', '278.88.672-83', '14.845.966-9', 'neusa@abc.com'),
(8, 3, 'Paulo', '91933c905402da2a2c193c8664dbf807a6f8e3d714a9e6dc5757370409c9a6becf582a9aa7f4fbf0fd618e0fab8a049aaa5f80e34922a7bb685f94d60a952bb3', '15/07/1989', 'Rua hij', '(11)3398-0929', '(11)99090-3198', '11912-129', '784.978.478-80', '25.847.412-2', 'maria@abc.com'),
(7, 2, 'Neusa', '0dc2403c8d2a31f160513e3959742a610a18f61d16aab6fb476721a034a163fbe883f7a99f6865e5b7f6ecbbe22e4064376497954ba26887ef75b016433bcdbd', '19/12/1977', 'Rua ghi', '(11)3893-0929', '(11)94109-3838', '32318-192', '738.929.273.93', '17.854.992-1', 'paulo@abc.com'),
(9, 3, 'Moisés', '0dc2403c8d2a31f160513e3959742a610a18f61d16aab6fb476721a034a163fbe883f7a99f6865e5b7f6ecbbe22e4064376497954ba26887ef75b016433bcdbd', '22/03/1991', 'Rua ijk', '(11)3390-0929', '(11)91822-8939', '19288-192', '783.939.376-48', '87.142.769-3', 'moises@abc.com'),
(10, 3, 'Cíntia', '1bed31834bf52664834cef4fea87716aca1003fef92be0710c5783718a9ffb6ec276ec66a74bd186f04d20b56ba9bd4ad8ee1b2cb369022ea22d2e192536dc15', '28/01/1972', 'Rua jkl', '(11)3902-0929', '(11)95988-1178', '29389-837', '128.721.472-17', '32.843.913-7', 'cintia@abc.com')

INSERT INTO lugar(id_lugar, nome_lugar, endereco, cep, qnt_max) VALUES
(1, 'Chácara', 'Rua aaa', '09383-039', 2000),
(2, 'Salão', 'Rua bbb', '28989-299', 1000)

INSERT INTO produto(id_produto, nm_produto, preco, tipo_produto) VALUES
(1, 'Pastel', 1.40, 'perecivel'),
(2, 'Coxinha', 0.14, 'perecivel'),
(3, 'Bolinha de queijo', 0.12, 'perecivel'),
(4, 'Mini-pizza', 0.78, 'perecivel'),
(5, 'Pipoca', 1.20, 'perecivel'),
(6, 'Hot dog', 1.60, 'perecivel'),
(7, 'Croquete', 0.16, 'perecivel'),
(8, 'Empadinha', 1.16, 'perecivel'),
(9, 'Brigadeiro', 0.10, 'perecivel'),
(10, 'Pé-de-moleque', 0.10, 'perecivel'),
(11, 'Beijinho', 0.10, 'perecivel'),
(12, 'Bala de côco', 0.05, 'perecivel'),
(13, 'Sorvete', 1.20, 'perecivel'),
(14, 'Torta de chocolate', 1.00, 'perecivel'),
(15, 'Torta de morango', 1.00, 'perecivel'),
(16, 'Pavê', 1.50, 'perecivel'),
(17, 'Água', 0.50, 'perecivel'),
(18, 'Refrigerante', 1.00, 'perecivel'),
(19, 'Suco', 1.00, 'perecivel'),
(20, 'Wiskey', 1.1, 'perecivel'),
(21, 'Vinho', 1.1, 'perecivel'),
(22, 'Champagne', 1.1, 'perecivel'),
(23, 'Vodka', 1.1, 'perecivel'),
(44, 'Jonnie Walker', 1.1, 'perecivel'),
(24, 'Centro de mesa', 0.80, 'consumivel'),
(25, 'Enfeite de parede', 3.00, 'consumivel'),
(26, 'Bexigas coloridas', 0.10, 'consumivel'),
(27, 'Decoração para mesa', 1.1, 'consumivel'),
(28, 'Guardanapo', 0.50, 'consumivel'),
(29, 'Prato', 15.00, 'consumivel'),
(30, 'Copo', 10.00, 'consumivel'),
(31, 'Talher', 5.00, 'consumivel'),
(32, 'Toalha', 5.00, 'consumivel'),
(33, 'Cadeira', 50.00, 'consumivel'),
(34, 'Mesa', 100.00, 'consumivel'),
(35, 'Flores', 10.00, 'consumivel'),
(36, 'Lanterna', 10.00, 'consumivel'),
(37, 'Glow sticks', 50.00, 'consumivel'),
(38, 'Feijoada', 10.00, 'perecivel'),
(39, 'Escondidinho de queijo', 10.00, 'perecivel'),
(40, 'Macarrão ao molho branco', 10.00, 'perecivel'),
(41, 'Red Bull', 1.1, 'perecivel'),
(42, 'Monster', 1.1, 'perecivel'),
(43, 'Absynto', 1.1, 'perecivel')

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

INSERT INTO contas(id_conta, nm_conta, data_conta, vencimento, valor_conta, cod_conta) VALUES
(1, 'Luz', '30/11/2015', '30/12/2015', 2100.00, '52451224854125854878542158874582521598754821596542'),
(2, 'Água', '30/11/2015', '30/12/2015', 2060.00, '52451254854125326548542158745874521598754821596542'),
(3, 'Telefone/Internet', '30/11/2015', '30/12/2015', 3456.30, '78548751548962548521456985254965213654875215842365'),
(4, 'Gás', '30/11/2015', '30/12/2015', 5230.00, '87548512546985236548541254875412896584857521569820'),
(5, 'Manutençao', '30/11/2015', '30/12/2015', 830.00, '87548512546985236548541254875412896584857521569456'),
(6, 'Encargos', '30/11/2015', '30/12/2015', 6420.00, '83454566675488236548541254875412896584857521569820'),
(7, 'Extras', '30/11/2015', '30/12/2015', 14420.30, '92451224857425854878542158874582921598754821596542')

INSERT INTO orcamento(id_orcamento, id_lugar, id_cliente, id_funcionario, valor_orcamento, num_convidados, dt_evento, tema, email_cliente, dt_orcamento, hr_inicio, duracao) VALUES
(1, 2, 1, 1, 10000.00, 300, '01/04/2016', 'Festa de criança', 'abc@abc.com', '20/11/2015', '19:00:00', '05:00:00'),
(2, 1, 2, 1, 20000.00, 1500, '02/04/2016', 'Casamento', 'abc@abc.com', '21/11/2015', '19:00:00', '05:00:00'),
(3, 1, 3, 1, 20000.00, 1000, '03/04/2016', 'Casamento', 'abc@abc.com', '22/11/2015', '19:00:00', '05:00:00'),
(4, 2, 4, 1, 10000.00, 800, '04/04/2016', 'Casamento', 'abc@abc.com', '23/11/2015', '19:00:00', '05:00:00'),
(5, 2, 5, 1, 10000.00, 500, '05/04/2016', 'Festa de 15 anos', 'abc@abc.com', '24/11/2015', '19:00:00', '05:00:00'),
(6, 1, 6, 1, 20000.00, 1200, '06/04/2016', 'Casamento', 'abc@abc.com', '25/11/2015', '19:00:00', '05:00:00'),
(7, 1, 7, 1, 20000.00, 1000, '07/04/2016', 'Casamento', 'abc@abc.com', '26/11/2015', '19:00:00', '05:00:00'),
(8, 2, 8, 1, 10000.00, 800, '08/04/2016', 'Festa de criança', 'abc@abc.com', '27/11/2015', '19:00:00', '05:00:00'),
(9, 2, 9, 1, 10000.00, 500, '09/04/2016', 'Festa de criança', 'abc@abc.com', '28/11/2015', '19:00:00', '05:00:00'),
(10, 1, 10, 1, 20000.00, 1000, '10/04/2016', 'Casamento', 'abc@abc.com', '29/11/2015', '19:00:00', '05:00:00')

INSERT INTO evento(id_evento, id_lugar, id_cliente, id_funcionario, valor_evento, num_convidados, dt_evento, tema, email_cliente, dt_orcamento,dt_aprovado, hr_inicio, duracao) VALUES
(1, 2, 2, 1, 15000.00, 300, '01/04/2016', 'Festa de criança', 'abc@abc.com', '20/11/2015', '20/11/2015', '19:00:00', '05:00:00'),
(2, 1, 1, 1, 15000.00, 1500, '02/04/2016', 'Casamento', 'abc@abc.com', '21/11/2015', '21/11/2015', '19:00:00', '05:00:00'),
(3, 1, 1, 1, 15000.00, 1000, '03/04/2016', 'Casamento', 'abc@abc.com', '22/11/2015', '22/11/2015', '19:00:00', '05:00:00'),
(4, 2, 1, 1, 15000.00, 800, '04/04/2016', 'Casamento', 'abc@abc.com', '23/11/2015', '23/11/2015', '19:00:00', '05:00:00'),
(5, 2, 2, 1, 15000.00, 500, '05/04/2016', 'Festa de 15 anos', 'abc@abc.com', '24/11/2015', '24/11/2015', '19:00:00', '05:00:00'),
(6, 1, 3, 1, 15000.00, 1200, '06/04/2016', 'Casamento', 'abc@abc.com', '25/11/2015', '25/11/2015', '19:00:00', '05:00:00'),
(7, 1, 1, 1, 15000.00, 1000, '07/04/2016', 'Casamento', 'abc@abc.com', '26/11/2015', '26/11/2015', '19:00:00', '05:00:00'),
(8, 2, 2, 1, 15000.00, 800, '08/04/2016', 'Festa de criança', 'abc@abc.com', '27/11/2015', '27/11/2015', '19:00:00', '05:00:00'),
(9, 2, 2, 1, 15000.00, 500, '09/04/2016', 'Festa de criança', 'abc@abc.com', '28/11/2015', '28/11/2015', '19:00:00', '05:00:00'),
(10, 1, 1, 1, 15000.00, 1000, '10/04/2016', 'Casamento', 'abc@abc.com', '29/11/2015', '29/11/2015', '19:00:00', '05:00:00'),
(11, 1, 1, 1, 15000.00, 1000, '10/04/2016', 'Casamento', 'abc@abc.com', '29/11/2015', '29/11/2015', '19:00:00', '05:00:00')

INSERT INTO convidados(id_convidado, id_evento,	nome_convidado,	email, compareceu) VALUES
(1, 1, 'Pagode', 'pagodin@danca.net',1),
(1, 2, 'Rubao', 'sentaechora@etesp.net',0)

INSERT INTO pratos_evento(id_orcamento, id_evento, id_produto, qtd_produto) VALUES
(1, 1, 1, 100),
(1, 1, 2, 100),
(2, 2, 1, 100),
(2, 2, 2, 100),
(3, 3, 2, 100),
(3, 3, 3, 100),
(4, 4, 2, 100),
(4, 4, 5, 100),
(5, 5, 2, 100),
(5, 5, 4, 100),
(6, 6, 7, 100),
(6, 6, 8, 100),
(7, 7, 1, 100),
(7, 7, 2, 100),
(8, 8, 1, 100),
(8, 8, 4, 100),
(9, 9, 2, 100),
(9, 9, 3, 100),
(10, 10, 5, 100),
(10, 10, 6, 100)

INSERT INTO detalhe_cancelamento(id_detalhe_cancelamento, id_cliente, id_orcamento,	motivo, dt_cancelamento) VALUES
(1,3,3,'Valores muito altos', '29/09/2015')

INSERT INTO pos_evento( id_pos_evento, id_evento, id_funcionario, adicionais, valor_adicionais) VALUES
(1,1,1,'Banana',69)
