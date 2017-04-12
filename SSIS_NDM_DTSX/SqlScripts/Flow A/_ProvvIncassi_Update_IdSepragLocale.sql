USE SchedarioTerritorio
UPDATE ProvvIncassi SET IdSepragLocale = n.IdSeprag
FROM(
select TOP 100 PERCENT i.id, 
	i.SepragLocale, 
	sep.ID as IdSeprag , 
	sep.Denominazione
FROm ProvvIncassi i
LEFT JOIN UnitaTerritorialiSeprag sep On sep.CodiceSede + sep.CodiceProvincia + sep.CodiceAgenzia = i.SepragLocale
ORDER BY sep.ID
) n 
WHERE n.sepragLocale = ProvvIncassi.SepragLocale
