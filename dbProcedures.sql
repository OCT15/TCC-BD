--Use master
Use eclair
GO
------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------/**Procedures ASP.NET**/-----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Login do Cliente dentro da Aplicação ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_LoginCli')
	DROP PROCEDURE USP_LoginCli
	GO
CREATE PROC USP_LoginCli(@emailCli AS VARCHAR(255), @senhaCli AS VARCHAR(50))
AS

BEGIN
	DECLARE @getEmailCli VARCHAR(255), @getSenhaCli VARCHAR(50)
	SET @getEmailCli = (SELECT email FROM cliente WHERE email = @emailCli)
	SET @getSenhaCli = (SELECT senha FROM cliente WHERE senha = @senhaCli)

	IF (LEN(@getEmailCli) > 0 AND (LEN(@getSenhaCli) > 0))
		IF (@getEmailCli <> '') AND (@getSenhaCli <> '')
			SELECT ('Bem Vindo ao espaço Eclair') AS LOGGER
		ELSE
			SELECT('Acesso recusado') AS LOGGER
	ELSE
		SELECT ('Acesso recusado') AS LOGGER
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Insert de Cliente no sistema pelo ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_InsertCli')
	DROP PROCEDURE USP_InsertCli
	GO
CREATE PROC USP_InsertCli(@idCli AS INT, @nomeCli AS VARCHAR(50), @senhaCli AS VARCHAR(50), @dtNasc AS DATE, @endCli VARCHAR(100), @telCli CHAR(13), @celCli CHAR(14), @cepCli CHAR(9), @cpfCli VARCHAR(18), @rgCli VARCHAR(12), @mailCli VARCHAR(255))
AS

BEGIN
	DECLARE @getNome INT
	SET @getNome = (SELECT nome FROM cliente WHERE id_cliente = @idCli)
		--IF (@getNome = null)
					INSERT INTO cliente(id_cliente, nome, senha, dt_nascim, endereco, telefone, celular, cep, cpf_cnpj, rg_ie, email) VALUES
				(@idCli, @nomeCli, @senhaCli, @dtNasc, @endCli, @telCli, @celCli, @cepCli, @cpfCli, @rgCli, @mailCli)

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Cliente no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectCliente')
	DROP PROCEDURE USP_SelectCliente
	GO
CREATE PROC USP_SelectCliente(@idCli AS INT)
AS

BEGIN
	DECLARE @getNome VARCHAR(50)
	SET @getNome = (SELECT nome FROM cliente WHERE id_cliente = @idCli)
	IF (@getNome <> '')
		IF (LEN(@getNome) > 0)
			SELECT * FROM cliente WHERE id_cliente = @idCli

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Produto no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectProd')
	DROP PROCEDURE USP_SelectProd
	GO
CREATE PROC USP_SelectProd(@idProd AS INT)
AS

BEGIN
	DECLARE @getNome VARCHAR(50)
	SET @getNome = (SELECT nm_produto FROM produto WHERE id_produto = @idProd)
	IF (@getNome <> '')
		SELECT * FROM produto WHERE id_produto = @idProd

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Pacote no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectPacote')
	DROP PROCEDURE USP_SelectPacote
	GO
CREATE PROC USP_SelectPacote
AS

BEGIN
	SELECT * FROM pacote P
		INNER JOIN produto_pacote ProdP ON P.id_pacote = ProdP.id_pacote
			INNER JOIN produto Prod ON ProdP.id_produto = Prod.id_produto
			
END 
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Pacote pelo ID no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectPacoteBYid')
	DROP PROCEDURE USP_SelectPacoteBYid
	GO
CREATE PROC USP_SelectPacoteBYid(@idPac AS INT)
AS

BEGIN
	DECLARE @getNome VARCHAR(50)
	SET @getNome = (SELECT nome FROM pacote WHERE id_pacote = @idPac)
	IF (@getNome <> '')
		SELECT * FROM pacote P
			INNER JOIN produto_pacote ProdP ON P.id_pacote = ProdP.id_pacote
				INNER JOIN produto Prod ON ProdP.id_produto = Prod.id_produto WHERE P.id_pacote = @idPac

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Orçamento no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectOrc')
	DROP PROCEDURE USP_SelectOrc
	GO
