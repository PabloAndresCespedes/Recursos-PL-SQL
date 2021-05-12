create or replace procedure JOB_UPD_ASISTENCIA_SALIDA is
/*
  Author  : @PabloACespedes
  Created : 11-May-21 8:56:52 PM
  Actualiza las salidas que no fueron marcadas 24hs antes; con el horario que debio salir
*/
begin
  update asistencia x
  set    x.hora_fin = to_char(x.func_hora_fin, 'hh24:mi'),
         x.tipo = 'S'
  where x.id in (
    select a.id
    from asistencia a
    where a.hora_fin is null
    and a.fecha_creado < sysdate - 1
  );
  
  commit; 
   
end JOB_UPD_ASISTENCIA_SALIDA;
/
