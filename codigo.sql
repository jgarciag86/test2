USE [DB_DESAROLLLO]
GO
/****** Object:  StoredProcedure [dbo].[Svc_TTAB_VAL_MON_VerValorDolarUF_v2]    Script Date: 11/06/2017 20:39:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Svc_TTAB_VAL_MON_VerValorDolarUF_v2]
@Fec_Cse VARCHAR(10) 

AS
/********************************************************************
AUTOR		: jose.
FECHA		: 24/05/2017
PROPÓSITO	: Entrega Valor del Dolar y UF segun fecha ingresada
EJECUCIÓN	: EXEC Svc_TTAB_VAL_MON_VerValorDolarUF_v2 '20170619'
*********************************************************************/
BEGIN

BEGIN TRANSACTION

DECLARE @val_mon_cod SMALLINT
DECLARE @val_tip_cmb_fec DATETIME
DECLARE @val_vta DECIMAL(12,4)
DECLARE @val_mon_cod2 SMALLINT
DECLARE @val_tip_cmb_fec2 DATETIME
DECLARE @val_vta2 DECIMAL(12,4)

DECLARE @Fec_Cse1 SMALLDATETIME  = convert(datetime, @Fec_Cse, 103)

-- 88888888888888888888888888888888888888888888888

	-- DOLAR
	SELECT TOP 1
		 @val_mon_cod = [val_mon_cod]
		,@val_tip_cmb_fec = [val_tip_cmb_fec]
		,@val_vta = [val_vta]
	FROM [dbo].[ttab_val_mon] WITH (NOLOCK)
	WHERE [val_mon_cod] = 13
	AND [val_tip_cmb_cod] = 'BCCH'
	AND [val_tip_val] = 0
	AND [val_tip_cmb_fec] = @Fec_Cse1
	ORDER BY [val_tip_cmb_fec] DESC

-- 88888888888888888888888888888888888888888888888

	-- UF
	SELECT TOP 1
		 @val_mon_cod2 = [val_mon_cod]
		,@val_tip_cmb_fec2 = [val_tip_cmb_fec]
		,@val_vta2 = [val_vta]
	FROM [dbo].[ttab_val_mon] WITH (NOLOCK)
	WHERE [val_mon_cod] = 998
	AND [val_tip_cmb_cod] = 'BANCO'
	AND [val_tip_val] = 0
	AND [val_tip_cmb_fec] = @Fec_Cse1
	ORDER BY [val_tip_cmb_fec] DESC

-- 88888888888888888888888888888888888888888888888

SELECT
@val_mon_cod AS Cod_Mon_Dol,  
@val_tip_cmb_fec AS Fec_Dol, 
@val_vta AS Valor_Dol, 
@val_mon_cod2 AS Cod_Mon_UF,  
@val_tip_cmb_fec2 AS Fec_UF, 
@val_vta2 AS Valor_UF 



IF @@ERROR = 0
	COMMIT TRANSACTION
ELSE
	ROLLBACK TRANSACTION

END
