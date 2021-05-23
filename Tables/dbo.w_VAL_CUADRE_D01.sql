CREATE TABLE [dbo].[w_VAL_CUADRE_D01] (
  [FECHA_ICG] [varchar](8) NULL,
  [COD_EMPRESA_ICG] [int] NULL,
  [NOM_TIENDA_ICG] [nvarchar](50) NULL,
  [NUMSERIE_ICG] [nvarchar](4) NULL,
  [NUMFACTURA_ICG] [int] NULL,
  [BASE_ICG] [float] NULL,
  [fecha_DM] [varchar](8) NULL,
  [COD_EMPRESA_DM] [int] NULL,
  [NOM_TIENDA_DM] [nvarchar](50) NULL,
  [NUMSERIE_DM] [nvarchar](4) NULL,
  [NUMFACTURA_DM] [int] NULL,
  [BASE_DM] [float] NULL,
  [delta] [float] NULL,
  [FHORACARGA] [varchar](30) NULL,
  [ORDEN] [bigint] NULL
)
ON [PRIMARY]
GO