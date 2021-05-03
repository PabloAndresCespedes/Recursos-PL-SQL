create or replace trigger turnos_antes
  before insert
  on TURNOS 
  referencing new as new old as old
  for each row
begin
  if :new.id is null then :new.id := TURNOS_SEQ.Nextval; end if;
end turnos_antes;
/
