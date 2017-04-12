--
-- SQL used dynamically in Script Task
-- Parameters used:
-- {0} DataReversaleDa
-- {1} DataReversaleA
-- {2} Oracle DateTime Format .e.g. "'dd-mm-yyyy hh:mi:ss AM'"
--


return @"
SELECT 
    ID_SCHEDA_ABBONAMENTO, 
    COD_SEPRAG, 
    SEPRAG_LOC, 
    CIRCOSCRIZIONE_LOCALE, 
    VOCE_INCASSO, 
    IMPORTO, 
    NUM_FATTURA, 
    NUM_DOCUMENTO, 
    DATA,
    CODICE_BA, 
    SEPRAG_EMITTENTE, 
    DENOMINAZIONE_LOCALE, 
    INDIRIZZO_LOCALE, 
    COMUNE, 
    ORGANIZZATORE,PAGAMENTO, 
    'MUSICA D''AMBIENTE' AS TIPOLOGIA_ACCENTRAMENTO, 
    ID_VOCE_COMPETENZA, 
    NULL AS ID_EVENTO, 
    NULL AS RESPONSABILE
FROM (     
        SELECT 
            q.id_quietanza,
            SCHEDA.ID_SCHEDA_ABBONAMENTO AS ID_SCHEDA_ABBONAMENTO,
            trim( cast( SCHEDA.COD_SEPRAG as varchar(7))) AS COD_SEPRAG,
            trim( cast( LOC.COD_SEPRAG as varchar(7))) AS SEPRAG_LOC,
            CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
            trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
            VSA.IMPORTO                             AS IMPORTO,
            Q.NUM_FATTURA                           AS NUM_FATTURA      ,
            Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
            Q.DATA                                  AS DATA_QUIETANZA,
            SP.CODICE_BA,
            trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
            LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
            TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
            COM.DESCRIZIONE    AS COMUNE,
            ORG.COGNOME        AS ORGANIZZATORE,
            'MDA_ONLINE'                            AS PAGAMENTO,
            Q.DATA                                  AS DATA, 
            VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
            SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
        FROM       
            QUIETANZA Q,                                            
			COMPETENZA CMP,   
			VOCE_COMPETENZA VSA, 
			SCHEDA_ABBONAMENTO SCHEDA, 
			EVENTO E,       
			CLASSE_EVENTO CE, 
			ORGANIZZATORE ORG, 
			CIRCOSCRIZIONE CIRC, 
			SPAZIO SP, 
			LOCALE LOC, 
			STRADA STR, 
			TOPONIMO TOP,   
			COMUNE COM
		WHERE  
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					 AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA
					 AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA 
					 AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA   
					 AND VSA.COD_VOCE_INCASSO IN (1615,1616,2226,2229,2230,2231,2232,2259,2272,2273,2276,2278,2279,2271,2277,2281,2442,3155,3872,3875,3876,3880,3882,3883,3884,2215,2216)  
					 AND SCHEDA.ID_EVENTO =E.ID_EVENTO  
					 AND SCHEDA.COD_GENERE_EVENTO = '95' 
					 AND SCHEDA.STATO = 'P'  
					 AND SCHEDA.COD_SEPRAG <> LOC.COD_SEPRAG 
					 AND E.ID_EVENTO =CE.ID_CLASSE_EVENTO   
					 AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE   
					 AND CE.ID_SPAZIO = SP.ID_SPAZIO 
					 AND SP.ID_LOCALE = LOC.ID_LOCALE  
					 AND LOC.ID_STRADA =STR.ID_STRADA  
					 AND LOC.COD_SEPRAG  = CIRC.COD_SEPRAG   
					 AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'                 
					 AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
					 AND STR.COD_COMUNE =   COM.COD_COMUNE                     
					 AND NOT EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))
					 
			UNION
				SELECT 
				    q.id_quietanza,
					SCHEDA.ID_SCHEDA_ABBONAMENTO            AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                             AS IMPORTO,
					Q.NUM_FATTURA                           AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
					Q.DATA                                  AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE    AS COMUNE,
					ORG.COGNOME        AS ORGANIZZATORE,
					'SPORTELLO'                             AS PAGAMENTO,
					Q.DATA                                  AS DATA, 
					VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM
				WHERE  
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					 AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA
					 AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA 
					 AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA   
					 AND VSA.COD_VOCE_INCASSO IN (1615,1616,2226,2229,2230,2231,2232,2259,2272,2273,2276,2278,2279,2271,2277,2281,2442,3155,3872,3875,3876,3880,3882,3883,3884,2215,2216)  
					 AND SCHEDA.ID_EVENTO =E.ID_EVENTO  
					 AND SCHEDA.COD_GENERE_EVENTO = '95' 
					 AND SCHEDA.STATO = 'P'  
					 AND E.ID_EVENTO =CE.ID_CLASSE_EVENTO   
					 AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE   
					 AND CE.ID_SPAZIO = SP.ID_SPAZIO 
					 AND SP.ID_LOCALE = LOC.ID_LOCALE  
					 AND LOC.ID_STRADA =STR.ID_STRADA  
					 and q.id_metodo_pagamento = 14
					 AND LOC.COD_SEPRAG  = CIRC.COD_SEPRAG   
					 AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'                 
					 AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
					 AND STR.COD_COMUNE =   COM.COD_COMUNE                     
					 AND NOT EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))	 
					 
			 UNION  
				SELECT 
				    q.id_quietanza,
					SCHEDA.ID_SCHEDA_ABBONAMENTO                AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE 							AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                                 AS IMPORTO,
					Q.NUM_FATTURA                               AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                             AS NUM_DOCUMENTO   ,
					Q.DATA                                      AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE      AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE        AS COMUNE,
					ORG.COGNOME            AS ORGANIZZATORE,
					'MAV'                                       AS PAGAMENTO,
					Q.DATA                                      AS DATA, 
					VSA.ID_VOCE_COMPETENZA                      AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                        AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM   
				WHERE       
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA
					AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA 
					AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA   
					AND VSA.COD_VOCE_INCASSO IN (1615,1616,2226,2229,2230,2231,2232,2259,2272,2273,2276,2278,2279,2271,2277,2281,2442,3155,3872,3875,3876,3880,3882,3883,3884,2215,2216)  
					AND SCHEDA.ID_EVENTO =E.ID_EVENTO  
					AND SCHEDA.COD_GENERE_EVENTO = '95' 
					AND SCHEDA.STATO = 'P'  
					AND E.ID_EVENTO =CE.ID_CLASSE_EVENTO   
					AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE   
					AND CE.ID_SPAZIO = SP.ID_SPAZIO 
					AND SP.ID_LOCALE = LOC.ID_LOCALE  
					AND LOC.ID_STRADA =STR.ID_STRADA  
					AND LOC.COD_SEPRAG  = CIRC.COD_SEPRAG   --
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'       --          
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO     -- 
					AND STR.COD_COMUNE =   COM.COD_COMUNE      
					AND EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))  
			UNION
				SELECT
				    q.id_quietanza,  
					SCHEDA.ID_SCHEDA_ABBONAMENTO            AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                             AS IMPORTO,
					Q.NUM_FATTURA                           AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
					Q.DATA                                  AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE    AS COMUNE,
					ORG.COGNOME        AS ORGANIZZATORE,
					'SPORTELLO SCF'                             AS PAGAMENTO,
					Q.DATA                                  AS DATA, 
					VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM  
				WHERE    
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
						AND LOC.COD_SEPRAG <> SCHEDA.COD_SEPRAG      
						AND SP.ID_LOCALE = LOC.ID_LOCALE      
						AND CE.ID_CLASSE_EVENTO = E.ID_EVENTO      
						AND CE.ID_SPAZIO = SP.ID_SPAZIO      
						AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA      
						AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA       
						AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE      
						AND CIRC.COD_SEPRAG = LOC.COD_SEPRAG      
						AND SCHEDA.STATO = 'P'       
						AND STR.ID_STRADA = LOC.ID_STRADA      
						AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
						AND STR.COD_COMUNE = COM.COD_COMUNE         
						AND E.ID_EVENTO = SCHEDA.ID_EVENTO         
						AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA     
						AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M' 
						AND SCHEDA.COD_GENERE_EVENTO = 'DC' 
						AND NOT EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E')) 
						AND SUBSTR(VSA.COD_VOCE_INCASSO, 0, 2) = '07'
			UNION
				SELECT  
				    q.id_quietanza,
					SCHEDA.ID_SCHEDA_ABBONAMENTO            AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                             AS IMPORTO,
					Q.NUM_FATTURA                           AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
					Q.DATA                                  AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE    AS COMUNE,
					ORG.COGNOME        AS ORGANIZZATORE,
					'MAV SCF'                               AS PAGAMENTO,
					Q.DATA                                  AS DATA, 
					VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM  
				WHERE    
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND SP.ID_LOCALE = LOC.ID_LOCALE      
					AND CE.ID_CLASSE_EVENTO = E.ID_EVENTO      
					AND CE.ID_SPAZIO = SP.ID_SPAZIO      
					AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA      
					AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA       
					AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE      
					AND CIRC.COD_SEPRAG = LOC.COD_SEPRAG      
					AND SCHEDA.STATO = 'P'       
					AND STR.ID_STRADA = LOC.ID_STRADA      
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
					AND STR.COD_COMUNE = COM.COD_COMUNE       
					AND E.ID_EVENTO = SCHEDA.ID_EVENTO         
					AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA       
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'  
					AND SCHEDA.COD_GENERE_EVENTO = 'DC' 
					AND EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))  
					AND SUBSTR(VSA.COD_VOCE_INCASSO, 0, 2) = '07'
			UNION
				SELECT
				    q.id_quietanza,     
					NULL                                        AS ID_SCHEDA_ABBONAMENTO,
					NULL                                        AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE     AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VQ.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VQ.IMPORTO                                  AS IMPORTO,
					Q.NUM_FATTURA                               AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                             AS NUM_DOCUMENTO   ,
					Q.DATA                                      AS DATA_QUIETANZA,
					SP.CODICE_BA,
					NULL                                        AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE      AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE        AS COMUNE,
					ORG.COGNOME            AS ORGANIZZATORE,
					'PORTUP'                                    AS PAGAMENTO,
					Q.DATA                                      AS DATA,
					VQ.ID_VOCE_QUIETANZA                        AS ID_VOCE_COMPETENZA,                                                                            
					Q.DATA_MODIFICA                             AS DATA_ULTIMA_MODIFICA     
				FROM   
					QUIETANZA Q,
					VOCE_QUIETANZA VQ,
					CIRCOSCRIZIONE CIRC, 
					ORGANIZZATORE ORG, 
					SPAZIO SP,
					LOCALE LOC,
					STRADA STR,
					TOPONIMO TOP,
					COMUNE COM
				WHERE   
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND Q.ORIGINE = 'PUP'
					AND Q.STATO = 'S'
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M' 
					AND Q.ID_QUIETANZA = VQ.ID_QUIETANZA
					AND CIRC.COD_SEPRAG = Q.COD_SEPRAG
					AND SP.ID_SPAZIO = Q.ID_SPAZIO
					AND SP.ID_LOCALE = LOC.ID_LOCALE
					AND STR.ID_STRADA = LOC.ID_STRADA
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO
					AND STR.COD_COMUNE = COM.COD_COMUNE
					AND Q.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE 
			UNION
				SELECT
				    q.id_quietanza,    
					NULL                                        AS ID_SCHEDA_ABBONAMENTO,
					NULL                                        AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE     AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VQ.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VQ.IMPORTO                                  AS IMPORTO,
					Q.NUM_FATTURA                               AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                             AS NUM_DOCUMENTO   ,
					Q.DATA                                      AS DATA_QUIETANZA,
					SP.CODICE_BA,
					NULL                                        AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE      AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE        AS COMUNE,
					ORG.COGNOME            AS ORGANIZZATORE,
					'PRIVATI'                                   AS PAGAMENTO,
					Q.DATA                                      AS DATA,        
					VQ.ID_VOCE_QUIETANZA                        AS ID_VOCE_COMPETENZA,                                                          
					Q.DATA_MODIFICA                             AS DATA_ULTIMA_MODIFICA     
				FROM   
					QUIETANZA Q,
					VOCE_QUIETANZA VQ,
					CIRCOSCRIZIONE CIRC, 
					ORGANIZZATORE ORG, 
					SPAZIO SP,
					LOCALE LOC,
					STRADA STR,
					TOPONIMO TOP,
					COMUNE COM
				WHERE       
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND Q.ORIGINE = 'PTP'
					AND Q.STATO = 'S' 
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'
					AND Q.ID_QUIETANZA = VQ.ID_QUIETANZA
					AND CIRC.COD_SEPRAG = LOC.COD_SEPRAG
					AND SP.ID_SPAZIO = Q.ID_SPAZIO
					AND SP.ID_LOCALE = LOC.ID_LOCALE
					AND STR.ID_STRADA = LOC.ID_STRADA
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO
					AND STR.COD_COMUNE = COM.COD_COMUNE 
					AND Q.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE
			) 
			
			UNION
				SELECT
				   q.id_quietanza, 
				   NULL AS id_scheda_abbonamento,
				   TRIM (CAST (a.cod_seprag AS VARCHAR (7))) AS cod_seprag,
				   TRIM (CAST (l.cod_seprag AS VARCHAR (7))) AS seprag_loc,
				   cil.denominazione AS circoscrizione_locale,
				   TRIM (CAST (vc.cod_voce_incasso AS VARCHAR (4))) AS voce_incasso,
				   vc.importo AS importo,
				   q.num_fattura AS num_fattura,
				   q.num_documento AS num_documento,
				   q.data AS data,
					s.CODICE_BA,
				   q.cod_seprag AS seprag_emittente,
				   l.denominazione AS denominazione_locale,
				   tpl.denominazione || ' ' || stl.denominazione || ' ' || l.numero_civico AS indirizzo_locale,
				   co.descrizione AS comune,
				   o.cognome AS organizzatore,
				   'SPORTELLO' AS pagamento,
				   'EVENTO' AS tipologia_accentramento,
				   vc.id_voce_competenza AS id_voce_competenza,
				   e.id_evento AS id_evento,
				   rc.responsabile AS responsabile
				FROM accentramento_scheda_evento aee
				   INNER JOIN accentramento_new a
					   ON a.id_accentramento = aee.id_accentramento
				   INNER JOIN accentramento_evento ae
					   ON ae.id_accentramento_evento = a.id_accentramento
				   INNER JOIN evento_observer eob
					   ON eob.id_evento = aee.id_evento
				   INNER JOIN competenza_observer cob
					   ON eob.observer_id = cob.observer_id
				   INNER JOIN quietanza_observer qob
					   ON cob.id_competenza = qob.observer_id
				   INNER JOIN quietanza q
					   ON qob.id_quietanza = q.id_quietanza
				   INNER JOIN competenza c
					   ON c.id_quietanza = q.id_quietanza
				   INNER JOIN voce_competenza vc
					   ON vc.id_competenza = c.id_competenza
				   INNER JOIN evento e
					   ON e.id_evento = aee.id_evento
				   INNER JOIN classe_evento ce
					   ON ce.id_classe_evento = e.id_evento
				   INNER JOIN organizzatore o
					   ON o.id_organizzatore = ce.id_organizzatore
				   INNER JOIN spazio s
					   ON s.id_spazio = ce.id_spazio
				   INNER JOIN locale l
					   ON l.id_locale = s.id_locale
				   INNER JOIN circoscrizione cil
					   ON cil.cod_seprag = l.cod_seprag
				   INNER JOIN strada stl
					   ON stl.id_strada = l.id_strada
				   INNER JOIN toponimo tpl
					   ON tpl.cod_toponimo = stl.cod_toponimo
				   INNER JOIN comune co
					   ON co.cod_comune = stl.cod_comune
				   LEFT JOIN (SELECT o.cognome || ' ' || o.nome AS responsabile,
									 oga.cod_seprag AS cod_seprag
								FROM     organizzatore_genere_attivita oga
									 INNER JOIN
										 organizzatore o
									 ON o.id_organizzatore = oga.id_organizzatore
							   WHERE     oga.cod_genere_attivita IN
											 ('070', '804', '812', '813')
									 AND (   (SYSDATE BETWEEN oga.inizio_validita
														  AND oga.fine_validita)
										  OR     (oga.fine_validita IS NULL)
											 AND SYSDATE >= oga.inizio_validita)) rc
					   ON rc.cod_seprag = l.cod_seprag AND ROWNUM <= 1         
				WHERE  a.stato = 'A'
				   AND q.stato = 'S'
				   AND ae.flag_398 = '0'
				   AND q.data BETWEEN TO_DATE({0}, {2}) AND TO_DATE({1}, {2})
			UNION 
				SELECT 
				   q.id_quietanza,
				   NULL AS id_scheda_abbonamento,
				   TRIM (CAST (a.cod_seprag AS VARCHAR (7))) AS cod_seprag,
				   TRIM (CAST (l.cod_seprag AS VARCHAR (7))) AS seprag_loc,
				   cil.denominazione AS circoscrizione_locale,
				   TRIM (CAST (vc.cod_voce_incasso AS VARCHAR (4))) AS voce_incasso,
				   vc.importo / 2 AS importo,
				   q.num_fattura AS num_fattura,
				   q.num_documento AS num_documento,
				   q.data AS data,
					s.CODICE_BA,
				   q.cod_seprag AS seprag_emittente,
				   l.denominazione AS denominazione_locale,
				   tpl.denominazione || ' ' || stl.denominazione || ' ' || l.numero_civico AS indirizzo_locale,
				   co.descrizione AS comune,
				   o.cognome AS organizzatore,
				   'SPORTELLO' AS pagamento,
				   '398' AS tipologia_accentramento,
				   vc.id_voce_competenza AS id_voce_competenza,
				   e.id_evento AS id_evento,
				   rc.responsabile AS responsabile
			  FROM accentramento_scheda_evento aee
				   INNER JOIN accentramento_new a
					   ON a.id_accentramento = aee.id_accentramento
				   INNER JOIN accentramento_evento ae
					   ON ae.id_accentramento_evento = a.id_accentramento
				   INNER JOIN evento_observer eob
					   ON eob.id_evento = aee.id_evento
				   INNER JOIN competenza_observer cob
					   ON eob.observer_id = cob.observer_id
				   INNER JOIN quietanza_observer qob
					   ON cob.id_competenza = qob.observer_id
				   INNER JOIN quietanza q
					   ON qob.id_quietanza = q.id_quietanza
				   INNER JOIN competenza c
					   ON c.id_quietanza = q.id_quietanza
				   INNER JOIN voce_competenza vc
					   ON vc.id_competenza = c.id_competenza
				   INNER JOIN evento e
					   ON e.id_evento = aee.id_evento
				   INNER JOIN classe_evento ce
					   ON ce.id_classe_evento = e.id_evento
				   INNER JOIN organizzatore o
					   ON o.id_organizzatore = ce.id_organizzatore
				   INNER JOIN spazio s
					   ON s.id_spazio = ce.id_spazio
				   INNER JOIN locale l
					   ON l.id_locale = s.id_locale
				   INNER JOIN circoscrizione cil
					   ON cil.cod_seprag = l.cod_seprag
				   INNER JOIN strada stl
					   ON stl.id_strada = l.id_strada
				   INNER JOIN toponimo tpl
					   ON tpl.cod_toponimo = stl.cod_toponimo
				   INNER JOIN comune co
					   ON co.cod_comune = stl.cod_comune
				   INNER JOIN (SELECT DISTINCT m97e.id_evento
								 FROM modello97_evento m97e) acrt
					   ON acrt.id_evento = e.id_evento
				   LEFT JOIN (SELECT o.cognome || ' ' || o.nome AS responsabile,
									 oga.cod_seprag AS cod_seprag
								FROM     organizzatore_genere_attivita oga
									 INNER JOIN
										 organizzatore o
									 ON o.id_organizzatore = oga.id_organizzatore
							   WHERE     oga.cod_genere_attivita IN
											 ('070', '804', '812', '813')
									 AND (   (SYSDATE BETWEEN oga.inizio_validita
														  AND oga.fine_validita)
										  OR     (oga.fine_validita IS NULL)
											 AND SYSDATE >= oga.inizio_validita)) rc
					   ON rc.cod_seprag = l.cod_seprag AND ROWNUM <= 1
			 WHERE     a.stato = 'A'
				   AND q.stato = 'S'
				   AND ae.flag_398 = '1'
				   AND q.data BETWEEN TO_DATE({0}, {2}) AND TO_DATE({1}, {2})
			UNION ALL 
				SELECT 
				   q.id_quietanza,
				   NULL AS id_scheda_abbonamento,
				   TRIM (CAST (a.cod_seprag AS VARCHAR (7))) AS cod_seprag,
				   TRIM (CAST (l.cod_seprag AS VARCHAR (7))) AS seprag_loc,
				   cil.denominazione AS circoscrizione_locale,
				   TRIM (CAST (vc.cod_voce_incasso AS VARCHAR (4))) AS voce_incasso,
				   (vc.importo / 2) * -1 AS importo,
				   q.num_fattura AS num_fattura,
				   q.num_documento AS num_documento,
				   q.data AS data,
					s.CODICE_BA,
				   q.cod_seprag AS seprag_emittente,
				   l.denominazione AS denominazione_locale,
				   tpl.denominazione || ' ' || stl.denominazione || ' ' || l.numero_civico AS indirizzo_locale,
				   co.descrizione AS comune,
				   o.cognome AS organizzatore,
				   'SPORTELLO' AS pagamento,
				   '398' AS tipologia_accentramento,
				   vc.id_voce_competenza AS id_voce_competenza,
				   e.id_evento AS id_evento,
				   rc.responsabile AS responsabile
			  FROM accentramento_scheda_evento aee
				   INNER JOIN accentramento_new a
					   ON a.id_accentramento = aee.id_accentramento
				   INNER JOIN accentramento_evento ae
					   ON ae.id_accentramento_evento = a.id_accentramento
				   INNER JOIN evento_observer eob
					   ON eob.id_evento = aee.id_evento
				   INNER JOIN competenza_observer cob
					   ON eob.observer_id = cob.observer_id
				   INNER JOIN quietanza_observer qob
					   ON cob.id_competenza = qob.observer_id
				   INNER JOIN quietanza q
					   ON qob.id_quietanza = q.id_quietanza
				   INNER JOIN competenza c
					   ON c.id_quietanza = q.id_quietanza
				   INNER JOIN voce_competenza vc
					   ON vc.id_competenza = c.id_competenza
				   INNER JOIN evento e
					   ON e.id_evento = aee.id_evento
				   INNER JOIN classe_evento ce
					   ON ce.id_classe_evento = e.id_evento
				   INNER JOIN organizzatore o
					   ON o.id_organizzatore = ce.id_organizzatore
				   INNER JOIN spazio s
					   ON s.id_spazio = ce.id_spazio
				   INNER JOIN locale l
					   ON l.id_locale = s.id_locale
				   INNER JOIN circoscrizione cil
					   ON cil.cod_seprag = l.cod_seprag
				   INNER JOIN strada stl
					   ON stl.id_strada = l.id_strada
				   INNER JOIN toponimo tpl
					   ON tpl.cod_toponimo = stl.cod_toponimo
				   INNER JOIN comune co
					   ON co.cod_comune = stl.cod_comune
				   INNER JOIN (SELECT DISTINCT m97e.id_evento
								 FROM modello97_evento m97e) acrt
					   ON acrt.id_evento = e.id_evento
				   LEFT JOIN (SELECT o.cognome || ' ' || o.nome AS responsabile,
									 oga.cod_seprag AS cod_seprag
								FROM     organizzatore_genere_attivita oga
									 INNER JOIN
										 organizzatore o
									 ON o.id_organizzatore = oga.id_organizzatore
							   WHERE     oga.cod_genere_attivita IN
											 ('070', '804', '812', '813')
									 AND (   (SYSDATE BETWEEN oga.inizio_validita
														  AND oga.fine_validita)
										  OR     (oga.fine_validita IS NULL)
											 AND SYSDATE >= oga.inizio_validita)) rc
					   ON rc.cod_seprag = a.cod_seprag AND ROWNUM <= 1
				WHERE     a.stato = 'A'
				   AND q.stato = 'S'
				   AND ae.flag_398 = '1'
				   AND q.data BETWEEN TO_DATE({0}, {2}) AND TO_DATE({1}, {2})
			ORDER BY tipologia_accentramento, id_voce_competenza
