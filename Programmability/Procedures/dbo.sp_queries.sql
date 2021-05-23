SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_queries]
AS
BEGIN

--dm
SELECT C.fecha
      ,C.NOM_TIENDA
      ,C.descripcion
      ,C.CONTA
      ,S.SUMA
  FROM (SELECT fecha
              ,NOM_TIENDA
              ,descripcion
              ,COUNT(*) AS CONTA
          FROM (SELECT DISTINCT fecha
                      ,NOM_TIENDA
                      ,NUMSERIE
                      ,NUMCORRELATIVO
                      ,descripcion
                      ,tventa
                  FROM ventasdet_v
                 WHERE fecha >= '20201001'
                   AND cod_empresa = '6'
                   AND tventa = 'BASE'
              ) AS T
          GROUP BY fecha
              ,NOM_TIENDA
              ,descripcion
      ) AS C INNER JOIN (
        SELECT fecha
              ,NOM_TIENDA
              ,descripcion
              ,ROUND(sum(total_l),2) AS SUMA
          FROM ventasdet_v
         WHERE fecha >= '20201001'
           AND cod_empresa = '6'
           AND tventa = 'BASE'
         GROUP BY fecha
              ,NOM_TIENDA
              ,descripcion
      ) AS S ON C.fecha = S.fecha
            AND C.NOM_TIENDA = S.NOM_TIENDA
            AND C.descripcion = S.descripcion
 ORDER BY 1,2,3,4;


/*
en las bases de datos de los restaurantes

 SELECT CONVERT(VARCHAR,C.FECHA,112) AS FECHA,
       C.SERIE,
       C.NUMERO,
       L.TIPODELIVERY,
       D.DESCRIPCION,
       MAX(C.BASEIMP1)--, --<-- BIEN
       --BASE=ROUND(SUM(L.UNIDADES*L.PRECIO*(1-L.DTO/100)), 3) --<-MAL
  FROM TIQUETSCAB C
         INNER JOIN TIQUETSLIN L
           ON C.SERIE = L.SERIE AND C.NUMERO = L.NUMERO AND C.N = L.N
         INNER JOIN TIPOSERVICIOSDELIVERY D
           ON L.TIPODELIVERY = D.TIPO 
 WHERE C.FECHA >= '20200515'
   and C.FECHA <= '20200516'
-- WHERE C.FECHA > CONCAT(FORMAT(YEAR(CURRENT_TIMESTAMP), '0000'),FORMAT(MONTH(CURRENT_TIMESTAMP) - 1, '00'),FORMAT(DAY(CURRENT_TIMESTAMP) - 1, '00'))
   AND L.DETALLEDENUMLINEA=0
   AND C.N='B'
   
      
 GROUP BY C.FECHA, C.SERIE, C.NUMERO, L.TIPODELIVERY, D.DESCRIPCION
 order by 3;

*/

-- select distinct
--NOM_TIENDA
--from tiendas
--where COD_EMPRESA = '6'
--and NOM_TIENDA is not null
--order by 2, 1;


 --servidor 70
