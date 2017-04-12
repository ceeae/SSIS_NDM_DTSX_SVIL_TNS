

Flusso B (lyrics)
=================

**Tabelle coinvolte:** _oraAccentramenti, ProvvPagamentiAccentrati, ProvvPagamentiAccentratiDettaglio.

Il flusso B scarica gli incassi da Oracle via OLE DB tramite comando SQL e li inserisce in una tabella temporanea "_oraAccentramenti".
Il comando SQL (select) viene creato parametricamente da SCT-1 attraverso la sostituzione di parametri (formato "{n}"): "data reversale da" e "data reversale a".
La tabella temporanea "_oraAccentramenti" viene troncata, viene effettuato l'import.

La fase successiva prevede la *normalizzazione* della tabella "_oraAccentramenti" in 
"ProvvPagamentiAccentrati" e "ProvvPagamentiAccentratiDettaglio" come segue:

1. Vengono inseriti i nuovi incassi nella tabella "ProvvPagamentiAccetrati" e aggiornati, su quest'utima, IdSeprag e IdSepragEmttente;
2. Vengono caricati i dettagli (tramite un cursore) in "ProvvPagamentiAccentratiDettaglio"
3. Viene aggiornato l'IdSepragLocale


Configurazione (import_sql_flow_B.dtsConfig)
===========================================

Definire l'intervallo *User::sDataReversaleDa* e *User::sDataReversaleDa* per specificare le date da importare con il formato "'dd-mm-yyyy hh:mi:ss AM'".
Impostando entrambe le variabili come '01-01-1899 12:00:00 AM' l'intervallo viene impostato automaticamente prendendo la data del server sul quale viene lanciato il dtsx  
dalla mezzanotte dell'altro ieri alla mezzanote di ieri.


Oracle
======
Oracle Datetime Format Utilizzato: "'dd-mm-yyyy hh:mi:ss AM'"