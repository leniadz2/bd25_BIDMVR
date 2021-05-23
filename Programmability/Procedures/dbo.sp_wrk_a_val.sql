SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_wrk_a_val]
AS
BEGIN

PRINT(concat('inicia tablas cuadre',SYSDATETIME()));

declare @datefcur date;
declare @datefini date;
declare @dateffin date;
declare @strgfcur nvarchar(80);
declare @strgfini nvarchar(8);
declare @strgffin nvarchar(8);

set @datefcur = getdate();
set @datefini = getdate()-263;
set @dateffin = getdate()-1;

set @strgfcur = CONVERT(varchar, getdate(), 120);
set @strgfini = CONVERT(varchar, @datefini, 112);
set @strgffin = CONVERT(varchar, @dateffin, 112);


TRUNCATE TABLE BIDMVR..w_val_a_s_01    ;
TRUNCATE TABLE BIDMVR..w_val_a_s_02    ;
TRUNCATE TABLE BIDMVR..w_val_a_d_01    ;
TRUNCATE TABLE BIDMVR..w_val_a_d_02    ;


   --ICG a nivel de fecha (w_val_a_s_01) y fecha/documento (w_val_a_s_02)

   --1 | PANISTERIA
   
   BEGIN

      INSERT INTO DBO.w_val_a_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[PANISTERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '1'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
       ORDER BY 1,2,3;

      INSERT INTO DBO.w_val_a_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[PANISTERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '1'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3,4,5;

   END;

   --2 | LIBRERIA

   BEGIN

      INSERT INTO DBO.w_val_a_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[LIBRERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '2'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
       ORDER BY 1,2,3;
      
      INSERT INTO DBO.w_val_a_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[LIBRERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '2'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3,4,5;

   END;

   --3 | GTT

   BEGIN

      INSERT INTO DBO.w_val_a_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGDEMORST].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '3'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
       ORDER BY 1,2,3;
      
      INSERT INTO DBO.w_val_a_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGDEMORST].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '3'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3,4,5;

   END;
       
   --4 | PAPAS

   BEGIN

      INSERT INTO DBO.w_val_a_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGPAPAS].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '4'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
       ORDER BY 1,2,3;
      
      INSERT INTO DBO.w_val_a_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGPAPAS].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '4'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3,4,5;

   END;

   --5 | DONBUFFET

   BEGIN

      INSERT INTO DBO.w_val_a_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MEDITERRANEO].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '5'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
       ORDER BY 1,2,3;
      
      INSERT INTO DBO.w_val_a_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MEDITERRANEO].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '5'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3,4,5;

   END;

   --6 | MEDITERRANEO
   
   BEGIN

      INSERT INTO DBO.w_val_a_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.100.150.70].[MEDITERRANEOQA].DBO.FACTURASVENTA F 
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '6'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
       ORDER BY 1,2,3;
      
      INSERT INTO DBO.w_val_a_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,T.COD_EMPRESA
             ,T.NOM_TIENDA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.100.150.70].[MEDITERRANEOQA].DBO.FACTURASVENTA F 
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
             INNER JOIN TIENDAS AS T ON T.NUMSERIE COLLATE DATABASE_DEFAULT = F.NUMSERIE
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND T.COD_EMPRESA = '6'
       GROUP BY F.FECHA,T.COD_EMPRESA,T.NOM_TIENDA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3,4,5;

   END;

   --DM a nivel de fecha
   INSERT INTO DBO.w_val_a_d_01
   select fecha,
          COD_EMPRESA,
          NOM_TIENDA,
          sum(TOTAL_L) as base
     from VENTASDET_V
    where fecha >= @strgfini
      and fecha <= @strgffin
      and tventa = 'BASE'
    group by fecha, COD_EMPRESA, NOM_TIENDA
    order by 1,2,3;

   --DM a nivel de fecha/documento
   INSERT INTO DBO.w_val_a_d_02
   select fecha,
          COD_EMPRESA,
          NOM_TIENDA,
          numserie,
          numcorrelativo,
          sum(TOTAL_L) as base
     from VENTASDET_V
    where fecha >= @strgfini
      and fecha <= @strgffin
      and tventa = 'BASE'
    group by fecha, COD_EMPRESA, NOM_TIENDA,
          numserie,
          numcorrelativo
    order by 1,2,3,4,5;

   --CUADRES
   --cuadre historico a nivel de fecha
   INSERT INTO DBO.w_val_a_r_01
   select s.fecha,
          s.COD_EMPRESA,
          s.NOM_TIENDA,
          s.base,
          d.fecha,
          d.COD_EMPRESA,
          d.NOM_TIENDA,
          d.base,
          s.base - d.base,
          @strgfcur as fhoracarga
     from w_val_a_s_01 as s 
            full outer join w_val_a_d_01 as d 
              on s.fecha = d.fecha 
             and s.NOM_TIENDA = d.NOM_TIENDA
 order by s.fecha, s.COD_EMPRESA, s.NOM_TIENDA, d.NOM_TIENDA;

   --cuadre historico a nivel de fecha/documento
   INSERT INTO DBO.w_val_a_r_02
   select s.fecha,
          s.COD_EMPRESA,
          s.NOM_TIENDA,
          s.numserie,
          s.numfactura,
          s.base,
          d.fecha,
          d.COD_EMPRESA,
          d.NOM_TIENDA,
          d.numserie,
          d.numfactura,
          d.base,
          s.base - d.base,
          @strgfcur as fhoracarga
     from w_val_a_s_02 as s 
            full outer join w_val_a_d_02 as d
              on s.fecha = d.fecha
             and s.NOM_TIENDA = d.NOM_TIENDA 
             and s.numserie = d.numserie 
             and s.numfactura = d.numfactura
 order by s.fecha, s.COD_EMPRESA, s.NOM_TIENDA, d.NOM_TIENDA, s.numserie, d.numserie, s.numfactura, d.numfactura;

   TRUNCATE table w_VAL_CUADRE_F01;
   TRUNCATE table w_VAL_CUADRE_F02;
   TRUNCATE table VAL_CUADRE_F;

   --cuadre reciente a nivel de fecha, tienda
   INSERT INTO w_VAL_CUADRE_F01
   SELECT FECHA_ICG
         ,COD_EMPRESA_ICG
         ,NOM_TIENDA_ICG
         ,BASE_ICG
         ,fecha_DM
         ,COD_EMPRESA_DM
         ,NOM_TIENDA_DM
         ,BASE_DM
         ,delta
         ,FHORACARGA
         ,ROW_NUMBER() OVER (PARTITION BY FECHA_ICG, FECHA_DM, COD_EMPRESA_ICG, COD_EMPRESA_DM, NOM_TIENDA_ICG, NOM_TIENDA_DM ORDER BY FHORACARGA DESC) AS ORDEN
     FROM [BIDMVR].[dbo].[w_val_a_r_01];
   
   INSERT INTO w_VAL_CUADRE_F02
   SELECT FECHA_ICG
         ,COD_EMPRESA_ICG
         ,NOM_TIENDA_ICG
         ,BASE_ICG
         ,fecha_DM
         ,COD_EMPRESA_DM
         ,NOM_TIENDA_DM
         ,BASE_DM
         ,delta
         ,FHORACARGA
     FROM w_VAL_CUADRE_F01
    WHERE ORDEN = 1
    ORDER BY FECHA_ICG, FECHA_DM, COD_EMPRESA_ICG, COD_EMPRESA_DM, NOM_TIENDA_ICG, NOM_TIENDA_DM;

   INSERT INTO VAL_CUADRE_F
   SELECT IIF(FECHA_ICG       IS NULL, FECHA_DM      , FECHA_ICG      ) AS FECHA,
          IIF(COD_EMPRESA_ICG IS NULL, COD_EMPRESA_DM, COD_EMPRESA_ICG) AS COD_EMPRESA,
          IIF(NOM_TIENDA_ICG  IS NULL, NOM_TIENDA_DM , NOM_TIENDA_ICG ) AS NOM_TIENDA,
          BASE_ICG,
          BASE_DM,
          ROUND(IIF(BASE_ICG IS NULL, 0, BASE_ICG) - IIF(BASE_DM IS NULL, 0, BASE_DM),3) AS DELTA
     FROM (select * from w_VAL_CUADRE_F02
            where cod_empresa_icg IS NOT NULL
           union
           select * from w_VAL_CUADRE_F02
            where cod_empresa_dm  IS NOT NULL) AS T
    ORDER BY FECHA,
          COD_EMPRESA,
          NOM_TIENDA;

   TRUNCATE table w_VAL_CUADRE_D01;
   TRUNCATE table w_VAL_CUADRE_D02;
   TRUNCATE table VAL_CUADRE_D;

   --cuadre reciente a nivel de fecha, tienda, documento
   INSERT INTO w_VAL_CUADRE_D01
   SELECT FECHA_ICG
         ,COD_EMPRESA_ICG
         ,NOM_TIENDA_ICG
         ,NUMSERIE_ICG
         ,NUMFACTURA_ICG
         ,BASE_ICG
         ,fecha_DM
         ,COD_EMPRESA_DM
         ,NOM_TIENDA_DM
         ,NUMSERIE_DM
         ,NUMFACTURA_DM
         ,BASE_DM
         ,delta
         ,FHORACARGA
         ,ROW_NUMBER() OVER (PARTITION BY FECHA_ICG, FECHA_DM, COD_EMPRESA_ICG, COD_EMPRESA_DM, NOM_TIENDA_ICG, NOM_TIENDA_DM, NUMSERIE_ICG, NUMSERIE_DM, NUMFACTURA_ICG, NUMFACTURA_DM ORDER BY FHORACARGA DESC) AS ORDEN
     FROM [BIDMVR].[dbo].[w_val_a_r_02];
   
