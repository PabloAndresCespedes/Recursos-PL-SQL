create or replace trigger PERMISOS_ANTES
  before insert or update
  on PERMISOS 
  for each row
--asigna pk y fecha 
begin
  if inserting and :new.id is null then
    :new.id := PERMISOS_SEQ.Nextval;
  end if;
  
  :new.fecha := sysdate;
end PERMISOS_ANTES;
/
