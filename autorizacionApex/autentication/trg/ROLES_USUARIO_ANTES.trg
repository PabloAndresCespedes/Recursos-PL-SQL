create or replace trigger ROLES_USUARIO_ANTES
  before insert or update
  on ROLES_USUARIO 
  for each row
-- asigna pk y fecha
begin
  if :new.id is null and inserting then
    :new.id := ROLES_USUARIO_SEQ.Nextval;
  end if;
  
  :new.fecha := sysdate;
  
end ROLES_USUARIO_ANTES;
/
