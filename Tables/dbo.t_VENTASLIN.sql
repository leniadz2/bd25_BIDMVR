CREATE TABLE [dbo].[t_VENTASLIN] (
  [COD_EMPRESA] [int] NOT NULL,
  [NUMLIN] [int] NOT NULL,
  [CODARTICULO] [int] NULL,
  [REFERENCIA] [nvarchar](15) NULL,
  [UNIDADESTOTAL] [float] NULL,
  [COD_ALMACEN] [nvarchar](3) NULL,
  [COSTO] [float] NULL,
  [NUMCORRELATIVO] [int] NOT NULL,
  [NUMSERIE] [nvarchar](4) NOT NULL,
  [BASE] [float] NULL,
  [IMPUESTO] [float] NULL,
  [RECARGOC] [float] NULL,
  [ESTADODELIVERY] [int] NULL
)
ON [PRIMARY]
GO