";

-- OLD @7-Apr-2017
return @"
SELECT 
    ID_SCHEDA_ABBONAMENTO, 
    COD_SEPRAG, 
    SEPRAG_LOC, 
    CIRCOSCRIZIONE_LOCALE, 
    VOCE_INCASSO, 
    IMPORTO, 
    NUM_FATTURA, 
    NUM_DOCUMENTO, 
    DATA,
    CODICE_BA, 
    SEPRAG_EMITTENTE, 
    DENOMINAZIONE_LOCALE, 
    INDIRIZZO_LOCALE, 
    COMUNE, 
    ORGANIZZATORE,PAGAMENTO, 
    'MUSICA D''AMBIENTE' AS TIPOLOGIA_ACCENTRAMENTO, 
    ID_VOCE_COMPETENZA, 
    NULL AS ID_EVENTO, 
    NULL AS RESPONSABILE
FROM (     
        SELECT 
            SCHEDA.ID_SCHEDA_ABBONAMENTO AS ID_SCHEDA_ABBONAMENTO,
            trim( cast( SCHEDA.COD_SEPRAG as varchar(7))) AS COD_SEPRAG,
            trim( cast( LOC.COD_SEPRAG as varchar(7))) AS SEPRAG_LOC,
            CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
            trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
            VSA.IMPORTO                             AS IMPORTO,
            Q.NUM_FATTURA                           AS NUM_FATTURA      ,
            Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
            Q.DATA                                  AS DATA_QUIETANZA,
            SP.CODICE_BA,
            trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
            LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
            TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
            COM.DESCRIZIONE    AS COMUNE,
            ORG.COGNOME        AS ORGANIZZATORE,
            'MDA_ONLINE'                            AS PAGAMENTO,
            Q.DATA                                  AS DATA, 
            VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
            SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
        FROM       
            QUIETANZA Q,                                            
			COMPETENZA CMP,   
			VOCE_COMPETENZA VSA, 
			SCHEDA_ABBONAMENTO SCHEDA, 
			EVENTO E,       
			CLASSE_EVENTO CE, 
			ORGANIZZATORE ORG, 
			CIRCOSCRIZIONE CIRC, 
			SPAZIO SP, 
			LOCALE LOC, 
			STRADA STR, 
			TOPONIMO TOP,   
			COMUNE COM
		WHERE  
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					 AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA
					 AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA 
					 AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA   
					 AND VSA.COD_VOCE_INCASSO IN (1615,1616,2226,2229,2230,2231,2232,2259,2272,2273,2276,2278,2279,2271,2277,2281,2442,3155,3872,3875,3876,3880,3882,3883,3884,2215,2216)  
					 AND SCHEDA.ID_EVENTO =E.ID_EVENTO  
					 AND SCHEDA.COD_GENERE_EVENTO = '95' 
					 AND SCHEDA.STATO = 'P'  
					 AND SCHEDA.COD_SEPRAG <> LOC.COD_SEPRAG 
					 AND E.ID_EVENTO =CE.ID_CLASSE_EVENTO   
					 AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE   
					 AND CE.ID_SPAZIO = SP.ID_SPAZIO 
					 AND SP.ID_LOCALE = LOC.ID_LOCALE  
					 AND LOC.ID_STRADA =STR.ID_STRADA  
					 AND LOC.COD_SEPRAG  = CIRC.COD_SEPRAG   
					 AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'                 
					 AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
					 AND STR.COD_COMUNE =   COM.COD_COMUNE                     
					 AND NOT EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))
					 
			UNION
				SELECT 
					SCHEDA.ID_SCHEDA_ABBONAMENTO            AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                             AS IMPORTO,
					Q.NUM_FATTURA                           AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
					Q.DATA                                  AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE    AS COMUNE,
					ORG.COGNOME        AS ORGANIZZATORE,
					'SPORTELLO'                             AS PAGAMENTO,
					Q.DATA                                  AS DATA, 
					VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM
				WHERE  
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					 AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA
					 AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA 
					 AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA   
					 AND VSA.COD_VOCE_INCASSO IN (1615,1616,2226,2229,2230,2231,2232,2259,2272,2273,2276,2278,2279,2271,2277,2281,2442,3155,3872,3875,3876,3880,3882,3883,3884,2215,2216)  
					 AND SCHEDA.ID_EVENTO =E.ID_EVENTO  
					 AND SCHEDA.COD_GENERE_EVENTO = '95' 
					 AND SCHEDA.STATO = 'P'  
					 AND E.ID_EVENTO =CE.ID_CLASSE_EVENTO   
					 AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE   
					 AND CE.ID_SPAZIO = SP.ID_SPAZIO 
					 AND SP.ID_LOCALE = LOC.ID_LOCALE  
					 AND LOC.ID_STRADA =STR.ID_STRADA  
					 and q.id_metodo_pagamento = 14
					 AND LOC.COD_SEPRAG  = CIRC.COD_SEPRAG   
					 AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'                 
					 AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
					 AND STR.COD_COMUNE =   COM.COD_COMUNE                     
					 AND NOT EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))	 
					 
			 UNION  
				SELECT 
					SCHEDA.ID_SCHEDA_ABBONAMENTO                AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE 							AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                                 AS IMPORTO,
					Q.NUM_FATTURA                               AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                             AS NUM_DOCUMENTO   ,
					Q.DATA                                      AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE      AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE        AS COMUNE,
					ORG.COGNOME            AS ORGANIZZATORE,
					'MAV'                                       AS PAGAMENTO,
					Q.DATA                                      AS DATA, 
					VSA.ID_VOCE_COMPETENZA                      AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                        AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM   
				WHERE       
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA
					AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA 
					AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA   
					AND VSA.COD_VOCE_INCASSO IN (1615,1616,2226,2229,2230,2231,2232,2259,2272,2273,2276,2278,2279,2271,2277,2281,2442,3155,3872,3875,3876,3880,3882,3883,3884,2215,2216)  
					AND SCHEDA.ID_EVENTO =E.ID_EVENTO  
					AND SCHEDA.COD_GENERE_EVENTO = '95' 
					AND SCHEDA.STATO = 'P'  
					AND E.ID_EVENTO =CE.ID_CLASSE_EVENTO   
					AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE   
					AND CE.ID_SPAZIO = SP.ID_SPAZIO 
					AND SP.ID_LOCALE = LOC.ID_LOCALE  
					AND LOC.ID_STRADA =STR.ID_STRADA  
					AND LOC.COD_SEPRAG  = CIRC.COD_SEPRAG   --
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'       --          
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO     -- 
					AND STR.COD_COMUNE =   COM.COD_COMUNE      
					AND EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))  
			UNION
				SELECT  
					SCHEDA.ID_SCHEDA_ABBONAMENTO            AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                             AS IMPORTO,
					Q.NUM_FATTURA                           AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
					Q.DATA                                  AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE    AS COMUNE,
					ORG.COGNOME        AS ORGANIZZATORE,
					'SPORTELLO SCF'                             AS PAGAMENTO,
					Q.DATA                                  AS DATA, 
					VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM  
				WHERE    
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
						AND LOC.COD_SEPRAG <> SCHEDA.COD_SEPRAG      
						AND SP.ID_LOCALE = LOC.ID_LOCALE      
						AND CE.ID_CLASSE_EVENTO = E.ID_EVENTO      
						AND CE.ID_SPAZIO = SP.ID_SPAZIO      
						AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA      
						AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA       
						AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE      
						AND CIRC.COD_SEPRAG = LOC.COD_SEPRAG      
						AND SCHEDA.STATO = 'P'       
						AND STR.ID_STRADA = LOC.ID_STRADA      
						AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
						AND STR.COD_COMUNE = COM.COD_COMUNE         
						AND E.ID_EVENTO = SCHEDA.ID_EVENTO         
						AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA     
						AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M' 
						AND SCHEDA.COD_GENERE_EVENTO = 'DC' 
						AND NOT EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E')) 
						AND SUBSTR(VSA.COD_VOCE_INCASSO, 0, 2) = '07'
			UNION
				SELECT  
					SCHEDA.ID_SCHEDA_ABBONAMENTO            AS ID_SCHEDA_ABBONAMENTO,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VSA.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VSA.IMPORTO                             AS IMPORTO,
					Q.NUM_FATTURA                           AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                         AS NUM_DOCUMENTO   ,
					Q.DATA                                  AS DATA_QUIETANZA,
					SP.CODICE_BA,
					trim( cast( SCHEDA.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE  AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE    AS COMUNE,
					ORG.COGNOME        AS ORGANIZZATORE,
					'MAV SCF'                               AS PAGAMENTO,
					Q.DATA                                  AS DATA, 
					VSA.ID_VOCE_COMPETENZA                  AS ID_VOCE_COMPETENZA, 
					SCHEDA.DATA_MODIFICA                    AS DATA_ULTIMA_MODIFICA 
				FROM       
					QUIETANZA Q,                                            
					COMPETENZA CMP,   
					VOCE_COMPETENZA VSA, 
					SCHEDA_ABBONAMENTO SCHEDA, 
					EVENTO E,       
					CLASSE_EVENTO CE, 
					ORGANIZZATORE ORG, 
					CIRCOSCRIZIONE CIRC, 
					SPAZIO SP, 
					LOCALE LOC, 
					STRADA STR, 
					TOPONIMO TOP,   
					COMUNE COM  
				WHERE    
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND SP.ID_LOCALE = LOC.ID_LOCALE      
					AND CE.ID_CLASSE_EVENTO = E.ID_EVENTO      
					AND CE.ID_SPAZIO = SP.ID_SPAZIO      
					AND CMP.ID_COMPETENZA = SCHEDA.ID_COMPETENZA      
					AND Q.ID_QUIETANZA = CMP.ID_QUIETANZA       
					AND CE.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE      
					AND CIRC.COD_SEPRAG = LOC.COD_SEPRAG      
					AND SCHEDA.STATO = 'P'       
					AND STR.ID_STRADA = LOC.ID_STRADA      
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO      
					AND STR.COD_COMUNE = COM.COD_COMUNE       
					AND E.ID_EVENTO = SCHEDA.ID_EVENTO         
					AND CMP.ID_COMPETENZA=VSA.ID_COMPETENZA       
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'  
					AND SCHEDA.COD_GENERE_EVENTO = 'DC' 
					AND EXISTS (SELECT 1 FROM FATTURA_SAP WHERE SCHEDA.ID_RICHIESTA_MAV = FATTURA_SAP.ID_RICHIESTA_MAV AND FATTURA_SAP.STATO IN ('S','E'))  
					AND SUBSTR(VSA.COD_VOCE_INCASSO, 0, 2) = '07'
			UNION
				SELECT     
					NULL                                        AS ID_SCHEDA_ABBONAMENTO,
					NULL                                        AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE     AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VQ.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VQ.IMPORTO                                  AS IMPORTO,
					Q.NUM_FATTURA                               AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                             AS NUM_DOCUMENTO   ,
					Q.DATA                                      AS DATA_QUIETANZA,
					SP.CODICE_BA,
					NULL                                        AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE      AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE        AS COMUNE,
					ORG.COGNOME            AS ORGANIZZATORE,
					'PORTUP'                                    AS PAGAMENTO,
					Q.DATA                                      AS DATA,
					VQ.ID_VOCE_QUIETANZA                        AS ID_VOCE_COMPETENZA,                                                                            
					Q.DATA_MODIFICA                             AS DATA_ULTIMA_MODIFICA     
				FROM   
					QUIETANZA Q,
					VOCE_QUIETANZA VQ,
					CIRCOSCRIZIONE CIRC, 
					ORGANIZZATORE ORG, 
					SPAZIO SP,
					LOCALE LOC,
					STRADA STR,
					TOPONIMO TOP,
					COMUNE COM
				WHERE   
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND Q.ORIGINE = 'PUP'
					AND Q.STATO = 'S'
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M' 
					AND Q.ID_QUIETANZA = VQ.ID_QUIETANZA
					AND CIRC.COD_SEPRAG = Q.COD_SEPRAG
					AND SP.ID_SPAZIO = Q.ID_SPAZIO
					AND SP.ID_LOCALE = LOC.ID_LOCALE
					AND STR.ID_STRADA = LOC.ID_STRADA
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO
					AND STR.COD_COMUNE = COM.COD_COMUNE
					AND Q.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE 
			UNION
				SELECT    
					NULL                                        AS ID_SCHEDA_ABBONAMENTO,
					NULL                                        AS COD_SEPRAG      ,
					trim( cast( LOC.COD_SEPRAG as varchar(7) ) ) AS SEPRAG_LOC      ,
					CIRC.DENOMINAZIONE     AS CIRCOSCRIZIONE_LOCALE,
					trim( cast( VQ.COD_VOCE_INCASSO as varchar(4) ) ) AS VOCE_INCASSO ,
					VQ.IMPORTO                                  AS IMPORTO,
					Q.NUM_FATTURA                               AS NUM_FATTURA      ,
					Q.NUM_DOCUMENTO                             AS NUM_DOCUMENTO   ,
					Q.DATA                                      AS DATA_QUIETANZA,
					SP.CODICE_BA,
					NULL                                        AS SEPRAG_EMITTENTE ,
					LOC.DENOMINAZIONE      AS DENOMINAZIONE_LOCALE,
					TOP.DENOMINAZIONE||' '||STR.DENOMINAZIONE||' '||LOC.NUMERO_CIVICO AS INDIRIZZO_LOCALE,
					COM.DESCRIZIONE        AS COMUNE,
					ORG.COGNOME            AS ORGANIZZATORE,
					'PRIVATI'                                   AS PAGAMENTO,
					Q.DATA                                      AS DATA,        
					VQ.ID_VOCE_QUIETANZA                        AS ID_VOCE_COMPETENZA,                                                          
					Q.DATA_MODIFICA                             AS DATA_ULTIMA_MODIFICA     
				FROM   
					QUIETANZA Q,
					VOCE_QUIETANZA VQ,
					CIRCOSCRIZIONE CIRC, 
					ORGANIZZATORE ORG, 
					SPAZIO SP,
					LOCALE LOC,
					STRADA STR,
					TOPONIMO TOP,
					COMUNE COM
				WHERE       
					 Q.DATA >= TO_DATE({0}, {2}) and Q.DATA < TO_DATE({1}, {2})     
					AND Q.ORIGINE = 'PTP'
					AND Q.STATO = 'S' 
					AND CIRC.COD_TIPO_CIRCOSCRIZIONE = 'M'
					AND Q.ID_QUIETANZA = VQ.ID_QUIETANZA
					AND CIRC.COD_SEPRAG = LOC.COD_SEPRAG
					AND SP.ID_SPAZIO = Q.ID_SPAZIO
					AND SP.ID_LOCALE = LOC.ID_LOCALE
					AND STR.ID_STRADA = LOC.ID_STRADA
					AND STR.COD_TOPONIMO = TOP.COD_TOPONIMO
					AND STR.COD_COMUNE = COM.COD_COMUNE 
					AND Q.ID_ORGANIZZATORE = ORG.ID_ORGANIZZATORE
			) 
			
			UNION
				SELECT NULL AS id_scheda_abbonamento,
				   TRIM (CAST (a.cod_seprag AS VARCHAR (7))) AS cod_seprag,
				   TRIM (CAST (l.cod_seprag AS VARCHAR (7))) AS seprag_loc,
				   cil.denominazione AS circoscrizione_locale,
				   TRIM (CAST (vc.cod_voce_incasso AS VARCHAR (4))) AS voce_incasso,
				   vc.importo AS importo,
				   q.num_fattura AS num_fattura,
				   q.num_documento AS num_documento,
				   q.data AS data,
					s.CODICE_BA,
				   q.cod_seprag AS seprag_emittente,
				   l.denominazione AS denominazione_locale,
				   tpl.denominazione || ' ' || stl.denominazione || ' ' || l.numero_civico AS indirizzo_locale,
				   co.descrizione AS comune,
				   o.cognome AS organizzatore,
				   'SPORTELLO' AS pagamento,
				   'EVENTO' AS tipologia_accentramento,
				   vc.id_voce_competenza AS id_voce_competenza,
				   e.id_evento AS id_evento,
				   rc.responsabile AS responsabile
				FROM accentramento_scheda_evento aee
				   INNER JOIN accentramento_new a
					   ON a.id_accentramento = aee.id_accentramento
				   INNER JOIN accentramento_evento ae
					   ON ae.id_accentramento_evento = a.id_accentramento
				   INNER JOIN evento_observer eob
					   ON eob.id_evento = aee.id_evento
				   INNER JOIN competenza_observer cob
					   ON eob.observer_id = cob.observer_id
				   INNER JOIN quietanza_observer qob
					   ON cob.id_competenza = qob.observer_id
				   INNER JOIN quietanza q
					   ON qob.id_quietanza = q.id_quietanza
				   INNER JOIN competenza c
					   ON c.id_quietanza = q.id_quietanza
				   INNER JOIN voce_competenza vc
					   ON vc.id_competenza = c.id_competenza
				   INNER JOIN evento e
					   ON e.id_evento = aee.id_evento
				   INNER JOIN classe_evento ce
					   ON ce.id_classe_evento = e.id_evento
				   INNER JOIN organizzatore o
					   ON o.id_organizzatore = ce.id_organizzatore
				   INNER JOIN spazio s
					   ON s.id_spazio = ce.id_spazio
				   INNER JOIN locale l
					   ON l.id_locale = s.id_locale
				   INNER JOIN circoscrizione cil
					   ON cil.cod_seprag = l.cod_seprag
				   INNER JOIN strada stl
					   ON stl.id_strada = l.id_strada
				   INNER JOIN toponimo tpl
					   ON tpl.cod_toponimo = stl.cod_toponimo
				   INNER JOIN comune co
					   ON co.cod_comune = stl.cod_comune
				   LEFT JOIN (SELECT o.cognome || ' ' || o.nome AS responsabile,
									 oga.cod_seprag AS cod_seprag
								FROM     organizzatore_genere_attivita oga
									 INNER JOIN
										 organizzatore o
									 ON o.id_organizzatore = oga.id_organizzatore
							   WHERE     oga.cod_genere_attivita IN
											 ('070', '804', '812', '813')
									 AND (   (SYSDATE BETWEEN oga.inizio_validita
														  AND oga.fine_validita)
										  OR     (oga.fine_validita IS NULL)
											 AND SYSDATE >= oga.inizio_validita)) rc
					   ON rc.cod_seprag = l.cod_seprag AND ROWNUM <= 1         
				WHERE  a.stato = 'A'
				   AND q.stato = 'S'
				   AND ae.flag_398 = '0'
				   AND q.data BETWEEN TO_DATE({0}, {2}) AND TO_DATE({1}, {2})
			UNION 
				SELECT NULL AS id_scheda_abbonamento,
				   TRIM (CAST (a.cod_seprag AS VARCHAR (7))) AS cod_seprag,
				   TRIM (CAST (l.cod_seprag AS VARCHAR (7))) AS seprag_loc,
				   cil.denominazione AS circoscrizione_locale,
				   TRIM (CAST (vc.cod_voce_incasso AS VARCHAR (4))) AS voce_incasso,
				   vc.importo / 2 AS importo,
				   q.num_fattura AS num_fattura,
				   q.num_documento AS num_documento,
				   q.data AS data,
					s.CODICE_BA,
				   q.cod_seprag AS seprag_emittente,
				   l.denominazione AS denominazione_locale,
				   tpl.denominazione || ' ' || stl.denominazione || ' ' || l.numero_civico AS indirizzo_locale,
				   co.descrizione AS comune,
				   o.cognome AS organizzatore,
				   'SPORTELLO' AS pagamento,
				   '398' AS tipologia_accentramento,
				   vc.id_voce_competenza AS id_voce_competenza,
				   e.id_evento AS id_evento,
				   rc.responsabile AS responsabile
			  FROM accentramento_scheda_evento aee
				   INNER JOIN accentramento_new a
					   ON a.id_accentramento = aee.id_accentramento
				   INNER JOIN accentramento_evento ae
					   ON ae.id_accentramento_evento = a.id_accentramento
				   INNER JOIN evento_observer eob
					   ON eob.id_evento = aee.id_evento
				   INNER JOIN competenza_observer cob
					   ON eob.observer_id = cob.observer_id
				   INNER JOIN quietanza_observer qob
					   ON cob.id_competenza = qob.observer_id
				   INNER JOIN quietanza q
					   ON qob.id_quietanza = q.id_quietanza
				   INNER JOIN competenza c
					   ON c.id_quietanza = q.id_quietanza
				   INNER JOIN voce_competenza vc
					   ON vc.id_competenza = c.id_competenza
				   INNER JOIN evento e
					   ON e.id_evento = aee.id_evento
				   INNER JOIN classe_evento ce
					   ON ce.id_classe_evento = e.id_evento
				   INNER JOIN organizzatore o
					   ON o.id_organizzatore = ce.id_organizzatore
				   INNER JOIN spazio s
					   ON s.id_spazio = ce.id_spazio
				   INNER JOIN locale l
					   ON l.id_locale = s.id_locale
				   INNER JOIN circoscrizione cil
					   ON cil.cod_seprag = l.cod_seprag
				   INNER JOIN strada stl
					   ON stl.id_strada = l.id_strada
				   INNER JOIN toponimo tpl
					   ON tpl.cod_toponimo = stl.cod_toponimo
				   INNER JOIN comune co
					   ON co.cod_comune = stl.cod_comune
				   INNER JOIN (SELECT DISTINCT m97e.id_evento
								 FROM modello97_evento m97e) acrt
					   ON acrt.id_evento = e.id_evento
				   LEFT JOIN (SELECT o.cognome || ' ' || o.nome AS responsabile,
									 oga.cod_seprag AS cod_seprag
								FROM     organizzatore_genere_attivita oga
									 INNER JOIN
										 organizzatore o
									 ON o.id_organizzatore = oga.id_organizzatore
							   WHERE     oga.cod_genere_attivita IN
											 ('070', '804', '812', '813')
									 AND (   (SYSDATE BETWEEN oga.inizio_validita
														  AND oga.fine_validita)
										  OR     (oga.fine_validita IS NULL)
											 AND SYSDATE >= oga.inizio_validita)) rc
					   ON rc.cod_seprag = l.cod_seprag AND ROWNUM <= 1
			 WHERE     a.stato = 'A'
				   AND q.stato = 'S'
				   AND ae.flag_398 = '1'
				   AND q.data BETWEEN TO_DATE({0}, {2}) AND TO_DATE({1}, {2})
			UNION ALL 
				SELECT NULL AS id_scheda_abbonamento,
				   TRIM (CAST (a.cod_seprag AS VARCHAR (7))) AS cod_seprag,
				   TRIM (CAST (l.cod_seprag AS VARCHAR (7))) AS seprag_loc,
				   cil.denominazione AS circoscrizione_locale,
				   TRIM (CAST (vc.cod_voce_incasso AS VARCHAR (4))) AS voce_incasso,
				   (vc.importo / 2) * -1 AS importo,
				   q.num_fattura AS num_fattura,
				   q.num_documento AS num_documento,
				   q.data AS data,
					s.CODICE_BA,
				   q.cod_seprag AS seprag_emittente,
				   l.denominazione AS denominazione_locale,
				   tpl.denominazione || ' ' || stl.denominazione || ' ' || l.numero_civico AS indirizzo_locale,
				   co.descrizione AS comune,
				   o.cognome AS organizzatore,
				   'SPORTELLO' AS pagamento,
				   '398' AS tipologia_accentramento,
				   vc.id_voce_competenza AS id_voce_competenza,
				   e.id_evento AS id_evento,
				   rc.responsabile AS responsabile
			  FROM accentramento_scheda_evento aee
				   INNER JOIN accentramento_new a
					   ON a.id_accentramento = aee.id_accentramento
				   INNER JOIN accentramento_evento ae
					   ON ae.id_accentramento_evento = a.id_accentramento
				   INNER JOIN evento_observer eob
					   ON eob.id_evento = aee.id_evento
				   INNER JOIN competenza_observer cob
					   ON eob.observer_id = cob.observer_id
				   INNER JOIN quietanza_observer qob
					   ON cob.id_competenza = qob.observer_id
				   INNER JOIN quietanza q
					   ON qob.id_quietanza = q.id_quietanza
				   INNER JOIN competenza c
					   ON c.id_quietanza = q.id_quietanza
				   INNER JOIN voce_competenza vc
					   ON vc.id_competenza = c.id_competenza
				   INNER JOIN evento e
					   ON e.id_evento = aee.id_evento
				   INNER JOIN classe_evento ce
					   ON ce.id_classe_evento = e.id_evento
				   INNER JOIN organizzatore o
					   ON o.id_organizzatore = ce.id_organizzatore
				   INNER JOIN spazio s
					   ON s.id_spazio = ce.id_spazio
				   INNER JOIN locale l
					   ON l.id_locale = s.id_locale
				   INNER JOIN circoscrizione cil
					   ON cil.cod_seprag = l.cod_seprag
				   INNER JOIN strada stl
					   ON stl.id_strada = l.id_strada
				   INNER JOIN toponimo tpl
					   ON tpl.cod_toponimo = stl.cod_toponimo
				   INNER JOIN comune co
					   ON co.cod_comune = stl.cod_comune
				   INNER JOIN (SELECT DISTINCT m97e.id_evento
								 FROM modello97_evento m97e) acrt
					   ON acrt.id_evento = e.id_evento
				   LEFT JOIN (SELECT o.cognome || ' ' || o.nome AS responsabile,
									 oga.cod_seprag AS cod_seprag
								FROM     organizzatore_genere_attivita oga
									 INNER JOIN
										 organizzatore o
									 ON o.id_organizzatore = oga.id_organizzatore
							   WHERE     oga.cod_genere_attivita IN
											 ('070', '804', '812', '813')
									 AND (   (SYSDATE BETWEEN oga.inizio_validita
														  AND oga.fine_validita)
										  OR     (oga.fine_validita IS NULL)
											 AND SYSDATE >= oga.inizio_validita)) rc
					   ON rc.cod_seprag = a.cod_seprag AND ROWNUM <= 1
				WHERE     a.stato = 'A'
				   AND q.stato = 'S'
				   AND ae.flag_398 = '1'
				   AND q.data BETWEEN TO_DATE({0}, {2}) AND TO_DATE({1}, {2})
			ORDER BY tipologia_accentramento, id_voce_competenza
";