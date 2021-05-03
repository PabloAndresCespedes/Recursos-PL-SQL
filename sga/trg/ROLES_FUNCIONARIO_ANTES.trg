CREATE OR REPLACE TRIGGER "ROLES_FUNCIONARIO_ANTES"
  before insert or update
  on ROLES_FUNCIONARIO
  for each row
-- asigna pk y fecha
begin
  if :new.id is null and inserting then
    :new.id := ROLES_FUNCIONARIO_SEQ.Nextval;
  end if;

  :new.fecha := sysdate;

end ROLES_FUNCIONARIO_ANTES;
/
