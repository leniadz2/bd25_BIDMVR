CREATE TABLE [dbo].[t_familias] (
  [cod_empresa] [int] NOT NULL,
  [cod_dpto] [int] NULL,
  [cod_seccion] [smallint] NULL,
  [cod_familia] [smallint] NULL,
  [nom_familia] [nvarchar](25) NULL
)
ON [PRIMARY]
GO