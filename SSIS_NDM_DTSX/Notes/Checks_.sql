

-- Connection Strings
---------------------

SQL SERVER
==========

SVILUPPO

Data Source=sql_emittenzaradiotelevisiva.sviluppo.siae;
Initial Catalog=SchedarioTerritorio;
Persist Security Info=True;
User ID=webserviziadmin;
Password=WebAdminpass

PRODUZIONE

Data Source=sql_SchedarioTerritorio.net.siae;
Initial Catalog=SchedarioTerritorio;
Persist Security Info=True;
User ID=SchedarioTerritorioRW;
Password=Sch3d4r1o0T3rrRWP455


ORACLE
======

SVILUPPO
Data Source=
(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=SRVSVI-L081V.NET.SIAE)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SPSVIL.NET.SIAE)));


PRODUZIONE
Data Source=
(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=dbsun-scan.servizi.siae)(PORT=1521))(LOAD_BALANCE=yes)(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SPPRD.NET.SIAE)));

User Id= NETDMUSR ;
Password= netdmusr1!;


##### ProvvIncassi

  
 -- ***** Distinct Quietanze in ProvvIncassi con Almeno un Dettaglio
 
--USE SchedarioTerritorio
--SELECT DISTINCT KK.Idquietanza FROM (
--	SELECT pri.IdQuietanza FROM ProvvIncassi pri LEFT JOIN ProvvIncassiDettaglio dett 
--	ON pri.IdQuietanza = dett.IdQuietanza 
--	WHERE pri.IdQuietanza IS NOT NULL
--) AS KK

--select COUNT(*) from ProvvIncassi


-- ******** Check Downloading Progress (ProvvIncassiDettaglio)

--USE SchedarioTerritorio
--SELECT COUNT(idq) FROM (
--	SELECT DISTINCT ora.idquietanza as idq, ora.id, dett.IdQuietanza, dett.Voce FROM _oraIncassi ora
--	LEFT JOIN 
--		(
--		SELECT DISTINCT idquietanza, Voce FROM ProvvIncassiDettaglio WHERE IdQuietanza IS NOT NULL
--		) AS dett 
--	ON ora.idquietanza = dett.idquietanza 
--	WHERE dett.idquietanza IS NULL
--) as kk

-- ******** Check Duplicates on ProvvIncassi

--USE SchedarioTerritorio
--SELECT COUNT(IdQuietanza)
--  FROM [SchedarioTerritorio].[dbo].[ProvvIncassi]
--  WHERE IdQuietanza IS NOT NULL
--  GROUP BY IdQuietanza
--  HAVING COUNT(IdQuietanza) > 1

-- ********** Remove Duplicates on ProvvIncassi

--USE SchedarioTerritorio
--WITH tt (Id, IdQuietanza) AS (
	--SELECT Id, IdQuietanza FROM ProvvIncassi WHERE IdQuietanza IN (
	--	SELECT IdQuietanza FROM ProvvIncassi
	--	WHERE IdQuietanza IS NOT NULL
	--	GROUP BY IdQuietanza
	--	HAVING COUNT(IdQuietanza) > 1
	--) 
--) DELETE FROM ProvvIncassi WHERE Id IN (SELECT MAX(Id) FROM tt GROUP BY IdQuietanza) 
  
  