CREATE TABLE [dbo].[w_dist_ventasdet] (
  [cod_empresa] [int] NOT NULL,
  [cod_dpto] [int] NULL,
  [nom_dpto] [nvarchar](25) NULL,
  [cod_seccion] [smallint] NULL,
  [nom_seccion] [nvarchar](25) NULL,
  [cod_familia] [smallint] NULL,
  [nom_familia] [nvarchar](25) NULL,
  [cod_subfamilia] [smallint] NULL,
  [nom_subfamilia] [nvarchar](25) NULL,
  [cod_marca] [int] NULL,
  [nom_marca] [nvarchar](25) NULL,
  [cod_linea] [smallint] NULL,
  [nom_linea] [nvarchar](25) NULL
)
ON [PRIMARY]
GO