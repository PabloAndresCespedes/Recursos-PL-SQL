create or replace procedure add_turno_calendario(p_func_id  varchar2,
                                                 p_depno    number,
                                                 p_f_inicio varchar2,
                                                 p_turno_id number,
                                                 p_user     varchar2
                                                 ) is
  lv_cat_id            number;
  lv_cant_func_cat_emp number;
  
  lv_hora_ini_turno varchar2(100);
  lv_total_hs_turno number;
           
  lv_fecha_inicio date;
  lv_fecha_fin    date;

  v_cf number := 0;
    
  dummy number;                       
begin
  
  -- datos de la categoria de la empresa
  begin
    select ce.id,
           ce.cant_funcionarios * ce.rondas
    into lv_cat_id,
         lv_cant_func_cat_emp
    from dept e
    inner join categorias_empresa ce on (ce.id = e.categoria_emp_id)
    where e.deptno = p_depno
    and   rownum = 1;
  exception
    when no_data_found then
      raise_application_Error(-20000, 'No se encuentra la categoria de la empresa');
  end;
  
  -- cuenta cuantos se insertaran por turno
  select count(column_value) 
  into  v_cf 
  from table(apex_string.split_numbers(p_str => p_func_id, p_sep => ':'));
  
  if v_cf > lv_cant_func_cat_emp then
    raise_application_Error(-20000, 'Es necesario insertar solo '||lv_cant_func_cat_emp||' funcionario/s para este turno');
  end if;
  
  -- datos del turno
  begin
    select t.hora_inicio, -- hh24:mi
           t.total_hs     -- number
    into lv_hora_ini_turno,
         lv_total_hs_turno
    from turnos t 
    where t.id = p_turno_id;
  exception
    when no_data_found then
      raise_application_Error(-20000, 'No se encuentra el turno');
  end;
  
  -- asigna las fechas
  lv_fecha_inicio := to_date(p_f_inicio ||' '||lv_hora_ini_turno, 'dd/mm/yyyy hh24:mi:ss');
  lv_fecha_fin    := lv_fecha_inicio + lv_total_hs_turno /24;
  
  -- horario utilizado?
  begin
    select distinct 1
    into dummy
    from funcionarios_empresa fe
    where ( ((lv_fecha_inicio+1/1440) between fe.fecha_inicio and fe.fecha_fin) or ((lv_fecha_fin-1/1440) between fe.fecha_inicio and fe.fecha_fin) )
    and   fe.depno = p_depno
    ;
    
    raise_application_Error(-20000, 'Horario utilizado');
    
  exception
    when no_Data_found then
       null; -- no
  end;

  -- funcionarios con turnos en estos horarios?
  if funcionario_valid_add_calendar(p_f_inicio => lv_fecha_inicio,
                                    p_f_fin    => lv_fecha_fin,
                                    p_func_ids => p_func_id)
  then
    raise_application_Error(-20000, 'Funcionario ya se encuentra asignado en este rango de horario. Tal vez en otra empresa');
  end if; 
   
  insert into funcionarios_empresa(funcionario_ids,
                                   depno,
                                   fecha_inicio,
                                   fecha_fin,
                                   user_web,
                                   categoria_id,
                                   turno_id,
                                   fecha_registro
                                   )
                            values(p_func_id,
                                   p_depno,
                                   lv_fecha_inicio,
                                   lv_fecha_fin,
                                   p_user,
                                   lv_cat_id,
                                   p_turno_id,
                                   sysdate                        
                                  );                            
end add_turno_calendario;
/
