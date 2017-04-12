-- Select All IdQuietanza from _oraIncassi not yet Imported
SELECT ora.* FROM _oraIncassi ora LEFT JOIN ProvvIncassi pri 
ON ora.IDQUIETANZA = pri.IdQuietanza 
WHERE pri.IdQuietanza IS NULL