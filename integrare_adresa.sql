truncate table c_adresa;

insert into c_adresa (id,judet,localitate,siiir,UNITATE_INVATAMANT)
select id,judet,localitate,siiir,UNITATE_INVATAMANT from source_adresa
;