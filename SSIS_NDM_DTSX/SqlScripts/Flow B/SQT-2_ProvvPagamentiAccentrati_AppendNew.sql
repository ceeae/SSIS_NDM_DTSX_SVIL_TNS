USE [SchedarioTerritorio]
INSERT INTO [ProvvPagamentiAccentrati]
           (
           [TipologiaAccentramento]
           ,[Seprag]
           ,[NumeroFattura]
           ,[NumeroDocumento]
           ,[Data]
           ,[SepragEmittente]
           ,[Pagamento]
           ,[Log_Inserimento]
           ,[Log_InserimentoDataOra]
           ,[IdQuietanza]
           )
SELECT 
    g.TIPOLOGIA_ACCENTRAMENTO
   ,g.COD_SEPRAG
   ,g.NUM_FATTURA
   ,g.NUM_DOCUMENTO
   ,g.DATA
   ,g.SEPRAG_EMITTENTE
   ,g.PAGAMENTO
   , '-IMPORT' AS Log_Inserimento
   , GETDATE() AS Log_InserimentoDataOra
   ,g.ID_QUIETANZA
 
FROM (
			SELECT TOP 100 PERCENT
				   TIPOLOGIA_ACCENTRAMENTO
				  ,COD_SEPRAG
				  ,NUM_FATTURA
				  ,NUM_DOCUMENTO
				  ,DATA
				  ,SEPRAG_EMITTENTE
				  ,PAGAMENTO
				  ,ID_QUIETANZA
	     FROM [_oraAccentramenti]
		 GROUP BY 
		   TIPOLOGIA_ACCENTRAMENTO
			  ,COD_SEPRAG
			  ,NUM_FATTURA
			  ,NUM_DOCUMENTO
			  ,DATA
			  ,SEPRAG_EMITTENTE
			  ,PAGAMENTO
			  ,ID_QUIETANZA

) AS g 
LEFT JOIN ProvvPagamentiAccentrati AS m 
	ON 
	 g.NUM_FATTURA = m.NumeroFattura AND
	 g.DATA = m.Data AND
	 g.ID_QUIETANZA = m.IdQuietanza
			 
	 WHERE
		m.Id IS NULL;
		
SELECT @@ROWCOUNT as RowsInserted;
	
