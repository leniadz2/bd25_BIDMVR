﻿CREATE TABLE [dbo].[MONEDAS] (
  [COD_EMPRESA] [int] NOT NULL,
  [COD_MONEDA] [int] NOT NULL,
  [NOM_MONEDA] [nvarchar](20) NULL,
  [INICIALES] [nvarchar](4) NULL,
  [PRINCIPAL] [nchar](1) NULL,
  [TASA_CAMBIO] [float] NULL,
  CONSTRAINT [PK_MONEDAS] PRIMARY KEY CLUSTERED ([COD_EMPRESA], [COD_MONEDA])
)
ON [PRIMARY]
GO