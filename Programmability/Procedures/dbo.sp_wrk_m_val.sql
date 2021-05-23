SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_wrk_m_val]
AS
BEGIN

declare @strgfini nvarchar(8);
declare @strgffin nvarchar(8);
declare @cCodEmpresa char(1);
declare @cNomTienda nvarchar(50);

declare @datefini date;
declare @dateffin date;

set @strgfini = '20200817';
set @strgffin = '20200817';
set @cCodEmpresa = '6';
set @cNomTienda  = 'MEDITERRANEO RESTAURANTE FERRERO';

set @datefini = CONVERT(date,CONCAT(SUBSTRING(@strgfini, 1, 4), '-', SUBSTRING(@strgfini, 5, 2), '-', SUBSTRING(@strgfini, 7, 2)));
set @dateffin = CONVERT(date,CONCAT(SUBSTRING(@strgffin, 1, 4), '-', SUBSTRING(@strgffin, 5, 2), '-', SUBSTRING(@strgffin, 7, 2)));

TRUNCATE TABLE BIDMVR..w_val_m_s_01    ;
TRUNCATE TABLE BIDMVR..w_val_m_s_02    ;
TRUNCATE TABLE BIDMVR..w_val_m_d_01    ;
TRUNCATE TABLE BIDMVR..w_val_m_d_02    ;
TRUNCATE TABLE BIDMVR..w_val_m_r_01    ;
TRUNCATE TABLE BIDMVR..w_val_m_r_02    ;

--1 | PANISTERIA
------------------
IF @cCodEmpresa = '1'
   
   BEGIN

      INSERT INTO DBO.w_val_m_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[PANISTERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
       ORDER BY 1;
      
      INSERT INTO DBO.w_val_m_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[PANISTERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[PANISTERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3;

   END;

   --2 | LIBRERIA
   ------------------
IF @cCodEmpresa = '2'

   BEGIN

      INSERT INTO DBO.w_val_m_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[LIBRERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
       ORDER BY 1;
      
      INSERT INTO DBO.w_val_m_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[LIBRERIA].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[LIBRERIA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3;

   END;

   --3 | GTT
   ------------------
IF @cCodEmpresa = '3'

   BEGIN

      INSERT INTO DBO.w_val_m_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGDEMORST].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
       ORDER BY 1;
      
      INSERT INTO DBO.w_val_m_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGDEMORST].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGDEMORST].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3;

   END;
       
   --4 | PAPAS
   ------------------
IF @cCodEmpresa = '4'

   BEGIN

      INSERT INTO DBO.w_val_m_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGPAPAS].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
       ORDER BY 1;
      
      INSERT INTO DBO.w_val_m_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MNGPAPAS].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MNGPAPAS].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3;

   END;

   --5 | DONBUFFET
   ------------------
IF @cCodEmpresa = '5'

   BEGIN

      INSERT INTO DBO.w_val_m_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MEDITERRANEO].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
       ORDER BY 1;
      
      INSERT INTO DBO.w_val_m_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.110.21.9].[MEDITERRANEO].DBO.FACTURASVENTA F 
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.110.21.9].[MEDITERRANEO].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3;

   END;

   --6 | MEDITERRANEO
   ------------------
IF @cCodEmpresa = '6'

   BEGIN

      INSERT INTO DBO.w_val_m_s_01
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.100.150.70].[MEDITERRANEOQA].DBO.FACTURASVENTA F 
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
       ORDER BY 1;
      
      INSERT INTO DBO.w_val_m_s_02
      SELECT  CONVERT(VARCHAR,F.FECHA,112) AS FECHA
             ,F.NUMSERIE
             ,F.NUMFACTURA
             ,BASE =ROUND(SUM(L.PRECIO * L.UNIDADESTOTAL* F.FACTORMONEDA*(1-L.DTO/100)*(1-AL.DTOCOMERCIAL/100)*(1-AL.DTOPP/100)),3)
        FROM [10.100.150.70].[MEDITERRANEOQA].DBO.FACTURASVENTA F 
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTACAB AL            WITH (NOLOCK)
                   ON (F.NUMSERIE=AL.NUMSERIEFAC AND F.NUMFACTURA=AL.NUMFAC AND F.N=AL.NFAC)
             INNER JOIN [10.100.150.70].[MEDITERRANEOQA].DBO.ALBVENTALIN L             WITH (NOLOCK)
                   ON (AL.NUMSERIE=L.NUMSERIE AND AL.NUMALBARAN=L.NUMALBARAN AND AL.N=L.N)
       WHERE F.FECHA >= @datefini
         AND F.FECHA <= @dateffin
         AND L.DETALLEDENUMLINEA=0
         AND F.N='B'
         AND AL.NUMSERIE in (SELECT NUMSERIE COLLATE DATABASE_DEFAULT
                               FROM TIENDAS
                              WHERE COD_EMPRESA = @cCodEmpresa
                                AND NOM_TIENDA  = @cNomTienda)
       GROUP BY F.FECHA
               ,F.NUMSERIE
               ,F.NUMFACTURA
       ORDER BY 1,2,3;

   END;

   INSERT INTO DBO.w_val_m_d_01
   select fecha,
          sum(TOTAL_L) as base
     from VENTASDET_V
    where cod_empresa = @cCodEmpresa
      and NOM_tienda =  @cNomTienda
      and fecha >= @strgfini
      and fecha <= @strgffin
      and tventa = 'BASE'
    group by fecha
    order by 1;
   
   INSERT INTO DBO.w_val_m_d_02
   select fecha,
          numserie,
          numcorrelativo,
          sum(TOTAL_L) as base
     from VENTASDET_V
    where cod_empresa = @cCodEmpresa
      and NOM_tienda =  @cNomTienda
      and fecha >= @strgfini
      and fecha <= @strgffin
      and tventa = 'BASE'
    group by fecha,
          numserie,
          numcorrelativo
    order by 1,2,3;

   INSERT INTO DBO.w_val_m_r_01
   select s.fecha,
          s.base,
          d.base,
          s.base - d.base
     from w_val_m_s_01 as s full outer join w_val_m_d_01 as d on s.fecha = d.fecha
 order by s.fecha;

   INSERT INTO DBO.w_val_m_r_02
   select s.fecha,
          s.numserie,
          s.numfactura,
          s.base,
          d.numserie,
          d.numfactura,
          d.base,
          s.base - d.base
     from w_val_m_s_02 as s full outer join w_val_m_d_02 as d on s.fecha = d.fecha and s.numserie = d.numserie and s.numfactura = d.numfactura
 order by s.fecha, s.numserie, d.numserie, s.numfactura, d.numfactura;

END
GO