CREATE PROC USP_SelectOrc
AS

BEGIN
	SELECT * FROM orcamento 

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Orçamento pelo ID no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectOrcBYid')
	DROP PROCEDURE USP_SelectOrcBYid
	GO
CREATE PROC USP_SelectOrcBYid(@idOrc AS INT)
AS

BEGIN
	DECLARE @getIdCli INT
	SET @getIdCli = (SELECT id_cliente FROM orcamento WHERE id_orcamento = @idOrc)
	IF (@getIdCli <> '')
		SELECT * FROM orcamento WHERE id_orcamento = @idOrc
		
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Insert de Orçamento no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_InsertOrc')
	DROP PROCEDURE USP_InsertOrc
	GO
CREATE PROC USP_InsertOrc(@idOrc AS INT, @idLug AS INT, @idCli AS INT, @idPerm AS INT, @idFunc AS INT, @valorOrc AS DECIMAL(8,2), @numConv AS INT, @dtEven AS DATE, @temaOrc AS VARCHAR(50), @mailCli AS VARCHAR(254), @dtOrc AS DATE, @hrEven AS TIME, @duracaoEven AS TIME)
AS

BEGIN
	IF NOT EXISTS (SELECT id_cliente FROM orcamento WHERE id_orcamento = @idOrc)
		INSERT INTO orcamento(id_orcamento, id_lugar, id_cliente, id_permissao, id_funcionario, valor_orcamento, num_convidados, dt_evento, tema, email_cliente, dt_orcamento, hr_inicio, duracao) VALUES
			(@idOrc, @idLug, @idCli, @idPerm, @idFunc, @valorOrc, @numConv, @dtEven, @temaOrc, @mailCli, @dtOrc, @hrEven, @duracaoEven)

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Update de Orçamento no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_UpdateOrc')
	DROP PROCEDURE USP_UpdateOrc
	GO
CREATE PROC USP_UpdateOrc(@idOrc AS INT, @idLug AS INT, @idCli AS INT, @idPerm AS INT, @idFunc AS INT, @valorOrc AS DECIMAL(8,2), @numConv AS INT, @dtEven AS DATE, @temaOrc AS VARCHAR(50), @mailCli AS VARCHAR(254), @dtOrc AS DATE, @hrEven AS TIME, @duracaoEven AS TIME)
AS

BEGIN
	DECLARE @getIDCli INT
	SET @getIDCli = (SELECT id_cliente FROM orcamento WHERE id_orcamento = @idOrc)
	IF (@getIDCLI <> '')
		UPDATE orcamento SET
			id_lugar = @idLug,
			id_cliente = @idCli,
			id_permissao = @idPerm,
			id_funcionario =  @idFunc,
			valor_orcamento = @valorOrc,
			num_convidados = @numConv,
			dt_evento = @dtEven,
			tema = @temaOrc,
			email_cliente = @mailCli,
			dt_orcamento = @dtOrc,
			hr_inicio = @hrEven,
			duracao = @duracaoEven
		WHERE id_orcamento = @idOrc

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de PratosEvento no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectPraEvento')
	DROP PROCEDURE USP_SelectPraEvento
	GO
CREATE PROC USP_SelectPraEvento
AS

