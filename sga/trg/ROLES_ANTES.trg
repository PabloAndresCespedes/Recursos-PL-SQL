CREATE OR REPLACE TRIGGER "ROLES_ANTES"
  before insert or update
  on ROLES
  for each row
--asigna pk y fecha
begin
  if :new.id is null then
    :new.id := ROLES_SEQ.Nextval;
  end if;

  :new.fecha := sysdate;

end ROLES_ANTES;
/
