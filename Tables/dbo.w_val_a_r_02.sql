CREATE TABLE [dbo].[w_val_a_r_02] (
  [FECHA_ICG] [varchar](8) NULL,
  [COD_EMPRESA_ICG] [int] NULL,
  [NOM_TIENDA_ICG] [nvarchar](50) NULL,
  [NUMSERIE_ICG] [nvarchar](4) NULL,
  [NUMFACTURA_ICG] [int] NULL,
  [BASE_ICG] [float] NULL,
  [FECHA_DM] [varchar](8) NULL,
  [COD_EMPRESA_DM] [int] NULL,
  [NOM_TIENDA_DM] [nvarchar](50) NULL,
  [NUMSERIE_DM] [nvarchar](4) NULL,
  [NUMFACTURA_DM] [int] NULL,
  [BASE_DM] [float] NULL,
  [delta] [float] NULL,
  [FHORACARGA] [varchar](30) NULL
)
ON [PRIMARY]
GO