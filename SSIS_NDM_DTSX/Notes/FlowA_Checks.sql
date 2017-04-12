-- *************************************************
-- Check ProvvIncassi Last Date Imported
-- *************************************************
--USE SchedarioTerritorio
--SELECT IdQuietanza, DataFattura, InsertedOn FROM ProvvIncassi
--ORDER BY DataFattura DESC


-- *************************************************
-- Check (temp) _oraIncassi to Import on ProvvIncassi (on IdQuietanza)
-- *************************************************
--USE SchedarioTerritorio
--SELECT ora.* FROM _oraIncassi ora LEFT JOIN ProvvIncassi pri ON ora.IDQUIETANZA = pri.IdQuietanza 
-- WHERE pri.IdQuietanza IS NULL


-- *************************************************
-- Quietanze su ProvvIncassi presenti su _oraIncassi (appena importate)
-- *************************************************
--USE SchedarioTerritorio
--SELECT DISTINCT pri.IdQuietanza, pri.Id FROM ProvvIncassi pri INNER JOIN _oraIncassi ora 
--ON pri.IdQuietanza = ora.IDQUIETANZA
--ORDER BY pri.IdQuietanza DESC

-- *************************************************
--ProvvIncassiDettaglio NON presenti su _oraIncassi da scaricare da Oracle (DA CAMBIARE)
-- *************************************************
--USE SchedarioTerritorio
--SELECT DISTINCT ora.idquietanza, ora.id FROM _oraIncassi ora
--LEFT JOIN (SELECT DISTINCT idquietanza FROM ProvvIncassiDettaglio WHERE IdQuietanza IS NOT NULL) AS dett 
--ON ora.idquietanza = dett.idquietanza 
--WHERE dett.idquietanza IS NULL
--ORDER BY ora.IDQUIETANZA DESC

-- *************************************************
-- Check misaligned FK [ProvvIncassiDettaglio].IdIncasso -> [ProvvIncassi].Id
-- *************************************************

--USE SchedarioTerritorio
--;WITH ctt (IdQuietanza, Id, IdIncasso) 
--AS (
--	SELECT pri.IdQuietanza, pri.Id, det.IdIncasso FROM ProvvIncassi pri
--	INNER JOIN ProvvIncassiDettaglio det
--	ON pri.IdQuietanza = det.IdQuietanza
--)SELECT ctt.IdQuietanza FROM ctt WHERE ctt.Id <> ctt.IdIncasso


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