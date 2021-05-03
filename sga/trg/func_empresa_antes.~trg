create or replace trigger func_empresa_antes
  before insert or delete
  on FUNCIONARIOS_EMPRESA 
  for each row
begin
  if inserting and :new.id is null then 
    :new.id := FUNCIONARIOS_EMPRESA_SEQ.NEXTVAL; 
  end if;
  
  if deleting then
    delete from asistencia a
    where (trunc(a.func_hora_inicio) >= trunc(sysdate) or trunc(a.func_hora_fin) >= trunc(sysdate))
    and   a.deptno = :old.depno;
  end if;
  
end func_empresa_antes;
/
