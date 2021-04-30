create or replace function get_dia_letra(p_numero number)
return varchar2 is
lv_r varchar2(255);
begin
  select descripcion into lv_r
  from numeros n
  where n.id = p_numero;
  
  return lv_r;
exception
  when others then
    return null;
end get_dia_letra;
/