/*with cte_tienda as (
select 'B318' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'B319' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'BN18' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'BN19' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'F318' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'F319' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'FN18' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'FN19' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'B343' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B344' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B345' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B346' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'BC43' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'BC44' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'BC45' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F343' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F344' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F345' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F346' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'FC43' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'FC44' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'FC45' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B400' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'B401' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'BC40' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'BC41' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'F400' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'F401' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'FC40' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'FC41' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'B300' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B301' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B302' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B600' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B601' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B602' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BB1G' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC30' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC31' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC32' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC60' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC61' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC62' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F300' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F301' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F302' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F600' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F601' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F602' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC30' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC31' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC32' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC60' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC61' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC62' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B500' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'B501' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'BC50' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'BC51' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'F500' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'F501' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'FC50' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'FC51' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'B200' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'B201' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'B202' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'BC20' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'BC21' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'BC22' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'F200' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'F201' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'F202' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'FC20' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'FC21' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'FC22' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda
)
SELECT CONVERT(VARCHAR,F.FECHA,112) AS FECHA
      --,AL.NUMSERIE
      --,AL.NUMALBARAN
      ,t.tienda
      --,l.TIPODELIVERY
      ,td.DESCRIPCION
      ,IMPUESTO=ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA *(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100))*L.IVA/100,3)
      ,RECARGOC=ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA *(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100))*L.REQ/100,3)
      ,TOTAL =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
  FROM DBO.FACTURASVENTA F
         INNER JOIN DBO.ALBVENTACAB AL            WITH (NOLOCK)
           ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
         INNER JOIN DBO.ALBVENTALIN L             WITH (NOLOCK)
           ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
         INNER JOIN cte_tienda T
           on t.serie = al.NUMSERIE
         left JOIN TIPOSERVICIOSDELIVERY TD
           on td.TIPO = l.TIPODELIVERY
 WHERE F.FECHA >= '20201001'
--   AND F.FECHA <= '20200801'
   AND L.DETALLEDENUMLINEA=0
   AND F.N='B'
 GROUP BY F.FECHA
       --,AL.NUMSERIE
       --,AL.NUMALBARAN
       ,t.tienda
       --,l.TIPODELIVERY
       ,td.DESCRIPCION
       ,L.IVA
       ,L.REQ
ORDER BY 1,2,3;

----------------------------------

with cte_tienda as (
select 'B318' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'B319' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'BN18' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'BN19' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'F318' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'F319' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'FN18' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'FN19' as serie, 'MEDITERRANEO PATIO DE COMIDAS MDS' as tienda union all
select 'B343' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B344' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B345' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B346' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'BC43' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'BC44' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'BC45' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F343' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F344' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F345' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'F346' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'FC43' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'FC44' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'FC45' as serie, 'MEDITERRANEO RESTAURANTE BENAVIDES' as tienda union all
select 'B400' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'B401' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'BC40' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'BC41' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'F400' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'F401' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'FC40' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'FC41' as serie, 'MEDITERRANEO RESTAURANTE CCPN' as tienda union all
select 'B300' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B301' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B302' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B600' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B601' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B602' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BB1G' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC30' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC31' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC32' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC60' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC61' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'BC62' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F300' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F301' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F302' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F600' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F601' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'F602' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC30' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC31' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC32' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC60' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC61' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'FC62' as serie, 'MEDITERRANEO RESTAURANTE FERRERO' as tienda union all
select 'B500' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'B501' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'BC50' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'BC51' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'F500' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'F501' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'FC50' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'FC51' as serie, 'MEDITERRANEO RESTAURANTE MDS' as tienda union all
select 'B200' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'B201' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'B202' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'BC20' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'BC21' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'BC22' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'F200' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'F201' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'F202' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'FC20' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'FC21' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda union all
select 'FC22' as serie, 'MEDITERRANEO RESTAURANTE POLO' as tienda
)
SELECT  CTD.FECHA
       --,CTD.TIPODELIVERY
       ,t.tienda
       ,td.DESCRIPCION,
       COUNT(*) AS CONTA
  FROM ( SELECT DISTINCT CONVERT(VARCHAR,F.FECHA,112) AS FECHA,
                AL.NUMSERIE,
                AL.NUMALBARAN,
                l.TIPODELIVERY
           FROM DBO.FACTURASVENTA F
                  INNER JOIN DBO.ALBVENTACAB AL            WITH (NOLOCK)
                    ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
                  INNER JOIN DBO.ALBVENTALIN L             WITH (NOLOCK)
                    ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
          WHERE F.FECHA >= '20201001'
            --AND F.FECHA <= '20201001'
            AND L.DETALLEDENUMLINEA=0
            AND F.N='B' ) AS CTD
         INNER JOIN cte_tienda T
           on t.serie = CTD.NUMSERIE
         left JOIN TIPOSERVICIOSDELIVERY TD
           on td.TIPO = CTD.TIPODELIVERY
 GROUP BY CTD.FECHA
         --,CTD.TIPODELIVERY
         ,t.tienda
         ,td.DESCRIPCION
 ORDER BY 1,2,3
;
*/
END
GO