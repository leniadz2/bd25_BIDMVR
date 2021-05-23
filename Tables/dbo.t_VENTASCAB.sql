CREATE TABLE [dbo].[t_VENTASCAB] (
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
  [ESTADODELIVERY] [int] NULL
)
ON [PRIMARY]
GO