-- Query di Aggregazione Principale
--
-- Paramentri:
-- {0} Data Quietanda Da
-- {1} Data Quietanza A
-- {2} Formato Data "'dd-mm-yyyy 12:00:00 AM'"

return @"
SELECT  quietanza.id_quietanza as chiave,
	case
	when quietanza.id_tipo_modello = 1 then 1
	else 2
	end as numtipomodello,
	trim( cast( generelocale.indicatore_se as varchar(1) ) ) as indicatorese,
	quietanza.NUM_FATTURA as numeroFattura,
	quietanza.DATA as dataQuietanza,
	
	spazio.DENOMINAZIONE as denominazioneSpazio,
	
	toponimoLocale.DENOMINAZIONE as TOPONIMOLOCALE,
	stradaLocale.DENOMINAZIONE as STRADALOCALE,
	locale.NUMERO_CIVICO as NUMEROCIVICO,
	trim( cast( comuneLocale.COD_COMUNE_SIAE as varchar(3) ) ) as codiceComuneSiae,
	trim( cast( locale.COD_CATEG_LOCALE as varchar(1) ) ) as CODCATEGLOCALE,
	trim( cast( locale.COD_GENERE_LOCALE as varchar(3) ) ) as genereLocale,
	organizzatore.COGNOME as cognomeOrganizzatore,
	organizzatore.NOME as nomeOrganizzatore,
	organizzatore.CODICE_FISCALE as CODICEFISCALE,
	organizzatore.PARTITA_IVA as PARTITAIVA,
	
	stradaOrganizzatore.ID_STRADA as IDSTRADAORGANIZZATORE,
	toponimoOrganizzatore.DENOMINAZIONE as TOPONIMOORGANIZZATORE,
	stradaOrganizzatore.DENOMINAZIONE as STRADAORGANIZZATORE,
	organizzatore.NUMERO_CIVICO as NUMCIVICOORGANIZZATORE,
	comuneOrganizzatore.DESCRIZIONE as COMUNEORGANIZZATORE,
	trim( cast( provincia.SIGLA as varchar(2) ) ) as PROVINCIAORGANIZZATORE,
	organizzatore.indirizzo_estero as STRADAESETEROORGANIZZATORE,

	infoStampaQuietanza.DATA_INIZIO as dataInizio,
	infoStampaQuietanza.DATA_FINE as dataFine,
	trim( cast( quietanza.COD_SEPRAG as varchar(7) ) ) as SEPRAG, 
	trim( cast( locale.COD_SEPRAG as varchar(7) ) ) as SEPRAGLOCALE,

	spazio.ID_SPAZIO as idspazio,
	
	quietanza.NUM_DOCUMENTO as numeroReversale,
	trim( cast( tipoDocumento.COD_TIPO_DOCUMENTO as varchar(2) ) ) as codiceTipoDocumento,
	quietanza.REVERSALE_RIFERIMENTO as numReversaleRiferimento,
	quietanza.DATA_REVERSALE_RIF as dataNumReveresaleRiferimento,				
	locale.TITOLARE as titolareLocale,
	trim( cast( quietanza.COD_GENERE_EVENTO as varchar(2) ) ) as codGenereEventoQuietanza,
	quietanza.IMPORTO as importoQuietanza,
	quietanza.ID_QUIETANZA as idQuietanza,
	infoStampaQuietanza.TOTALE_IMPONIBILE_DA as incassoNetto,
	infoStampaQuietanza.INGRESSI as numeroBiglietti,
	infoStampaQuietanza.NUMERO_DOCUMENTI as numeroDocumenti,
	infoStampaQuietanza.NUMERO_EVENTI as numeroEventi,
	case
	when infoStampaQuietanza.NUMERO_GIORNATE > 99 then 99
	else infoStampaQuietanza.NUMERO_GIORNATE
	end as numeroGiornateEventi,
	locale.DENOMINAZIONE as denominazioneLocale,
	comuneLocale.DESCRIZIONE as localitaLocale,
	trim( cast( quietanza.STATO as varchar(1) ) ) as statoQuietanza,
	trim( cast( infoStampaQuietanza.FLAG_398 as varchar(1) ) ) as flag398,
	trim( cast( infoStampaQuietanza.TIPO_DOCUMENTO as varchar(1) ) ) as tipoDocumento,
	infoStampaQuietanza.COD_ACCORDO_SPEI_CATEGORIA as codAccordoSpeiCategoria,
	quietanza.NOTE as noteQuietanza,
	
	trim( cast( locale.COD_GENERE_LOCALE as varchar(3) ) ) as codGenereLocale,
	
	spazio.CODICE_BA as codBASpazio,
	raggruppamento.NUM_DITTA as numeroDitta,
	trim( cast( codiceSpei.CODICE  as varchar(13) ) ) as codSpei, 
	quietanza.ID_TIPO_MODELLO as tipoModello,
	nvl(quietanza.FLAG_PRIVACY,'') AS flagPrivacy,
	infoStampaQuietanza.MISSIONI_PROTOCOLLO_SAP as missioniProtocolloSap,
	
	quietanza.CODICE_IPA as codiceIPAQuietanza,
	
	quietanza.REGIME_IVA_APPLICATO as regimeIvaApplicato

