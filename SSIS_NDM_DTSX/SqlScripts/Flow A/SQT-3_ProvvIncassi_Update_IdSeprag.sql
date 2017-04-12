USE SchedarioTerritorio
DECLARE @TableName VARCHAR(50);
SET @TableName = 'ProvvIncassi'

DECLARE @CreateTableSQLQuery VARCHAR(MAX);

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TableName)
	BEGIN
		SET @CreateTableSQLQuery = 'UPDATE ' + @TableName + ' SET  
			IdSeprag = n.IdSeprag
			FROM(
				SELECT TOP 100 PERCENT i.id, 
					i.Seprag, 
					sep.ID as IdSeprag, 
					sep.Denominazione
				FROM ' + @TableName + ' i
				LEFT JOIN UnitaTerritorialiSeprag sep ON sep.CodiceSede + sep.CodiceProvincia + sep.CodiceAgenzia = i.Seprag
				WHERE sep.ID IS NOT NULL
				ORDER BY sep.ID
			) n 
			WHERE n.seprag = ' + @TableName + '.Seprag;'

		EXEC (@CreateTableSQLQuery);
	END



