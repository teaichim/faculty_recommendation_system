truncate table c_facultate;

insert into c_facultate (id_facultate,universitate,facultate,specializare,medie_intrare,localitate,judet,materii_bac)
select id_facultate,universitate,facultate,specializare,medie_intrare,localitate,judet,materii_bac from source_facultate
;