CREATE TABLE [dbo].[x_ventasdet_v_PAN] (
  [FECHA] [varchar](8) NULL,
  [NOM_TIENDA] [nvarchar](50) NULL,
  [NUMSERIE] [nvarchar](4) NOT NULL,
  [NUMCORRELATIVO] [int] NOT NULL,
  [TIPODOC] [int] NULL,
  [ANO] [int] NULL,
  [MES_VENTA] [int] NULL,
  [DIA_FECHA] [int] NULL,
  [SEMANA_VENTA] [int] NULL,
  [DIA_SEMANA] [int] NULL,
  [HORA] [int] NULL,
  [BASE] [float] NULL,
  [IMPUESTO] [float] NULL,
  [TOTAL] [float] NULL,
  [UBICACION] [nvarchar](50) NULL
)
ON [PRIMARY]
GO