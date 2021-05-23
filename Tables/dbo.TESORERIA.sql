﻿CREATE TABLE [dbo].[TESORERIA] (
  [FECHA] [nvarchar](8) NULL,
  [COD_EMPRESA] [int] NOT NULL,
  [COD_ALMACEN] [nvarchar](3) NULL,
  [CAJA] [nvarchar](3) NULL,
  [NUMSERIE] [nvarchar](4) NOT NULL,
  [NUMCORRELATIVO] [int] NOT NULL,
  [TOTAL] [float] NULL,
  [IMPUESTO] [float] NULL,
  [BASE] [float] NULL,
  [NUMLINEA] [smallint] NOT NULL,
  [COD_TIPOPAGO] [nvarchar](2) NULL,
  [COD_FORMAPAGO] [nvarchar](6) NULL,
  [COD_MONEDA] [int] NULL,
  [ESTADODELIVERY] [int] NULL,
  CONSTRAINT [PK_TESORERIA] PRIMARY KEY NONCLUSTERED ([COD_EMPRESA], [NUMSERIE], [NUMCORRELATIVO], [NUMLINEA])
)
ON [PRIMARY]
GO