BEGIN
	SELECT * FROM pratos_evento

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/** Select de PratosEvento por IdOrçamento no ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectPraEventoBYid')
	DROP PROCEDURE USP_SelectPraEventoBYid
	GO
CREATE PROC USP_SelectPraEventoBYid(@idEven AS INT)
AS

BEGIN
	IF EXISTS (SELECT id_evento FROM pratos_evento WHERE id_orcamento = @idEven)
		SELECT * FROM pratos_evento WHERE id_evento = @idEven

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Insert de PratosEvento por ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_InsertPraEvento')
	DROP PROCEDURE USP_InsertPraEvento
	GO
CREATE PROC USP_InsertPraEvento(@idEve AS INT, @idLug AS INT, @idCli AS INT, @idPerm AS INT, @idFunc AS INT, @valEven AS DECIMAL(8,2), @numConv AS INT, @dtEven AS DATE, @localEven AS VARCHAR(50), @tema AS VARCHAR(50), @mailCli AS VARCHAR(254), @dtOrc AS DATE,@dtAprov AS DATE, @hrEven AS TIME, @duracao AS TIME)
AS

BEGIN
	IF NOT EXISTS (SELECT id_cliente FROM evento WHERE id_evento = @idEve)
		INSERT INTO evento(id_evento, id_lugar, id_cliente, id_permissao, id_funcionario, valor_evento, num_convidados, dt_evento, local_evento, tema, email_cliente, dt_orcamento,dt_aprovado, hr_inicio, duracao) VALUES
			(@idEve, @idLug, @idCli, @idPerm, @idFunc, @valEven, @numConv, @dtEven, @localEven, @tema, @mailCli, @dtOrc, @dtAprov, @hrEven, @duracao)
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Insert de Cancelamento por ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_InsertCanc')
	DROP PROCEDURE USP_InsertCanc
	GO
CREATE PROC USP_InsertCanc(@idCanc AS INT, @idCLi AS INT, @idOrc AS INT, @motivo AS VARCHAR(150), @dtCanc AS DATE)
AS

BEGIN
	IF NOT EXISTS (SELECT id_cliente FROM detalhe_cancelamento WHERE id_detalhe_cancelamento = @idCanc)
		INSERT INTO detalhe_cancelamento(id_detalhe_cancelamento, id_cliente, id_orcamento, motivo, dt_cancelamento) VALUES
			(@idCanc, @idCli, @idOrc, @motivo, @dtCanc)

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Eventos (Aprovados Ontem) por ASP.NET**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_Eventos_AprovOntem')
	DROP PROCEDURE USP_Eventos_AprovOntem
	GO
CREATE PROC USP_Eventos_AprovOntem
AS

BEGIN
	SELECT C.nome, C.email, E.id_evento, E.dt_evento FROM cliente C 
		INNER JOIN Evento E ON E.id_cliente = C.id_cliente
			WHERE CONVERT(Date, E.dt_aprovado) = DATEADD(DAY, -1, CONVERT(DATE, GETDATE()))

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------/**Procedures JAVA**/--------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Insert de Pós-Evento no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_InsertPosEvento')
	DROP PROCEDURE USP_InsertPosEvento
	GO
CREATE PROC USP_InsertPosEvento(@idPosEven AS INT, @idEvento AS INT, @idFunc AS INT, @add AS VARCHAR(255), @valorAdd AS DECIMAL(8,2))
AS

BEGIN
	IF NOT EXISTS (SELECT id_Evento FROM pos_evento WHERE id_pos_evento = @idPosEven)
		INSERT INTO pos_evento(id_pos_evento, id_evento, id_funcionario, adicionais, valor_adicionais) VALUES
			(@idPosEven, @idEvento, @idFunc, @add, @valorAdd)

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Update de Pós-Evento no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_UpdatePosEvento')
	DROP PROCEDURE USP_UpdatePosEvento
	GO
CREATE PROC USP_UpdatePosEvento(@idEven AS INT, @idConv AS INT, @compareceu AS BIT)
AS

