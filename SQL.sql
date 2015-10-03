USE master
IF EXISTS(SELECT * FROM sys.databases WHERE name='eclair')
DROP Database eclair
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
	qtd_max INT
)
GO

CREATE TABLE evento(
	id_evento INT PRIMARY KEY,
	dt_evento DATE,
	hr_inicio CHAR(8))
)
GO

CREATE TABLE produto(
	id_produto INT PRIMARY KEY,
	nm_produto VARCHAR(20),
	quantidade INT,
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
	nm_produto VARCHAR(20),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
	dt_pedido DATE,
	dt_entrega DATE,
	valor_pedido DECIMAL(7,2)
)
GO

CREATE TABLE detalhe_pedido_perecivel(
	id_detalhe_pedido_perecivel INT PRIMARY KEY,
	id_pedido_perecivel INT FOREIGN KEY REFERENCES pedido_perecivel(id_pedido_perecivel),
	tipo_prato VARCHAR(50),
	nm_produto VARCHAR(50),
	qnt_produto INT,
	valor_produto DECIMAL(7,2),
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
(1, 'João', 123, '09/07/1997', 'Rua 123', '(11)2345-8767', '(11)98378-3787', '28738-578', '122.443.165-098', 'abc@abc.com'),
(2, 'Maria', 123, '09/07/1996', 'Rua 234', '(11)3542-8176', '(11)93847-1262', '18273-489', '129.187.938-379', 'bcd@abc.com'),
(3, 'José', 123, '09/07/1995', 'Rua 345', '(11)3565-7887', '(11)92389-1287', '18273-190', '546.289.298-198', 'cde@abc.com'),
(4, 'Irene', 123, '09/07/1994', 'Rua 456', '(11)1276-9189', '(11)90238-4562', '39384-083', '938.187.374-298', 'def@abc.com'),
(5, 'Odete', 123, '09/07/1993', 'Rua 567', '(11)7368-3287', '(11)92030-0929', '56373-827', '198.378.218-902', 'efg@abc.com'),
(6, 'Rosana', 123, '09/07/1992', 'Rua 678', '(11)2365-6739', '(11)92030-2877', '12728-278', '128.384.390-690', 'fgh@abc.com'),
(7, 'Claudia', 123, '09/07/1991', 'Rua 789', '(11)3873-0098', '(11)93030-2787', '19283-467', '598.129.198-039', 'ghi@abc.com'),
(8, 'Roberto', 123, '09/07/1990', 'Rua 890', '(11)3268-2837', '(11)91276-0939', '57839-128', '489.209.188-309', 'hij@abc.com'),
(9, 'Robson', 123, '09/07/1989', 'Rua 901', '(11)2398-2398', '(11)92363-8399', '93847-938', '982.127.189-647', 'ijk@abc.com'),
(10, 'Mário', 123, '09/07/1988', 'Rua 012', '(11)2099-2788', '(11)94673-1828', '17263-748', '289.489.093-902', 'jkl@abc.com')

INSERT INTO permissao(id_permissao, nm_permissao, lista_permissoes) VALUES
(1, 'Administrador', 'adm; atd; etq'),
(2, 'Atendente', 'atd; etq'),
(3, 'Estoquista','etq')

INSERT INTO funcionario(id_funcionario, id_permissao, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf, email) VALUES
(1, 1, 'Rita', '123', '05/07/1970', 'Rua abc', '(11)3782-0929', '(11)94893-3878', '01918-019', '898.234.824-838', 'rita@abc.com'),
(2, 1, 'Rúbia', '123', '31/07/1980', 'Rua bcd', '(11)3453-0929', '(11)9938-1102', '01343-439', '898.238.298-574', 'rubia@abc.com'),
(3, 1, 'Claudio', '123', '24/02/1972', 'Rua cde', '(11)2289-0929', '(11)92988-2993', '01323-019', '328.838.928-470', 'claudio@abc.com'),
(4, 2, 'Lúcia', '123', '05/08/1976', 'Rua def', '(11)2930-0929', '(11)92923-8393', '33318-390', '129.832.838-388', 'lucia@abc.com'),
(5, 2, 'João', '123', '04/03/1983', 'Rua efg', '(11)2918-0929', '(11)92039-1099', '01323-109', '647.763.872-893', 'joao@abc.com'),
(6, 2, 'Maria', '123', '16/11/1980', 'Rua fgh', '(11)2010-0929', '(11)93983-3300', '01238-129', '278.878.478-980', 'maria@abc.com'),
(7, 2, 'Neusa', '123', '19/12/1977', 'Rua ghi', '(11)3893-0929', '(11)94109-3838', '32318-192', '738.928.672-983', 'neusa@abc.com'),
(8, 3, 'Paulo', '123', '15/07/1989', 'Rua hij', '(11)3398-0929', '(11)99090-3198', '11912-129', '784.989.273.093', 'paulo@abc.com'),
(9, 3, 'Moisés', '123', '22/03/1991', 'Rua ijk', '(11)3390-0929', '(11)91822-8939', '19288-192', '783.939.376-848', 'moises@abc.com'),
(10, 3, 'Cíntia', '123', '28/01/1972', 'Rua jkl', '(11)3902-0929', '(11)95988-1178', '29389-837', '128.721.472-617', 'cintia@abc.com')

INSERT INTO lugar(id_lugar, endereco, cep, qnt_max) VALUES
(1, 'Rua aaa', '09383-039', 300),
(2, 'Rua bbb', '28989-299', 250)

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

INSERT INTO produto(id_produto, nm_produto, quantidade, tipo_produto) VALUES
(1, 'pastel', 300, 'perecivel'),
(2, 'coxinha', 300, 'perecivel'),
(3, 'bolinha de queijo', 300, 'perecivel'),
(4, 'mini-pizza', 300, 'perecivel'),
(5, 'pipoca', 300, 'perecivel'),
(6, 'hot dog', 300, 'perecivel'),
(7, 'croquete', 300, 'perecivel'),
(8, 'empadinha', 300, 'perecivel'),
(9, 'brigadeiro', 300, 'perecivel'),
(10, 'pé-de-moleque', 300, 'perecivel'),
(11, 'beijinho', 300, 'perecivel'),
(12, 'bala de côco', 300, 'perecivel'),
(13, 'sorvete', 300, 'perecivel'),
(14, 'torta de chocolate', 300, 'perecivel'),
(15, 'torta de morango', 300, 'perecivel'),
(16, 'pavê', 300, 'perecivel'),
(17, 'água', 300, 'perecivel'),
(18, 'refrigerante', 300, 'perecivel'),
(19, 'suco', 300, 'perecivel'),
(20, 'cerveja', 300, 'perecivel'),
(21, 'vinho', 300, 'perecivel'),
(22, 'champagne', 300, 'perecivel'),
(23, 'pé-de-moleque', 300, 'perecivel'),
(24, 'centro de mesa', 300, 'consumivel'),
(25, 'enfeite de parede', 300, 'consumivel'),
(26, 'bexigas coloridas', 300, 'consumivel'),
(27, 'decoração para mesa', 300, 'consumivel'),
(28, 'guardanapo', 300, 'consumivel'),
(29, 'prato', 300, 'consumivel'),
(30, 'copo', 300, 'consumivel'),
(31, 'talher', 300, 'consumivel'),
(32, 'toalha', 300, 'consumivel'),
(33, 'cadeira', 300, 'consumivel'),
(34, 'mesa', 300, 'consumivel'),
(35, 'flores', 300, 'consumivel'),
(36, 'lanterna', 300, 'consumivel'),
(37, 'glow sticks', 300, 'consumivel'),
(38, 'feijoada', 300, 'perecivel'),
(39, 'escondidinho de queijo', 300, 'perecivel'),
(40, 'macarrão ao molho branco', 300, 'perecivel')

INSERT INTO pratos_evento(id_pratos_evento, id_produto) VALUES
(1, 38),
(2, 39),
(3, 40)
