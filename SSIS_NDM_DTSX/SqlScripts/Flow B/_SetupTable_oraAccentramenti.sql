USE SchedarioTerritorio
DECLARE @TableName VARCHAR(50);
SET @TableName = '_oraAccentramenti'

DECLARE @CreateTableSQLQuery VARCHAR(MAX);

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TableName)	
	BEGIN
		SET @CreateTableSQLQuery = 'CREATE TABLE ' + @TableName + 
			' (
				[ID_SCHEDA_ABBONAMENTO] bigint,
				[COD_SEPRAG] varchar(7),
				[SEPRAG_LOC] varchar(7),
				[CIRCOSCRIZIONE_LOCALE] varchar(50),
				[VOCE_INCASSO] varchar(4),
				[IMPORTO] numeric(18,2),
				[NUM_FATTURA] varchar(20),
				[NUM_DOCUMENTO] varchar(20),
				[DATA] datetime,
				[CODICE_BA] varchar(13),
				[SEPRAG_EMITTENTE] varchar(7),
				[DENOMINAZIONE_LOCALE] varchar(50),
				[INDIRIZZO_LOCALE] varchar(162),
				[COMUNE] varchar(80),
				[ORGANIZZATORE] varchar(100),
				[PAGAMENTO] varchar(13),
				[TIPOLOGIA_ACCENTRAMENTO] varchar(17),
				[ID_VOCE_COMPETENZA] bigint,
				[ID_EVENTO] bigint,
				[RESPONSABILE] varchar(201),
				
				[Id] [bigint] IDENTITY(1,1) NOT NULL,
				[InsertedOn] [datetime] NOT NULL,
				
			    CONSTRAINT [PK_' + @TableName + '] PRIMARY KEY CLUSTERED 
					(
						[id] ASC
					) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			 ) ON [PRIMARY]';
		
		EXEC (@CreateTableSQLQuery);
				
		SET @CreateTableSQLQuery = 
			'ALTER TABLE ' + @TableName + ' ADD CONSTRAINT [DF_' + @TableName + '_InsertedOn] DEFAULT (GETUTCDATE()) FOR [InsertedOn]'
		EXEC (@CreateTableSQLQuery);

	END