--   INSERT INTO VAL_CUADRE_D
   INSERT INTO w_VAL_CUADRE_D02
   SELECT FECHA_ICG
         ,COD_EMPRESA_ICG
         ,NOM_TIENDA_ICG
         ,NUMSERIE_ICG
         ,NUMFACTURA_ICG
         ,BASE_ICG
         ,fecha_DM
         ,COD_EMPRESA_DM
         ,NOM_TIENDA_DM
         ,NUMSERIE_DM
         ,NUMFACTURA_DM
         ,BASE_DM
         ,delta
         ,FHORACARGA
     FROM w_VAL_CUADRE_D01
    WHERE ORDEN = 1
    ORDER BY FECHA_ICG, FECHA_DM, COD_EMPRESA_ICG, COD_EMPRESA_DM, NOM_TIENDA_ICG, NOM_TIENDA_DM, NUMSERIE_ICG, NUMSERIE_DM, NUMFACTURA_ICG, NUMFACTURA_DM;

   INSERT INTO VAL_CUADRE_D
   SELECT IIF(FECHA_ICG       IS NULL, FECHA_DM      , FECHA_ICG      ) AS FECHA,
          IIF(COD_EMPRESA_ICG IS NULL, COD_EMPRESA_DM, COD_EMPRESA_ICG) AS COD_EMPRESA,
          IIF(NOM_TIENDA_ICG  IS NULL, NOM_TIENDA_DM , NOM_TIENDA_ICG ) AS NOM_TIENDA,
          IIF(NUMSERIE_ICG    IS NULL, NUMSERIE_DM   , NUMSERIE_ICG   ) AS NUMSERIE,
          IIF(NUMFACTURA_ICG  IS NULL, NUMFACTURA_DM , NUMFACTURA_ICG ) AS NUMFACTURA,
          BASE_ICG,
          BASE_DM,
          ROUND(IIF(BASE_ICG IS NULL, 0, BASE_ICG) - IIF(BASE_DM IS NULL, 0, BASE_DM),3) AS DELTA
     FROM (select * from w_VAL_CUADRE_D02
            where cod_empresa_icg IS NOT NULL
           union
           select * from w_VAL_CUADRE_D02
            where cod_empresa_dm  IS NOT NULL) AS T
END
GO