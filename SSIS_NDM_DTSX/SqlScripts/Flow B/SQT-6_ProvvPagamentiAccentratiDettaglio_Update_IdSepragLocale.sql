USE SchedarioTerritorio
DECLARE @TableName VARCHAR(50);
SET @TableName = 'ProvvPagamentiAccentratiDettaglio'

DECLARE @CreateTableSQLQuery VARCHAR(MAX);

SET @CreateTableSQLQuery = 
   'UPDATE ' + @TableName + ' SET
    IdSepragLocale = n.IdSepragLocale
	FROM(
		SELECT TOP 100 PERCENT i.id, 
			i.SEPRAG_LOC, 
			seplocale.ID as IdSepragLocale,
			seplocale.Denominazione as DenominazioneSepragLocale
		FROM _oraAccentramenti i
		INNER JOIN UnitaTerritorialiSeprag sepLocale On sepLocale.CodiceSede + sepLocale.CodiceProvincia + sepLocale.CodiceAgenzia = i.SEPRAG_LOC
		ORDER BY sepLocale.ID
	) n 
	WHERE n.id = ' + @TableName + '.id;
	
	SELECT @@ROWCOUNT as RowsUpdated;'

EXEC (@CreateTableSQLQuery);