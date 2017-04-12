-- Get All Pagamenti without a corresponding Dettaglio AND in _ora
USE SchedarioTerritorio

DECLARE @Id BIGINT,  @NumeroFattura varchar(20), @NumeroDocumento varchar(20), @Data DATETIME, @IdSeprag INT, @IdQuietanza numeric(38,0)

DECLARE cur CURSOR FOR  
	SELECT ppa.Id, ppa.NumeroFattura, ppa.NumeroDocumento, ppa.Data, ppa.IdSeprag, ppa.IdQuietanza FROM ProvvPagamentiAccentrati ppa 
	LEFT JOIN ProvvPagamentiAccentratiDettaglio dett
	ON ppa.Id = dett.IdPagamento
	WHERE dett.IdPagamento IS NULL	
	ORDER BY NumeroFattura, Data 

OPEN cur  
	FETCH NEXT FROM cur  INTO @Id, @NumeroFattura, @NumeroDocumento, @Data, @IdSeprag, @IdQuietanza
	WHILE @@FETCH_STATUS = 0  
	BEGIN	

		INSERT INTO [dbo].[ProvvPagamentiAccentratiDettaglio]
			   (
			    [IdPagamento]
			   ,[NumeroFattura]
			   ,[NumeroDocumento]
			   ,[Data]
			   ,[Voce]
			   ,[Importo]
			   ,[IdSepragLocale]
			   ,[SepragLocale]
			   ,[CodiceBA]
			   ,[CircoscrizioneLocale]
			   ,[DenominazioneLocale]
			   ,[IndirizzoLocale]
			   ,[Comune]
			   ,[Organizzatore]
			   ,[Responsabile]
			   ,[IdEventoSchedaAbbonamento]
			   ,[Log_Inserimento]
			   ,[Log_InserimentoDataOra]
			   ,[Log_Aggiornamento]
			   ,[Log_AggiornamentoDataOra]
			   ,[IdQuietanza]
			)

		SELECT DISTINCT @Id, @NumeroFattura, @NumeroDocumento, @Data, VOCE_INCASSO, Importo,
			@IdSeprag, SEPRAG_LOC, CODICE_BA, CIRCOSCRIZIONE_LOCALE, DENOMINAZIONE_LOCALE,
			INDIRIZZO_LOCALE, Comune, Organizzatore, Responsabile, ID_SCHEDA_ABBONAMENTO,
			'-IMPORT', GETDATE(), NULL, NULL,@IdQuietanza
		FROM _oraAccentramenti appo
		WHERE appo.NUM_FATTURA = @NumeroFattura AND appo.Data = @Data AND appo.ID_QUIETANZA = @IdQuietanza

		FETCH NEXT FROM cur  INTO @Id, @NumeroFattura, @NumeroDocumento, @Data, @IdSeprag, @IdQuietanza
	END

CLOSE cur
SELECT @@CURSOR_ROWS as CursorRowsFetched
DEALLOCATE cur
