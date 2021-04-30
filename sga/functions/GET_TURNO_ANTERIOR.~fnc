create or replace function GET_FUNC_TURNO_ANTERIOR(p_fecha_inicio varchar2, 
                                                   p_depno number
                                                   )
return varchar2 is
  lv_func_ids varchar2(4000);
  lv_c        date;
  lv_fecha_inicio date := to_date(p_fecha_inicio, 'dd/mm/yyyy hh24:mi:ss');
  lv_fecha_ini_menos date := lv_fecha_inicio-1;
/*
  Author  : @PabloACespedes
  Created : 30-Apr-21 9:38:35 AM
  Revisa el ante ultimo turno del relevo de contra turno
  con un rango de 1 dia menos al actual
*/  
begin
  select max(fe.fecha_inicio) x,
         fe.funcionario_ids
  into   lv_c,
         lv_func_ids
  from funcionarios_empresa fe
  where (fe.fecha_inicio between lv_fecha_ini_menos and lv_fecha_inicio )
  and  fe.depno = p_depno
  and  fe.fecha_inicio <> lv_fecha_inicio
  and rownum = 1
  group by fe.funcionario_ids;
  
  return lv_func_ids;
  
exception
  when no_Data_found then
    return '-1';
end GET_FUNC_TURNO_ANTERIOR;
/
