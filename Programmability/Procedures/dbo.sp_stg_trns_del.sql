SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_stg_trns_del] (@strgfini NVARCHAR(8), @strgffin NVARCHAR(8), @datefini DATE, @dateffin DATE)
AS
BEGIN

  --BEGIN TRANSACTION;

  --    DELETE LIN
  --    FROM DBO.VENTASLIN AS LIN
  --            INNER JOIN
  --         DBO.VENTASCAB AS CAB
  --             ON CAB.COD_EMPRESA = LIN.COD_EMPRESA
  --            AND CAB.NUMSERIE = LIN.NUMSERIE
  --            AND CAB.NUMCORRELATIVO = LIN.NUMCORRELATIVO
  --    WHERE CAB.FECHA >= @strgfini
  --      AND CAB.FECHA <= @strgffin;

  --    DELETE FROM DBO.VENTASCAB
  --    WHERE FECHA >= @strgfini
  --      AND FECHA <= @strgffin;

  --    DELETE FROM DBO.
  --    WHERE FECHA >= @strgfini
  --      AND FECHA <= @strgffin;

  --COMMIT TRANSACTION;

  --EXEC sp_stg_trns_01 @datefini,@dateffin;
  --EXEC sp_stg_trns_02 @datefini,@dateffin;
  --EXEC sp_stg_trns_03 @datefini,@dateffin;
  --EXEC sp_stg_trns_04 @datefini,@dateffin;
  --EXEC sp_stg_trns_05 @datefini,@dateffin;
  --EXEC sp_stg_trns_06 @datefini,@dateffin;

  BEGIN TRANSACTION;

  DELETE FROM DBO.VENTASDET_V
  WHERE FECHA >= @strgfini
    AND FECHA <= @strgffin;

  COMMIT TRANSACTION;

--EXEC sp_stg_trns_tablon @strgfini,@strgffin;

END
GO