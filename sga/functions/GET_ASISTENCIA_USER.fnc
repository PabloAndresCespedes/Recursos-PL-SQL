create or replace function GET_ASISTENCIA_USER(p_user varchar2)
return asistencia.id%type
is
  /*
  @PabloACespedes 26-04-2021 
  obj: retornar la ultima asistencia del funcionario en caso que no lo tenga, creará un registro
       si lo tiene, actualiza la hora fin y su tipo
 */
  lv_id asistencia.id%type;
begin
  select max(a.id) into lv_id
  from asistencia a
  inner join funcionario f on (f.id_funcionario = a.id_funcionario)
  where trim(upper(f.usuario)) = trim(upper(p_user))
  and (a.hora_inicio is null or (a.hora_inicio is not null and a.hora_fin is null and a.tipo = 'E'));
  
  return lv_id;
exception
  when no_data_found then
    null;
end GET_ASISTENCIA_USER;
/
