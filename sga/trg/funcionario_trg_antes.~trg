create or replace trigger funcionario_trg_antes
  before insert or update
  on FUNCIONARIO 
  for each row
-- 29-Apr-21 9:02:17 AM @PabloACespedes
-- encripta la password y valida que no sea superuser
begin
  :new.pw := encripta_password(p_user_name => :new.usuario, p_password => :new.pw);
  
  if inserting and :new.usuario = 'SGAMAN' then
    raise_application_Error(-20000, 'Usuario invalido');
  end if;
  
end funcionario_trg_antes;
/
