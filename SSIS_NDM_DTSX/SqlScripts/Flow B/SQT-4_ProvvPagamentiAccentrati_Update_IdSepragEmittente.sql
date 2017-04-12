USE SchedarioTerritorio
DECLARE @TableName VARCHAR(50);
SET @TableName = 'ProvvPagamentiAccentrati'

DECLARE @CreateTableSQLQuery VARCHAR(MAX);

SET @CreateTableSQLQuery = 
   'UPDATE ' + @TableName + ' SET
        IdSepragEmittente = n.IdSepragEmittente
	FROM(
		SELECT TOP 100 PERCENT i.id, 
			i.SepragEmittente, 
			sepEmittente.Id as IdSepragEmittente,
			sepEmittente.Denominazione as DenominazioneSepragEmittente
		FROM ' + @TableName + ' i
		INNER JOIN UnitaTerritorialiSeprag sepEmittente On sepEmittente.CodiceSede + sepEmittente.CodiceProvincia + sepEmittente.CodiceAgenzia = i.SepragEmittente
		ORDER BY sepEmittente.ID
	) n 
	WHERE n.id = ' + @TableName + '.id;
	
	SELECT @@ROWCOUNT as RowsUpdated;'

EXEC (@CreateTableSQLQuery);