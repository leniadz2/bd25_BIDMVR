﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_stg_trns_03](
@fechaini date, @fechafin date)
AS
BEGIN

PRINT(concat('inicia transaccion 03 ',SYSDATETIME()));

---VENTASCAB---
INSERT INTO t_VENTASCAB
SELECT
      CONVERT(VARCHAR,F.FECHA,112) AS FECHA
      ,3 AS COD_EMPRESA
      ,DATEPART(WEEK,F.FECHA)AS SEMANA_VENTA
      ,DATEPART(MONTH,F.FECHA)AS MES_VENTA
      ,DATENAME(MONTH,F.FECHA)AS NOM_MES_VENTA
      ,F.FECHA AS FECHA_VENTA
      ,CASE 
            WHEN (DATEPART(hh,F.HORA)) <= 8 then '0. Sin asignar (0-8)'
            WHEN (DATEPART(hh,F.HORA)) between  9  and 11 then '1. Mañana (9-11)'
            WHEN (DATEPART(hh,F.HORA)) between  12 and 14 then '2. Almuerzo (12-14)'
            WHEN (DATEPART(hh,F.HORA)) between  15 and 17 then '3. Tarde (15-17)'
            WHEN (DATEPART(hh,F.HORA)) between  18 and 20 then '4. Cena (18-20)'
            WHEN (DATEPART(hh,F.HORA)) between  21 and 23 then '5. Noche (21-23)'
       END AS PARTE_DEL_DIA
      ,DATEPART(hh,F.HORA) AS HORA
      ,DATEPART(YEAR ,F.FECHA) AS ANO
      ,DATEPART(WEEKDAY ,F.FECHA) AS DIA_SEMANA
      ,DATEPART(DAY ,F.FECHA) AS DIA_FECHA
      ,CASE DATEPART(WEEKDAY,F.FECHA)
            WHEN 1 THEN 'Lunes'
            WHEN 2 THEN 'Martes' 
            WHEN 3 THEN 'Miércoles' 
            WHEN 4 THEN 'Jueves' 
            WHEN 5 THEN 'Viernes' 
            WHEN 6 THEN 'Sábado' 
            WHEN 7 THEN 'Domingo' END AS NOMBREDIASEMANA
      ,F.NUMSERIE
      ,F.NUMFACTURA
      ,F.TIPODOC
      ,F.CAJA
      ,C.CODCLIENTE
      ,L.CODALMACEN
      ,BASE=ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA *(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
      ,F.TOTALIMPUESTOS AS IMPUESTO
      ,F.TOTALNETO AS TOTAL
      ,AL.ESTADODELIVERY
FROM [10.110.21.9].[MNGDEMORST].DBO.FACTURASVENTA F 
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTACAB AL             WITH (NOLOCK)
        ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTALIN L              WITH (NOLOCK)
        ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.CLIENTES C                 WITH (NOLOCK)
        ON C.CODCLIENTE = F.CODCLIENTE
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.ARTICULOS AR               WITH (NOLOCK)
        ON (L.CODARTICULO=AR.CODARTICULO)
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.SERIESCAMPOSLIBRES SL      WITH (NOLOCK)
        ON (SL.SERIE=F.CAJA)
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.IMPUESTOS I                WITH (NOLOCK)
        ON (L.TIPOIMPUESTO=I.TIPOIVA)
WHERE F.FECHA >= @fechaini
  AND F.FECHA <= @fechafin
  AND F.N='B'
  AND F.NUMSERIE NOT IN ('BA3T','BB3T')--WA DOS ALMACENES POR SERIE
GROUP BY F.FECHA
        ,F.HORA
        ,F.NUMSERIE
        ,F.NUMFACTURA
        ,F.TOTALBRUTO
        ,F.TOTALIMPUESTOS
        ,F.TOTALNETO
        ,F.TIPODOC
        ,F.CAJA
        ,C.CODCLIENTE
        ,L.CODALMACEN
        ,AL.ESTADODELIVERY
ORDER BY F.NUMSERIE
        ,F.NUMFACTURA;

---VENTASLIN---
INSERT INTO t_VENTASLIN
SELECT 3 AS COD_EMPRESA
       ,L.NUMLIN
       ,L.CODARTICULO
       ,L.REFERENCIA
       ,ROUND(SUM(L.UNIDADESTOTAL),2) AS UNIDADESTOTAL
       ,L.CODALMACEN AS ALMACEN
       ,SUM(ROUND((L.COSTE)*(L.UNIDADESTOTAL),2)) AS COSTO
       ,F.NUMFACTURA
       ,F.NUMSERIE
       ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA *(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
       ,IMPUESTO=ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA *(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100))*L.IVA/100,3)
	   ,RECARGOC=ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA *(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100))*L.REQ/100,3)
       ,ISNULL(L.TIPODELIVERY,99)
FROM [10.110.21.9].[MNGDEMORST].DBO.FACTURASVENTA F 
    INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTACAB AL            WITH (NOLOCK)
        ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
    INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTALIN L             WITH (NOLOCK)
        ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.CLIENTES C                 WITH (NOLOCK)
        ON C.CODCLIENTE = F.CODCLIENTE
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.ARTICULOS AR               WITH (NOLOCK)
        ON (L.CODARTICULO=AR.CODARTICULO)
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.SERIESCAMPOSLIBRES SL      WITH (NOLOCK)
        ON (SL.SERIE=F.CAJA)
    LEFT JOIN [10.110.21.9].[MNGDEMORST].DBO.IMPUESTOS I                WITH (NOLOCK)
        ON (L.TIPOIMPUESTO=I.TIPOIVA)
WHERE F.FECHA >= @fechaini
  AND F.FECHA <= @fechafin
  AND L.DETALLEDENUMLINEA=0
  AND F.N='B'
GROUP BY L.NUMLIN
        ,L.CODARTICULO
        ,L.REFERENCIA
        ,L.NUMSERIE
        ,L.CODALMACEN
        ,F.NUMFACTURA
        ,F.NUMSERIE
        ,L.IVA
        ,L.REQ
        ,L.TIPODELIVERY
ORDER BY F.NUMSERIE
        ,F.NUMFACTURA
        ,l.NUMLIN;



END
GO