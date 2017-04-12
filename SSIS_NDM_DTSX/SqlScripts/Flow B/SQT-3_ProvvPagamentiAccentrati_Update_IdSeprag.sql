USE SchedarioTerritorio
DECLARE @TableName VARCHAR(50);
SET @TableName = 'ProvvPagamentiAccentrati'

DECLARE @CreateTableSQLQuery VARCHAR(MAX);

SET @CreateTableSQLQuery = 'UPDATE ' + @TableName + ' SET
    IdSeprag = n.IdSeprag
	FROM(
		SELECT TOP 100 PERCENT i.id, 
			i.Seprag, 
			sep.ID as IdSeprag, 
			sep.Denominazione
		FROM ' + @TableName + ' i
		INNER JOIN UnitaTerritorialiSeprag sep On sep.CodiceSede + sep.CodiceProvincia + sep.CodiceAgenzia = i.Seprag
		ORDER BY sep.ID
	) n 
	WHERE n.id = ' + @TableName + '.id
	
	'

EXEC (@CreateTableSQLQuery);