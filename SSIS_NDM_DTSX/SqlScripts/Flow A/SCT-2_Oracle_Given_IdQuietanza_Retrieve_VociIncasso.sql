-- Download All Dettagli from Oracle (given ID_QUIETANZA)
return @"
select
	trim( cast( voceQuietanza.COD_VOCE_INCASSO as varchar(4) ) ) as codiceVoceIncasso,
	voceQuietanza.IMPORTO as importoVoceIncasso,
	trim( cast( voceQuietanza.COD_GENERE_EVENTO as varchar(2) ) ) AS codGenereEventoVoceIncasso,
	trim( cast( voceIncasso.FLAG_ENTR_USC as varchar(1) ) ) AS flagEntrUsc
from
	VOCE_QUIETANZA voceQuietanza left join VOCE_INCASSO voceIncasso ON voceQuietanza.cod_voce_incasso = voceIncasso.cod_voce_incasso
where
	voceQuietanza.ID_QUIETANZA={0} and
	voceIncasso.FLAG_NCA = '1'
order by
	voceQuietanza.COD_VOCE_INCASSO;	
";