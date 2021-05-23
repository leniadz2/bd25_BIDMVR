﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_stg_maestros_00]
AS
BEGIN

PRINT(concat('inicia maestros ',SYSDATETIME()));

TRUNCATE TABLE BIDMVR..EMPRESAS      ;
TRUNCATE TABLE BIDMVR..MONEDAS       ;
TRUNCATE TABLE BIDMVR..TARIFAS       ;
TRUNCATE TABLE BIDMVR..PRECIOSVENTA  ;
TRUNCATE TABLE BIDMVR..TIPOSPAGO     ;
TRUNCATE TABLE BIDMVR..FORMASPAGO    ;
TRUNCATE TABLE BIDMVR..VENCIMFPAGO   ;
TRUNCATE TABLE BIDMVR..VENDEDORES    ;
TRUNCATE TABLE BIDMVR..DEPARTAMENTO  ;
TRUNCATE TABLE BIDMVR..SECCIONES     ;
TRUNCATE TABLE BIDMVR..FAMILIAS      ;
TRUNCATE TABLE BIDMVR..SUBFAMILIAS   ;
TRUNCATE TABLE BIDMVR..MARCA         ;
TRUNCATE TABLE BIDMVR..LINEA         ;
TRUNCATE TABLE BIDMVR..ARTICULOS     ;
TRUNCATE TABLE BIDMVR..IMPUESTOS     ;
TRUNCATE TABLE BIDMVR..TIPOSERVICIOSDELIVERY;
TRUNCATE TABLE BIDMVR..CLIENTES;

---EMPRESAS---
INSERT [dbo].[EMPRESAS] ([COD_EMPRESA], [NOMBRE_EMPRESA]) VALUES (1, N'PANISTERIA')    ;
INSERT [dbo].[EMPRESAS] ([COD_EMPRESA], [NOMBRE_EMPRESA]) VALUES (2, N'LIBRERIA') ;
INSERT [dbo].[EMPRESAS] ([COD_EMPRESA], [NOMBRE_EMPRESA]) VALUES (3, N'GTT')           ;
INSERT [dbo].[EMPRESAS] ([COD_EMPRESA], [NOMBRE_EMPRESA]) VALUES (4, N'PAPAS')         ;
INSERT [dbo].[EMPRESAS] ([COD_EMPRESA], [NOMBRE_EMPRESA]) VALUES (5, N'DONBUFFET')    ;
INSERT [dbo].[EMPRESAS] ([COD_EMPRESA], [NOMBRE_EMPRESA]) VALUES (6, N'MEDITERRANEO')  ;

END
GO