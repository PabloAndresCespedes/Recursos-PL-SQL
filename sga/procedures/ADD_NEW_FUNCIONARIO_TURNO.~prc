create or replace procedure ADD_NEW_FUNCIONARIO_TURNO(p_id number, p_func_ids varchar2, p_user varchar2) is
lv_f_inicio_orig funcionarios_empresa.fecha_inicio%type;
lv_f_fin_orig    funcionarios_empresa.fecha_fin%type;
lv_func_ids_orig funcionarios_empresa.funcionario_ids%type;
lv_cat_func_cat  categorias_empresa.cant_funcionarios%type;
lv_co             number := 0;
lv_ct             number := 0;
begin
  -- captura datos de origen
  begin
    select fe.fecha_inicio,
           fe.fecha_fin,
           fe.funcionario_ids,
           (ce.cant_funcionarios * ce.rondas)
    into lv_f_inicio_orig,
         lv_f_fin_orig,
         lv_func_ids_orig,
         lv_cat_func_cat
    from funcionarios_empresa fe
    inner join dept d on (d.deptno = fe.depno)
    inner join categorias_empresa ce on (ce.id = d.categoria_emp_id)
    where fe.id = p_id;
  exception
    when no_Data_found then
      raise_application_Error(-20000, 'No se encuentra el turno');
  end;
  
  -- comprueba si no existe en el listado
  for i in (select column_value func_id_orig from table(apex_string.split_numbers(p_str => lv_func_ids_orig, p_sep => ':'))) loop
    for j in (select column_value func_id_new from table(apex_string.split_numbers(p_str => p_func_ids, p_sep => ':'))) loop
      if i.func_id_orig = j.func_id_new then
        raise_application_error(-20000, 'Ya existe el funcionario en el listado');
      end if;
      lv_co := lv_co + 1;
    end loop;
    lv_ct := lv_ct + 1;
  end loop;
  
  -- comprueba cantidad por categoria
  if (lv_co + lv_ct) > lv_cat_func_cat then
    raise_application_error(-20000, 'La categoria de la empresa solo admite '|| lv_cat_func_cat||' funcionarios');
  end if;
  
  -- comprueba si no esta asignado en algun horario
  if funcionario_valid_add_calendar(p_f_inicio => (lv_f_inicio_orig+1/1440),
                                    p_f_fin    => (lv_f_fin_orig-1/1440),
                                    p_func_ids => p_func_ids) 
  then
    raise_application_Error(-20000, 'Funcionario ya se encuentra asignado en este horario');
  end if;
  
  -- actualiza el registro
  update funcionarios_empresa fe
  set    fe.funcionario_ids = lv_func_ids_orig || ':' || p_func_ids,
         fe.user_web        = p_user,
         fe.fecha_registro  = sysdate
  where  fe.id = p_id;
  
end ADD_NEW_FUNCIONARIO_TURNO;
/
