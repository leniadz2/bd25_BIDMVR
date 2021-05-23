CREATE TABLE [dbo].[t_subfamilias] (
  [cod_empresa] [int] NOT NULL,
  [cod_dpto] [int] NULL,
  [cod_seccion] [smallint] NULL,
  [cod_familia] [smallint] NULL,
  [cod_subfamilia] [smallint] NULL,
  [nom_subfamilia] [nvarchar](25) NULL
)
ON [PRIMARY]
GO