SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_main_auto] 
AS
BEGIN

declare @fechaD date;
declare @fechaS nvarchar(8);

declare @strgfini nvarchar(8);
declare @strgffin nvarchar(8);
declare @datefini date;
declare @dateffin date;

SET DATEFIRST 1;

set @fechaD = CONVERT(date,getdate()-1);
set @fechaS = CONVERT(varchar, getdate()-1, 112);

--set @datefini = CONVERT(date,CONCAT(SUBSTRING(@strgfini, 1, 4), '-', SUBSTRING(@strgfini, 5, 2), '-', SUBSTRING(@strgfini, 7, 2)));
--set @dateffin = CONVERT(date,CONCAT(SUBSTRING(@strgffin, 1, 4), '-', SUBSTRING(@strgffin, 5, 2), '-', SUBSTRING(@strgffin, 7, 2)));

EXEC sp_stg_maestros_00;
EXEC sp_stg_maestros_01;
EXEC sp_stg_maestros_02;
EXEC sp_stg_maestros_03;
EXEC sp_stg_maestros_04;
EXEC sp_stg_maestros_05;
EXEC sp_stg_maestros_06;

--TRUNCA TABLAS TEMPORALES (TRANSACCIONES)
TRUNCATE TABLE BIDMVR..t_VENTASCAB     ;
TRUNCATE TABLE BIDMVR..t_VENTASLIN     ;
TRUNCATE TABLE BIDMVR..t_VENTASDET     ;
TRUNCATE TABLE BIDMVR..t_VENTASDET_V   ;

EXEC sp_stg_trns_01 @fechaD,@fechaD;
EXEC sp_stg_trns_02 @fechaD,@fechaD;
EXEC sp_stg_trns_03 @fechaD,@fechaD;
EXEC sp_stg_trns_04 @fechaD,@fechaD;
EXEC sp_stg_trns_05 @fechaD,@fechaD;
EXEC sp_stg_trns_06 @fechaD,@fechaD;

--DELETE REGISTROS TABLA FINAL TRANSACCIONES (VENTASDET_V)
--EXEC sp_stg_trns_del @strgfini, @strgffin, @datefini, @dateffin;

EXEC sp_stg_trns_tablon fechaS,fechaS;

EXEC sp_stg_wa_cleansing;

-- LOG DE DATOS NUEVOS

EXEC sp_wrk_a_val;

END
GO