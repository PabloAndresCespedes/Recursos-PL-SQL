create or replace trigger USUARIOS_ANTES
  before insert or update
  on USUARIOS 
  for each row
-- asigna pk y fecha
begin
  if :new.id is null and inserting then
    :new.id := USUARIOS_SEQ.Nextval;
  end if;
  
  :new.fecha := sysdate;
  
  -- si no tiene password asignado crea a partir del nick de usuario nuevo
  if :new.pass is null then
    :new.pass := encripta_password(p_user_name => upper(:new.nick), p_password => lower(:new.nick));
  end if;
  
end USUARIOS_ANTES;
/
