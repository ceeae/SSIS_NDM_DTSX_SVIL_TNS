USE SchedarioTerritorio
DECLARE @TableName VARCHAR(50);
SET @TableName = '_oraAccentramenti'

DECLARE @CreateTableSQLQuery VARCHAR(MAX);

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TableName)
	BEGIN
		SET @CreateTableSQLQuery = 'DELETE FROM ' + @TableName; 
		EXEC (@CreateTableSQLQuery);
	END