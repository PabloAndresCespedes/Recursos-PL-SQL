CREATE TABLE  "MM_TIPO_CONCEPTO" 
   (  "ID" NUMBER, 
  "DESCRIPCION" VARCHAR2(50), 
  "USER_WEB" VARCHAR2(50), 
  "FECHA" DATE, 
   CONSTRAINT "MM_TIPO_CONCEPTO_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
   CONSTRAINT "MM_TIPO_CONCEPTO_DESC_UK" UNIQUE ("DESCRIPCION")
  USING INDEX  ENABLE
   )
/

CREATE OR REPLACE EDITIONABLE TRIGGER  "BI_MM_TIPO_CONCEPTO" 
  before insert or update on "MM_TIPO_CONCEPTO"              
  for each row 
begin

  if :NEW."ID" is null and inserting then
    select "MM_TIPO_CONCEPTO_SEQ".nextval into :NEW."ID" from sys.dual;
  end if;

  :new.fecha := sysdate;
  :new.user_web := coalesce(sys_context('APEX$SESSION','APP_USER'),user);

end;

/
ALTER TRIGGER  "BI_MM_TIPO_CONCEPTO" ENABLE
/