create or replace function GET_DATA_FUNCIONARIO(p_id number,
                                                p_data varchar2
                                               ) 
return varchar2 is
  lv_r varchar2(4000);
/*
  Author  : @PabloACespedes
  Created : 30-Apr-21 9:20:40 AM
  captura nombre del funcionario
  
  p_data: NAME, CI
*/  
begin
  select case 
          when p_data = 'NAME' then 
            initcap( f.nombre_f || ' ' || f.apellido_f) 
          when p_data = 'CI' then 
            to_char(f.cedula_f, '999G999G999G999G999G999G990')
         else ''
         end x
  into lv_r
  from funcionario f
  where f.id_funcionario = p_id;
  
  return trim(lv_r);
  
exception
  when no_data_found then
    return '';
end GET_DATA_FUNCIONARIO;
/