BEGIN
	IF EXISTS (SELECT compareceu FROM convidados WHERE id_evento = @idEven AND id_convidado = @idConv)
		UPDATE convidados SET
			compareceu = @compareceu
		WHERE id_evento = @idEven AND id_convidado = @idConv

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
				/**Select de Convidados no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectConvidados')
	DROP PROCEDURE USP_SelectConvidados
	GO
CREATE PROC USP_SelectConvidados
AS

BEGIN
	SELECT id_evento, id_convidado, nome_convidado, compareceu FROM convidados

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Update de Convidados no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_UpdateConvidados')
	DROP PROCEDURE USP_UpdateConvidados
	GO
CREATE PROC USP_UpdateConvidados(@idEven AS INT, @idConv AS INT, @Compareceu as BIT)
AS

BEGIN
	IF EXISTS (SELECT nome_convidado FROM convidados WHERE id_evento = @idEven AND id_convidado = @idConv)
		UPDATE convidados SET 
			compareceu = @Compareceu
				WHERE id_evento = @idEven AND id_convidado = @idConv

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Insert de Convidados no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_InsertConvidado')
	DROP PROCEDURE USP_InsertConvidado
	GO
CREATE PROC USP_InsertConvidado(@idEven AS INT, @idConv AS INT, @nomeConv AS VARCHAR(50), @compareceu AS BIT)
AS

BEGIN
	IF NOT EXISTS (SELECT nome_convidado FROM convidados WHERE id_evento = @idEven AND id_convidado = @idConv )
		INSERT INTO convidados(id_evento, id_convidado, nome_convidado, compareceu) VALUES
			(@idEven, @idConv, @nomeConv, @compareceu)

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Convidados por Id_Evento/Nome no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectConvidadoBYid')
	DROP PROCEDURE USP_SelectConvidadoByid
	GO
CREATE PROC USP_SelectConvidadoBYid(@idEven AS INT, @nomeConv AS VARCHAR(50))
AS
BEGIN
	IF EXISTS (SELECT id_convidado FROM convidados WHERE id_evento = @idEven AND nome_convidado = @nomeConv)
		SELECT id_convidado FROM convidados WHERE id_evento = @idEven AND nome_convidado = @nomeConv

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Login do Gerente no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectEvento_Login')
	DROP PROCEDURE USP_SelectEvento_Login
	GO
CREATE PROC USP_SelectEvento_Login(@dtEven AS DATE,@hrEven AS TIME)
AS
BEGIN
	SELECT id_evento, hr_inicio, duracao FROM evento WHERE dt_evento = @dtEven AND DATEPART(HOUR,@hrEven) = DATEPART(HOUR,GETDATE())+1

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Update de Prato_Evento no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_UpdatePrato')
	DROP PROCEDURE USP_UpdatePrato
	GO
CREATE PROC USP_UpdatePrato(@idEven AS INT, @idProd AS INT, @quant AS INT)
AS

BEGIN
	IF EXISTS (SELECT qtd_produto FROM pratos_evento WHERE id_evento = @idEven AND id_produto = @idProd)
		UPDATE pratos_evento SET
			qtd_produto = @quant
		WHERE id_evento = @idEven AND id_produto = @idProd

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Evento no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectEvento')
	DROP PROCEDURE USP_SelectEvento
	GO
CREATE PROC USP_SelectEvento
AS

BEGIN
	SELECT id_evento, id_cliente, dt_evento, hr_inicio, id_lugar, duracao FROM evento

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Evento por ID_Evento no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectEventoBYid')
	DROP PROCEDURE USP_SelectEventoBYid
	GO
CREATE PROC USP_SelectEventoBYid(@idEven AS INT)
AS

BEGIN
	IF EXISTS (SELECT id_cliente FROM evento WHERE id_evento = @idEven)
		SELECT * FROM evento WHERE id_evento = @idEven

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Pos_Evento por ID_PosEvento no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectPosEvento')
	DROP PROCEDURE USP_SelectPosEvento
	GO
CREATE PROC USP_SelectPosEvento(@idEven AS INT)
AS

BEGIN
	IF EXISTS (SELECT id_funcionario FROM pos_evento WHERE id_pos_evento = @idEven)
		SELECT * FROM pos_evento where id_pos_evento = @idEven

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de PratosEvento e Produtos por ID_Evento no sistema JAVA**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectProds')
	DROP PROCEDURE USP_SelectProds
	GO
CREATE PROC USP_SelectProds(@idEven AS INT)
AS

BEGIN
	SELECT pr.id_evento, pr.id_produto, p.nm_produto, pr.qtd_produto FROM pratos_evento AS pr 
		INNER JOIN produto AS p ON pr.id_produto = p.id_produto AND pr.id_evento = @idEven AND p.tipo_produto = 'perecivel'
END
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------/**Procedures Mobiles**/-----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------/**Procedures C#**/----------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Procedure de login do funcionário no sistema**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_LoginFunc')
	DROP PROCEDURE USP_LoginFunc
	GO
