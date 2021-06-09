CREATE table "MM_CONCEPTOS" (
    "ID"          NUMBER NOT NULL,
    "DESCRIPCION" VARCHAR2(255) NOT NULL,
    "ESTADO_ID"   NUMBER NOT NULL,
    "FECHA"       DATE NOT NULL,
    "USER_WEB"    VARCHAR2(50) NOT NULL,
    constraint  "MM_CONCEPTOS_PK" primary key ("ID")
)
/

CREATE sequence "MM_CONCEPTOS_SEQ" 
/

CREATE OR REPLACE EDITIONABLE trigger "BI_MM_CONCEPTOS"  
  before insert OR UPDATE on "MM_CONCEPTOS"              
  for each row 
begin  
  if :NEW."ID" is null AND INSERTING then
    select "MM_CONCEPTOS_SEQ".nextval into :NEW."ID" from sys.dual;
  end if;

  :new.fecha := sysdate;
  :new.user_web := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end;
/   

ALTER TABLE "MM_CONCEPTOS" ADD CONSTRAINT "MM_CONCEPTOS_EST_FK" 
FOREIGN KEY ("ESTADO_ID")
REFERENCES "MM_ESTADOS" ("ID")

/
alter table "MM_CONCEPTOS" add
constraint "MM_CONCEPTOS_DESC_UK" 
unique ("DESCRIPCION")
/   
