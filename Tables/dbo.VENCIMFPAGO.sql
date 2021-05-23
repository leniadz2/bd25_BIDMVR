﻿CREATE TABLE [dbo].[VENCIMFPAGO] (
  [COD_EMPRESA] [int] NOT NULL,
  [COD_TIPOPAGO] [nvarchar](2) NOT NULL,
  [COD_FORMAPAGO] [nvarchar](6) NOT NULL,
  [CUOTAS] [smallint] NOT NULL,
  [DIAS] [int] NULL,
  [PORCENTAJE] [float] NULL,
  [TIPO_VENCIMIENTO] [nvarchar](15) NULL,
  CONSTRAINT [PK_VENCIMFPAGO] PRIMARY KEY CLUSTERED ([COD_EMPRESA], [COD_TIPOPAGO], [COD_FORMAPAGO], [CUOTAS])
)
ON [PRIMARY]
GO