﻿CREATE TABLE [dbo].[SUBFAMILIAS] (
  [COD_EMPRESA] [int] NOT NULL,
  [COD_DPTO] [int] NOT NULL,
  [COD_SECCION] [int] NOT NULL,
  [COD_FAMILIA] [int] NOT NULL,
  [COD_SUBFAMILIA] [int] NOT NULL,
  [NOM_SUBFAMILIA] [nvarchar](25) NULL,
  CONSTRAINT [PK_SUBFAMILIAS] PRIMARY KEY CLUSTERED ([COD_EMPRESA], [COD_DPTO], [COD_SECCION], [COD_FAMILIA], [COD_SUBFAMILIA])
)
ON [PRIMARY]
GO