from
	QUIETANZA quietanza 
	left join INFO_STAMPA_QUIETANZA infoStampaQuietanza on  quietanza.ID_INFO_STAMPA_QUIETANZA=infoStampaQuietanza.ID_INFO_STAMPA_QUIETANZA
	inner join SPAZIO spazio ON spazio.id_spazio = quietanza.id_spazio			
	left join RAGGRUPPAMENTO_SPAZIO raggruppamentoSpazio on spazio.ID_SPAZIO=raggruppamentoSpazio.ID_SPAZIO
	left join RAGGRUPPAMENTO raggruppamento on raggruppamentoSpazio.ID_RAGGRUPPAMENTO =raggruppamento.ID_RAGGRUPPAMENTO
	inner join LOCALE locale ON  spazio.ID_LOCALE=locale.ID_LOCALE 
	left join CODICE_SPEI codiceSpei on spazio.ID_SPAZIO = codiceSpei.ID_SPAZIO AND quietanza.COD_SEPRAG = codiceSpei.COD_SEPRAG,

	ORGANIZZATORE organizzatore left join  STRADA stradaOrganizzatore on   organizzatore.ID_STRADA=stradaOrganizzatore.ID_STRADA 
	left join TOPONIMO toponimoOrganizzatore on     stradaOrganizzatore.COD_TOPONIMO=toponimoOrganizzatore.COD_TOPONIMO 
	left join COMUNE comuneOrganizzatore  on stradaOrganizzatore.COD_COMUNE=comuneOrganizzatore.COD_COMUNE 
	left join PROVINCIA provincia 	  on  comuneOrganizzatore.COD_PROVINCIA=provincia.COD_PROVINCIA ,
	
	STRADA stradaLocale,
	TOPONIMO toponimoLocale,
	COMUNE comuneLocale,
	TIPO_DOCUMENTO tipoDocumento,
	GENERE_LOCALE genereLocale
	
where
	quietanza.STATO in('S','A')   
	and quietanza.origine='SUN'  and
	quietanza.ID_ORGANIZZATORE=organizzatore.ID_ORGANIZZATORE and 
	locale.ID_STRADA=stradaLocale.ID_STRADA and
	stradaLocale.COD_TOPONIMO=toponimoLocale.COD_TOPONIMO and
	stradaLocale.COD_COMUNE=comuneLocale.COD_COMUNE and		    
	tipoDocumento.ID_TIPO_DOCUMENTO=quietanza.ID_TIPO_DOCUMENTO and
	locale.cod_genere_locale = generelocale.cod_genere_locale
	and quietanza.data >= TO_DATE({0}, {2}) 
    and quietanza.data < TO_DATE({1}, {2})

order by 
	numtipomodello, 
	quietanza.NUM_DOCUMENTO
";