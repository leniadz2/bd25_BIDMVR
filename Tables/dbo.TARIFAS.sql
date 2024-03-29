﻿CREATE TABLE [dbo].[TARIFAS] (
  [COD_EMPRESA] [int] NOT NULL,
  [COD_TARIFA] [int] NOT NULL,
  [NOM_TARIFA] [nvarchar](35) NULL,
  [COD_MONEDA] [int] NULL,
  [IVA_INCLUIDO] [nchar](1) NULL,
  CONSTRAINT [PK_TARIFAS] PRIMARY KEY CLUSTERED ([COD_EMPRESA], [COD_TARIFA])
)
ON [PRIMARY]
GO