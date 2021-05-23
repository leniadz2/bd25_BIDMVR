﻿CREATE TABLE [dbo].[x_ICG_2021_Cruce_Cli_VtaID] (
  [FECHA] [varchar](8) NULL,
  [COD_EMPRESA] [int] NOT NULL,
  [SEMANA_VENTA] [int] NULL,
  [MES_VENTA] [int] NULL,
  [NOM_MES_VENTA] [nvarchar](30) NULL,
  [FECHA_VENTA] [datetime] NULL,
  [PARTE_DEL_DIA] [varchar](20) NULL,
  [HORA] [int] NULL,
  [ANO] [int] NULL,
  [DIA_SEMANA] [int] NULL,
  [DIA_FECHA] [int] NULL,
  [NOMBREDIASEMANA] [varchar](9) NULL,
  [NUMSERIE] [nvarchar](4) NOT NULL,
  [NUMCORRELATIVO] [int] NOT NULL,
  [TIPODOC] [int] NULL,
  [CAJA] [nvarchar](3) NULL,
  [COD_CLIENTE] [int] NULL,
  [COD_ALMACEN] [nvarchar](3) NULL,
  [BASE] [float] NULL,
  [IMPUESTO] [float] NULL,
  [TOTAL] [float] NULL,
  [ESTADODELIVERY] [int] NULL,
  [NUMLIN] [int] NOT NULL,
  [CODARTICULO] [int] NULL,
  [REFERENCIA] [nvarchar](15) NULL,
  [UNIDADESTOTAL] [float] NULL,
  [COSTO] [float] NULL,
  [BASE_L] [float] NOT NULL,
  [IMPUESTO_L] [float] NOT NULL,
  [RECARGOC_L] [float] NOT NULL,
  [TOTAL_L] [float] NOT NULL,
  [ESTADODELIVERY_L] [int] NULL,
  [CENTRO] [nvarchar](4) NOT NULL,
  [NOM_TIENDA] [nvarchar](50) NULL,
  [MTS_CUADRADOS] [int] NULL,
  [ORG_VENTA] [nvarchar](4) NOT NULL,
  [DEN_ORG_VTA] [nvarchar](50) NULL,
  [UBICACION] [nvarchar](50) NULL,
  [NEGOCIO] [nvarchar](50) NULL,
  [TIPO_CPE] [varchar](2) NULL,
  [TASA_RC] [numeric](4, 1) NULL,
  [CNCTND] [nvarchar](16) NOT NULL,
  [DESCRIPCION] [nvarchar](35) NULL,
  [TVENTA] [varchar](4) NOT NULL,
  [VTAPM2] [float] NULL,
  [UNIDADESWA] [float] NULL,
  [DIAWA] [varchar](2) NULL,
  [CODIGOPERSONA] [varchar](10) NOT NULL
)
ON [PRIMARY]
GO