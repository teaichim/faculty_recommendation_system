truncate table c_persoana;

insert into c_persoana (cod_candidat,sex,specializare,profil,filiera,siiir,an,sesiune)
select cod_candidat,sex,specializare,profil,filiera,siiir,an,sesiune from source_persoana

;