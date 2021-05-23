﻿CREATE TABLE [dbo].[TIENDAS] (
  [COD_EMPRESA] [int] NOT NULL,
  [PAIS] [nvarchar](50) NULL,
  [PROVINCIA] [nvarchar](50) NULL,
  [POBLACION] [nvarchar](50) NULL,
  [ZONA] [nvarchar](50) NULL,
  [TIPO_TIENDA] [int] NULL,
  [NUMSERIE] [nvarchar](4) NOT NULL,
  [COD_ALMACEN] [varchar](4) NULL,
  [CENTRO] [nvarchar](4) NOT NULL,
  [NOM_TIENDA] [nvarchar](50) NULL,
  [CODCOMERCIO] [nvarchar](6) NULL,
  [SERIMP] [nvarchar](50) NULL,
  [MTS_CUADRADOS] [int] NULL,
  [NUM_EMPLEADOS] [int] NULL,
  [FECHA_APERTURA] [datetime] NULL,
  [ORG_VENTA] [nvarchar](4) NOT NULL,
  [DEN_ORG_VTA] [nvarchar](50) NULL,
  [UBICACION] [nvarchar](50) NULL,
  [NEGOCIO] [nvarchar](50) NULL,
  [TIPO_CPE] [varchar](2) NULL,
  [TASA_RC] [numeric](4, 1) NULL,
  [CODWONG] [nvarchar](30) NULL,
  [DATO] [nvarchar](50) NULL,
  [NOMBREDEUDOR] [nvarchar](50) NULL,
  [RUCEMISOR] [nvarchar](11) NULL,
  [RAZONEMISOR] [nvarchar](60) NULL,
  [EXTRA01] [nvarchar](5) NULL
)
ON [PRIMARY]
GO