create or replace function GET_DATA_FUNCIONARIO(p_ids   varchar2 -- ids funcionarios separador por dos puntos Ej. "1:2:5"
                                               ) 
return varchar2 is
  lv_r varchar2(4000);
/*
  Author  : @PabloACespedes
  Created : 09-May-21 10:47:59 AM
  captura nombre del funcionario
*/ 
begin
  select listagg(initcap( f.nombre_f) || ' ' || initcap(f.apellido_f) ||', con CI Nro: '||trim(to_char(f.cedula_f, '999G999G999G999G999G999G990')), ', ') within group (order by 1) x
  into lv_r
  from funcionario f
  where f.id_funcionario in(
    select column_value 
    from table( apex_string.split_numbers(p_str => p_ids, p_sep => ':') )
  );
  
  return trim(lv_r);
  
exception
  when no_data_found then
    return '';
end GET_DATA_FUNCIONARIO;
/
