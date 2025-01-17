truncate table c_rezultate_bac;

insert into c_rezultate_bac (cod_candidat,subiect_ea,subiect_eb,subiect_ec,subiect_ed,nota_subiect_ea,nota_subiect_eb,nota_subiect_ec,nota_subiect_ed,status,materii_bac,medie,an,sesiune)
select cod_candidat,subiect_ea,subiect_eb,subiect_ec,subiect_ed,nota_subiect_ea,nota_subiect_eb,nota_subiect_ec,nota_subiect_ed,status,materii_bac,medie,an,sesiune 
from source_rezultate_bac
where status='Promovat'

;