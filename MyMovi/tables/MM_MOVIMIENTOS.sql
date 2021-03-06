CREATE TABLE  "MM_MOVIMIENTOS" 
   (  "ID" NUMBER NOT NULL ENABLE, 
  "CONCEPTO_ID" NUMBER NOT NULL ENABLE, 
  "TIPO_MOVIMIENTO_ID" NUMBER NOT NULL ENABLE, 
  "MONTO" NUMBER NOT NULL ENABLE, 
  "FECHA" DATE NOT NULL ENABLE, 
  "USER_WEB" VARCHAR2(50) NOT NULL ENABLE, 
  "ENTIDAD_ID" NUMBER, 
   CONSTRAINT "MM_MOVIMIEN_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "MM_MOVIMIENTOS" ADD CONSTRAINT "MM_MOVIMIENTOS_ENTIDAD_FK" FOREIGN KEY ("ENTIDAD_ID")
    REFERENCES  "MM_ENTIDADES" ("ID") ENABLE
/
ALTER TABLE  "MM_MOVIMIENTOS" ADD CONSTRAINT "MM_MOVIMIENTOS_TIP_MOV_FK" FOREIGN KEY ("TIPO_MOVIMIENTO_ID")
    REFERENCES  "MM_TIPO_MOVIMIENTO" ("ID") ENABLE
/
ALTER TABLE  "MM_MOVIMIENTOS" ADD CONSTRAINT "MM_MOVIMIEN_CONCEPTO_FK" FOREIGN KEY ("CONCEPTO_ID")
    REFERENCES  "MM_CONCEPTOS" ("ID") ENABLE
/

CREATE OR REPLACE EDITIONABLE TRIGGER  "BI_MM_MOVIMIENTOS" 
  before insert OR UPDATE on "MM_MOVIMIENTOS"               
  for each row  
begin   
  if :NEW."ID" is null AND INSERTING then 
    select "MM_MOVIMIEN_SEQ1".nextval into :NEW."ID" from sys.dual; 
  end if; 

  if :new.fecha is null then
    :new.fecha := sysdate;
  end if;
  
  :new.user_web := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end;

/
ALTER TRIGGER  "BI_MM_MOVIMIENTOS" ENABLE
/