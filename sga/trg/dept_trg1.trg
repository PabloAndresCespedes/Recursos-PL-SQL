create or replace trigger dept_trg1
before insert or update or delete
on dept
for each row
begin
   if inserting and :new.deptno is null then
      select dept_seq.nextval into :new.deptno from sys.dual;
   end if;
   
   if updating or deleting then
     delete from funcionarios_empresa fe
     where  (trunc(fe.fecha_inicio) >= trunc(sysdate) or trunc(fe.fecha_fin) >= trunc(sysdate))
     and    fe.depno = :old.deptno;
   end if;
end;
/