CREATE PROC USP_LoginFunc(@User AS VARCHAR(50), @Pass AS VARCHAR(50))
AS

BEGIN
	DECLARE @getUser VARCHAR(50), @getPass VARCHAR(50)
	IF @User = (SELECT nome FROM funcionario WHERE senha = @Pass) AND @Pass = (Select senha FROM funcionario WHERE nome = @User)
			SELECT f.nome, p.* FROM funcionario f
				INNER JOIN permissao p ON f.id_permissao = p.id_permissao
					AND f.nome = @User AND f.senha = @Pass

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Cliente na aplicação C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectCli')
	DROP PROCEDURE USP_SelectCli
	GO
CREATE PROC USP_SelectCli(@txtID_Cli AS INT)
As

BEGIN
	DECLARE @getNome VARCHAR(50)
	SET @getNome = (SELECT nome FROM cliente WHERE id_cliente = @txtID_Cli)
	IF (@getNome <> '')
		SELECT * FROM cliente WHERE id_cliente = @txtID_Cli		
END
GO
----------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Cliente por id_cliente na aplicação C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectCliBYid')
	DROP PROCEDURE USP_SelectCliBYid
	GO
CREATE PROC USP_SelectCliBYid(@Coringa AS SQL_VARIANT)
AS

BEGIN
	IF EXISTS (SELECT nome FROM cliente AS Cli WHERE Cli.id_cliente = @Coringa OR nome LIKE '%' + CAST (@Coringa AS VARCHAR) + '%' OR email LIKE '%' + CAST(@Coringa AS VARCHAR) + '%')
		SELECT Cli.id_cliente AS ID, Cli.nome AS Nome, Cli.dt_nascim AS Nascimento, Cli.endereco AS Endereço, Cli.telefone AS Telefone, Cli.celular AS Celular, Cli.cep AS Cep, Cli.cpf_cnpj AS CPF, Cli.rg_ie AS RG, Cli.email AS Email 
			FROM cliente AS Cli	WHERE Cli.id_cliente = @Coringa OR nome LIKE '%' + CAST (@Coringa AS VARCHAR) + '%' OR email LIKE '%' + CAST(@Coringa AS VARCHAR) + '%'

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Update de Cliente no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_UpdateCli')
	DROP PROCEDURE USP_UpdateCli
	GO
CREATE PROC USP_UpdateCli(@nome AS VARCHAR(50), @senha AS VARCHAR(50), @Data AS DATE, @Endereço AS VARCHAR(100), @Tel AS CHAR(13), @Cel AS CHAR(14), @CEP AS CHAR(9), @CPF AS CHAR(14), @RG AS CHAR(12), @Mail AS VARCHAR(255), @idCli AS INT)
AS

BEGIN
	IF EXISTS (SELECT nome FROM cliente WHERE id_cliente = @idCli)
		UPDATE cliente SET
			nome = @nome,
			senha = @senha,
			dt_nascim = @Data,
			endereco = @Endereço,
			telefone = @Tel,
			celular = @Cel,
			cep = @CEP,
			cpf_cnpj = @CPF,
			rg_ie = @RG,
			email = @Mail
	  WHERE id_cliente = @idCli

END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Funcionario no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectFunc')
	DROP PROCEDURE USP_SelectFunc
	GO
CREATE PROC USP_SelectFunc(@idFunc AS INT)
AS

BEGIN
	IF EXISTS (SELECT nome FROM funcionario WHERE id_funcionario = @idFunc)
		SELECT F.*, P.nm_permissao FROM funcionario AS F
			INNER JOIN permissao AS P ON F.id_permissao = P.id_permissao WHERE id_funcionario = @idFunc

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Funcuncionario por id_funcionario no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectFunBYid')
	DROP PROCEDURE USP_SelectFuncBYid
	GO
CREATE PROC USP_SelectFuncBYid(@idFunc AS INT)
AS

BEGIN
	IF EXISTS (SELECT nome FROM funcionario WHERE id_funcionario = @idFunc)
		SELECT * FROM funcionario WHERE id_funcionario = @idFunc

