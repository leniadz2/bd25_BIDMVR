SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_stg_wa_cleansing]
AS
BEGIN

  PRINT (CONCAT('inicia cleansing ', SYSDATETIME()));

  DROP TABLE DBO.w_ventasdet;

  SELECT
    v.*
   ,a.COD_DPTO
   ,d.NOM_DPTO
   ,a.COD_SECCION
   ,s.NOM_SECCION
   ,a.COD_FAMILIA
   ,f.NOM_FAMILIA
   ,a.COD_SUBFAMILIA
   ,sf.NOM_SUBFAMILIA
   ,a.COD_MARCA
   ,m.NOM_MARCA
   ,a.COD_LINEA
   ,l.NOM_LINEA INTO DBO.w_ventasdet
  FROM DBO.VENTASDET_V AS v
  INNER JOIN DBO.ARTICULOS AS a
    ON v.cod_empresa = a.cod_empresa
      AND v.CODARTICULO = a.CODARTICULO
  LEFT JOIN DBO.DEPARTAMENTO AS d
    ON v.cod_empresa = d.cod_empresa
      AND a.COD_DPTO = d.COD_DPTO
  LEFT JOIN DBO.SECCIONES AS s
    ON v.cod_empresa = s.cod_empresa
      AND a.COD_DPTO = s.COD_DPTO
      AND a.COD_SECCION = s.COD_SECCION
  LEFT JOIN DBO.FAMILIAS AS f
    ON v.cod_empresa = f.cod_empresa
      AND a.COD_DPTO = f.COD_DPTO
      AND a.COD_SECCION = f.COD_SECCION
      AND a.COD_FAMILIA = f.COD_FAMILIA
  LEFT JOIN DBO.SUBFAMILIAS AS sf
    ON v.cod_empresa = sf.cod_empresa
      AND a.COD_DPTO = sf.COD_DPTO
      AND a.COD_SECCION = sf.COD_SECCION
      AND a.COD_FAMILIA = sf.COD_FAMILIA
      AND a.COD_SUBFAMILIA = sf.COD_SUBFAMILIA
  LEFT JOIN DBO.MARCA AS m
    ON v.cod_empresa = m.cod_empresa
      AND a.COD_MARCA = m.COD_MARCA
  LEFT JOIN DBO.LINEA AS l
    ON v.cod_empresa = l.cod_empresa
      AND a.COD_MARCA = l.COD_MARCA
      AND a.COD_LINEA = l.COD_LINEA
  ;

  DROP TABLE DBO.w_dist_ventasdet;

  SELECT DISTINCT
    cod_empresa
   ,cod_dpto
   ,nom_dpto
   ,cod_seccion
   ,nom_seccion
   ,cod_familia
   ,nom_familia
   ,cod_subfamilia
   ,nom_subfamilia
   ,cod_marca
   ,nom_marca
   ,cod_linea
   ,nom_linea INTO DBO.w_dist_ventasdet
  FROM DBO.w_ventasdet;

  DROP TABLE DBO.t_departamento;
  DROP TABLE DBO.t_secciones;
  DROP TABLE DBO.t_familias;
  DROP TABLE DBO.t_subfamilias;
  DROP TABLE DBO.t_marca;
  DROP TABLE DBO.t_linea;

  SELECT DISTINCT
    cod_empresa
   ,cod_dpto
   ,nom_dpto INTO DBO.t_departamento
  FROM DBO.w_dist_ventasdet
  ORDER BY 1, 2;

  SELECT DISTINCT
    cod_empresa
   ,cod_dpto
   ,cod_seccion
   ,nom_seccion INTO DBO.t_secciones
  FROM DBO.w_dist_ventasdet
  ORDER BY 1, 2, 3;

  SELECT DISTINCT
    cod_empresa
   ,cod_dpto
   ,cod_seccion
   ,cod_familia
   ,nom_familia INTO DBO.t_familias
  FROM DBO.w_dist_ventasdet
  ORDER BY 1, 2, 3, 4;

  SELECT DISTINCT
    cod_empresa
   ,cod_dpto
   ,cod_seccion
   ,cod_familia
   ,cod_subfamilia
   ,nom_subfamilia INTO DBO.t_subfamilias
  FROM DBO.w_dist_ventasdet
  ORDER BY 1, 2, 3, 4, 5;

  SELECT DISTINCT
    cod_empresa
   ,cod_marca
   ,nom_marca INTO DBO.t_marca
  FROM DBO.w_dist_ventasdet
  ORDER BY 1, 2;

  SELECT DISTINCT
    cod_empresa
   ,cod_marca
   ,cod_linea
   ,nom_linea INTO DBO.t_linea
  FROM DBO.w_dist_ventasdet
  ORDER BY 1, 2, 3;

  INSERT INTO DBO.DEPARTAMENTO
    SELECT
      a.cod_empresa
     ,a.cod_dpto
     ,'SIN DEFINIR' AS nom_dpto
    FROM (SELECT
        *
      FROM DBO.t_departamento
      EXCEPT
      SELECT
        *
      FROM DBO.DEPARTAMENTO) AS a
    ORDER BY 1, 2;

  INSERT INTO DBO.SECCIONES
    SELECT
      a.cod_empresa
     ,CASE
        WHEN a.cod_dpto IS NULL THEN 9999
        ELSE a.cod_dpto
      END AS cod_dpto
     ,CASE
        WHEN a.cod_seccion IS NULL THEN 9999
        ELSE a.cod_seccion
      END AS cod_seccion
     ,'SIN DEFINIR' AS nom_seccion
    FROM (SELECT
        *
      FROM DBO.t_secciones
      EXCEPT
      SELECT
        *
      FROM DBO.SECCIONES) AS a
    ORDER BY 1, 2, 3;

  INSERT INTO DBO.FAMILIAS
    SELECT
      a.cod_empresa
     ,a.cod_dpto
     ,a.cod_seccion
     ,CASE
        WHEN a.cod_familia IS NULL THEN 9999
        ELSE a.cod_familia
      END AS cod_familia
     ,'SIN DEFINIR' AS nom_familia
    FROM (SELECT
        *
      FROM DBO.t_familias
      EXCEPT
      SELECT
        *
      FROM DBO.FAMILIAS) AS a
    ORDER BY 1, 2, 3, 4;

  INSERT INTO DBO.SUBFAMILIAS
    SELECT
      a.cod_empresa
     ,a.cod_dpto
     ,a.cod_seccion
     ,CASE
        WHEN a.cod_familia IS NULL THEN 9999
        ELSE a.cod_familia
      END AS cod_familia
     ,CASE
        WHEN a.cod_subfamilia IS NULL THEN 9999
        ELSE a.cod_subfamilia
      END AS cod_subfamilia
     ,'SIN DEFINIR' AS nom_subfamilia
    FROM (SELECT
        *
      FROM DBO.t_subfamilias
      EXCEPT
      SELECT
        *
      FROM DBO.SUBFAMILIAS) AS a
    ORDER BY 1, 2, 3, 4, 5;

  INSERT INTO DBO.MARCA
    SELECT
      a.cod_empresa
     ,CASE
        WHEN a.cod_marca IS NULL THEN 9999
        ELSE a.cod_marca
      END AS cod_marca
     ,'SIN DEFINIR' AS nom_marca
    FROM (SELECT
        *
      FROM DBO.t_marca
      EXCEPT
      SELECT
        *
      FROM DBO.MARCA) AS a
    ORDER BY 1, 2;

  INSERT INTO DBO.LINEA
    SELECT
      a.cod_empresa
     ,CASE
        WHEN a.cod_marca IS NULL THEN 9999
        ELSE a.cod_marca
      END AS cod_marca
     ,CASE
        WHEN a.cod_linea IS NULL THEN 9999
        ELSE a.cod_linea
      END AS cod_linea
     ,'SIN DEFINIR' AS nom_linea
    FROM (SELECT
        *
      FROM DBO.t_linea
      EXCEPT
      SELECT
        *
      FROM DBO.LINEA) AS a
    ORDER BY 1, 2, 3;

  --wa maestra articulos
  --DROP TABLE DBO.t_articulos;

