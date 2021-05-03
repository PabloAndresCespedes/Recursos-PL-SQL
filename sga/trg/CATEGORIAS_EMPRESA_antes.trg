create or replace trigger CATEGORIAS_EMPRESA_antes
  before insert
  on CATEGORIAS_EMPRESA 
  for each row
begin
  if :new.id is null then :new.id := CATEGORIAS_EMPRESA_SEQ.Nextval; end if;
end CATEGORIAS_EMPRESA_antes;
/