END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Insert de Funcionario no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_InsertFunc')
	DROP PROCEDURE USP_InsertFunc
	GO
CREATE PROC USP_InsertFunc(@idFunc AS INT, @idPerm AS INT, @nome AS VARCHAR(50), @senha AS VARCHAR(15), @Data AS DATE, @Endereço AS VARCHAR(100), @Tel AS CHAR(13), @Cel AS CHAR(14), @CEP AS CHAR(9), @CPF AS CHAR(14), @RG AS CHAR(12), @Email AS VARCHAR(254))
AS

BEGIN
	IF NOT EXISTS (SELECT nome FROM funcionario WHERE id_funcionario = @idFunc)
		INSERT INTO funcionario VALUES
			(@idFunc, @idPerm, @nome, @senha, @Data, @Endereço, @Tel, @Cel, @CEP, @CPF, @RG, @Email)

END
GO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
		/**Update de Funcionario no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_UpdateFunc')
	DROP PROCEDURE USP_UpdateFunc
	GO
CREATE PROC USP_UpdateFunc(@nome AS VARCHAR(50), @senha AS VARCHAR(50), @Data AS DATE, @Endere AS VARCHAR(100), @Tel AS CHAR(13), @Cel AS CHAR(14), @CEP AS CHAR(9), @Mail AS VARCHAR(255), @idFunc AS INT, @idPerm AS INT)
AS

BEGIN
	IF EXISTS (SELECT nome FROM funcionario WHERE id_funcionario = @idFunc)
		UPDATE funcionario SET
			nome = @nome,
			senha = @senha,
			dt_nascim = @Data,
			endereco = @Endere,
			telefone = @Tel,
			celular = @Cel,
			cep = @CEP,
			email = @Mail,
			id_permissao = @idPerm
	WHERE id_funcionario = @idFunc

END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
		/**Verificador de id_funcionario vazio**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_VerifIDFunc')
	DROP PROCEDURE USP_VerifIDFunc
	GO
CREATE PROC USP_VerifIDFunc(@idFunc AS INT)
AS

BEGIN
	SELECT nome FROM funcionario WHERE id_funcionario = @idFunc

END
GO
----------------------------------------------------------------------------------------------------------------------------------------------------------
		/**Verificador de id_cliente vazio**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_VerifIDCli')
	DROP PROCEDURE USP_VerifIDCli
	GO
CREATE PROC USP_VerifIDCli(@idCli AS INT)
AS

BEGIN
	SELECT nome FROM cliente WHERE id_cliente = @idCli

END
GO
----------------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Contas por Mes no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectContasBYdata')
	DROP PROCEDURE USP_SelectContasBYdata
	GO
CREATE PROC USP_SelectContasBYdata(@data AS DATE)
AS

BEGIN
	SELECT valor_conta FROM contas WHERE YEAR(data_conta) = YEAR(@data) AND MONTH(data_conta) = MONTH(@data)

END
GO
EXECUTE USP_SelectContasBYdata '01/11/2015'
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Contas por Mes no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectEventoBYdata')
	DROP PROCEDURE USP_SelectEventoBYdata
	GO
CREATE PROC USP_SelectEventoBYdata(@data AS DATE)
AS

BEGIN
	SELECT SUM(valor_evento) AS Valor FROM evento WHERE YEAR(dt_evento) = YEAR(@data) AND MONTH(dt_evento) = MONTH(@data)

END
GO
EXECUTE USP_SelectEventoBYdata '01/04/2016'
------------------------------------------------------------------------------------------------------------------------------------------------
		/**Select de Produtos no sistema C#**/
IF EXISTS ( SELECT * FROM sys.objects WHERE type = 'P' AND name = 'USP_SelectProd')
	DROP PROCEDURE USP_SelectProd
	GO
CREATE PROC USP_SelectProd(@idProd AS INT)
AS

BEGIN
	IF EXISTS (SELECT nm_produto FROM produto WHERE id_produto = @idProd)
		SELECT * FROM produto WHERE id_produto = @idProd

END
GO
---------------------------------------------------------------------------------------------------------------------------------------------------
