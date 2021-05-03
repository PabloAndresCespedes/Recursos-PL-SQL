create or replace function GET_NAME_FUNCIONARIO(p_id number)
return varchar2 is
  lv_r varchar2(4000);
/*
  Author  : @PabloACespedes
  Created : 30-Apr-21 9:20:40 AM
  captura nombre del funcionario
*/  
begin
  select initcap(f.apellido_f|| ', ' || f.nombre_f) x
  into lv_r
  from funcionario f
  where f.id_funcionario = p_id;
  
  return lv_r;
  
exception
  when no_data_found then
    return '';
end GET_NAME_FUNCIONARIO;
/
