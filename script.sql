/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.5026)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [DB7289_CONTRATOS_DES]
GO
/****** Object:  Schema [contratos]    Script Date: 11/12/2020 17:48:26 ******/
CREATE SCHEMA [contratos]
GO
/****** Object:  Table [contratos].[tb_tipos_documento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_tipos_documento](
	[id_tipo_documento] [tinyint] IDENTITY(1,1) NOT NULL,
	[tipo_documento] [varchar](50) NOT NULL,
	[possui_validade] [bit] NOT NULL,
	[id_dominio_documento] [tinyint] NOT NULL,
	[ativo] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_tipos_documento] PRIMARY KEY CLUSTERED 
(
	[id_tipo_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [contratos].[tb_dominios_documento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_dominios_documento](
	[id_dominio_documento] [tinyint] NOT NULL,
	[dominio_documento] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_dominios_documento] PRIMARY KEY CLUSTERED 
(
	[id_dominio_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_documento_selecionar_por_id_dominio_documento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_tipo_documento_selecionar_por_id_dominio_documento]
(	
	@id_dominio_documento tinyint
)
RETURNS TABLE
AS
RETURN 
(
	/* manter a.id_dominio_documento por causa dos testes */
	SELECT a.id_tipo_documento, a.tipo_documento, a.possui_validade, a.id_dominio_documento, b.dominio_documento
	FROM [contratos].[tb_tipos_documento] a
		LEFT JOIN [contratos].[tb_dominios_documento] b ON a.id_dominio_documento = b.id_dominio_documento
	WHERE a.id_dominio_documento = @id_dominio_documento
)
GO
/****** Object:  Table [contratos].[tb_unidades]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_unidades](
	[id_unidade] [smallint] NOT NULL,
	[unidade] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_unidades] PRIMARY KEY CLUSTERED 
(
	[id_unidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_unidade_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_unidade_selecionar_por_id](@id_unidade smallint)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_unidade, unidade
	FROM [contratos].[tb_unidades]
	WHERE id_unidade = @id_unidade
)
GO
/****** Object:  Table [contratos].[tb_documentos]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_documentos](
	[id_documento] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipo_documento] [tinyint] NOT NULL,
	[id_empresa] [smallint] NULL,
	[id_contrato] [int] NULL,
	[id_ateste_pagamento] [int] NULL,
	[id_penalidade] [int] NULL,
	[data_validade] [date] NULL,
	[nome_documento] [varchar](255) NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
	[observacao] [varchar](8000) NULL,
 CONSTRAINT [PK_tb_documentos] PRIMARY KEY CLUSTERED 
(
	[id_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_documento_selecionar_por_id_empresa]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_documento_selecionar_por_id_empresa](@id_empresa smallint)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_documento
		 , a.id_tipo_documento
		 , b.tipo_documento
		 , a.id_empresa
		 , FORMAT(a.data_validade, 'd', 'pt-BR') data_validade
		 , a.nome_documento
		 , a.observacao
		 , (CAST(a.id_tipo_documento AS varchar) + (CAST(a.id_empresa AS varchar) + a.nome_documento)) download
	FROM [contratos].[tb_documentos] a
		LEFT JOIN [contratos].[tb_tipos_documento] b ON a.id_tipo_documento = b.id_tipo_documento
	WHERE a.id_empresa = @id_empresa
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_documento_selecionar_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_documento_selecionar_por_id_contrato](@id_contrato int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_documento
		 , a.id_tipo_documento
		 , b.tipo_documento
		 , a.id_contrato
		 , FORMAT(a.data_validade, 'd', 'pt-BR') data_validade
		 , a.nome_documento
		 , a.observacao
		 , (CAST(a.id_tipo_documento AS varchar) + (CAST(a.id_contrato AS varchar) + a.nome_documento)) download
	FROM [contratos].[tb_documentos] a
		LEFT JOIN [contratos].[tb_tipos_documento] b ON a.id_tipo_documento = b.id_tipo_documento
	WHERE a.id_contrato = @id_contrato
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_documento_selecionar_por_id_ateste_pagamento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_documento_selecionar_por_id_ateste_pagamento](@id_ateste_pagamento int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_documento
		 , a.id_tipo_documento
		 , b.tipo_documento
		 , a.id_ateste_pagamento
		 , FORMAT(a.data_validade, 'd', 'pt-BR') data_validade
		 , a.nome_documento
		 , a.observacao
		 , (CAST(a.id_tipo_documento AS varchar) + (CAST(a.id_ateste_pagamento AS varchar) + a.nome_documento)) download
	FROM [contratos].[tb_documentos] a
		LEFT JOIN [contratos].[tb_tipos_documento] b ON a.id_tipo_documento = b.id_tipo_documento
	WHERE a.id_ateste_pagamento = @id_ateste_pagamento
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_documento_selecionar_por_id_penalidade]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_documento_selecionar_por_id_penalidade](@id_penalidade int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_documento
		 , a.id_tipo_documento
		 , b.tipo_documento
		 , a.id_penalidade
		 , FORMAT(a.data_validade, 'd', 'pt-BR') data_validade
		 , a.nome_documento
		 , a.observacao
		 , (CAST(a.id_tipo_documento AS varchar) + (CAST(a.id_penalidade AS varchar) + a.nome_documento)) download
	FROM [contratos].[tb_documentos] a
		LEFT JOIN [contratos].[tb_tipos_documento] b ON a.id_tipo_documento = b.id_tipo_documento
	WHERE a.id_penalidade = @id_penalidade
)
GO
/****** Object:  Table [contratos].[tb_empresas]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_empresas](
	[id_empresa] [smallint] IDENTITY(1,1) NOT NULL,
	[empresa] [varchar](200) NOT NULL,
	[cnpj] [bigint] NOT NULL,
	[endereco] [varchar](200) NULL,
	[cidade] [varchar](100) NOT NULL,
	[uf] [char](2) NOT NULL,
	[cep] [bigint] NOT NULL,
	[observacao] [varchar](8000) NOT NULL,
	[ativo] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_empresas] PRIMARY KEY CLUSTERED 
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_empresa_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_empresa_selecionar_por_id](@id_empresa smallint)
RETURNS TABLE
AS
RETURN
(
	SELECT id_empresa, empresa, cnpj, endereco, cidade, uf, cep, observacao, ativo, ultima_alteracao, usuario_alteracao
	FROM [contratos].[tb_empresas]
	WHERE id_empresa = @id_empresa
)
GO
/****** Object:  Table [contratos].[tb_perfis]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_perfis](
	[id_perfil] [tinyint] IDENTITY(1,1) NOT NULL,
	[perfil] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_perfis] PRIMARY KEY CLUSTERED 
(
	[id_perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_perfil_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_perfil_selecionar_por_id](@id_perfil tinyint)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_perfil, perfil
	FROM [contratos].[tb_perfis]
	WHERE id_perfil = @id_perfil
)
GO
/****** Object:  Table [contratos].[tb_atestes_pagamento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_atestes_pagamento](
	[id_ateste_pagamento] [int] IDENTITY(1,1) NOT NULL,
	[id_contrato] [int] NOT NULL,
	[ano] [smallint] NOT NULL,
	[mes] [tinyint] NOT NULL,
	[observacao] [varchar](8000) NULL,
	[pago] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NULL,
	[usuario_alteracao] [char](7) NULL,
 CONSTRAINT [PK_tb_ateste_pagamento] PRIMARY KEY CLUSTERED 
(
	[id_ateste_pagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [contratos].[tb_contratos]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_contratos](
	[id_contrato] [int] IDENTITY(1,1) NOT NULL,
	[id_empresa] [smallint] NOT NULL,
	[id_tipo_contrato] [tinyint] NOT NULL,
	[numero_processo] [varchar](30) NULL,
	[numero_ordem_servico] [bigint] NULL,
	[data_assinatura] [date] NULL,
	[data_inicio_vigencia] [date] NOT NULL,
	[data_fim_vigencia] [date] NOT NULL,
	[valor_global_inicial] [decimal](19, 2) NOT NULL,
	[valor_global_atualizado] [decimal](19, 2) NULL,
	[objeto_contratual] [varchar](8000) NOT NULL,
	[dia_pagamento] [tinyint] NOT NULL,
	[dia_pagamento_corridos] [bit] NULL,
	[prazo_alerta_dias_pagamento] [tinyint] NOT NULL,
	[prazo_alerta_dias_ateste] [tinyint] NOT NULL,
	[prazo_alerta_dias_nota_fiscal] [tinyint] NOT NULL,
	[prazo_alerta_meses_fim_vigencia] [tinyint] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
	[ativo] [bit] NULL,
 CONSTRAINT [PK_tb_contratos] PRIMARY KEY CLUSTERED 
(
	[id_contrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_ateste_pagamento_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_ateste_pagamento_selecionar_por_id](@id_ateste_pagamento int)
RETURNS TABLE
AS
RETURN
(
	SELECT c.empresa
		 , b.numero_processo contrato
		 , (CAST(a.mes AS varchar) + '/' + CAST(a.ano AS varchar)) competencia
		 , a.observacao
	FROM [contratos].[tb_atestes_pagamento] a
		LEFT JOIN [contratos].[tb_contratos] b ON a.id_contrato = b.id_contrato
		LEFT JOIN [contratos].[tb_empresas] c ON b.id_empresa = c.id_empresa
	WHERE a.id_ateste_pagamento = @id_ateste_pagamento
)
GO
/****** Object:  Table [contratos].[tb_tipos_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_tipos_contrato](
	[id_tipo_contrato] [tinyint] IDENTITY(1,1) NOT NULL,
	[tipo_contrato] [varchar](50) NOT NULL,
	[ativo] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_tipos_contrato] PRIMARY KEY CLUSTERED 
(
	[id_tipo_contrato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_contrato_selecionar_por_id_empresa]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_contrato_selecionar_por_id_empresa]( @id_empresa int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_contrato
		 , a.id_empresa
		 , b.empresa
		 , a.id_tipo_contrato
		 , c.tipo_contrato
		 , a.numero_processo
		 , a.numero_ordem_servico
		 , CONVERT(VARCHAR, a.data_assinatura, 103) AS data_assinatura
		 , CONVERT(VARCHAR, a.data_inicio_vigencia, 103) AS data_inicio_vigencia
		 , CONVERT(VARCHAR, a.data_fim_vigencia, 103) AS data_fim_vigencia
		 , a.valor_global_inicial
		 , a.valor_global_atualizado
		 , a.objeto_contratual
		 , a.dia_pagamento
		 , a.dia_pagamento_corridos
		 , a.prazo_alerta_dias_pagamento
		 , a.prazo_alerta_dias_ateste
		 , a.prazo_alerta_dias_nota_fiscal
		 , a.prazo_alerta_meses_fim_vigencia
		 , a.ultima_alteracao
		 , a.usuario_alteracao
	FROM [contratos].[tb_contratos] a
		LEFT JOIN [contratos].[tb_empresas] b ON a.id_empresa = b.id_empresa
		LEFT JOIN [contratos].[tb_tipos_contrato] c ON a.id_tipo_contrato = c.id_tipo_contrato
	WHERE a.id_empresa = @id_empresa
)
GO
/****** Object:  Table [contratos].[tb_tipos_penalidade]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_tipos_penalidade](
	[id_tipo_penalidade] [tinyint] IDENTITY(1,1) NOT NULL,
	[tipo_penalidade] [varchar](70) NULL,
	[ativo] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NULL,
	[usuario_alteracao] [char](7) NULL,
 CONSTRAINT [PK_tb_tipos_penalidade] PRIMARY KEY CLUSTERED 
(
	[id_tipo_penalidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_penalidade_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_tipo_penalidade_selecionar]
(	
	@ativo bit
)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_tipo_penalidade, tipo_penalidade, ativo, usuario_alteracao
	FROM [contratos].[tb_tipos_penalidade]
	WHERE ativo = @ativo
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_contrato_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_contrato_selecionar_por_id](@id_contrato int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_contrato
		 , a.id_empresa
		 , c.empresa
		 , a.id_tipo_contrato
		 , b.tipo_contrato
		 , a.numero_processo
		 , a.numero_ordem_servico
		 , CONVERT(VARCHAR, a.data_assinatura, 103) AS data_assinatura
		 , CONVERT(VARCHAR, a.data_inicio_vigencia, 103) AS data_inicio_vigencia
		 , CONVERT(VARCHAR, a.data_fim_vigencia, 103) AS data_fim_vigencia
		 , a.valor_global_inicial
		 , a.valor_global_atualizado
		 , a.objeto_contratual
		 , a.dia_pagamento
		 , a.dia_pagamento_corridos
		 , a.prazo_alerta_dias_pagamento
		 , a.prazo_alerta_dias_ateste
		 , a.prazo_alerta_dias_nota_fiscal
		 , a.prazo_alerta_meses_fim_vigencia
		 , a.ultima_alteracao
		 , a.usuario_alteracao
	FROM [contratos].[tb_contratos] a
		LEFT JOIN [contratos].[tb_tipos_contrato] b ON a.id_tipo_contrato = b.id_tipo_contrato
		LEFT JOIN [contratos].[tb_empresas] c ON a.id_empresa = c.id_empresa
	WHERE id_contrato = @id_contrato
)
GO
/****** Object:  Table [contratos].[tb_compromissos_siplo]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_compromissos_siplo](
	[id_compromisso_siplo] [int] IDENTITY(1,1) NOT NULL,
	[compromisso_siplo] [char](12) NOT NULL,
	[id_contrato] [int] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_compromissos_siplo] PRIMARY KEY CLUSTERED 
(
	[id_compromisso_siplo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_compromisso_siplo_selecionar_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_compromisso_siplo_selecionar_por_id_contrato]
(	
	@id_contrato int
)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_compromisso_siplo, compromisso_siplo, id_contrato
	FROM [contratos].[tb_compromissos_siplo]
	WHERE id_contrato = @id_contrato
)
GO
/****** Object:  Table [contratos].[tb_emails]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_emails](
	[id_email] [int] IDENTITY(1,1) NOT NULL,
	[id_empresa] [smallint] NOT NULL,
	[id_tipo_contato] [tinyint] NOT NULL,
	[email] [varchar](100) NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_emails] PRIMARY KEY CLUSTERED 
(
	[id_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [contratos].[tb_tipos_contato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_tipos_contato](
	[id_tipo_contato] [tinyint] IDENTITY(1,1) NOT NULL,
	[tipo_contato] [varchar](50) NOT NULL,
	[ativo] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [pk_id_tipo_contato] PRIMARY KEY CLUSTERED 
(
	[id_tipo_contato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_email_selecionar_por_id_empresa]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_email_selecionar_por_id_empresa](@id_empresa smallint)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_email, a.id_empresa, a.id_tipo_contato, b.tipo_contato, a.email
	FROM [contratos].[tb_emails] a
		LEFT JOIN [contratos].[tb_tipos_contato] b ON a.id_tipo_contato = b.id_tipo_contato
	WHERE id_empresa = @id_empresa
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_documento_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_tipo_documento_selecionar]
(	
	@ativo bit
)
RETURNS TABLE
AS
RETURN 
(
	/* manter a.id_dominio_documento por causa dos testes */
	SELECT a.id_tipo_documento, a.tipo_documento, a.possui_validade, a.id_dominio_documento, b.dominio_documento, a.ativo
	FROM [contratos].[tb_tipos_documento] a
		LEFT JOIN [contratos].[tb_dominios_documento] b ON a.id_dominio_documento = b.id_dominio_documento
	WHERE ativo = @ativo
)
GO
/****** Object:  Table [contratos].[tbr_contratos_tipos_penalidade]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tbr_contratos_tipos_penalidade](
	[id_contrato] [int] NOT NULL,
	[id_tipo_penalidade] [tinyint] NOT NULL,
 CONSTRAINT [PK_tbr_contratos_tipos_penalidade] PRIMARY KEY CLUSTERED 
(
	[id_contrato] ASC,
	[id_tipo_penalidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_penalidade_selecionar_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_tipo_penalidade_selecionar_por_id_contrato]
(	
	  @id_contrato int
	, @ativo bit
)
RETURNS TABLE
AS
RETURN 
(
	SELECT a.id_tipo_penalidade, a.tipo_penalidade, IIF(b.id_contrato IS NULL, 0, 1) checked
	FROM [contratos].[tb_tipos_penalidade] a
		LEFT JOIN [contratos].[tbr_contratos_tipos_penalidade] b ON a.id_tipo_penalidade = b.id_tipo_penalidade
																AND b.id_contrato = @id_contrato
	WHERE a.ativo = @ativo
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_unidade_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_unidade_selecionar]()
RETURNS TABLE
AS
RETURN 
(
	SELECT id_unidade, unidade
	FROM [contratos].[tb_unidades] a
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_dominio_documento_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_dominio_documento_selecionar]()
RETURNS TABLE
AS
RETURN 
(
	SELECT id_dominio_documento, dominio_documento
	FROM [contratos].[tb_dominios_documento]
)
GO
/****** Object:  Table [contratos].[tb_parcelas_siplo]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_parcelas_siplo](
	[id_parcela_siplo] [int] IDENTITY(1,1) NOT NULL,
	[id_ateste_pagamento] [int] NOT NULL,
	[valor] [decimal](19, 2) NOT NULL,
	[descricao] [varchar](8000) NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_valores_siplo] PRIMARY KEY CLUSTERED 
(
	[id_parcela_siplo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_parcela_siplo_selecionar_por_id_ateste_pagamento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_parcela_siplo_selecionar_por_id_ateste_pagamento]( @id_ateste_pagamento int )
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_parcela_siplo
		 , a.id_ateste_pagamento
		 , a.valor
		 , a.descricao
	FROM [contratos].[tb_parcelas_siplo] a
	WHERE a.id_ateste_pagamento = @id_ateste_pagamento
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_penalidade_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_tipo_penalidade_selecionar_por_id]
(	
	@id_tipo_penalidade tinyint
)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_tipo_penalidade, tipo_penalidade, ativo, usuario_alteracao
	FROM [contratos].[tb_tipos_penalidade]
	WHERE id_tipo_penalidade = @id_tipo_penalidade
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_parcela_siplo_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_parcela_siplo_selecionar_por_id]( @id_parcela_siplo int )
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_parcela_siplo
		 , a.id_ateste_pagamento
		 , a.valor
		 , a.descricao
	FROM [contratos].[tb_parcelas_siplo] a
	WHERE a.id_parcela_siplo = @id_parcela_siplo
)
GO
/****** Object:  Table [contratos].[tb_itens]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_itens](
	[id_item] [int] IDENTITY(1,1) NOT NULL,
	[item] [varchar](50) NOT NULL,
	[id_contrato] [int] NULL,
	[ativo] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_itens] PRIMARY KEY CLUSTERED 
(
	[id_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [contratos].[tb_subitens]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_subitens](
	[id_subitem] [int] IDENTITY(1,1) NOT NULL,
	[subitem] [varchar](50) NOT NULL,
	[id_item] [int] NOT NULL,
	[qtd] [int] NOT NULL,
	[valor_unitario] [decimal](19, 2) NOT NULL,
	[ativo] [bit] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_subitens] PRIMARY KEY CLUSTERED 
(
	[id_subitem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_item_subitem_selecionar_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_item_subitem_selecionar_por_id_contrato](@id_contrato int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_item, a.item, b.id_subitem, b.subitem, a.id_contrato, b.qtd, b.valor_unitario, a.ativo AS i_ativo, b.ativo AS s_ativo
	FROM [contratos].[tb_itens] a
	LEFT OUTER JOIN [contratos].[tb_subitens] b ON a.id_item = b.id_item
	WHERE a.id_contrato = @id_contrato
	AND b.id_subitem IS NOT NULL
	AND a.ativo = 1
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_contrato_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_tipo_contrato_selecionar_por_id]
(	
	@id_tipo_contrato tinyint
)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_tipo_contrato, tipo_contrato, ativo, usuario_alteracao
	FROM [contratos].[tb_tipos_contrato]
	WHERE id_tipo_contrato = @id_tipo_contrato
)
GO
/****** Object:  Table [contratos].[tb_funcoes]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_funcoes](
	[id_funcao] [smallint] NOT NULL,
	[funcao] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_funcoes] PRIMARY KEY CLUSTERED 
(
	[id_funcao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_funcao_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_funcao_selecionar]()
RETURNS TABLE
AS
RETURN 
(
	SELECT id_funcao, funcao
	FROM [contratos].[tb_funcoes]
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_perfil_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_perfil_selecionar]()
RETURNS TABLE
AS
RETURN 
(
	SELECT id_perfil, perfil
	FROM [contratos].[tb_perfis]
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_empresa_selecionar_por_cnpj]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_empresa_selecionar_por_cnpj](@cnpj bigint)
RETURNS TABLE
AS
RETURN
(
	SELECT id_empresa, empresa, cnpj, endereco, cidade, uf, cep, observacao, ativo, ultima_alteracao, usuario_alteracao
	FROM [contratos].[tb_empresas]
	WHERE cnpj = @cnpj
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_contrato_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_tipo_contrato_selecionar]
(	
	@ativo bit
)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_tipo_contrato, tipo_contrato, ativo, usuario_alteracao
	FROM [contratos].[tb_tipos_contrato]
	WHERE ativo = @ativo
)
GO
/****** Object:  Table [contratos].[tb_usuarios]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_usuarios](
	[id_usuario] [char](7) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[id_unidade] [smallint] NOT NULL,
	[id_funcao] [smallint] NOT NULL,
	[id_perfil] [tinyint] NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_usuarios] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_usuario_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_usuario_selecionar_por_id](
@id_usuario char(7)
)
RETURNS TABLE
AS
RETURN 
(
	SELECT a.id_usuario, a.nome, a.id_unidade, b.unidade, a.id_funcao, c.funcao, a.id_perfil, d.perfil
	FROM [contratos].[tb_usuarios] a
	LEFT JOIN [contratos].[tb_unidades] b ON a.id_unidade = b.id_unidade
	LEFT JOIN [contratos].[tb_funcoes] c ON a.id_funcao = c.id_funcao
	LEFT JOIN [contratos].[tb_perfis] d ON a.id_perfil = d.id_perfil
	WHERE a.id_usuario = @id_usuario
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_usuario_selecionar_por_perfil]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_usuario_selecionar_por_perfil](
@id_perfil tinyint
)
RETURNS TABLE
AS
RETURN 
(
	SELECT a.id_usuario, a.nome, a.id_unidade, b.unidade, a.id_funcao, c.funcao, a.id_perfil, d.perfil
	FROM [contratos].[tb_usuarios] a
	LEFT JOIN [contratos].[tb_unidades] b ON a.id_unidade = b.id_unidade
	LEFT JOIN [contratos].[tb_funcoes] c ON a.id_funcao = c.id_funcao
	LEFT JOIN [contratos].[tb_perfis] d ON a.id_perfil = d.id_perfil
	WHERE a.id_perfil = @id_perfil
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_empresa_selecionar_por_cnpj_nome]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_empresa_selecionar_por_cnpj_nome](@empresa varchar(200))
RETURNS TABLE
AS
RETURN
(
	SELECT id_empresa, empresa, cnpj, endereco, cidade, uf, cep, observacao, ativo, ultima_alteracao, usuario_alteracao
	FROM [contratos].[tb_empresas]
	WHERE empresa LIKE CONCAT('%', @empresa, '%')
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_usuario_selecionar_por_unidade]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_usuario_selecionar_por_unidade](
@id_unidade smallint
)
RETURNS TABLE
AS
RETURN 
(
	SELECT a.id_usuario, a.nome, a.id_unidade, b.unidade, a.id_funcao, c.funcao, a.id_perfil, d.perfil
	FROM [contratos].[tb_usuarios] a
	LEFT JOIN [contratos].[tb_unidades] b ON a.id_unidade = b.id_unidade
	LEFT JOIN [contratos].[tb_funcoes] c ON a.id_funcao = c.id_funcao
	LEFT JOIN [contratos].[tb_perfis] d ON a.id_perfil = d.id_perfil
	WHERE a.id_unidade = @id_unidade
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_ateste_pagamento_selecionar_competencias_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_ateste_pagamento_selecionar_competencias_por_id_contrato]( @id_contrato int )
RETURNS TABLE
AS
RETURN
(

	SELECT id_ateste_pagamento
		 , (CAST(mes AS varchar) + '/' + CAST(ano AS varchar)) competencia
	FROM [contratos].[tb_atestes_pagamento]
	WHERE id_contrato = @id_contrato
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_item_selecionar_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_item_selecionar_por_id_contrato](@id_contrato int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_item, a.item, a.id_contrato, a.ativo
	FROM [contratos].[tb_itens] a
	WHERE a.id_contrato = @id_contrato
	AND a.ativo = 1
)
GO
/****** Object:  Table [contratos].[tb_uf]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_uf](
	[uf] [char](2) NOT NULL,
	[nome_uf] [varchar](200) NOT NULL,
 CONSTRAINT [PK_tb_uf] PRIMARY KEY CLUSTERED 
(
	[uf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_uf_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_uf_selecionar]()
RETURNS TABLE
AS
RETURN 
(
	SELECT uf, nome_uf
	FROM [contratos].[tb_uf]
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_usuario_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_usuario_selecionar]()
RETURNS TABLE
AS
RETURN 
(
	SELECT a.id_usuario, a.nome, a.id_unidade, b.unidade, a.id_funcao, c.funcao, a.id_perfil, d.perfil
	FROM [contratos].[tb_usuarios] a
	LEFT JOIN [contratos].[tb_unidades] b ON a.id_unidade = b.id_unidade
	LEFT JOIN [contratos].[tb_funcoes] c ON a.id_funcao = c.id_funcao
	LEFT JOIN [contratos].[tb_perfis] d ON a.id_perfil = d.id_perfil
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_funcao_selecionar_por_id]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_funcao_selecionar_por_id](@id_funcao smallint)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_funcao, funcao
	FROM [contratos].[tb_funcoes]
	WHERE id_funcao = @id_funcao
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_ateste_pagamento_selecionar_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_ateste_pagamento_selecionar_por_id_contrato](@id_contrato int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_ateste_pagamento, a.id_contrato, a.ano, a.mes, a.observacao
	FROM [contratos].[tb_atestes_pagamento] a
	WHERE a.id_contrato = @id_contrato
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_subitem_selecionar_por_id_item]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_subitem_selecionar_por_id_item](@id_item int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_subitem, a.subitem, a.id_item, a.qtd, a.valor_unitario, a.ativo
	FROM [contratos].[tb_subitens] a
	WHERE a.id_item = @id_item
	AND a.ativo = 1
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_subitem_selecionar_por_id_contrato]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_subitem_selecionar_por_id_contrato](@id_contrato int)
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_subitem, a.subitem, a.id_item, a.qtd, a.valor_unitario, b.id_contrato, a.ativo
	FROM [contratos].[tb_subitens] a
	LEFT JOIN [contratos].[tb_itens] b ON a.id_item = b.id_item
	WHERE b.id_contrato = @id_contrato
	AND a.ativo = 1
)
GO
/****** Object:  Table [contratos].[tb_atestes]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_atestes](
	[id_ateste] [int] IDENTITY(1,1) NOT NULL,
	[id_ateste_pagamento] [int] NOT NULL,
	[id_subitem] [int] NOT NULL,
	[qtd] [int] NULL,
	[valor] [decimal](19, 2) NULL,
	[qtd_paga_competencia] [int] NULL,
	[valor_pago_competencia] [decimal](19, 2) NULL,
	[existe_acerto] [bit] NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
	[atestado_gestor_operacional] [bit] NOT NULL,
 CONSTRAINT [PK_tb_atestes] PRIMARY KEY CLUSTERED 
(
	[id_ateste] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_ateste_selecionar_por_id_ateste_pagamento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_ateste_selecionar_por_id_ateste_pagamento]( @id_ateste_pagamento int )
RETURNS TABLE
AS
RETURN
(
	SELECT a.id_ateste
		 , c.id_item
		 , c.item
		 , a.id_subitem
		 , b.subitem
		 , a.qtd
		 , a.valor
		 , a.atestado_gestor_operacional
	FROM [contratos].[tb_atestes] a
		LEFT JOIN [contratos].[tb_subitens] b ON a.id_subitem = b.id_subitem
		LEFT JOIN [contratos].[tb_itens] c ON b.id_item = c.id_item
	WHERE a.id_ateste_pagamento = @id_ateste_pagamento
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_tipo_contato_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_tipo_contato_selecionar]
(	
	@ativo bit
)
RETURNS TABLE
AS
RETURN 
(
	SELECT id_tipo_contato, tipo_contato, ativo, usuario_alteracao
	FROM [contratos].[tb_tipos_contato]
	WHERE ativo = @ativo
)
GO
/****** Object:  UserDefinedFunction [contratos].[fn_empresa_selecionar]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [contratos].[fn_empresa_selecionar](@ativo bit)
RETURNS TABLE
AS
RETURN
(
	SELECT id_empresa, empresa, cnpj, endereco, cidade, uf, cep, observacao, ultima_alteracao, usuario_alteracao, ativo
	FROM [contratos].[tb_empresas]
	WHERE ativo = @ativo
)
GO
/****** Object:  Table [contratos].[tb_telefones]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_telefones](
	[id_telefone] [int] IDENTITY(1,1) NOT NULL,
	[id_empresa] [smallint] NOT NULL,
	[id_tipo_contato] [tinyint] NOT NULL,
	[telefone] [varchar](11) NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_telefones] PRIMARY KEY CLUSTERED 
(
	[id_telefone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [contratos].[fn_telefone_selecionar_por_id_empresa]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [contratos].[fn_telefone_selecionar_por_id_empresa](@id_empresa smallint)
RETURNS TABLE
AS
RETURN
(
	/* não retirar id_tipo_contato senão quebram os testes*/
	SELECT a.id_telefone, a.id_empresa, a.id_tipo_contato, b.tipo_contato, a.telefone
	FROM [contratos].[tb_telefones]	a
		LEFT JOIN [contratos].[tb_tipos_contato] b ON a.id_tipo_contato = b.id_tipo_contato
	WHERE id_empresa = @id_empresa
)
GO
/****** Object:  Table [contratos].[tb_acertos]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_acertos](
	[id_acerto] [int] IDENTITY(1,1) NOT NULL,
	[id_ateste_pagamento] [int] NOT NULL,
	[id_ateste] [int] NOT NULL,
	[qtd] [int] NOT NULL,
	[valor] [decimal](19, 2) NOT NULL,
	[ultima_alteracao] [datetime2](3) NOT NULL,
	[usuario_alteracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_acertos] PRIMARY KEY CLUSTERED 
(
	[id_acerto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [contratos].[tb_historico_atestes]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_historico_atestes](
	[id_historico_ateste] [int] IDENTITY(1,1) NOT NULL,
	[id_ateste_pagamento] [int] NOT NULL,
	[id_ateste] [int] NOT NULL,
	[data_hora] [datetime2](3) NOT NULL,
	[id_usuario] [char](7) NOT NULL,
	[qtd] [int] NOT NULL,
	[valor] [decimal](19, 2) NOT NULL,
	[qtd_paga_competencia] [int] NULL,
	[valor_pago_competencia] [decimal](19, 2) NULL,
	[atestado_gestor_operacional] [bit] NOT NULL,
 CONSTRAINT [PK_tb_historico_atestes] PRIMARY KEY CLUSTERED 
(
	[id_historico_ateste] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [contratos].[tb_historico_atestes_pagamento]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_historico_atestes_pagamento](
	[id_historico_ateste_pagamento] [int] IDENTITY(1,1) NOT NULL,
	[id_ateste_pagamento] [int] NOT NULL,
	[data_hora] [datetime2](3) NOT NULL,
	[valor] [decimal](19, 2) NOT NULL,
	[usuario_alterracao] [char](7) NOT NULL,
 CONSTRAINT [PK_tb_historico_atestes_pagamento] PRIMARY KEY CLUSTERED 
(
	[id_historico_ateste_pagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [contratos].[tb_penalidades]    Script Date: 11/12/2020 17:48:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [contratos].[tb_penalidades](
	[id_penalidade] [int] NOT NULL,
 CONSTRAINT [PK_tb_penalidades] PRIMARY KEY CLUSTERED 
(
	[id_penalidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [contratos].[tb_acertos] ON 

INSERT [contratos].[tb_acertos] ([id_acerto], [id_ateste_pagamento], [id_ateste], [qtd], [valor], [ultima_alteracao], [usuario_alteracao]) VALUES (1, 10, 1, 1, CAST(1000.00 AS Decimal(19, 2)), CAST(N'2020-12-10T00:00:00.0000000' AS DateTime2), N'c109724')
SET IDENTITY_INSERT [contratos].[tb_acertos] OFF
SET IDENTITY_INSERT [contratos].[tb_atestes] ON 

INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (1, 4, 10, 30, CAST(22500.00 AS Decimal(19, 2)), 13, CAST(50000.00 AS Decimal(19, 2)), 1, CAST(N'2020-12-07T16:44:46.7400000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (2, 4, 11, 110, CAST(14230.13 AS Decimal(19, 2)), 100, CAST(30000.00 AS Decimal(19, 2)), 1, CAST(N'2020-12-07T10:22:01.1770000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (3, 4, 12, 18, CAST(2.00 AS Decimal(19, 2)), NULL, NULL, 0, CAST(N'2020-12-07T10:10:58.1230000' AS DateTime2), N'C137703', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (4, 4, 13, 25000, NULL, NULL, NULL, 0, CAST(N'2020-12-04T09:53:28.4170000' AS DateTime2), N'C137703', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (5, 4, 17, 15600, CAST(16500.52 AS Decimal(19, 2)), NULL, NULL, 0, CAST(N'2020-12-08T13:49:31.5630000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (6, 5, 4, 18252, CAST(18451.23 AS Decimal(19, 2)), NULL, NULL, 0, CAST(N'2020-12-08T10:01:58.3400000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (7, 5, 18, NULL, NULL, NULL, NULL, 0, CAST(N'2020-12-03T14:09:09.2500000' AS DateTime2), N'S000000', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (8, 6, 7, NULL, NULL, NULL, NULL, 0, CAST(N'2020-12-03T14:09:09.2500000' AS DateTime2), N'S000000', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (9, 7, 5, NULL, NULL, NULL, NULL, 0, CAST(N'2020-12-03T14:09:09.2500000' AS DateTime2), N'S000000', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (10, 7, 6, NULL, NULL, NULL, NULL, 0, CAST(N'2020-12-03T14:09:09.2500000' AS DateTime2), N'S000000', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (11, 8, 14, NULL, NULL, NULL, NULL, 0, CAST(N'2020-12-03T14:09:09.2500000' AS DateTime2), N'S000000', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (12, 10, 15, NULL, NULL, NULL, NULL, 0, CAST(N'2020-12-03T14:09:09.2500000' AS DateTime2), N'S000000', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (13, 10, 16, NULL, NULL, NULL, NULL, 0, CAST(N'2020-12-03T14:09:09.2500000' AS DateTime2), N'S000000', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (19, 11, 4, 1000, CAST(100000.00 AS Decimal(19, 2)), NULL, NULL, 0, CAST(N'2020-11-01T00:00:00.0000000' AS DateTime2), N'C137703', 0)
INSERT [contratos].[tb_atestes] ([id_ateste], [id_ateste_pagamento], [id_subitem], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [existe_acerto], [ultima_alteracao], [usuario_alteracao], [atestado_gestor_operacional]) VALUES (21, 12, 4, 1500, CAST(1500.00 AS Decimal(19, 2)), NULL, NULL, 0, CAST(N'2020-10-01T00:00:00.0000000' AS DateTime2), N'C137703', 0)
SET IDENTITY_INSERT [contratos].[tb_atestes] OFF
SET IDENTITY_INSERT [contratos].[tb_atestes_pagamento] ON 

INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (1, 1, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (2, 2, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (3, 3, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (4, 4, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (5, 5, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (6, 6, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (7, 7, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (8, 8, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (9, 9, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (10, 10, 2020, 12, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (11, 5, 2020, 11, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (12, 5, 2020, 10, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (13, 5, 2020, 9, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (14, 5, 2020, 8, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (15, 5, 2020, 7, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (16, 5, 2020, 6, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (17, 5, 2020, 5, NULL, 0, NULL, NULL)
INSERT [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento], [id_contrato], [ano], [mes], [observacao], [pago], [ultima_alteracao], [usuario_alteracao]) VALUES (18, 5, 2020, 4, NULL, 0, NULL, NULL)
SET IDENTITY_INSERT [contratos].[tb_atestes_pagamento] OFF
SET IDENTITY_INSERT [contratos].[tb_compromissos_siplo] ON 

INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (2, N'1234562018MZ', 1, CAST(N'2020-11-18T21:06:52.1230000' AS DateTime2), N'c110611')
INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (3, N'9876542020SP', 1, CAST(N'2020-11-19T10:06:03.0230000' AS DateTime2), N'c110611')
INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (9, N'222222/2222-', 5, CAST(N'2020-11-20T14:39:12.3800000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (10, N'6666666666ZM', 6, CAST(N'2020-11-20T14:41:58.1100000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (11, N'5555555555MM', 1, CAST(N'2020-11-24T14:57:35.1530000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (14, N'0123451999MZ', 4, CAST(N'2020-11-30T15:01:50.4070000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (15, N'0123452000BR', 4, CAST(N'2020-11-30T15:08:28.5630000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_compromissos_siplo] ([id_compromisso_siplo], [compromisso_siplo], [id_contrato], [ultima_alteracao], [usuario_alteracao]) VALUES (16, N'7777772020MZ', 4, CAST(N'2020-12-07T09:10:40.5200000' AS DateTime2), N'       ')
SET IDENTITY_INSERT [contratos].[tb_compromissos_siplo] OFF
SET IDENTITY_INSERT [contratos].[tb_contratos] ON 

INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (1, 33, 1, N'123456', 999999, NULL, CAST(N'2020-01-01' AS Date), CAST(N'2025-01-01' AS Date), CAST(1000000.00 AS Decimal(19, 2)), NULL, N'Objeto X', 1, NULL, 10, 10, 10, 10, CAST(N'2020-11-14T14:56:22.2330000' AS DateTime2), N'c110611', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (2, 33, 2, N'555555', 999999, CAST(N'2020-01-01' AS Date), CAST(N'2020-01-01' AS Date), CAST(N'2025-01-01' AS Date), CAST(10.00 AS Decimal(19, 2)), CAST(20.99 AS Decimal(19, 2)), N'Objeto Ação', 1, 0, 10, 10, 10, 10, CAST(N'2020-11-20T10:50:58.8000000' AS DateTime2), N'c110611', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (3, 33, 3, N'555555', 999999, CAST(N'2020-01-01' AS Date), CAST(N'2020-01-01' AS Date), CAST(N'2025-01-01' AS Date), CAST(10.00 AS Decimal(19, 2)), CAST(20.99 AS Decimal(19, 2)), N'Objeto XPTO', 1, 0, 10, 10, 10, 10, CAST(N'2020-11-18T19:02:29.2530000' AS DateTime2), N'c110611', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (4, 2, 2, N'123', 789, CAST(N'2018-01-01' AS Date), CAST(N'2018-01-10' AS Date), CAST(N'2023-01-01' AS Date), CAST(1600000.00 AS Decimal(19, 2)), NULL, N'PROGRAMA DE PONTOS ação ÀÁÃÂÄ@#$%&*', 12, 0, 13, 13, 15, 8, CAST(N'2020-11-30T10:58:15.4900000' AS DateTime2), N'C110611', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (5, 2, 5, N'858512', 46, CAST(N'2017-05-12' AS Date), CAST(N'2017-05-14' AS Date), CAST(N'2028-05-01' AS Date), CAST(2400000.00 AS Decimal(19, 2)), NULL, N'CONTRATAÃ‡ÃƒO', 8, 0, 2, 8, 17, 10, CAST(N'2020-11-30T10:25:53.8970000' AS DateTime2), N'C110611', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (6, 2, 4, N'56784', 36959, CAST(N'2018-09-12' AS Date), CAST(N'2018-09-15' AS Date), CAST(N'2025-09-01' AS Date), CAST(18000.00 AS Decimal(19, 2)), NULL, N'ATENDIMENTO JURÃDICO', 2, 1, 5, 6, 10, 12, CAST(N'2020-11-20T08:19:26.7030000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (7, 2, 4, N'8989', 12, CAST(N'2020-07-30' AS Date), CAST(N'2020-08-15' AS Date), CAST(N'2022-08-19' AS Date), CAST(170000.00 AS Decimal(19, 2)), NULL, N'ATENDIMENTO SIACH', 8, 1, 5, 6, 8, 9, CAST(N'2020-11-20T08:21:57.1970000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (8, 2, 4, N'26546', 615464, CAST(N'2020-06-06' AS Date), CAST(N'2020-06-06' AS Date), CAST(N'2020-06-06' AS Date), CAST(1700000.00 AS Decimal(19, 2)), NULL, N'dfhgfjhk', 6, 1, 1, 7, 14, 12, CAST(N'2020-11-20T08:27:15.2070000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (9, 2, 1, N'986532', 26, CAST(N'2018-06-26' AS Date), CAST(N'2020-06-26' AS Date), CAST(N'2026-06-26' AS Date), CAST(250000.00 AS Decimal(19, 2)), NULL, N'oibnsoighpidsbhgfpvndskllcvnadldg', 1, 1, 8, 9, 10, 10, CAST(N'2020-11-20T08:29:50.3800000' AS DateTime2), N'C137703', 1)
INSERT [contratos].[tb_contratos] ([id_contrato], [id_empresa], [id_tipo_contrato], [numero_processo], [numero_ordem_servico], [data_assinatura], [data_inicio_vigencia], [data_fim_vigencia], [valor_global_inicial], [valor_global_atualizado], [objeto_contratual], [dia_pagamento], [dia_pagamento_corridos], [prazo_alerta_dias_pagamento], [prazo_alerta_dias_ateste], [prazo_alerta_dias_nota_fiscal], [prazo_alerta_meses_fim_vigencia], [ultima_alteracao], [usuario_alteracao], [ativo]) VALUES (10, 2, 1, N'756512', 89, CAST(N'2018-02-20' AS Date), CAST(N'2018-02-26' AS Date), CAST(N'2027-02-01' AS Date), CAST(900000.00 AS Decimal(19, 2)), NULL, N'ATENDIMENTO Ã“RGÃƒOS REGULADORES.', 10, 0, 1, 28, 28, 2, CAST(N'2020-11-20T11:53:01.3930000' AS DateTime2), N'C137703', 1)
SET IDENTITY_INSERT [contratos].[tb_contratos] OFF
SET IDENTITY_INSERT [contratos].[tb_documentos] ON 

INSERT [contratos].[tb_documentos] ([id_documento], [id_tipo_documento], [id_empresa], [id_contrato], [id_ateste_pagamento], [id_penalidade], [data_validade], [nome_documento], [ultima_alteracao], [usuario_alteracao], [observacao]) VALUES (1, 18, NULL, 4, NULL, NULL, NULL, N'cip_linx.7z', CAST(N'2020-12-03T10:40:43.7900000' AS DateTime2), N'C137703', N'KHGUYFYTDS')
INSERT [contratos].[tb_documentos] ([id_documento], [id_tipo_documento], [id_empresa], [id_contrato], [id_ateste_pagamento], [id_penalidade], [data_validade], [nome_documento], [ultima_alteracao], [usuario_alteracao], [observacao]) VALUES (2, 18, NULL, 4, NULL, NULL, NULL, N'cip_linx2.7z', CAST(N'2020-12-03T10:51:50.3530000' AS DateTime2), N'C137703', N'ghtrjhhkk')
INSERT [contratos].[tb_documentos] ([id_documento], [id_tipo_documento], [id_empresa], [id_contrato], [id_ateste_pagamento], [id_penalidade], [data_validade], [nome_documento], [ultima_alteracao], [usuario_alteracao], [observacao]) VALUES (3, 5, 2, NULL, NULL, NULL, NULL, N'20051600164058272379055_ruroiwoirwirwioooiwoeriweorwri.7z', CAST(N'2020-12-03T11:46:41.5830000' AS DateTime2), N'C110611', N'ação')
INSERT [contratos].[tb_documentos] ([id_documento], [id_tipo_documento], [id_empresa], [id_contrato], [id_ateste_pagamento], [id_penalidade], [data_validade], [nome_documento], [ultima_alteracao], [usuario_alteracao], [observacao]) VALUES (4, 15, 2, NULL, NULL, NULL, NULL, N'XPTO.7z', CAST(N'2020-12-03T11:58:38.9270000' AS DateTime2), N'C110611', N'ação')
SET IDENTITY_INSERT [contratos].[tb_documentos] OFF
INSERT [contratos].[tb_dominios_documento] ([id_dominio_documento], [dominio_documento]) VALUES (1, N'EMPRESA')
INSERT [contratos].[tb_dominios_documento] ([id_dominio_documento], [dominio_documento]) VALUES (2, N'CONTRATO')
INSERT [contratos].[tb_dominios_documento] ([id_dominio_documento], [dominio_documento]) VALUES (3, N'ATESTE')
INSERT [contratos].[tb_dominios_documento] ([id_dominio_documento], [dominio_documento]) VALUES (4, N'PENALIDADE')
SET IDENTITY_INSERT [contratos].[tb_emails] ON 

INSERT [contratos].[tb_emails] ([id_email], [id_empresa], [id_tipo_contato], [email], [ultima_alteracao], [usuario_alteracao]) VALUES (6, 32, 9, N'teste@teste.com', CAST(N'2020-11-11T17:31:49.1100000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_emails] ([id_email], [id_empresa], [id_tipo_contato], [email], [ultima_alteracao], [usuario_alteracao]) VALUES (7, 32, 10, N'teste3@teste.com', CAST(N'2020-11-11T20:37:16.0600000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_emails] ([id_email], [id_empresa], [id_tipo_contato], [email], [ultima_alteracao], [usuario_alteracao]) VALUES (8, 32, 56, N'teste4@teste.com', CAST(N'2020-11-13T20:32:51.7170000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_emails] OFF
SET IDENTITY_INSERT [contratos].[tb_empresas] ON 

INSERT [contratos].[tb_empresas] ([id_empresa], [empresa], [cnpj], [endereco], [cidade], [uf], [cep], [observacao], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (1, N'CAIXA', 360305000104, N'SAUS 3/4', N'BRASÍLIA', N'DF', 77000100, N'Observação.', 0, CAST(N'2020-11-06T09:21:22.5500000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_empresas] ([id_empresa], [empresa], [cnpj], [endereco], [cidade], [uf], [cep], [observacao], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (2, N'ORBITALL ATENDIMENTO LTDA', 18081219000128, N'XQD 6 RUA 5 EDIFICIO', N'BRASÍLIA', N'DF', 78282300, N'Observação.', 1, CAST(N'2020-11-09T11:15:16.8030000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_empresas] ([id_empresa], [empresa], [cnpj], [endereco], [cidade], [uf], [cep], [observacao], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (30, N'AÇÃO', 85377365000192, N'RUA JOÃO XXIII', N'SÃO PAULO', N'DF', 12312312, N'', 1, CAST(N'2020-11-11T16:54:53.7970000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_empresas] ([id_empresa], [empresa], [cnpj], [endereco], [cidade], [uf], [cep], [observacao], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (31, N'ÁÂÀÃÕÇÄÄÚÛÙÉÊÈ', 88567762000115, N'ÁÂÀÃÕÇÄÄÚÛÙÉÊÈ', N'ÁÂÀÃÕÇÄÄÚÛÙÉÊÈ', N'DF', 12312312, N'ÁÂÀÃÕÇÄÄÚÛÙÉÊÈ', 0, CAST(N'2020-11-12T12:09:20.6330000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_empresas] ([id_empresa], [empresa], [cnpj], [endereco], [cidade], [uf], [cep], [observacao], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (32, N'ÕÓÒÖÔÇ', 18458571000130, N'ÕÓÒÖÔÇ', N'ÕÓÒÖÔÇ', N'DF', 40935931, N'ÕÓÒÖÔÇ', 1, CAST(N'2020-11-12T13:17:57.5530000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_empresas] ([id_empresa], [empresa], [cnpj], [endereco], [cidade], [uf], [cep], [observacao], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (33, N'Empresa ÉÊÈÊËÍÌÎÏ', 78792772000109, N'ÉÊÈÊËÍÌÎÏ', N'ÉÊÈÊËÍÌÎÏ', N'DF', 12345678, N'ÉÊÈÊËÍÌÎÏ', 1, CAST(N'2020-11-17T15:53:30.1830000' AS DateTime2), N'c110611')
INSERT [contratos].[tb_empresas] ([id_empresa], [empresa], [cnpj], [endereco], [cidade], [uf], [cep], [observacao], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (34, N'EMPRESA 2', 84580234000145, N'RUA JOÃO XXIII', N'SÃO PAULO', N'SP', 23131313, N'Rua João XXIII', 1, CAST(N'2020-11-24T16:48:10.2070000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_empresas] OFF
INSERT [contratos].[tb_funcoes] ([id_funcao], [funcao]) VALUES (1234, N'ASSISTENTE JUNIOR')
INSERT [contratos].[tb_funcoes] ([id_funcao], [funcao]) VALUES (2222, N'ASSISTENTE SENIOR')
INSERT [contratos].[tb_funcoes] ([id_funcao], [funcao]) VALUES (3333, N'GERENTE')
INSERT [contratos].[tb_funcoes] ([id_funcao], [funcao]) VALUES (9999, N'ASSISTENTE PLENO')
SET IDENTITY_INSERT [contratos].[tb_historico_atestes] ON 

INSERT [contratos].[tb_historico_atestes] ([id_historico_ateste], [id_ateste_pagamento], [id_ateste], [data_hora], [id_usuario], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [atestado_gestor_operacional]) VALUES (3, 11, 19, CAST(N'2020-11-01T00:00:00.0000000' AS DateTime2), N'C137703', 1000, CAST(100000.00 AS Decimal(19, 2)), NULL, NULL, 0)
INSERT [contratos].[tb_historico_atestes] ([id_historico_ateste], [id_ateste_pagamento], [id_ateste], [data_hora], [id_usuario], [qtd], [valor], [qtd_paga_competencia], [valor_pago_competencia], [atestado_gestor_operacional]) VALUES (4, 12, 21, CAST(N'2020-10-01T00:00:00.0000000' AS DateTime2), N'C137703', 1500, CAST(1500.00 AS Decimal(19, 2)), NULL, NULL, 0)
SET IDENTITY_INSERT [contratos].[tb_historico_atestes] OFF
SET IDENTITY_INSERT [contratos].[tb_itens] ON 

INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (1, N'ITEM ABC', 4, 0, CAST(N'2020-11-25T10:11:31.3070000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (2, N'ITEM DEF', 7, 1, CAST(N'2020-11-25T10:12:57.1070000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (3, N'ITEM 123', 5, 1, CAST(N'2020-11-25T10:21:12.6530000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (4, N'ITEM 456', 2, 0, CAST(N'2020-11-25T10:22:09.8300000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (5, N'ATENDIMENTO SAC', 4, 1, CAST(N'2020-11-25T13:47:12.5230000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (6, N'ITEM DEF', 4, 1, CAST(N'2020-11-25T13:50:46.0070000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (7, N'ITEM HHH', 4, 0, CAST(N'2020-11-25T13:55:40.5000000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (8, N'ITEM 123', 9, 0, CAST(N'2020-11-25T13:56:21.6270000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (9, N'ABCDEF', 4, 1, CAST(N'2020-11-27T12:14:57.1970000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (10, N'GHI', 4, 1, CAST(N'2020-11-26T13:50:40.9400000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (11, N'FGG', 4, 1, CAST(N'2020-11-26T13:51:53.8070000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (12, N'IUIRFHJKM', 4, 1, CAST(N'2020-11-26T13:52:38.8600000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (13, N'XPTO', 4, 1, CAST(N'2020-11-26T14:00:00.6800000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (14, N'POUJOSDHGFUIGBF', 4, 1, CAST(N'2020-11-26T14:00:28.3370000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (15, N'JIM', 4, 0, CAST(N'2020-11-26T14:02:10.4870000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (16, N'ITEM ABC', 5, 1, CAST(N'2020-11-26T14:10:09.1730000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (17, N'ITEM DEF', 5, 1, CAST(N'2020-11-26T14:11:31.4700000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (18, N'ITEM GHI', 5, 1, CAST(N'2020-11-26T14:12:36.7200000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (19, N'ITEM ABC', 7, 1, CAST(N'2020-11-26T14:24:11.4530000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (20, N'ITEM ABC', 6, 1, CAST(N'2020-11-26T14:26:31.1600000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (21, N'ÁÀÂÃÄ', 4, 0, CAST(N'2020-11-26T14:50:53.9770000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (22, N'AÇÃOXXX', 5, 1, CAST(N'2020-11-27T09:35:39.6830000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (23, N'ATENDIMENTO SAC	', 4, 0, CAST(N'2020-11-27T09:55:12.7000000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (24, N'ITEM DEF', 6, 1, CAST(N'2020-11-27T13:43:47.0200000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (25, N'ITEM GHI', 6, 1, CAST(N'2020-11-27T13:45:58.8900000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (26, N'ITEM BBB', 5, 1, CAST(N'2020-11-27T13:50:32.4830000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (27, N'ITEM 457', 4, 1, CAST(N'2020-11-27T13:51:10.6530000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (28, N'ITEM 888', 4, 0, CAST(N'2020-11-27T13:52:42.8630000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (29, N'ITEM 722', 4, 1, CAST(N'2020-11-27T13:57:42.5400000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (30, N'ITEM 123', 8, 1, CAST(N'2020-11-27T14:04:02.5330000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (31, N'ITEM 456', 8, 1, CAST(N'2020-11-27T14:04:52.3870000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (32, N'ITEM DEF', 8, 1, CAST(N'2020-11-27T14:05:47.7530000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (33, N'ITEM 123', 10, 1, CAST(N'2020-11-27T14:06:26.5730000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (34, N'ITEM 456', 10, 1, CAST(N'2020-11-27T14:12:05.6300000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (35, N'LOREM IPSUM DOLOR SIT AMET CONSECTETUR ADIPISCING ', 4, 0, CAST(N'2020-11-30T11:05:06.8470000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (36, N'ZZZ', 4, 1, CAST(N'2020-11-30T11:07:24.4270000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_itens] ([id_item], [item], [id_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (37, N'WWW', 4, 1, CAST(N'2020-12-01T15:43:12.0500000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_itens] OFF
SET IDENTITY_INSERT [contratos].[tb_parcelas_siplo] ON 

INSERT [contratos].[tb_parcelas_siplo] ([id_parcela_siplo], [id_ateste_pagamento], [valor], [descricao], [ultima_alteracao], [usuario_alteracao]) VALUES (8, 4, CAST(14500.00 AS Decimal(19, 2)), N'Parcela 123', CAST(N'2020-12-09T14:40:47.6100000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_parcelas_siplo] ([id_parcela_siplo], [id_ateste_pagamento], [valor], [descricao], [ultima_alteracao], [usuario_alteracao]) VALUES (9, 5, CAST(21500.60 AS Decimal(19, 2)), N'Parcela 123', CAST(N'2020-12-09T14:47:22.6970000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_parcelas_siplo] ([id_parcela_siplo], [id_ateste_pagamento], [valor], [descricao], [ultima_alteracao], [usuario_alteracao]) VALUES (11, 5, CAST(250.00 AS Decimal(19, 2)), N'Parcela 789', CAST(N'2020-12-09T15:19:22.0730000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_parcelas_siplo] ([id_parcela_siplo], [id_ateste_pagamento], [valor], [descricao], [ultima_alteracao], [usuario_alteracao]) VALUES (12, 5, CAST(156000.45 AS Decimal(19, 2)), N'REPACTUAÇÃO 11/2020', CAST(N'2020-12-09T15:46:16.0830000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_parcelas_siplo] ([id_parcela_siplo], [id_ateste_pagamento], [valor], [descricao], [ultima_alteracao], [usuario_alteracao]) VALUES (13, 5, CAST(56489.49 AS Decimal(19, 2)), N'fgfdgfgv', CAST(N'2020-12-09T16:06:20.9670000' AS DateTime2), N'C137703')
SET IDENTITY_INSERT [contratos].[tb_parcelas_siplo] OFF
SET IDENTITY_INSERT [contratos].[tb_perfis] ON 

INSERT [contratos].[tb_perfis] ([id_perfil], [perfil]) VALUES (1, N'ATESTE - GESTOR OPERACIONAL')
INSERT [contratos].[tb_perfis] ([id_perfil], [perfil]) VALUES (2, N'ADMINISTRADOR')
INSERT [contratos].[tb_perfis] ([id_perfil], [perfil]) VALUES (3, N'CONTRATOS')
INSERT [contratos].[tb_perfis] ([id_perfil], [perfil]) VALUES (4, N'ATESTE  PAGAMENTOS')
SET IDENTITY_INSERT [contratos].[tb_perfis] OFF
SET IDENTITY_INSERT [contratos].[tb_subitens] ON 

INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (1, N'SUBITEM 123 DÉBITO', 5, 56000, CAST(890000.00 AS Decimal(19, 2)), 0, CAST(N'2020-11-26T11:39:45.2500000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (2, N'SUBITEM 123 DÉBITO', 17, 56000, CAST(89000.00 AS Decimal(19, 2)), 0, CAST(N'2020-11-26T14:14:01.9870000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (3, N'DEFREHGT', 17, 5456, CAST(2654.45 AS Decimal(19, 2)), 0, CAST(N'2020-11-26T14:16:06.4130000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (4, N'SUBITEM 123 DÉBITO', 18, 56, CAST(89.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-26T14:22:32.7300000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (5, N'SUBITEM 123 DÉBITO', 19, 56, CAST(89.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-26T14:24:41.8830000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (6, N'SUBITEM 123 DÉBITO', 2, 89787, CAST(15000.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-26T14:25:07.8800000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (7, N'SUBITEM 123 DÉBITO', 20, 89561, CAST(60000.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-26T14:27:10.4330000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (8, N'ITEM ÓEÇÁ', 20, 56487, CAST(2600.06 AS Decimal(19, 2)), 0, CAST(N'2020-11-26T14:29:47.7130000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (9, N'INSERT INTO [CONTRATOS].[TB_UF] VALUES(XX,XXXX)', 5, 20, CAST(50.00 AS Decimal(19, 2)), 0, CAST(N'2020-11-27T11:22:12.0500000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (10, N'!@#$%&*TESTE{}ªº°¹²³£¢', 6, 50, CAST(999999999999.99 AS Decimal(19, 2)), 1, CAST(N'2020-11-27T11:23:44.0370000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (11, N'ZZZ', 6, 100000, CAST(1.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-27T12:10:03.1270000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (12, N'AAA', 9, 10, CAST(20.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-27T12:10:34.1730000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (13, N'BBB', 9, 888888888, CAST(888888888888.88 AS Decimal(19, 2)), 1, CAST(N'2020-11-27T12:10:48.1830000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (14, N'SUBITEM 123 DÉBITO', 30, 22, CAST(448.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-27T14:04:19.7070000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (15, N'SUBITEM 123', 33, 22456, CAST(44856.26 AS Decimal(19, 2)), 1, CAST(N'2020-11-27T14:06:56.9100000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (16, N'SUBITEM DEF', 33, 8899, CAST(4563.25 AS Decimal(19, 2)), 1, CAST(N'2020-11-27T14:08:02.8800000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (17, N'SUBITEM1', 5, 100000, CAST(1.00 AS Decimal(19, 2)), 1, CAST(N'2020-11-30T09:40:47.6430000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (18, N'ZZZ', 18, 250000, CAST(1.99 AS Decimal(19, 2)), 1, CAST(N'2020-11-30T09:44:54.8370000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (19, N'SUBITEM111', 35, 50000, CAST(5.99 AS Decimal(19, 2)), 0, CAST(N'2020-11-30T11:11:45.5500000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (20, N'DOLOR SIT AMET CONSECTETUR ADIPISCING LOREM IPSUM', 35, 9999, CAST(4.99 AS Decimal(19, 2)), 0, CAST(N'2020-11-30T11:14:07.2600000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (21, N'SUBITEM3', 35, 10000, CAST(1.55 AS Decimal(19, 2)), 0, CAST(N'2020-11-30T11:20:00.0730000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (22, N'SUBITEM4', 35, 80001, CAST(1.56 AS Decimal(19, 2)), 0, CAST(N'2020-11-30T11:21:42.4900000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (23, N'SUBITEM5', 35, 888, CAST(1.23 AS Decimal(19, 2)), 0, CAST(N'2020-11-30T11:24:10.6970000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (24, N'SUBITEM6', 35, 6666, CAST(6.66 AS Decimal(19, 2)), 0, CAST(N'2020-11-30T11:26:11.0670000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_subitens] ([id_subitem], [subitem], [id_item], [qtd], [valor_unitario], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (25, N'SUBITEM7', 35, 7777, CAST(7.77 AS Decimal(19, 2)), 0, CAST(N'2020-11-30T11:32:55.1370000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_subitens] OFF
SET IDENTITY_INSERT [contratos].[tb_telefones] ON 

INSERT [contratos].[tb_telefones] ([id_telefone], [id_empresa], [id_tipo_contato], [telefone], [ultima_alteracao], [usuario_alteracao]) VALUES (11, 31, 8, N'12321321123', CAST(N'2020-11-11T17:07:33.1230000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_telefones] ([id_telefone], [id_empresa], [id_tipo_contato], [telefone], [ultima_alteracao], [usuario_alteracao]) VALUES (12, 32, 8, N'11987989797', CAST(N'2020-11-11T17:31:42.7330000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_telefones] ([id_telefone], [id_empresa], [id_tipo_contato], [telefone], [ultima_alteracao], [usuario_alteracao]) VALUES (13, 32, 9, N'12321313112', CAST(N'2020-11-11T20:37:08.4200000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_telefones] ([id_telefone], [id_empresa], [id_tipo_contato], [telefone], [ultima_alteracao], [usuario_alteracao]) VALUES (14, 32, 56, N'11334034834', CAST(N'2020-11-12T10:51:06.3900000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_telefones] ([id_telefone], [id_empresa], [id_tipo_contato], [telefone], [ultima_alteracao], [usuario_alteracao]) VALUES (15, 32, 10, N'11987987987', CAST(N'2020-11-12T10:51:12.9300000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_telefones] ([id_telefone], [id_empresa], [id_tipo_contato], [telefone], [ultima_alteracao], [usuario_alteracao]) VALUES (16, 32, 9, N'11989789898', CAST(N'2020-11-12T10:51:23.8200000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_telefones] ([id_telefone], [id_empresa], [id_tipo_contato], [telefone], [ultima_alteracao], [usuario_alteracao]) VALUES (17, 32, 56, N'13132131321', CAST(N'2020-11-13T20:32:42.2630000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_telefones] OFF
SET IDENTITY_INSERT [contratos].[tb_tipos_contato] ON 

INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (8, N'CONTABILIDADE', 1, CAST(N'2020-11-07T15:27:22.4530000' AS DateTime2), N'c999999')
INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (9, N'DIRETORIA', 1, CAST(N'2020-11-09T10:30:04.2200000' AS DateTime2), N'c999999')
INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (10, N'OPERAÇÃO', 1, CAST(N'2020-11-03T16:45:41.2500000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (56, N'RH', 1, CAST(N'2020-11-10T14:56:38.9270000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (58, N'TI', 1, CAST(N'2020-11-12T15:19:21.7000000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (59, N'', 1, CAST(N'2020-11-20T13:56:00.8470000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (60, N'suporte', 1, CAST(N'2020-11-24T16:18:52.1470000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contato] ([id_tipo_contato], [tipo_contato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (61, N'teste', 1, CAST(N'2020-11-24T17:24:58.8870000' AS DateTime2), N'C109724')
SET IDENTITY_INSERT [contratos].[tb_tipos_contato] OFF
SET IDENTITY_INSERT [contratos].[tb_tipos_contrato] ON 

INSERT [contratos].[tb_tipos_contrato] ([id_tipo_contrato], [tipo_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (1, N'BANDEIRAS', 1, CAST(N'2020-11-13T12:42:27.8500000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contrato] ([id_tipo_contrato], [tipo_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (2, N'PONTOS', 1, CAST(N'2020-11-13T12:42:49.7300000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contrato] ([id_tipo_contrato], [tipo_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (3, N'CONCORRENCIAIS', 1, CAST(N'2020-11-13T12:43:01.1900000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contrato] ([id_tipo_contrato], [tipo_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (4, N'DIVERSOS', 1, CAST(N'2020-11-13T12:43:09.4800000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contrato] ([id_tipo_contrato], [tipo_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (5, N'PREGÃO', 1, CAST(N'2020-11-13T12:43:16.2500000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contrato] ([id_tipo_contrato], [tipo_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (6, N'DIRETA', 1, CAST(N'2020-11-13T12:43:23.9670000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_contrato] ([id_tipo_contrato], [tipo_contrato], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (7, N'INEXIGIBILIDADE', 1, CAST(N'2020-11-13T12:43:30.6000000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_tipos_contrato] OFF
SET IDENTITY_INSERT [contratos].[tb_tipos_documento] ON 

INSERT [contratos].[tb_tipos_documento] ([id_tipo_documento], [tipo_documento], [possui_validade], [id_dominio_documento], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (1, N'CERTIDÃO NEGATIVA', 1, 1, 1, CAST(N'2020-11-04T16:13:02.5200000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_tipos_documento] ([id_tipo_documento], [tipo_documento], [possui_validade], [id_dominio_documento], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (5, N'ATA DE REUNIÃO - REPACTUAÇÃO COMPETÊNCIA 01/2020', 0, 1, 1, CAST(N'2020-11-05T12:09:10.4830000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_tipos_documento] ([id_tipo_documento], [tipo_documento], [possui_validade], [id_dominio_documento], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (6, N'ATESTE DE FATURA COMPETÊNCIA 08/2020', 0, 3, 1, CAST(N'2020-11-05T12:16:48.5100000' AS DateTime2), N'C137703')
INSERT [contratos].[tb_tipos_documento] ([id_tipo_documento], [tipo_documento], [possui_validade], [id_dominio_documento], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (15, N'RESCISÃO', 0, 1, 1, CAST(N'2020-11-12T14:19:33.1370000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_documento] ([id_tipo_documento], [tipo_documento], [possui_validade], [id_dominio_documento], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (17, N'ATA', 0, 2, 1, CAST(N'2020-12-02T15:54:27.7470000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_documento] ([id_tipo_documento], [tipo_documento], [possui_validade], [id_dominio_documento], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (18, N'TERMO ADITIVO', 0, 2, 1, CAST(N'2020-12-02T15:54:41.5970000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_tipos_documento] OFF
SET IDENTITY_INSERT [contratos].[tb_tipos_penalidade] ON 

INSERT [contratos].[tb_tipos_penalidade] ([id_tipo_penalidade], [tipo_penalidade], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (1, N'ADVERTÊNCIA', 1, CAST(N'2020-11-17T13:57:38.6030000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_penalidade] ([id_tipo_penalidade], [tipo_penalidade], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (3, N'MULTA', 1, CAST(N'2020-11-17T13:57:38.6030000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_tipos_penalidade] ([id_tipo_penalidade], [tipo_penalidade], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (4, N'IMPEDIMENTO DE CONTRATAR COM A CAIXA', 1, CAST(N'2020-11-18T19:06:01.5200000' AS DateTime2), N'c999999')
INSERT [contratos].[tb_tipos_penalidade] ([id_tipo_penalidade], [tipo_penalidade], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (10, N'IMPEDIMENTO DE LICITAR E CONTRATAR COM A ADMINISTRAÇÃO', 1, CAST(N'2020-11-18T19:06:39.6170000' AS DateTime2), N'c999999')
INSERT [contratos].[tb_tipos_penalidade] ([id_tipo_penalidade], [tipo_penalidade], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (11, N'RESSARCIMENTO, INDENIZAÇÃO', 1, CAST(N'2020-11-18T19:06:55.6000000' AS DateTime2), N'c999999')
INSERT [contratos].[tb_tipos_penalidade] ([id_tipo_penalidade], [tipo_penalidade], [ativo], [ultima_alteracao], [usuario_alteracao]) VALUES (12, N'RESCISÃO AMIGÁVEL E UNILATERAL E RESCISÃO POR INTERESSE DA EMPRESA', 1, CAST(N'2020-11-17T13:57:38.6030000' AS DateTime2), N'C110611')
SET IDENTITY_INSERT [contratos].[tb_tipos_penalidade] OFF
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'AC', N'Acre')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'AL', N'Alagoas')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'AM', N'Amazonas')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'AP', N'Amapá')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'BA', N'Bahia')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'CE', N'Ceará')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'DF', N'Distrifo Federal')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'ES', N'Espírito Santo')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'GO', N'Goiás')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'MA', N'Maranhão')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'MG', N'Minas Gerais')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'MS', N'Mato Grosso do Sul')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'MT', N'Mato Grosso')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'PA', N'Pará')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'PB', N'Paraíba')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'PE', N'Pernambuco')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'PI', N'Piauí')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'PR', N'Paraná')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'RJ', N'Rio de Janeiro')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'RN', N'Rio Grande do Norte')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'RO', N'Rondônia')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'RR', N'Roraima')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'RS', N'Rio Grande do Sul')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'SC', N'Santa Catarina')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'SE', N'Sergipe')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'SP', N'São Paulo')
INSERT [contratos].[tb_uf] ([uf], [nome_uf]) VALUES (N'TO', N'Tocantins')
INSERT [contratos].[tb_unidades] ([id_unidade], [unidade]) VALUES (7289, N'CECOP')
INSERT [contratos].[tb_unidades] ([id_unidade], [unidade]) VALUES (7688, N'CECOB')
INSERT [contratos].[tb_usuarios] ([id_usuario], [nome], [id_unidade], [id_funcao], [id_perfil], [ultima_alteracao], [usuario_alteracao]) VALUES (N'C109724', N'WESLEY GRUDTNER MARTINS', 7289, 9999, 1, CAST(N'2020-12-07T10:21:09.4400000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_usuarios] ([id_usuario], [nome], [id_unidade], [id_funcao], [id_perfil], [ultima_alteracao], [usuario_alteracao]) VALUES (N'C110611', N'MAURO', 7688, 1234, 4, CAST(N'2020-12-09T09:17:07.0800000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_usuarios] ([id_usuario], [nome], [id_unidade], [id_funcao], [id_perfil], [ultima_alteracao], [usuario_alteracao]) VALUES (N'C137703', N'EMERSON VIEIRA', 7289, 9999, 2, CAST(N'2020-12-07T10:20:37.8430000' AS DateTime2), N'C110611')
INSERT [contratos].[tb_usuarios] ([id_usuario], [nome], [id_unidade], [id_funcao], [id_perfil], [ultima_alteracao], [usuario_alteracao]) VALUES (N'C999999', N'JOSÉ DA SILVA', 7289, 1234, 1, CAST(N'2020-12-07T09:01:24.5830000' AS DateTime2), N'C110611')
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (1, 3)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (1, 12)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (4, 1)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (4, 3)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (4, 4)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (4, 10)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (4, 11)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (4, 12)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (6, 4)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (6, 10)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (10, 1)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (10, 4)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (10, 10)
INSERT [contratos].[tbr_contratos_tipos_penalidade] ([id_contrato], [id_tipo_penalidade]) VALUES (10, 11)
SET ANSI_PADDING ON
GO
/****** Object:  Index [uq_tipo_contato]    Script Date: 11/12/2020 17:48:27 ******/
ALTER TABLE [contratos].[tb_tipos_contato] ADD  CONSTRAINT [uq_tipo_contato] UNIQUE NONCLUSTERED 
(
	[tipo_contato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [contratos].[tb_atestes] ADD  CONSTRAINT [DF_tb_atestes_existe_acerto]  DEFAULT ((0)) FOR [existe_acerto]
GO
ALTER TABLE [contratos].[tb_atestes] ADD  CONSTRAINT [DF_tb_atestes_homologado]  DEFAULT ((0)) FOR [atestado_gestor_operacional]
GO
ALTER TABLE [contratos].[tb_atestes_pagamento] ADD  CONSTRAINT [DF_tb_atestes_pagamento_pago]  DEFAULT ((0)) FOR [pago]
GO
ALTER TABLE [contratos].[tb_contratos] ADD  CONSTRAINT [DF_tb_contratos_ativo]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_empresas] ADD  CONSTRAINT [DF_tb_empresas_ativa]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_historico_atestes] ADD  CONSTRAINT [DF_tb_historico_atestes_data_hora]  DEFAULT (getdate()) FOR [data_hora]
GO
ALTER TABLE [contratos].[tb_itens] ADD  CONSTRAINT [DF_tb_itens_ativo]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_parcelas_siplo] ADD  CONSTRAINT [DF_tb_parcelas_siplo_ultima_alteracao]  DEFAULT (getdate()) FOR [ultima_alteracao]
GO
ALTER TABLE [contratos].[tb_subitens] ADD  CONSTRAINT [DF_tb_subitens_ativo]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_tipos_contato] ADD  CONSTRAINT [df_tb_tipos_contato_ativo]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_tipos_contrato] ADD  CONSTRAINT [DF_tb_tipos_contrato_ativo]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_tipos_documento] ADD  CONSTRAINT [DF_tb_tipos_documento_possui_validade]  DEFAULT ((0)) FOR [possui_validade]
GO
ALTER TABLE [contratos].[tb_tipos_documento] ADD  CONSTRAINT [DF_tb_tipos_documento_ativo]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_tipos_penalidade] ADD  CONSTRAINT [DF_tb_tipos_penalidade_ativo]  DEFAULT ((1)) FOR [ativo]
GO
ALTER TABLE [contratos].[tb_acertos]  WITH CHECK ADD  CONSTRAINT [FK_tb_acertos_tb_atestes] FOREIGN KEY([id_ateste_pagamento])
REFERENCES [contratos].[tb_atestes] ([id_ateste])
GO
ALTER TABLE [contratos].[tb_acertos] CHECK CONSTRAINT [FK_tb_acertos_tb_atestes]
GO
ALTER TABLE [contratos].[tb_acertos]  WITH CHECK ADD  CONSTRAINT [FK_tb_acertos_tb_atestes_pagamento] FOREIGN KEY([id_ateste_pagamento])
REFERENCES [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento])
GO
ALTER TABLE [contratos].[tb_acertos] CHECK CONSTRAINT [FK_tb_acertos_tb_atestes_pagamento]
GO
ALTER TABLE [contratos].[tb_atestes]  WITH CHECK ADD  CONSTRAINT [fk_tb_atestes_tb_atestes_pagamento] FOREIGN KEY([id_ateste_pagamento])
REFERENCES [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento])
GO
ALTER TABLE [contratos].[tb_atestes] CHECK CONSTRAINT [fk_tb_atestes_tb_atestes_pagamento]
GO
ALTER TABLE [contratos].[tb_atestes]  WITH CHECK ADD  CONSTRAINT [fk_tb_atestes_tb_subitens] FOREIGN KEY([id_subitem])
REFERENCES [contratos].[tb_subitens] ([id_subitem])
GO
ALTER TABLE [contratos].[tb_atestes] CHECK CONSTRAINT [fk_tb_atestes_tb_subitens]
GO
ALTER TABLE [contratos].[tb_atestes_pagamento]  WITH CHECK ADD  CONSTRAINT [fk_tb_atestes_pagamento_tb_contratos] FOREIGN KEY([id_contrato])
REFERENCES [contratos].[tb_contratos] ([id_contrato])
GO
ALTER TABLE [contratos].[tb_atestes_pagamento] CHECK CONSTRAINT [fk_tb_atestes_pagamento_tb_contratos]
GO
ALTER TABLE [contratos].[tb_compromissos_siplo]  WITH CHECK ADD  CONSTRAINT [fk_tb_compromissos_siplo_tb_contratos] FOREIGN KEY([id_contrato])
REFERENCES [contratos].[tb_contratos] ([id_contrato])
GO
ALTER TABLE [contratos].[tb_compromissos_siplo] CHECK CONSTRAINT [fk_tb_compromissos_siplo_tb_contratos]
GO
ALTER TABLE [contratos].[tb_contratos]  WITH CHECK ADD  CONSTRAINT [fk_tb_contratos_tb_empresas] FOREIGN KEY([id_empresa])
REFERENCES [contratos].[tb_empresas] ([id_empresa])
GO
ALTER TABLE [contratos].[tb_contratos] CHECK CONSTRAINT [fk_tb_contratos_tb_empresas]
GO
ALTER TABLE [contratos].[tb_contratos]  WITH CHECK ADD  CONSTRAINT [fk_tb_contratos_tb_tipos_contrato] FOREIGN KEY([id_tipo_contrato])
REFERENCES [contratos].[tb_tipos_contrato] ([id_tipo_contrato])
GO
ALTER TABLE [contratos].[tb_contratos] CHECK CONSTRAINT [fk_tb_contratos_tb_tipos_contrato]
GO
ALTER TABLE [contratos].[tb_documentos]  WITH CHECK ADD  CONSTRAINT [fk_tb_documentos_tb_ateste_pagamento] FOREIGN KEY([id_ateste_pagamento])
REFERENCES [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento])
GO
ALTER TABLE [contratos].[tb_documentos] CHECK CONSTRAINT [fk_tb_documentos_tb_ateste_pagamento]
GO
ALTER TABLE [contratos].[tb_documentos]  WITH CHECK ADD  CONSTRAINT [fk_tb_documentos_tb_contratos] FOREIGN KEY([id_contrato])
REFERENCES [contratos].[tb_contratos] ([id_contrato])
GO
ALTER TABLE [contratos].[tb_documentos] CHECK CONSTRAINT [fk_tb_documentos_tb_contratos]
GO
ALTER TABLE [contratos].[tb_documentos]  WITH CHECK ADD  CONSTRAINT [fk_tb_documentos_tb_empresas] FOREIGN KEY([id_empresa])
REFERENCES [contratos].[tb_empresas] ([id_empresa])
GO
ALTER TABLE [contratos].[tb_documentos] CHECK CONSTRAINT [fk_tb_documentos_tb_empresas]
GO
ALTER TABLE [contratos].[tb_documentos]  WITH CHECK ADD  CONSTRAINT [fk_tb_documentos_tb_penalidades] FOREIGN KEY([id_penalidade])
REFERENCES [contratos].[tb_penalidades] ([id_penalidade])
GO
ALTER TABLE [contratos].[tb_documentos] CHECK CONSTRAINT [fk_tb_documentos_tb_penalidades]
GO
ALTER TABLE [contratos].[tb_documentos]  WITH CHECK ADD  CONSTRAINT [fk_tb_documentos_tb_tipos_documento] FOREIGN KEY([id_tipo_documento])
REFERENCES [contratos].[tb_tipos_documento] ([id_tipo_documento])
GO
ALTER TABLE [contratos].[tb_documentos] CHECK CONSTRAINT [fk_tb_documentos_tb_tipos_documento]
GO
ALTER TABLE [contratos].[tb_emails]  WITH CHECK ADD  CONSTRAINT [fk_tb_emails_tb_empresas] FOREIGN KEY([id_empresa])
REFERENCES [contratos].[tb_empresas] ([id_empresa])
GO
ALTER TABLE [contratos].[tb_emails] CHECK CONSTRAINT [fk_tb_emails_tb_empresas]
GO
ALTER TABLE [contratos].[tb_emails]  WITH CHECK ADD  CONSTRAINT [fk_tb_emails_tb_tipos_contato] FOREIGN KEY([id_tipo_contato])
REFERENCES [contratos].[tb_tipos_contato] ([id_tipo_contato])
GO
ALTER TABLE [contratos].[tb_emails] CHECK CONSTRAINT [fk_tb_emails_tb_tipos_contato]
GO
ALTER TABLE [contratos].[tb_empresas]  WITH CHECK ADD  CONSTRAINT [fk_tb_empresas_tb_uf] FOREIGN KEY([uf])
REFERENCES [contratos].[tb_uf] ([uf])
GO
ALTER TABLE [contratos].[tb_empresas] CHECK CONSTRAINT [fk_tb_empresas_tb_uf]
GO
ALTER TABLE [contratos].[tb_historico_atestes]  WITH CHECK ADD  CONSTRAINT [fk_tb_historico_atestes_tb_atestes] FOREIGN KEY([id_ateste])
REFERENCES [contratos].[tb_atestes] ([id_ateste])
GO
ALTER TABLE [contratos].[tb_historico_atestes] CHECK CONSTRAINT [fk_tb_historico_atestes_tb_atestes]
GO
ALTER TABLE [contratos].[tb_historico_atestes]  WITH CHECK ADD  CONSTRAINT [fk_tb_historico_atestes_tb_usuarios] FOREIGN KEY([id_usuario])
REFERENCES [contratos].[tb_usuarios] ([id_usuario])
GO
ALTER TABLE [contratos].[tb_historico_atestes] CHECK CONSTRAINT [fk_tb_historico_atestes_tb_usuarios]
GO
ALTER TABLE [contratos].[tb_historico_atestes_pagamento]  WITH CHECK ADD  CONSTRAINT [fk_tb_historico_atestes_pagamento_tb_atestes_pagamento] FOREIGN KEY([id_ateste_pagamento])
REFERENCES [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento])
GO
ALTER TABLE [contratos].[tb_historico_atestes_pagamento] CHECK CONSTRAINT [fk_tb_historico_atestes_pagamento_tb_atestes_pagamento]
GO
ALTER TABLE [contratos].[tb_itens]  WITH CHECK ADD  CONSTRAINT [fk_tb_itens_tb_contratos] FOREIGN KEY([id_contrato])
REFERENCES [contratos].[tb_contratos] ([id_contrato])
GO
ALTER TABLE [contratos].[tb_itens] CHECK CONSTRAINT [fk_tb_itens_tb_contratos]
GO
ALTER TABLE [contratos].[tb_parcelas_siplo]  WITH CHECK ADD  CONSTRAINT [fk_tb_valores_siplo_tb_atestes_pagamento] FOREIGN KEY([id_ateste_pagamento])
REFERENCES [contratos].[tb_atestes_pagamento] ([id_ateste_pagamento])
GO
ALTER TABLE [contratos].[tb_parcelas_siplo] CHECK CONSTRAINT [fk_tb_valores_siplo_tb_atestes_pagamento]
GO
ALTER TABLE [contratos].[tb_subitens]  WITH CHECK ADD  CONSTRAINT [fk_tb_subitens_tb_itens] FOREIGN KEY([id_item])
REFERENCES [contratos].[tb_itens] ([id_item])
GO
ALTER TABLE [contratos].[tb_subitens] CHECK CONSTRAINT [fk_tb_subitens_tb_itens]
GO
ALTER TABLE [contratos].[tb_telefones]  WITH CHECK ADD  CONSTRAINT [fk_tb_telefones_tb_empresas] FOREIGN KEY([id_empresa])
REFERENCES [contratos].[tb_empresas] ([id_empresa])
GO
ALTER TABLE [contratos].[tb_telefones] CHECK CONSTRAINT [fk_tb_telefones_tb_empresas]
GO
ALTER TABLE [contratos].[tb_telefones]  WITH CHECK ADD  CONSTRAINT [fk_tb_telefones_tb_tipos_contato] FOREIGN KEY([id_tipo_contato])
REFERENCES [contratos].[tb_tipos_contato] ([id_tipo_contato])
GO
ALTER TABLE [contratos].[tb_telefones] CHECK CONSTRAINT [fk_tb_telefones_tb_tipos_contato]
GO
ALTER TABLE [contratos].[tb_tipos_documento]  WITH CHECK ADD  CONSTRAINT [fk_tb_tipos_documento_tb_dominios_documento] FOREIGN KEY([id_dominio_documento])
REFERENCES [contratos].[tb_dominios_documento] ([id_dominio_documento])
GO
ALTER TABLE [contratos].[tb_tipos_documento] CHECK CONSTRAINT [fk_tb_tipos_documento_tb_dominios_documento]
GO
ALTER TABLE [contratos].[tb_usuarios]  WITH CHECK ADD  CONSTRAINT [fk_tb_usuarios_tb_funcoes] FOREIGN KEY([id_funcao])
REFERENCES [contratos].[tb_funcoes] ([id_funcao])
GO
ALTER TABLE [contratos].[tb_usuarios] CHECK CONSTRAINT [fk_tb_usuarios_tb_funcoes]
GO
ALTER TABLE [contratos].[tb_usuarios]  WITH CHECK ADD  CONSTRAINT [fk_tb_usuarios_tb_perfis] FOREIGN KEY([id_perfil])
REFERENCES [contratos].[tb_perfis] ([id_perfil])
GO
ALTER TABLE [contratos].[tb_usuarios] CHECK CONSTRAINT [fk_tb_usuarios_tb_perfis]
GO
ALTER TABLE [contratos].[tb_usuarios]  WITH CHECK ADD  CONSTRAINT [fk_tb_usuarios_tb_unidades] FOREIGN KEY([id_unidade])
REFERENCES [contratos].[tb_unidades] ([id_unidade])
GO
ALTER TABLE [contratos].[tb_usuarios] CHECK CONSTRAINT [fk_tb_usuarios_tb_unidades]
GO
ALTER TABLE [contratos].[tbr_contratos_tipos_penalidade]  WITH CHECK ADD  CONSTRAINT [fk_tbr_contratos_tipos_penalidade_tb_contratos] FOREIGN KEY([id_contrato])
REFERENCES [contratos].[tb_contratos] ([id_contrato])
GO
ALTER TABLE [contratos].[tbr_contratos_tipos_penalidade] CHECK CONSTRAINT [fk_tbr_contratos_tipos_penalidade_tb_contratos]
GO
ALTER TABLE [contratos].[tbr_contratos_tipos_penalidade]  WITH CHECK ADD  CONSTRAINT [fk_tbr_contratos_tipos_penalidade_tb_tipos_penalidade] FOREIGN KEY([id_tipo_penalidade])
REFERENCES [contratos].[tb_tipos_penalidade] ([id_tipo_penalidade])
GO
ALTER TABLE [contratos].[tbr_contratos_tipos_penalidade] CHECK CONSTRAINT [fk_tbr_contratos_tipos_penalidade_tb_tipos_penalidade]
GO
/****** Object:  StoredProcedure [contratos].[ateste_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[ateste_alterar]
	  @id_ateste int
	, @qtd int
	, @valor decimal(19,2)
	, @usuario_alteracao char(7)
	, @atestado_gestor_operacional bit
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_atestes] WHERE id_ateste = @id_ateste)
		BEGIN
			UPDATE [contratos].[tb_atestes] SET qtd = @qtd
											  , valor = @valor
											  , atestado_gestor_operacional = @atestado_gestor_operacional
											  , ultima_alteracao = GETDATE()
											  , usuario_alteracao = @usuario_alteracao
			WHERE id_ateste = @id_ateste
			SET @mensagem = '1_Ateste alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Ateste não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Ateste não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[ateste_alterar_atestado_gestor_operacional]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[ateste_alterar_atestado_gestor_operacional]
	  @id_ateste int
	, @atestado_gestor_operacional bit
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_atestes] WHERE id_ateste = @id_ateste)
		BEGIN
			UPDATE [contratos].[tb_atestes] SET atestado_gestor_operacional = @atestado_gestor_operacional
											  , ultima_alteracao = GETDATE()
											  , usuario_alteracao = @usuario_alteracao
			WHERE id_ateste = @id_ateste
			SET @mensagem = '1_Ateste alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Ateste não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Ateste não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[ateste_alterar_quantidade]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[ateste_alterar_quantidade]
	  @id_ateste int
	, @qtd int
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_atestes] WHERE id_ateste = @id_ateste)
		BEGIN
			UPDATE [contratos].[tb_atestes] SET qtd = @qtd
											  , ultima_alteracao = GETDATE()
											  , usuario_alteracao = @usuario_alteracao
			WHERE id_ateste = @id_ateste
			SET @mensagem = '1_Quantidade do ateste alterada com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Ateste não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Ateste não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[ateste_alterar_valor]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[ateste_alterar_valor]
	  @id_ateste int
	, @valor decimal(19,2)
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_atestes] WHERE id_ateste = @id_ateste)
		BEGIN
			UPDATE [contratos].[tb_atestes] SET valor = @valor
											  , ultima_alteracao = GETDATE()
											  , usuario_alteracao = @usuario_alteracao
			WHERE id_ateste = @id_ateste
			SET @mensagem = '1_Valor do ateste alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Ateste não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Ateste não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[ateste_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[ateste_inserir]

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		INSERT INTO [contratos].[tb_atestes] (id_ateste_pagamento, id_subitem, usuario_alteracao, ultima_alteracao)
		SELECT c.id_ateste_pagamento, a.id_subitem, 'S000000', GETDATE()
		FROM [contratos].[tb_subitens] a
			INNER JOIN [contratos].[tb_itens] b ON a.id_item = b.id_item
			INNER JOIN [contratos].[tb_atestes_pagamento] c ON b.id_contrato = c.id_contrato
		WHERE a.ativo = 1
		  AND b.ativo = 1

	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
	END CATCH

END
GO
/****** Object:  StoredProcedure [contratos].[ateste_pagamento_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[ateste_pagamento_alterar]
	  @id_ateste_pagamento int
	, @observacao varchar(8000)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_atestes_pagamento] WHERE id_ateste_pagamento = @id_ateste_pagamento)
		BEGIN
			UPDATE [contratos].[tb_atestes_pagamento] SET observacao = @observacao
			WHERE id_ateste_pagamento = @id_ateste_pagamento

			SET @mensagem = '1_Ateste Pagamento alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Ateste Pagamento não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Ateste Pagamento não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[ateste_pagamento_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[ateste_pagamento_inserir]

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		
		INSERT INTO [contratos].[tb_atestes_pagamento] (id_contrato, ano, mes)
		SELECT id_contrato, YEAR(GETDATE()) ano, MONTH(GETDATE()) mes
		FROM [contratos].[tb_contratos]
		WHERE ativo = 1

	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE()
	END CATCH

END
GO
/****** Object:  StoredProcedure [contratos].[compromisso_siplo_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[compromisso_siplo_alterar]
	@id_compromisso_siplo int
  , @compromisso_siplo char(12)
  , @id_contrato int
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_compromissos_siplo] WHERE id_compromisso_siplo = @id_compromisso_siplo)
		BEGIN
			UPDATE [contratos].[tb_compromissos_siplo]
			SET compromisso_siplo = @compromisso_siplo 
			  , id_contrato = @id_contrato
			  , ultima_alteracao = GETDATE()
			  , usuario_alteracao = @usuario_alteracao
			WHERE id_compromisso_siplo = @id_compromisso_siplo;
			SET @mensagem = '1_Compromisso SIPLO "' + @compromisso_siplo + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Compromisso SIPLO "' + @compromisso_siplo + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Compromisso SIPLO "' + @compromisso_siplo + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[compromisso_siplo_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[compromisso_siplo_inserir]
	  @compromisso_siplo char(12)
	, @id_contrato int
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_compromisso_siplo int

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_compromissos_siplo] WHERE compromisso_siplo = @compromisso_siplo AND id_contrato = @id_contrato)
		BEGIN
			INSERT INTO [contratos].[tb_compromissos_siplo](compromisso_siplo, id_contrato, ultima_alteracao, usuario_alteracao)
			VALUES (@compromisso_siplo, @id_contrato, GETDATE(), @usuario_alteracao);

			SET @id_compromisso_siplo = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Compromisso SIPLO "' + @compromisso_siplo + '" inserido com sucesso._' + CAST(@id_compromisso_siplo AS varchar)
		END 
		ELSE
			SET @mensagem = '0_Compromisso SIPLO "' + @compromisso_siplo + '" já existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Compromisso SIPLO "' + @compromisso_siplo + '" não inserido.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[compromisso_siplo_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[compromisso_siplo_remover]
	@id_compromisso_siplo int 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_compromissos_siplo] WHERE id_compromisso_siplo = @id_compromisso_siplo)
		BEGIN
			DELETE FROM [contratos].[tb_compromissos_siplo]
			WHERE id_compromisso_siplo = @id_compromisso_siplo;
			SET @mensagem = '1_Compromisso SIPLO removido com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Compromisso SIPLO não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Compromisso SIPLO não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[contrato_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[contrato_alterar]
	  @id_contrato int
	, @numero_processo varchar(30)
	, @numero_ordem_servico bigint
	, @data_assinatura date
	, @data_inicio_vigencia date
	, @data_fim_vigencia date
	, @valor_global_inicial decimal(19, 2)
	, @valor_global_atualizado decimal(19, 2)
	, @objeto_contratual varchar(8000)
	, @dia_pagamento tinyint
	, @dia_pagamento_corridos bit
	, @prazo_alerta_dias_pagamento tinyint
	, @prazo_alerta_dias_ateste tinyint
	, @prazo_alerta_dias_nota_fiscal tinyint
	, @prazo_alerta_meses_fim_vigencia tinyint
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_contratos] WHERE id_contrato = @id_contrato)
		BEGIN
			UPDATE [contratos].[tb_contratos] SET numero_processo = @numero_processo
												, numero_ordem_servico = @numero_ordem_servico
												, data_assinatura = @data_assinatura
												, data_inicio_vigencia = @data_inicio_vigencia
												, data_fim_vigencia = @data_fim_vigencia
												, valor_global_inicial = @valor_global_inicial
												, valor_global_atualizado = @valor_global_atualizado
												, objeto_contratual = @objeto_contratual
												, dia_pagamento = @dia_pagamento
												, dia_pagamento_corridos = @dia_pagamento_corridos
												, prazo_alerta_dias_pagamento = @prazo_alerta_dias_pagamento
												, prazo_alerta_dias_ateste = @prazo_alerta_dias_ateste
												, prazo_alerta_dias_nota_fiscal = @prazo_alerta_dias_nota_fiscal
												, prazo_alerta_meses_fim_vigencia = @prazo_alerta_meses_fim_vigencia
												, ultima_alteracao = GETDATE()
												, usuario_alteracao = @usuario_alteracao
			WHERE id_contrato = @id_contrato
			SET @mensagem = '1_Contrato "' + @numero_processo + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Contrato "' + @numero_processo + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Contrato "' + @numero_processo + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[contrato_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[contrato_inserir]
	  @id_empresa smallint
	, @id_tipo_contrato tinyint
	, @numero_processo varchar(30)
	, @numero_ordem_servico bigint
	, @data_assinatura date
	, @data_inicio_vigencia date
	, @data_fim_vigencia date
	, @valor_global_inicial decimal(19, 2)
	, @valor_global_atualizado decimal(19, 2)
	, @objeto_contratual varchar(8000)
	, @dia_pagamento tinyint
	, @dia_pagamento_corridos bit
	, @prazo_alerta_dias_pagamento tinyint
	, @prazo_alerta_dias_ateste tinyint
	, @prazo_alerta_dias_nota_fiscal tinyint
	, @prazo_alerta_meses_fim_vigencia tinyint
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_contrato int

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_contratos] WHERE numero_processo = @numero_processo)
		BEGIN
			INSERT INTO [contratos].[tb_contratos](
				  id_empresa
				, id_tipo_contrato
				, numero_processo
				, numero_ordem_servico
				, data_assinatura
				, data_inicio_vigencia
				, data_fim_vigencia
				, valor_global_inicial
				, valor_global_atualizado
				, objeto_contratual
				, dia_pagamento
				, dia_pagamento_corridos
				, prazo_alerta_dias_pagamento
				, prazo_alerta_dias_ateste
				, prazo_alerta_dias_nota_fiscal
				, prazo_alerta_meses_fim_vigencia
				, ultima_alteracao
				, usuario_alteracao
				)
			VALUES (
				  @id_empresa
				, @id_tipo_contrato
				, @numero_processo
				, @numero_ordem_servico
				, @data_assinatura
				, @data_inicio_vigencia
				, @data_fim_vigencia
				, @valor_global_inicial
				, @valor_global_atualizado
				, @objeto_contratual
				, @dia_pagamento
				, @dia_pagamento_corridos
				, @prazo_alerta_dias_pagamento
				, @prazo_alerta_dias_ateste
				, @prazo_alerta_dias_nota_fiscal
				, @prazo_alerta_meses_fim_vigencia
				, GETDATE()
				, @usuario_alteracao
			);
			SET @id_contrato = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Contrato inserido com sucesso._' + CAST(@id_contrato AS varchar)
		END 
		ELSE
			SET @mensagem = '0_Contrato já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Contrato não inserido!'
	END CATCH

	SELECT @mensagem

END
GO
/****** Object:  StoredProcedure [contratos].[contrato_tipo_penalidade_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[contrato_tipo_penalidade_inserir]
	  @id_contrato int
	, @id_tipo_penalidade tinyint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tbr_contratos_tipos_penalidade]
					  WHERE id_contrato = @id_contrato AND id_tipo_penalidade = @id_tipo_penalidade)
		BEGIN
			INSERT INTO [contratos].[tbr_contratos_tipos_penalidade](id_contrato, id_tipo_penalidade)
			VALUES (@id_contrato, @id_tipo_penalidade)

			SET @mensagem = '1_Tipo penalidade inserido no contrato com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Tipo penalidade do contrato já existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo penalidade do contrato não inserido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[contrato_tipo_penalidade_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[contrato_tipo_penalidade_remover]
	  @id_contrato int
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tbr_contratos_tipos_penalidade] WHERE id_contrato = @id_contrato)
		BEGIN
			DELETE FROM [contratos].[tbr_contratos_tipos_penalidade] WHERE id_contrato = @id_contrato
			SET @mensagem = '1'
		END
		ELSE
			SET @mensagem = '1'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[documento_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[documento_alterar]
	@id_documento bigint
  , @id_tipo_documento tinyint
  , @id_dominio int
  , @data_validade date
  , @nome_documento varchar(255)
  , @usuario_alteracao char(7)
  , @observacao varchar(8000)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_dominio_documento tinyint = (SELECT id_dominio_documento FROM [contratos].[tb_tipos_documento]
											 WHERE id_tipo_documento = @id_tipo_documento)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_documentos] WHERE id_documento = @id_documento)
		BEGIN

			IF @id_dominio_documento = 1
				UPDATE [contratos].[tb_documentos] SET id_tipo_documento = @id_tipo_documento
												     , id_empresa = @id_dominio
												     , data_validade = @data_validade
												     , nome_documento = @nome_documento
												     , ultima_alteracao = GETDATE()
												     , usuario_alteracao = @usuario_alteracao
												     , observacao = @observacao
				WHERE id_documento = @id_documento
			ELSE IF @id_dominio_documento = 2
				UPDATE [contratos].[tb_documentos] SET id_tipo_documento = @id_tipo_documento
												     , id_contrato = @id_dominio
												     , data_validade = @data_validade
												     , nome_documento = @nome_documento
												     , ultima_alteracao = GETDATE()
												     , usuario_alteracao = @usuario_alteracao
												     , observacao = @observacao
				WHERE id_documento = @id_documento
			ELSE IF @id_dominio_documento = 3
				UPDATE [contratos].[tb_documentos] SET id_tipo_documento = @id_tipo_documento
												     , id_ateste_pagamento = @id_dominio
												     , data_validade = @data_validade
												     , nome_documento = @nome_documento
												     , ultima_alteracao = GETDATE()
												     , usuario_alteracao = @usuario_alteracao
												     , observacao = @observacao
				WHERE id_documento = @id_documento
			ELSE IF @id_dominio_documento = 4
				UPDATE [contratos].[tb_documentos] SET id_tipo_documento = @id_tipo_documento
												     , id_penalidade = @id_dominio 
												     , data_validade = @data_validade
												     , nome_documento = @nome_documento
												     , ultima_alteracao = GETDATE()
												     , usuario_alteracao = @usuario_alteracao
												     , observacao = @observacao
				WHERE id_documento = @id_documento

			SET @mensagem = '1_Documento "' + @nome_documento + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Documento com o nome "' + @nome_documento + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Documento "' + @nome_documento + '" não alterado.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[documento_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[documento_inserir]
	@id_tipo_documento tinyint
  , @id_dominio int
  , @data_validade date
  , @nome_documento varchar(255)
  , @observacao varchar(8000)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @mensagem_inserido varchar(255) = '1_Documento inserido com sucesso._'
	DECLARE @mensagem_doc_existe varchar(255) = '0_Documento já existe. Favor renomear.'

	DECLARE @id_documento bigint
	DECLARE @id_dominio_documento tinyint = (SELECT id_dominio_documento FROM [contratos].[tb_tipos_documento]
											 WHERE id_tipo_documento = @id_tipo_documento)
	BEGIN TRY

		IF @id_dominio_documento = 1
		BEGIN
			IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_documentos] WHERE id_empresa = @id_dominio AND nome_documento = @nome_documento)
			BEGIN
				INSERT INTO [contratos].[tb_documentos](id_tipo_documento, id_empresa, data_validade, nome_documento,
														ultima_alteracao, usuario_alteracao, observacao)
				VALUES (@id_tipo_documento, @id_dominio, @data_validade, @nome_documento, GETDATE(),
						@usuario_alteracao, @observacao)

				SET @id_documento = (SELECT SCOPE_IDENTITY())
				SET @mensagem = @mensagem_inserido + CAST(@id_documento AS varchar)
			END
			ELSE
				SET @mensagem = @mensagem_doc_existe
		END
		ELSE IF @id_dominio_documento = 2
		BEGIN
			IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_documentos] WHERE id_contrato = @id_dominio AND nome_documento = @nome_documento)
			BEGIN
				INSERT INTO [contratos].[tb_documentos](id_tipo_documento, id_contrato, data_validade, nome_documento,
														ultima_alteracao, usuario_alteracao, observacao)
				VALUES (@id_tipo_documento, @id_dominio, @data_validade, @nome_documento, GETDATE(),
						@usuario_alteracao, @observacao)

				SET @id_documento = (SELECT SCOPE_IDENTITY())
				SET @mensagem = @mensagem_inserido + CAST(@id_documento AS varchar)
			END
			ELSE
				SET @mensagem = @mensagem_doc_existe
		END
		ELSE IF @id_dominio_documento = 3
		BEGIN
			IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_documentos] WHERE id_ateste_pagamento = @id_dominio AND nome_documento = @nome_documento)
			BEGIN
				INSERT INTO [contratos].[tb_documentos](id_tipo_documento, id_ateste_pagamento, data_validade, nome_documento,
														ultima_alteracao, usuario_alteracao, observacao)
				VALUES (@id_tipo_documento, @id_dominio, @data_validade, @nome_documento, GETDATE(),
						@usuario_alteracao, @observacao)

				SET @id_documento = (SELECT SCOPE_IDENTITY())
				SET @mensagem = @mensagem_inserido + CAST(@id_documento AS varchar)
			END
			ELSE
				SET @mensagem = @mensagem_doc_existe
		END
		ELSE IF @id_dominio_documento = 4
		BEGIN
			IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_documentos] WHERE id_penalidade = @id_dominio AND nome_documento = @nome_documento)
			BEGIN
				INSERT INTO [contratos].[tb_documentos](id_tipo_documento, id_penalidade, data_validade, nome_documento,
														ultima_alteracao, usuario_alteracao, observacao)
				VALUES (@id_tipo_documento, @id_dominio, @data_validade, @nome_documento, GETDATE(),
						@usuario_alteracao, @observacao)

				SET @id_documento = (SELECT SCOPE_IDENTITY())
				SET @mensagem = @mensagem_inserido + CAST(@id_documento AS varchar)
			END
			ELSE
				SET @mensagem = @mensagem_doc_existe
		END

	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Documento não inserido.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[documento_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[documento_remover]
	@id_documento bigint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_documentos] WHERE id_documento = @id_documento)
		BEGIN		
			DELETE FROM [contratos].[tb_documentos]
				WHERE id_documento = @id_documento
			SET @mensagem = '1_Documento removido com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Documento não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Documento não removido.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[email_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[email_alterar]
	@id_email int
  , @id_empresa smallint
  , @id_tipo_contato tinyint
  ,	@email varchar(100)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_emails] WHERE id_email = @id_email)
		BEGIN
			UPDATE [contratos].[tb_emails]
			SET id_empresa = @id_empresa 
			  , id_tipo_contato = @id_tipo_contato
			  , email = @email
			  , ultima_alteracao = GETDATE()
			  , usuario_alteracao = @usuario_alteracao
			WHERE id_email = @id_email;
			SET @mensagem = '1_Email "' + @email + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Email "' + @email + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Email "' + @email + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[email_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[email_inserir]
    @id_empresa smallint
  , @id_tipo_contato tinyint
  , @email varchar(100)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_email int

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_emails] WHERE email = @email)
		BEGIN
			INSERT INTO [contratos].[tb_emails](id_empresa, id_tipo_contato, email, ultima_alteracao, usuario_alteracao)
			VALUES (@id_empresa, @id_tipo_contato, @email, GETDATE(), @usuario_alteracao);

			SET @id_email = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Email "' + @email + '" inserido com sucesso._' + CAST(@id_email AS varchar)
		END 
		ELSE
			SET @mensagem = '0_Email "' + @email + '" já existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Email "' + @email + '" não inserido.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[email_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[email_remover]
    @id_email smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_emails] WHERE id_email = @id_email)
		BEGIN
			DELETE FROM [contratos].[tb_emails] WHERE id_email = @id_email;
			SET @mensagem = '1_Email removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Email não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Email não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[empresa_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[empresa_alterar]
	@id_empresa smallint
  , @empresa varchar(200)
  , @cnpj bigint
  , @endereco varchar(20)
  , @cidade varchar(100)
  , @uf char(2)
  , @cep bigint
  , @observacao varchar(8000)
  , @ativo bit
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_empresas] WHERE id_empresa = @id_empresa)
		BEGIN
			UPDATE [contratos].[tb_empresas]
			SET empresa = @empresa 
			  , cnpj = @cnpj
			  , endereco = @endereco
   			  , cidade = @cidade
			  , uf = @uf
			  , cep = @cep
			  , observacao = @observacao
			  , ativo = @ativo
			  , ultima_alteracao = GETDATE()
			  , usuario_alteracao = @usuario_alteracao
			WHERE id_empresa = @id_empresa;
			SELECT '1_Empresa "' + @empresa + '" alterada com sucesso!'
		END
		ELSE
			SELECT '0_Empresa "' + @empresa + '" Empresa não existe!'
	END TRY
	BEGIN CATCH
		SELECT '0_Erro! Empresa "' + @empresa + '" não inserida!'
	END CATCH
END
GO
/****** Object:  StoredProcedure [contratos].[empresa_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[empresa_inserir]
    @empresa varchar(200)
  , @cnpj bigint
  , @endereco varchar(20)
  , @cidade varchar(100)
  , @uf char(2)
  , @cep bigint
  , @observacao varchar(8000)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_empresa int

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_empresas] WHERE cnpj = @cnpj AND ativo = 1)
		BEGIN
			INSERT INTO [contratos].[tb_empresas](empresa, cnpj, endereco, cidade, uf, cep,
												  observacao, ultima_alteracao, usuario_alteracao)
			VALUES (@empresa, @cnpj, @endereco, @cidade, @uf, @cep, @observacao, GETDATE(), @usuario_alteracao);

			SET @id_empresa = (SELECT SCOPE_IDENTITY())
		END
		ELSE
		BEGIN
			SET @id_empresa = (SELECT id_empresa FROM [contratos].[tb_empresas] WHERE cnpj = @cnpj)

			UPDATE [contratos].[tb_empresas]
			SET ativo = 1
			WHERE id_empresa = @id_empresa
		END

		SET @mensagem = '1_Empresa inserida com sucesso._' + CAST(@id_empresa AS varchar)
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Empresa "' + @empresa + '" não inserida!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[empresa_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[empresa_remover]
    @id_empresa varchar(200)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_empresas] WHERE id_empresa = @id_empresa)
		BEGIN
			UPDATE [contratos].[tb_empresas] SET ativo = 0, ultima_alteracao = GETDATE()
			WHERE id_empresa = @id_empresa

			SET @mensagem = '1_Empresa removida com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Empresa não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Empresa não removida.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[funcao_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[funcao_alterar]
	@id_funcao smallint
  ,	@funcao varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_funcoes] WHERE id_funcao = @id_funcao)
		BEGIN
			UPDATE [contratos].[tb_funcoes]
			SET funcao = @funcao 
			WHERE id_funcao = @id_funcao;
			SET @mensagem = '1_Função "' + @funcao + '" alterada com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Função "' + @funcao + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Função "' + @funcao + '" não alterada!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[funcao_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[funcao_inserir]
	  @id_funcao smallint
	, @funcao varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_funcoes] WHERE id_funcao = @id_funcao)
		BEGIN
			INSERT INTO [contratos].[tb_funcoes](id_funcao, funcao)
			VALUES (@id_funcao, @funcao);
			SET @mensagem = '1_Função "' + @funcao + '" inserida com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Função "' + @funcao + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Função "' + @funcao + '" não inserida!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[funcao_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[funcao_remover]
    @id_funcao smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_funcoes] WHERE id_funcao = @id_funcao)
		BEGIN
			DELETE FROM [contratos].[tb_funcoes] WHERE id_funcao = @id_funcao;
			SET @mensagem = '1_Função removida com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Função não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Função não removida!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[item_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[item_alterar]
	@id_item int
  , @item varchar(50)
  , @id_contrato int
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_itens] WHERE id_item = @id_item)
		BEGIN
			UPDATE [contratos].[tb_itens]
			SET item = @item 
			  , id_contrato = @id_contrato
			  , ultima_alteracao = GETDATE()
			  , usuario_alteracao = @usuario_alteracao
			WHERE id_item = @id_item;
			SET @mensagem = '1_Item "' + @item + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Item "' + @item + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Item "' + @item + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[item_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[item_inserir]
    @id_contrato int
  , @item varchar(50)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_item int
	DECLARE @ativo bit

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_itens] WHERE item = @item AND id_contrato = @id_contrato)
		BEGIN
			INSERT INTO [contratos].[tb_itens](item, id_contrato, ativo, ultima_alteracao, usuario_alteracao)
			VALUES (@item, @id_contrato, 1, GETDATE(), @usuario_alteracao);

			SET @id_item = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Item "' + @item + '" inserido com sucesso._' + CAST(@id_item AS varchar)
		END 
		ELSE
		BEGIN
			SELECT @ativo = ativo, @id_item = id_item
			FROM [contratos].[tb_itens] WHERE item = @item AND id_contrato = @id_contrato

			IF (@ativo = 0)
			BEGIN
				UPDATE [contratos].[tb_itens]
				SET ativo = 1, usuario_alteracao = @usuario_alteracao, ultima_alteracao = GETDATE()
				WHERE id_item = @id_item

				SET @mensagem = '1_Item "' + @item + '" inserido com sucesso._' + CAST(@id_item AS varchar)
			END
			ELSE
				SET @mensagem = '1_Item "' + @item + '" já existe.'
		END
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Item "' + @item + '" não inserido.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[item_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[item_remover]
	@id_item int
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_itens] WHERE id_item = @id_item)
		BEGIN
			UPDATE [contratos].[tb_itens] SET ativo = 0, usuario_alteracao = @usuario_alteracao WHERE id_item = @id_item;
			UPDATE [contratos].[tb_subitens] SET ativo = 0 WHERE id_item = @id_item;
			SET @mensagem = '1_Item removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Item não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Item não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[parcela_siplo_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [contratos].[parcela_siplo_alterar]
	@id_parcela_siplo int
  , @valor decimal(19,2)
  ,	@descricao varchar(8000)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_parcelas_siplo] WHERE id_parcela_siplo = @id_parcela_siplo)
		BEGIN
			UPDATE [contratos].[tb_parcelas_siplo]
			SET valor = @valor, descricao = @descricao, usuario_alteracao = @usuario_alteracao 
			WHERE id_parcela_siplo = @id_parcela_siplo;
			SET @mensagem = '1_Parcela Siplo alterada com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Parcela Siplo não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Parcela Siplo não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[parcela_siplo_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[parcela_siplo_inserir]
	  @id_ateste_pagamento int
	, @valor decimal(19, 2)
	, @descricao varchar(8000)
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_parcelas_siplo]
					  WHERE id_ateste_pagamento = @id_ateste_pagamento AND valor = @valor AND descricao = @descricao)
		BEGIN
			INSERT INTO [contratos].[tb_parcelas_siplo](id_ateste_pagamento, valor, descricao, usuario_alteracao)
			VALUES (@id_ateste_pagamento, @valor, @descricao, @usuario_alteracao);
			SET @mensagem = '1_Parcela Siplo inserida com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Parcela Siplo já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Parcela Siplo não inserida!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[parcela_siplo_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[parcela_siplo_remover]
    @id_parcela_siplo int
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_parcelas_siplo] WHERE id_parcela_siplo = @id_parcela_siplo)
		BEGIN
			DELETE FROM [contratos].[tb_parcelas_siplo] WHERE id_parcela_siplo = @id_parcela_siplo;
			SET @mensagem = '1_Parcela Siplo removida com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Parcela Siplo não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Parcela Siplo não removida!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[perfil_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[perfil_alterar]
	@id_perfil smallint
  ,	@perfil varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_perfis] WHERE id_perfil = @id_perfil)
		BEGIN
			UPDATE [contratos].[tb_perfis]
			SET perfil = @perfil 
			WHERE id_perfil = @id_perfil;
			SET @mensagem = '1_Perfil "' + @perfil + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Perfil "' + @perfil + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Perfil "' + @perfil + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[perfil_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[perfil_inserir]
	@perfil varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_perfis] WHERE perfil = @perfil)
		BEGIN
			INSERT INTO [contratos].[tb_perfis](perfil)
			VALUES (@perfil);
			SET @mensagem = '1_Perfil "' + @perfil + '" inserido com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Perfil "' + @perfil + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Perfil "' + @perfil + '" não inserido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[perfil_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[perfil_remover]
    @id_perfil smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_perfis] WHERE id_perfil = @id_perfil)
		BEGIN
			DELETE FROM [contratos].[tb_perfis] WHERE id_perfil = @id_perfil;
			SET @mensagem = '1_Perfil removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Perfil não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Perfil não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[subitem_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[subitem_alterar]
	@id_subitem int
  , @subitem varchar(50)
  , @id_item int
  , @qtd int
  , @valor_unitario decimal(19,2)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_subitens] WHERE id_subitem = @id_subitem)
		BEGIN
			UPDATE [contratos].[tb_subitens]
			SET subitem = @subitem 
			  , id_item = @id_item
			  , qtd = @qtd
			  , valor_unitario = @valor_unitario
			  , ultima_alteracao = GETDATE()
			  , usuario_alteracao = @usuario_alteracao
			WHERE id_subitem = @id_subitem;
			SET @mensagem = '1_Subitem "' + @subitem + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Subitem "' + @subitem + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Subitem "' + @subitem + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[subitem_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[subitem_inserir]
    @id_item int
  , @subitem varchar(50)
  , @qtd int
  , @valor_unitario decimal(19,2)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_subitem int
	DECLARE @ativo bit

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_subitens] WHERE subitem = @subitem AND id_item = @id_item)
		BEGIN
			INSERT INTO [contratos].[tb_subitens](subitem, id_item, qtd, valor_unitario, ativo, ultima_alteracao, usuario_alteracao)
			VALUES (@subitem, @id_item, @qtd, @valor_unitario, 1, GETDATE(), @usuario_alteracao);

			SET @id_subitem = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Subitem "' + @subitem + '" inserido com sucesso._' + CAST(@id_subitem AS varchar)
		END 
		ELSE
		BEGIN
			SELECT @ativo = ativo, @id_subitem = id_subitem FROM [contratos].[tb_subitens] WHERE subitem = @subitem AND id_item = @id_item
			IF (@ativo = 0)
			BEGIN
				UPDATE [contratos].[tb_subitens] SET ativo = 1, usuario_alteracao = @usuario_alteracao, ultima_alteracao = GETDATE() WHERE id_subitem = @id_subitem
				SET @mensagem = '1_Subitem "' + @subitem + '" inserido com sucesso._' + CAST(@id_subitem AS varchar)
			END
			ELSE 
				SET @mensagem = '0_Erro! Subitem "' + @subitem + '" já existe.'
		END
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Subitem "' + @subitem + '" não inserido.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[subitem_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[subitem_remover]
	@id_subitem int
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_subitens] WHERE id_subitem = @id_subitem)
		BEGIN
			UPDATE [contratos].[tb_subitens] SET ativo = 0, usuario_alteracao = @usuario_alteracao WHERE id_subitem = @id_subitem;
			SET @mensagem = '1_Subitem removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Subitem não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Subitem não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[telefone_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[telefone_alterar]
	@id_telefone int
  , @id_empresa smallint
  , @id_tipo_contato tinyint
  ,	@telefone varchar(11)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_telefones] WHERE id_telefone = @id_telefone)
		BEGIN
			UPDATE [contratos].[tb_telefones]
			SET id_empresa = @id_empresa 
			  , id_tipo_contato = @id_tipo_contato
			  , telefone = @telefone
			  , ultima_alteracao = GETDATE()
			  , usuario_alteracao = @usuario_alteracao
			WHERE id_telefone = @id_telefone;
			SET @mensagem = '1_Telefone "' + @telefone + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Telefone "' + @telefone + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Telefone "' + @telefone + '" não alterado!'
	END CATCH

	SELECT @mensagem

END
GO
/****** Object:  StoredProcedure [contratos].[telefone_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [contratos].[telefone_inserir]
    @id_empresa smallint
  , @id_tipo_contato tinyint
  , @telefone varchar(11)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_telefone int

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_telefones] WHERE telefone = @telefone)
		BEGIN
			INSERT INTO [contratos].[tb_telefones](id_empresa, id_tipo_contato, telefone, ultima_alteracao, usuario_alteracao)
			VALUES (@id_empresa, @id_tipo_contato, @telefone, GETDATE(), @usuario_alteracao);

			SET @id_telefone = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Telefone "' + @telefone + '" inserido com sucesso._' + CAST(@id_telefone AS varchar)
		END 
		ELSE
			SET @mensagem = '0_Telefone "' + @telefone + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Telefone "' + @telefone + '" não inserido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[telefone_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[telefone_remover]
    @id_telefone smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_telefones] WHERE id_telefone = @id_telefone)
		BEGIN
			DELETE FROM [contratos].[tb_telefones] WHERE id_telefone = @id_telefone;
			SET @mensagem = '1_Telefone removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Telefone não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Telefone não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[telefone_selecionar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[telefone_selecionar]
	@id_telefone int
AS
BEGIN

	SET NOCOUNT ON;

	IF @id_telefone IS NOT NULL
		SELECT id_telefone, id_empresa, id_tipo_contato, telefone, ultima_alteracao, usuario_alteracao
			FROM [contratos].[tb_telefones]
			WHERE id_telefone = @id_telefone
	ELSE
		SELECT id_telefone, id_empresa, id_tipo_contato, telefone, ultima_alteracao, usuario_alteracao
			FROM [contratos].[tb_telefones]
	RETURN
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_contato_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[tipo_contato_alterar]
	@id_tipo_contato tinyint
  ,	@tipo_contato varchar(50)
  , @ativo bit
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_contato] WHERE id_tipo_contato = @id_tipo_contato)
		BEGIN
			UPDATE [contratos].[tb_tipos_contato]
			SET tipo_contato = @tipo_contato 
			  , ativo = @ativo
			  , usuario_alteracao = @usuario_alteracao
			  , ultima_alteracao = GETDATE()
			WHERE id_tipo_contato = @id_tipo_contato;
			SET @mensagem = '1_Tipo Contato "' + @tipo_contato + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Tipo Contato "' + @tipo_contato + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo Contato "' + @tipo_contato + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_contato_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[tipo_contato_inserir]
	@tipo_contato varchar(50)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_tipo_contato tinyint
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_contato] WHERE tipo_contato = @tipo_contato)
		BEGIN
			INSERT INTO [contratos].[tb_tipos_contato](tipo_contato, usuario_alteracao, ultima_alteracao)
			VALUES (@tipo_contato, @usuario_alteracao, GETDATE());
			SET @id_tipo_contato = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Tipo Contato "' + @tipo_contato + '" inserido com sucesso._' + CAST(@id_tipo_contato AS varchar)
		END 
		ELSE
			SET @mensagem = '0_Tipo Contato "' + @tipo_contato + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo Contato "' + @tipo_contato + '" não inserido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_contato_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[tipo_contato_remover]
    @id_tipo_contato smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_contato] WHERE id_tipo_contato = @id_tipo_contato)
		BEGIN
			DELETE FROM [contratos].[tb_tipos_contato] WHERE id_tipo_contato = @id_tipo_contato;
			SET @mensagem = '1_Tipo contato removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Tipo contato não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo contato não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_contrato_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[tipo_contrato_alterar]
	@id_tipo_contrato tinyint
  ,	@tipo_contrato varchar(50)
  , @ativo bit
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_contrato] WHERE id_tipo_contrato = @id_tipo_contrato)
		BEGIN
			UPDATE [contratos].[tb_tipos_contrato]
			SET tipo_contrato = @tipo_contrato 
			  , ativo = @ativo
			  , usuario_alteracao = @usuario_alteracao
			  , ultima_alteracao = GETDATE()
			WHERE id_tipo_contrato = @id_tipo_contrato;
			SET @mensagem = '1_Tipo Contrato "' + @tipo_contrato + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Tipo Contrato "' + @tipo_contrato + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo Contrato "' + @tipo_contrato + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_contrato_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[tipo_contrato_inserir]
	@tipo_contrato varchar(50)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_tipo_contrato tinyint
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_contrato] WHERE tipo_contrato = @tipo_contrato)
		BEGIN
			INSERT INTO [contratos].[tb_tipos_contrato](tipo_contrato, ativo, usuario_alteracao, ultima_alteracao)
			VALUES (@tipo_contrato, 1, @usuario_alteracao, GETDATE());
			SET @id_tipo_contrato = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Tipo Contrato "' + @tipo_contrato + '" inserido com sucesso._' + CAST(@id_tipo_contrato AS varchar)
		END 
		ELSE
			SET @mensagem = '0_Tipo Contrato "' + @tipo_contrato + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo Contrato "' + @tipo_contrato + '" não inserido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_contrato_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[tipo_contrato_remover]
    @id_tipo_contrato smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_contrato] WHERE id_tipo_contrato = @id_tipo_contrato)
		BEGIN
			DELETE FROM [contratos].[tb_tipos_contrato] WHERE id_tipo_contrato = @id_tipo_contrato;
			SET @mensagem = '1_Tipo contrato removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Tipo contrato não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo contrato não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_documento_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[tipo_documento_alterar]
	@id_tipo_documento tinyint
  ,	@tipo_documento varchar(50)
  , @possui_validade bit
  , @id_dominio_documento tinyint
  , @ativo bit
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_documento] WHERE id_tipo_documento = @id_tipo_documento)
		BEGIN
			UPDATE [contratos].[tb_tipos_documento]
			SET tipo_documento = @tipo_documento 
			  , possui_validade = @possui_validade
			  , id_dominio_documento = @id_dominio_documento
			  , ativo = @ativo
			  , usuario_alteracao = @usuario_alteracao
			  , ultima_alteracao = GETDATE()
			WHERE id_tipo_documento = @id_tipo_documento;
			SET @mensagem = '1_Tipo documento "' + @tipo_documento + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Tipo documento "' + @tipo_documento + '" já existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo documento "' + @tipo_documento + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_documento_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[tipo_documento_inserir]
	@tipo_documento varchar(50)
  , @possui_validade bit
  , @id_dominio_documento tinyint
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_tipo_documento tinyint

	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_documento] WHERE tipo_documento = @tipo_documento)
		BEGIN
			INSERT INTO [contratos].[tb_tipos_documento](tipo_documento, possui_validade, id_dominio_documento,
														 usuario_alteracao, ultima_alteracao)
			VALUES (@tipo_documento, @possui_validade, @id_dominio_documento, @usuario_alteracao, GETDATE());

			SET @id_tipo_documento = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Tipo documento "' + @tipo_documento + '" inserido com sucesso._' + CAST(@id_tipo_documento AS varchar)
		END 
		ELSE
			SET @mensagem = '0_Tipo documento "' + @tipo_documento + '" já existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo documento "' + @tipo_documento + '" não inserido.'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_documento_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[tipo_documento_remover]
    @id_tipo_documento smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_documento] WHERE id_tipo_documento = @id_tipo_documento)
		BEGIN
			DELETE FROM [contratos].[tb_tipos_documento] WHERE id_tipo_documento = @id_tipo_documento;
			SET @mensagem = '1_Tipo documento removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Tipo documento não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo documento não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_penalidade_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[tipo_penalidade_alterar]
	@id_tipo_penalidade tinyint
  ,	@tipo_penalidade varchar(50)
  , @ativo bit
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_penalidade] WHERE id_tipo_penalidade = @id_tipo_penalidade)
		BEGIN
			UPDATE [contratos].[tb_tipos_penalidade]
			SET tipo_penalidade = @tipo_penalidade 
			  , ativo = @ativo
			  , usuario_alteracao = @usuario_alteracao
			  , ultima_alteracao = GETDATE()
			WHERE id_tipo_penalidade = @id_tipo_penalidade;
			SET @mensagem = '1_Tipo penalidade "' + @tipo_penalidade + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Tipo penalidade "' + @tipo_penalidade + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo penalidade "' + @tipo_penalidade + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_penalidade_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[tipo_penalidade_inserir]
	@tipo_penalidade varchar(50)
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	DECLARE @id_tipo_penalidade tinyint
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_penalidade] WHERE tipo_penalidade = @tipo_penalidade)
		BEGIN
			INSERT INTO [contratos].[tb_tipos_penalidade](tipo_penalidade, ativo, usuario_alteracao, ultima_alteracao)
			VALUES (@tipo_penalidade, 1, @usuario_alteracao, GETDATE());
			SET @id_tipo_penalidade = (SELECT SCOPE_IDENTITY())
			SET @mensagem = '1_Tipo Penalidade "' + @tipo_penalidade + '" inserido com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Tipo Penalidade "' + @tipo_penalidade + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo Penalidade "' + @tipo_penalidade + '" não inserido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[tipo_penalidade_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[tipo_penalidade_remover]
    @id_tipo_penalidade tinyint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_tipos_penalidade] WHERE id_tipo_penalidade = @id_tipo_penalidade)
		BEGIN
			DELETE FROM [contratos].[tb_tipos_penalidade] WHERE id_tipo_penalidade = @id_tipo_penalidade;
			SET @mensagem = '1_Tipo penalidade removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Tipo penalidade não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Tipo penalidade não removido!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[unidade_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[unidade_alterar]
	@id_unidade smallint
  ,	@unidade varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_unidades] WHERE id_unidade = @id_unidade)
		BEGIN
			UPDATE [contratos].[tb_unidades]
			SET unidade = @unidade 
			WHERE id_unidade = @id_unidade;
			SET @mensagem = '1_Unidade "' + @unidade + '" alterada com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Unidade "' + @unidade + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Unidade "' + @unidade + '" não alterada!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[unidade_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[unidade_inserir]
	  @id_unidade smallint
	, @unidade varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_unidades] WHERE id_unidade = @id_unidade)
		BEGIN
			INSERT INTO [contratos].[tb_unidades](id_unidade, unidade)
			VALUES (@id_unidade, @unidade);
			SET @mensagem = '1_Unidade "' + @unidade + '" inserida com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Unidade "' + @unidade + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Unidade "' + @unidade + '" não inserida!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[unidade_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[unidade_remover]
    @id_unidade smallint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_unidades] WHERE id_unidade = @id_unidade)
		BEGIN
			DELETE FROM [contratos].[tb_unidades] WHERE id_unidade = @id_unidade;
			SET @mensagem = '1_Unidade removida com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Unidade não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Unidade não removida!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[usuario_alterar]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[usuario_alterar]
	@id_usuario char(7)
  ,	@nome varchar(100)
  , @id_unidade smallint
  , @id_funcao smallint
  , @id_perfil tinyint
  , @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_usuarios] WHERE id_usuario = @id_usuario)
		BEGIN
			UPDATE [contratos].[tb_usuarios]
			SET nome = @nome
			  , id_unidade = @id_unidade
			  , id_funcao = @id_funcao
			  , id_perfil = @id_perfil
			  , ultima_alteracao = GETDATE()
			  , usuario_alteracao = @usuario_alteracao 
			WHERE id_usuario = @id_usuario;
			SET @mensagem = '1_Usuario "' + @id_usuario + '" alterado com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Usuario "' + @id_usuario + '" não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Usuario "' + @id_usuario + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[usuario_inserir]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [contratos].[usuario_inserir]
	  @id_usuario char(7)
	, @nome varchar(100)
	, @id_unidade smallint
	, @id_funcao smallint
	, @id_perfil tinyint
	, @usuario_alteracao char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_usuarios] WHERE id_usuario = @id_usuario)
		BEGIN
			INSERT INTO [contratos].[tb_usuarios](id_usuario, nome, id_unidade, id_funcao, id_perfil, ultima_alteracao, usuario_alteracao)
			VALUES (@id_usuario, @nome, @id_unidade, @id_funcao, @id_perfil, GETDATE(), @usuario_alteracao);
			SET @mensagem = '1_Usuario "' + @nome + '" inserido com sucesso.'
		END 
		ELSE
			SET @mensagem = '0_Usuario "' + @nome + '" já existe!'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Usuario "' + @nome + '" não alterado!'
	END CATCH

	SELECT @mensagem
END
GO
/****** Object:  StoredProcedure [contratos].[usuario_remover]    Script Date: 11/12/2020 17:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [contratos].[usuario_remover]
    @id_usuario char(7)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @mensagem varchar(255)

	BEGIN TRY
		IF EXISTS(SELECT TOP(1) 1 FROM [contratos].[tb_usuarios] WHERE id_usuario = @id_usuario)
		BEGIN
			DELETE FROM [contratos].[tb_usuarios] WHERE id_usuario = @id_usuario;
			SET @mensagem = '1_Usuário removido com sucesso.'
		END
		ELSE
			SET @mensagem = '0_Usuário não existe.'
	END TRY
	BEGIN CATCH
		SET @mensagem = '0_Erro! Usuário não removido!'
	END CATCH

	SELECT @mensagem
END
GO
