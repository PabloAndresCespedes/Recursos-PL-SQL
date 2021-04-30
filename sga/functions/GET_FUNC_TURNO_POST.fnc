create or replace function GET_FUNC_TURNO_POST(p_fecha_fin varchar2,
                                               p_dept      number                                           
                                               ) return varchar2 is
  lv_d date;
  lv_r varchar2(4000);
  lv_fecha_fin date := to_date(p_fecha_fin, 'dd/mm/yyyy hh24:mi:ss');
begin
  select min(fe.fecha_inicio) x,
       fe.funcionario_ids
  into lv_d,
       lv_r
  from funcionarios_empresa fe 
  where fe.depno = p_dept
  and   (fe.fecha_inicio >= lv_fecha_fin)
  and   rownum = 1
  group by fe.funcionario_ids;
  
  return lv_r;
  
exception
  when no_data_found then
    return '-1';
    
end GET_FUNC_TURNO_POST;
/
