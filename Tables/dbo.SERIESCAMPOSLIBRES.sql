CREATE TABLE [dbo].[SERIESCAMPOSLIBRES] (
  [cod_empresa] [int] NOT NULL,
  [SERIE] [nvarchar](4) COLLATE Latin1_General_CS_AI NOT NULL,
  [CODWONG] [nvarchar](30) NULL,
  [DATO] [nvarchar](50) NULL,
  [NOMBREDEUDOR] [nvarchar](50) NULL,
  [CENTRO] [nvarchar](50) NULL,
  [RUCEMISOR] [nvarchar](11) NULL,
  [RAZONEMISOR] [nvarchar](60) NULL
)
ON [PRIMARY]
GO