--  SELECT *
--  INTO DBO.t_articulos
--  FROM DBO.ARTICULOS;

  UPDATE DBO.ARTICULOS
  SET DESCRIPCION = 'TRAGUESE ESE SAPO'
  WHERE COD_EMPRESA = 2
  AND CODARTICULO = 6899;

  UPDATE DBO.ARTICULOS
  SET DESCRIPCION = SUBSTRING(DESCRIPCION, 2, LEN(DESCRIPCION) - 1)
  WHERE cod_empresa = 6
  AND codarticulo IN (2298, 1805, 2076, 1757);

  UPDATE DBO.ARTICULOS
  SET DESCRIPCION = SUBSTRING(DESCRIPCION, 2, LEN(DESCRIPCION) - 1)
  WHERE cod_empresa = 1
  AND codarticulo IN (860, 861, 862);

  UPDATE DBO.ARTICULOS
  SET DESCRIPCION = SUBSTRING(DESCRIPCION, 2, LEN(DESCRIPCION) - 1)
  WHERE cod_empresa = 2
  AND codarticulo IN (21698, 21501, 21502);

--wa codigos SAP (ini)

  --WITH t2 AS
  --(
  --  SELECT
  --     a.COD_EMPRESA,
  --     a.CODARTICULO,
  --     CASE
  --       WHEN b.codmatsap IS NULL THEN CONCAT(RTRIM(SUBSTRING(CONCAT(REPLACE(a.descripcion, '|', ' '),'                                        '), 1, 38)),'|-')
  --       ELSE CONCAT(RTRIM(SUBSTRING(CONCAT(REPLACE(a.descripcion, '|', ' '),'                                        '), 1, 28)),'|',b.codmatsap)
  --     END AS DESCRIPCION
  --   FROM dbo.ARTICULOS AS a INNER JOIN dbo.ARTICULOSCAMPOSLIBRES AS b
  --      ON a.COD_EMPRESA = b.COD_EMPRESA AND a.CODARTICULO = b.CODARTICULO
  --)
  --UPDATE t1
  --  SET t1.DESCRIPCION = t2.DESCRIPCION
  --  FROM dbo.ARTICULOS AS t1
  --  INNER JOIN t2
  --  ON t1.COD_EMPRESA = t2.COD_EMPRESA
  --  AND t1.CODARTICULO = t2.CODARTICULO;
  
  --WITH t2 AS
  --(
  --  SELECT
  --     COD_EMPRESA,
  --     CODARTICULO,
  --     DESCRIPCION
  --   FROM dbo.t_articulos
  --)
  --UPDATE t1
  --  SET t1.DESCRIPCION = t2.DESCRIPCION
  --  FROM dbo.ARTICULOS AS t1
  --  INNER JOIN t2
  --  ON t1.COD_EMPRESA = t2.COD_EMPRESA
  --  AND t1.CODARTICULO = t2.CODARTICULO;

  --UPDATE DBO.ARTICULOS
  --SET DESCRIPCION = 'SIN DEFINIR'
  --WHERE DESCRIPCION = 'SIN DEFINIR|-';

