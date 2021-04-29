create or replace function funcionario_valid_add_calendar(p_f_inicio date,
                                                           p_f_fin date, 
                                                           p_func_ids varchar2)return boolean is 
  lv_func_turnos_usados varchar2(32767);                                                        
begin
  begin
    select listagg(fe.funcionario_ids, ':') within group (order by 2) x
    into lv_func_turnos_usados
    from funcionarios_empresa fe
    where ( (p_f_inicio between fe.fecha_inicio and fe.fecha_fin) or (p_f_fin between fe.fecha_inicio and fe.fecha_fin) )
    ;
  exception
    when no_Data_found then
        lv_func_turnos_usados := -1;
  end;
  
  for i in (select column_value func_id 
            from table(apex_string.split_numbers(p_str => p_func_ids, p_sep => ':'))) 
  loop
     -- comprobar que el usuario no exista asignado en el rango de horas
     for j in (select column_value func_id_usado 
               from table(apex_string.split_numbers(p_str => lv_func_turnos_usados, p_sep => ':')))
     loop
        if i.func_id = j.func_id_usado then
          return true;
        end if;
     end loop;
      
  end loop; 
  
  return false;
  
end funcionario_valid_add_calendar;
/
