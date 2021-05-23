SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_stg_trns_tablon](
@strgfini nvarchar(8), @strgffin nvarchar(8))
AS
BEGIN

PRINT(concat('inicia tablon ',SYSDATETIME()));

drop table DBO.t_tiposerviciosdelivery;

select distinct
       cod_empresa,
       estadodelivery as tipo
  into DBO.t_tiposerviciosdelivery
  from DBO.t_VENTASLIN
 order by 1,2;

insert into DBO.TIPOSERVICIOSDELIVERY
select a.cod_empresa,
       a.tipo,
       'SIN DEFINIR' as descripcion,
       null as tasaespecial,
       null as imagen,
       null as importeminimo,
       null as activarcashdro
  from (select cod_empresa, tipo from DBO.t_tiposerviciosdelivery
        except
        select cod_empresa, tipo from DBO.TIPOSERVICIOSDELIVERY) as a
 order by 1,2;

--DROP INDEX VENTASDET_V.IX1_VENTASDET;
--DROP INDEX VENTASDET_V.IX2_VENTASDET;

INSERT INTO t_VENTASDET
SELECT CAB.FECHA          ,
       CAB.COD_EMPRESA    ,
       CAB.SEMANA_VENTA   ,
       CAB.MES_VENTA      ,
       CAB.NOM_MES_VENTA  ,
       CAB.FECHA_VENTA    ,
       CAB.PARTE_DEL_DIA  ,
       CAB.HORA           ,
       CAB.ANO            ,
       CAB.DIA_SEMANA     ,
       CAB.DIA_FECHA      ,
       CAB.NOMBREDIASEMANA,
       CAB.NUMSERIE       ,
       CAB.NUMCORRELATIVO ,
       CAB.TIPODOC        ,
       CAB.CAJA           ,
       CAB.COD_CLIENTE    ,
       CAB.COD_ALMACEN    ,
       CAB.BASE           ,
       CAB.IMPUESTO       ,
       CAB.TOTAL          ,
       CAB.ESTADODELIVERY ,
       LIN.NUMLIN         ,
       LIN.CODARTICULO    ,
       LIN.REFERENCIA     ,
       LIN.UNIDADESTOTAL  ,
       LIN.COSTO          ,
       isnull(LIN.BASE ,0)     as BASE_L     ,
       isnull(LIN.IMPUESTO ,0) as IMPUESTO_L ,
       isnull(LIN.RECARGOC ,0) as RECARGOC_L ,
       0 as TOTAL_L     ,
       LIN.ESTADODELIVERY AS ESTADODELIVERY_L, --cod_delivery
       TDA.CENTRO         ,
       TDA.NOM_TIENDA     ,
       TDA.MTS_CUADRADOS  ,
       TDA.ORG_VENTA      ,
       TDA.DEN_ORG_VTA    ,
       TDA.UBICACION      ,
       TDA.NEGOCIO        ,
       TDA.TIPO_CPE       ,
       TDA.TASA_RC
       , CONCAT(CAB.NUMSERIE, CAB.NUMCORRELATIVO) as CNCTND
       , TSD.DESCRIPCION
       , case 
           when TDA.MTS_CUADRADOS is null then null
           when TDA.MTS_CUADRADOS = 0 then null
           else isnull(LIN.BASE ,0)/TDA.MTS_CUADRADOS end as VTAPM2BASE
       , case 
           when TDA.MTS_CUADRADOS is null then null
           when TDA.MTS_CUADRADOS = 0 then null
           else isnull(LIN.IMPUESTO ,0)/TDA.MTS_CUADRADOS end as VTAPM2IGV
       , case 
           when TDA.MTS_CUADRADOS is null then null
           when TDA.MTS_CUADRADOS = 0 then null
           else isnull(LIN.RECARGOC ,0)/TDA.MTS_CUADRADOS end as VTAPM2RC
FROM DBO.t_VENTASCAB AS CAB 
        INNER JOIN
	 DBO.t_VENTASLIN AS LIN 
         ON CAB.COD_EMPRESA = LIN.COD_EMPRESA
        AND CAB.NUMSERIE = LIN.NUMSERIE
        AND CAB.NUMCORRELATIVO = LIN.NUMCORRELATIVO
        INNER JOIN
     DBO.TIENDAS AS TDA
         ON CAB.COD_EMPRESA = TDA.COD_EMPRESA
		AND CAB.NUMSERIE = TDA.NUMSERIE
        INNER JOIN
     DBO.TIPOSERVICIOSDELIVERY AS TSD
         ON CAB.COD_EMPRESA = TSD.COD_EMPRESA
		AND LIN.ESTADODELIVERY = TSD.TIPO;


--WHERE CAB.FECHA >= @strgfini
--  AND CAB.FECHA <= @strgffin;
  
--CREATE INDEX IX1_VENTASDET
--ON DBO.VENTASDET_V(FECHA, COD_EMPRESA, NUMSERIE, NUMCORRELATIVO, NUMLIN);