--wa codigos SAP (fin)


  --wa transacciones con articulos que no estan en el maestro
  INSERT INTO ARTICULOS (COD_EMPRESA, COD_DPTO, COD_SECCION, COD_FAMILIA, COD_SUBFAMILIA, COD_MARCA, COD_LINEA, CODARTICULO, ULTIMO_COSTO, COSTO_PROMEDIO)
    VALUES (2, 9999, 9999, 9999, 9999, 9999, 9999, 14464, 0, 0);

  INSERT INTO ARTICULOS (COD_EMPRESA, COD_DPTO, COD_SECCION, COD_FAMILIA, COD_SUBFAMILIA, COD_MARCA, COD_LINEA, CODARTICULO, ULTIMO_COSTO, COSTO_PROMEDIO)
    VALUES (2, 9999, 9999, 9999, 9999, 9999, 9999, 14803, 0, 0);

  INSERT INTO ARTICULOS (COD_EMPRESA, COD_DPTO, COD_SECCION, COD_FAMILIA, COD_SUBFAMILIA, COD_MARCA, COD_LINEA, CODARTICULO, ULTIMO_COSTO, COSTO_PROMEDIO)
    VALUES (2, 9999, 9999, 9999, 9999, 9999, 9999, 15409, 0, 0);

  --wa reservas Mediterraneo
  INSERT INTO ARTICULOS (COD_EMPRESA, COD_DPTO, COD_SECCION, COD_FAMILIA, COD_SUBFAMILIA, COD_MARCA, COD_LINEA, CODARTICULO, ULTIMO_COSTO, COSTO_PROMEDIO, DESCRIPCION)
    VALUES (6, 9999, 9999, 9999, 9999, 9999, 9999, -10, 0, 0, 'Reserva');

  --wa generales (siempre al final)
  UPDATE DBO.ARTICULOS
  SET COD_DPTO = 9999
  WHERE COD_DPTO IS NULL;
  UPDATE DBO.ARTICULOS
  SET COD_SECCION = 9999
  WHERE COD_SECCION IS NULL;
  UPDATE DBO.ARTICULOS
  SET COD_FAMILIA = 9999
  WHERE COD_FAMILIA IS NULL;
  UPDATE DBO.ARTICULOS
  SET COD_SUBFAMILIA = 9999
  WHERE COD_SUBFAMILIA IS NULL;
  UPDATE DBO.ARTICULOS
  SET COD_MARCA = 9999
  WHERE COD_MARCA IS NULL;
  UPDATE DBO.ARTICULOS
  SET COD_LINEA = 9999
  WHERE COD_LINEA IS NULL;

  UPDATE ARTICULOS
  SET DESCRIPCION = 'SIN DEFINIR'
  WHERE DESCRIPCION IS NULL;
  UPDATE DEPARTAMENTO
  SET NOM_DPTO = 'SIN DEFINIR'
  WHERE NOM_DPTO IS NULL;
  UPDATE SECCIONES
  SET NOM_SECCION = 'SIN DEFINIR'
  WHERE NOM_SECCION IS NULL;
  UPDATE FAMILIAS
  SET NOM_FAMILIA = 'SIN DEFINIR'
  WHERE NOM_FAMILIA IS NULL;
  UPDATE SUBFAMILIAS
  SET NOM_SUBFAMILIA = 'SIN DEFINIR'
  WHERE NOM_SUBFAMILIA IS NULL;
  UPDATE MARCA
  SET NOM_MARCA = 'SIN DEFINIR'
  WHERE NOM_MARCA IS NULL;
  UPDATE LINEA
  SET NOM_LINEA = 'SIN DEFINIR'
  WHERE NOM_LINEA IS NULL;

  UPDATE ARTICULOS
  SET DESCRIPCION = 'SIN DEFINIR'
  WHERE LTRIM(RTRIM(DESCRIPCION)) = '';
  UPDATE DEPARTAMENTO
  SET NOM_DPTO = 'SIN DEFINIR'
  WHERE LTRIM(RTRIM(NOM_DPTO)) = '';
  UPDATE SECCIONES
  SET NOM_SECCION = 'SIN DEFINIR'
  WHERE LTRIM(RTRIM(NOM_SECCION)) = '';
  UPDATE FAMILIAS
  SET NOM_FAMILIA = 'SIN DEFINIR'
  WHERE LTRIM(RTRIM(NOM_FAMILIA)) = '';
  UPDATE SUBFAMILIAS
  SET NOM_SUBFAMILIA = 'SIN DEFINIR'
  WHERE LTRIM(RTRIM(NOM_SUBFAMILIA)) = '';
  UPDATE MARCA
  SET NOM_MARCA = 'SIN DEFINIR'
  WHERE LTRIM(RTRIM(NOM_MARCA)) = '';
  UPDATE LINEA
  SET NOM_LINEA = 'SIN DEFINIR'
  WHERE LTRIM(RTRIM(NOM_LINEA)) = '';


