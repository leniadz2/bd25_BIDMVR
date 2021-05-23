﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_stg_maestros_04]
AS
BEGIN

  ---MONEDAS---
  INSERT INTO MONEDAS
    SELECT
      4 AS COD_EMPRESA
     ,M.CODMONEDA
     ,M.DESCRIPCION AS NOM_MONEDA
     ,M.INICIALES
     ,M.PRINCIPAL
     ,M.COTDEF AS TASA_CAMBIO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[MONEDAS] M;

  ---TARIFAS VENTA---
  INSERT INTO TARIFAS
    SELECT
      4 AS COD_EMPRESA
     ,T.IDTARIFAV AS COD_TARIFA
     ,T.DESCRIPCION AS NOM_TARIFA
     ,T.CODMONEDA
     ,T.CONIVA AS IVA_INCLUIDO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[TARIFASVENTA] T;

  ---PRECIOS VENTA---
  INSERT INTO PRECIOSVENTA
    SELECT
      4 AS COD_EMPRESA
     ,PV.IDTARIFAV
     ,PV.CODARTICULO
     ,PV.PBRUTO
     ,PV.DTO
     ,PV.PNETO
     ,PV.PNETOANTERIOR
     ,PV.BENEFICIO
     ,PV.CODMONEDA
     ,PV.FECHAMODIFICADO
     ,PV.DESCATALOGADO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[PRECIOSVENTA] PV;

  ---TIPOS PAGO---
  INSERT INTO TIPOSPAGO
    SELECT
      4 AS COD_EMPRESA
     ,TP.CODTIPOPAGO
     ,TP.DESCRIPCION AS NOM_TIPO_PAGO
     ,TP.METALICO
     ,TP.TARJETA
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[TIPOSPAGO] TP;

  ---FORMAS PAGO---
  INSERT INTO FORMASPAGO
    SELECT
      4 AS COD_EMPRESA
     ,FP.CODFORMAPAGO
     ,FP.DESCRIPCION AS NOM_FORMA_PAGO
     ,FP.CODMONEDA
     ,FP.VISIBLEFRONT
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[FORMASPAGO] FP;

  ---VENCIMIENTOS PAGO---
  INSERT INTO VENCIMFPAGO
    SELECT
      4 AS COD_EMPRESA
     ,VP.CODTIPOPAGO
     ,VP.CODFORMAPAGO
     ,VP.NUMVENCIM AS CUOTAS
     ,VP.DIAS
     ,VP.PORCENTAJE
     ,VP.GENTESORERIA AS TIPO_VENCIMIENTO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[VENCIMFPAGO] VP;

  ---VENDEDORES---
  INSERT INTO VENDEDORES
    SELECT
      4 AS COD_EMPRESA
     ,V.CODVENDEDOR
     ,V.NOMBRECORTO
     ,V.NOMVENDEDOR
     ,V.TIPOUSUARIO
     ,V.TIPOEMPLEADO
     ,V.ACTIVO
     ,V.DESCATALOGADO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[VENDEDORES] V;

  ---ARTICULOS---
  INSERT INTO DEPARTAMENTO
    SELECT
      4 AS COD_EMPRESA
     ,D.NUMDPTO AS COD_DPTO
     ,D.DESCRIPCION AS NOM_DPTO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[DEPARTAMENTO] D;

  ---TABLA SECCIONES---
  INSERT INTO SECCIONES
    SELECT
      4 AS COD_EMPRESA
     ,S.NUMDPTO AS COD_DPTO
     ,S.NUMSECCION AS COD_SECCION
     ,S.DESCRIPCION AS NOM_SECCION
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[SECCIONES] S;

  ---FAMILIAS---
  INSERT INTO FAMILIAS
    SELECT
      4 AS COD_EMPRESA
     ,F.NUMDPTO AS COD_DPTO
     ,F.NUMSECCION AS COD_SECCION
     ,F.NUMFAMILIA AS COD_FAMILIA
     ,F.DESCRIPCION AS NOM_FAMILIA
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[FAMILIAS] F;

  ---SUBFAMILIAS---
  INSERT INTO SUBFAMILIAS
    SELECT
      4 AS COD_EMPRESA
     ,SF.NUMDPTO AS COD_DPTO
     ,SF.NUMSECCION AS COD_SECCION
     ,SF.NUMFAMILIA AS COD_FAMILIA
     ,SF.NUMSUBFAMILIA AS COD_SUBFAMILIA
     ,SF.DESCRIPCION AS NOM_SUBFAMILIA
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[SUBFAMILIAS] SF;

  ---MARCA---
  INSERT INTO MARCA
    SELECT
      4 AS COD_EMPRESA
     ,M.CODMARCA
     ,M.DESCRIPCION AS NOM_MARCA
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[MARCA] M;

  ---LINEAS---
  INSERT INTO LINEA
    SELECT
      4 AS COD_EMPRESA
     ,L.CODMARCA
     ,L.CODLINEA
     ,L.DESCRIPCION AS NOM_LINEA
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[LINEA] L;

  ---ARTICULOS---
  INSERT INTO ARTICULOS
    SELECT
      4 AS COD_EMPRESA
     ,A.DPTO AS COD_DPTO
     ,A.SECCION AS COD_SECCION
     ,A.FAMILIA AS COD_FAMILIA
     ,A.SUBFAMILIA AS COD_SUBFAMILIA
     ,A.MARCA AS COD_MARCA
     ,A.LINEA AS COD_LINEA
     ,A.CODARTICULO
     ,A.REFPROVEEDOR
     ,A.DESCRIPCION
     ,A.DESCRIPADIC
     ,A.TIPOIMPUESTO
     ,A.ESKIT AS FORMULA
     ,A.USASTOCKS AS MANEJA_INVENTARIO
     ,A.UNIDADMEDIDA
     ,A.FECHAMODIFICADO
     ,A.TIPOARTICULO
     ,A.DESCATALOGADO
     ,0 AS ULTIMO_COSTO
     ,0 AS COSTO_PROMEDIO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[ARTICULOS] A;

  ---IMPUESTOS---
  INSERT INTO IMPUESTOS
    SELECT
      4 AS COD_EMPRESA
     ,I.TIPOIVA AS TIPOIMPUESTO
     ,I.DESCRIPCION AS NOM_IMPUESTO
     ,I.IVA
     ,I.REQ AS RECARGO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[IMPUESTOS] I;

  ---TIPOSERVICIOSDELIVERY---
  INSERT INTO TIPOSERVICIOSDELIVERY
    SELECT
      4 AS COD_EMPRESA
     ,TIPO
     ,DESCRIPCION
     ,TASAESPECIAL
     ,IMAGEN
     ,IMPORTEMINIMO
     ,ACTIVARCASHDRO
    FROM [10.110.21.9].[MNGPAPAS].[dbo].[TIPOSERVICIOSDELIVERY];

  ---CLIENTES---
  INSERT INTO CLIENTES
    SELECT
      4 AS COD_EMPRESA
     ,CODCLIENTE
     ,CODCONTABLE
     ,NOMBRECLIENTE
     ,NOMBRECOMERCIAL
     ,CIF
     ,ALIAS
     ,DIRECCION1
     ,CODPOSTAL
     ,POBLACION
     ,PROVINCIA
     ,PAIS
     ,PERSONACONTACTO
     ,TELEFONO1
     ,TELEFONO2
     ,FAX
     ,FAXPEDIDOS
     ,TELEX
     ,E_MAIL
     ,CODCLISUYO
     ,NUMCUENTA
     ,CODBANCO
     ,NUMSUCURSAL
     ,DIGCONTROLBANCO
     ,CODPOSTALBANCO
     ,CODSWIFT
     ,NOMBREBANCO
     ,DIRECCIONBANCO
     ,POBLACIONBANCO
     ,ENVIOPOR
     ,ENVIODIRECION
     ,ENVIOCODPOSTAL
     ,ENVIOPOBLACION
     ,ENVIOPROVINCIA
     ,ENVIOPAIS
     ,CANTPORTESPAG
     ,TIPOPORTES
     ,NUMDIASENTREGA
     ,RIESGOCONCEDIDO
     ,TIPO
     ,RECARGO
     ,ZONA
     ,CODVENDEDOR
     ,DIAPAGO1
     ,DIAPAGO2
     ,CONVERT(NVARCHAR(2000), OBSERVACIONES) AS OBSERVACIONES
     ,FACTURARSINIMPUESTOS
     ,APDOCORREOS
     ,DTOCOMERCIAL
     , /**/FECHAMODIFICADO
     ,REGIMFACT
     ,CODMONEDA
     ,DIRECCION2
     ,COMPRADOREDI
     ,RECEPTOREDI
     ,CLIENTEEDI
     ,PAGADOREDI
     ,USUARIO
     ,PASS
     ,TIPODOC
     ,NUMTARJETA
     ,
      /**/FECHANACIMIENTO
     ,SEXO
     ,NIF20
     ,DESCATALOGADO
     ,TRANSPORTE
     ,MESVACACIONES
     ,GRUPOIMPRESION
     ,NUMCOPIASFACTURA
     ,TIPOCLIENTE
     ,CONDENTREGAEDI
     ,CONDENTREGA
     ,CODIDIOMA
     ,SERIE
     ,ALMACEN
     ,LOCAL_REMOTA
     ,EMPRESA
     ,CODENTREGA
     ,PROCEDENCIA
     ,CODIGOPROCEDENCIA
     ,IDSUCURSAL
     ,CODVISIBLE
     ,CODPAIS
     ,B2B_IDMAPPING
     ,FACTURARCONIMPUESTO
     ,FOTOCLIENTE
     ,CARGOSFIJOSA
     ,TIPOTARJETA
     ,TARCADUCIDAD
     ,CVC
     ,CODCONTABLEDMN
     ,DISENYO_CAMPOSLIBRES
     ,MOBIL
     ,NOCALCULARCARGO1ARTIC
     ,NOCALCULARCARGO2ARTIC
     ,ESCLIENTEDELGRUPO
     ,PASSWORDCOMMERCE
     ,TIPORESERVA
     ,REGIMRET
     ,TIPORET
     , /**/RET_TIPORETENCIONIVA
     , /**/RET_PORCEXCLUSION
     ,RET_FECHAINIEXCLUSION
     ,RET_FECHAFINEXCLUSION
     ,CAMPOSLIBRESTOTALIZAR
     ,CODCLIASOC
     ,CARGOSEXTRASA
     ,COMISION
     ,PROVEEDORCOMISION
     ,COMISIONESFACTURABLES
     ,LOCALIZADOROBLIGATORIO
     ,RECC
     ,BLOQUEADO
     ,ORDENADEUDO
     ,SUBNORMA
     ,SECUENCIAADEUDO
     ,CODIGOIBAN
     , /**/FECHAFIRMAORDENADEUDO
     ,TIPODOCIDENT
     ,NULL PERSONAJURIDICA
     ,NULL RECIBIRINFORMACION
    FROM [10.110.21.9].[MNGPAPAS].DBO.CLIENTES;

  ---ARTICULOSCAMPOSLIBRES---
  INSERT INTO DBO.ARTICULOSCAMPOSLIBRES
      SELECT 4,
	         CODARTICULO,
             CODIGOSAP as CODMATSAP,
             CODIGOPRODSUNAT,
             DESCRIPCION_LARGA,
             DESCRIPCION_VIETA
      FROM [10.110.21.9].[MNGPAPAS].DBO.ARTICULOSCAMPOSLIBRES;

END
GO