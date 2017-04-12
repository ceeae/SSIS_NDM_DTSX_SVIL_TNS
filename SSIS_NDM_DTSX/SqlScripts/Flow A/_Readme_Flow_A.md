
Flusso A (lyrics)
=================

**Tabelle coinvolte:** _oraIncassi, ProvvIncassi, ProvvIncassiDettaglio.

Il flusso A scarica gli incassi da Oracle via OLE DB tramite comando SQL e li inserisce in una tabella temporanea "_oraIncassi".
Il comando SQL viene creato parametricamente da SCT-1 attraverso la sostituzione di parametri (formato "{n}"): "data quietanza da" e "data quietanza a".
La tabella temporanea "_oraIncassi" viene troncata, viene effettuato l'import.

Configurazione (import_sql_flow_A.dtsConfig)
===========================================

Definire l'intervallo *User::sDataQuietanzaDa* e *User::sDataQuietanzaA* per specificare le date da importare con il formato "'dd-mm-yyyy hh:mi:ss AM'".

Impostando entrambe le variabili come '01-01-1899 12:00:00 AM' l'intervallo viene impostato automaticamente prendendo la data del server sul quale viene lanciato il dtsx  
dalla mezzanotte dell'altro ieri alla mezzanote di ieri.


Oracle
======
Oracle Datetime Format Utilizzato: "'dd-mm-yyyy hh:mi:ss AM'"