----wa t_ventaslin
----ventas DB en manager RES (27) 20210317

--update DBO.t_VENTASCAB 
--set cod_empresa = '5'
--where NUMSERIE IN ('F023','B023','FC23','BC23','F024','B024','FC24','BC24')
--and cod_empresa = '6';

--update DBO.t_VENTASLIN 
--set cod_empresa = '5'
--where NUMSERIE IN ('F023','B023','FC23','BC23','F024','B024','FC24','BC24')
--and cod_empresa = '6';

----wa end




----wa t_ventaslin
----ventas DB en manager RES (27) 20210317

----update DBO.t_VENTASDET 
----set DESCRIPCION = 'DELIVERY'
----where NUMSERIE IN ('F023','B023','FC23','BC23','F024','B024','FC24','BC24')
----and cod_empresa = '5';

--MERGE INTO DBO.t_VENTASDET AS t
--USING DBO.TIPOSERVICIOSDELIVERY AS s
--   ON t.ESTADODELIVERY_L = s.TIPO
--  AND t.COD_EMPRESA    = 5
--  AND s.COD_EMPRESA    = 6
--  AND t.NUMSERIE IN ('F023','B023','FC23','BC23','F024','B024','FC24','BC24')
-- WHEN MATCHED THEN
--      UPDATE SET t.DESCRIPCION = s.DESCRIPCION;


----WITH t2 AS
----(
----  SELECT TIPO, DESCRIPCION
----    FROM DBO.TIPOSERVICIOSDELIVERY
----   WHERE COD_EMPRESA = 6
----)
----UPDATE t1
----  SET t1.DESCRIPCION = t2.DESCRIPCION
----  FROM dbo.t_VENTASDET AS t1
----  INNER JOIN t2
----  ON t1.ESTADODELIVERY_L = t2.TIPO;


----wa end

END
GO