﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_REPMM_MEDI] AS

 /*
1	PANISTERIA
2	LIBRERIA
3	GTT
4	PAPAS
5	DONBUFFET
6	MEDITERRANEO
*/

SELECT FECHA,
       ROUND(SUM(MED_restBENAVIDES_icg  ),3) AS "MED restBENAVIDES icg"  ,
       ROUND(SUM(MED_restBENAVIDES_sac  ),3) AS "MED restBENAVIDES sac"  ,
       ROUND(SUM(MED_restBENAVIDES_delta),3) AS "MED restBENAVIDES delta",
       ROUND(SUM(MED_restFERRERO_icg    ),3) AS "MED restFERRERO icg"   ,
       ROUND(SUM(MED_restFERRERO_sac    ),3) AS "MED restFERRERO sac"   ,
       ROUND(SUM(MED_restFERRERO_delta  ),3) AS "MED restFERRERO delta" ,
       ROUND(SUM(MED_restMDS_icg   ),3) AS "MED restMDS icg"  ,
       ROUND(SUM(MED_restMDS_sac   ),3) AS "MED restMDS sac"  ,
       ROUND(SUM(MED_restMDS_delta ),3) AS "MED restMDS delta",
       ROUND(SUM(MED_pcomMDS_icg   ),3) AS "MED pcomMDS icg"   ,
       ROUND(SUM(MED_pcomMDS_sac   ),3) AS "MED pcomMDS sac"   ,
       ROUND(SUM(MED_pcomMDS_delta ),3) AS "MED pcomMDS delta" ,
       ROUND(SUM(MED_restCCPN_icg  ),3) AS "MED restCCPN icg"  ,
       ROUND(SUM(MED_restCCPN_sac  ),3) AS "MED restCCPN sac"  ,
       ROUND(SUM(MED_restCCPN_delta),3) AS "MED restCCPN delta",
       ROUND(SUM(MED_restPOLO_icg  ),3) AS "MED restPOLO icg"   ,
       ROUND(SUM(MED_restPOLO_sac  ),3) AS "MED restPOLO sac"   ,
       ROUND(SUM(MED_restPOLO_delta),3) AS "MED restPOLO delta" ,
       ROUND(SUM(MED_null_icg  ),3) AS "MED null icg"  ,
       ROUND(SUM(MED_null_sac  ),3) AS "MED null sac"  ,
       ROUND(SUM(MED_null_delta),3) AS "MED null delta"
  FROM (SELECT FECHA,
               MED_restBENAVIDES_icg   = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE BENAVIDES' THEN BASE_ICG ELSE NULL END,
               MED_restBENAVIDES_sac   = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE BENAVIDES' THEN BASE_DM ELSE NULL END,
               MED_restBENAVIDES_delta = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE BENAVIDES' THEN DELTA ELSE NULL END,
               MED_restFERRERO_icg     = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE FERRERO' THEN BASE_ICG ELSE NULL END,
               MED_restFERRERO_sac     = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE FERRERO' THEN BASE_DM ELSE NULL END,
               MED_restFERRERO_delta   = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE FERRERO' THEN DELTA ELSE NULL END,
               MED_restMDS_icg    = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE MDS' THEN BASE_ICG ELSE NULL END,
               MED_restMDS_sac    = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE MDS' THEN BASE_DM ELSE NULL END,
               MED_restMDS_delta  = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE MDS' THEN DELTA ELSE NULL END,
               MED_pcomMDS_icg    = CASE NOM_TIENDA  WHEN 'MEDITERRANEO PATIO DE COMIDAS MDS' THEN BASE_ICG ELSE NULL END,
               MED_pcomMDS_sac    = CASE NOM_TIENDA  WHEN 'MEDITERRANEO PATIO DE COMIDAS MDS' THEN BASE_DM ELSE NULL END,
               MED_pcomMDS_delta  = CASE NOM_TIENDA  WHEN 'MEDITERRANEO PATIO DE COMIDAS MDS' THEN DELTA ELSE NULL END,
               MED_restCCPN_icg   = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE CCPN' THEN BASE_ICG ELSE NULL END,
               MED_restCCPN_sac   = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE CCPN' THEN BASE_DM ELSE NULL END,
               MED_restCCPN_delta = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE CCPN' THEN DELTA ELSE NULL END,
               MED_restPOLO_icg   = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE POLO' THEN BASE_ICG ELSE NULL END,
               MED_restPOLO_sac   = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE POLO' THEN BASE_DM ELSE NULL END,
               MED_restPOLO_delta = CASE NOM_TIENDA  WHEN 'MEDITERRANEO RESTAURANTE POLO' THEN DELTA ELSE NULL END,
               MED_null_icg   = CASE NOM_TIENDA  WHEN NULL THEN BASE_ICG ELSE NULL END,
               MED_null_sac   = CASE NOM_TIENDA  WHEN NULL THEN BASE_DM ELSE NULL END,
               MED_null_delta = CASE NOM_TIENDA  WHEN NULL THEN DELTA ELSE NULL END
          FROM VAL_CUADRE_F
         WHERE COD_EMPRESA = '6') AS T
 GROUP BY FECHA
GO