--CREATE INDEX IX2_VENTASDET
--ON DBO.VENTASDET_V(FECHA, ANO);


INSERT INTO t_VENTASDET_V
select *
  from ( select FECHA            ,COD_EMPRESA      ,SEMANA_VENTA     ,MES_VENTA        ,
                NOM_MES_VENTA    ,FECHA_VENTA      ,PARTE_DEL_DIA    ,HORA             ,
                ANO              ,DIA_SEMANA       ,DIA_FECHA        ,NOMBREDIASEMANA  ,
                NUMSERIE         ,NUMCORRELATIVO   ,TIPODOC          ,CAJA             ,
                COD_CLIENTE      ,COD_ALMACEN      ,BASE             ,IMPUESTO         ,
                TOTAL            ,ESTADODELIVERY   ,NUMLIN           ,CODARTICULO      ,
                REFERENCIA       ,UNIDADESTOTAL    ,COSTO            ,
                0 as BASE_L          ,
                0 as IMPUESTO_L      ,
                0 as RECARGOC_L      ,
                BASE_L as TOTAL_L    ,
                ESTADODELIVERY_L ,CENTRO           ,NOM_TIENDA       ,MTS_CUADRADOS    ,
                ORG_VENTA        ,DEN_ORG_VTA      ,UBICACION        ,NEGOCIO          ,
                TIPO_CPE         ,TASA_RC          ,
                CNCTND           ,
                DESCRIPCION      ,
                'BASE' as TVENTA ,
                VTAPM2BASE as VTAPM2,
                unidadestotal as UNIDADESWA,
                SUBSTRING(FECHA,7,2) as DIAWA
           from t_VENTASDET

          union all
         
         select FECHA            ,COD_EMPRESA      ,SEMANA_VENTA     ,MES_VENTA        ,
                NOM_MES_VENTA    ,FECHA_VENTA      ,PARTE_DEL_DIA    ,HORA             ,
                ANO              ,DIA_SEMANA       ,DIA_FECHA        ,NOMBREDIASEMANA  ,
                NUMSERIE         ,NUMCORRELATIVO   ,TIPODOC          ,CAJA             ,
                COD_CLIENTE      ,COD_ALMACEN      ,BASE             ,IMPUESTO         ,
                TOTAL            ,ESTADODELIVERY   ,NUMLIN           ,CODARTICULO      ,
                REFERENCIA       ,UNIDADESTOTAL    ,COSTO            ,
                0 as BASE_L                      ,
                0 as IMPUESTO_L                  ,
                0 as RECARGOC_L                  ,
                IMPUESTO_L as TOTAL_L     ,
                ESTADODELIVERY_L ,CENTRO           ,NOM_TIENDA       ,MTS_CUADRADOS    ,
                ORG_VENTA        ,DEN_ORG_VTA      ,UBICACION        ,NEGOCIO          ,
                TIPO_CPE         ,TASA_RC          ,
                CNCTND           ,
                DESCRIPCION      ,
                'IGV' as TVENTA ,
                VTAPM2IGV as VTAPM2,
                null as UNIDADESWA,
                SUBSTRING(FECHA,7,2) as DIAWA
           from t_VENTASDET

          union all
         
         select FECHA            ,COD_EMPRESA      ,SEMANA_VENTA     ,MES_VENTA        ,
                NOM_MES_VENTA    ,FECHA_VENTA      ,PARTE_DEL_DIA    ,HORA             ,
                ANO              ,DIA_SEMANA       ,DIA_FECHA        ,NOMBREDIASEMANA  ,
                NUMSERIE         ,NUMCORRELATIVO   ,TIPODOC          ,CAJA             ,
                COD_CLIENTE      ,COD_ALMACEN      ,BASE             ,IMPUESTO         ,
                TOTAL            ,ESTADODELIVERY   ,NUMLIN           ,CODARTICULO      ,
                REFERENCIA       ,UNIDADESTOTAL    ,COSTO            ,
                0 as BASE_L                      ,
                0 as IMPUESTO_L                  ,
                0 as RECARGOC_L                  ,
                RECARGOC_L as TOTAL_L     ,
                ESTADODELIVERY_L ,CENTRO           ,NOM_TIENDA       ,MTS_CUADRADOS    ,
                ORG_VENTA        ,DEN_ORG_VTA      ,UBICACION        ,NEGOCIO          ,
                TIPO_CPE         ,TASA_RC          ,
                CNCTND           ,
                DESCRIPCION      ,
                'RC' as TVENTA ,
                VTAPM2RC as VTAPM2,
                null as UNIDADESWA,
                SUBSTRING(FECHA,7,2) as DIAWA
           from t_VENTASDET ) TVT;
		   
INSERT INTO VENTASDET_V
SELECT *
FROM t_VENTASDET_V;


END
GO