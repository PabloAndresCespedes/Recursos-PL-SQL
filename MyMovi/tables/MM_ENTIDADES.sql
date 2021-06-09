CREATE table "MM_ENTIDADES" (
    "ID"          NUMBER,
    "DESCRIPCION" VARCHAR2(255),
    "ESTADO_ID"   NUMBER,
    "FECHA"       DATE,
    "USER_WEB"    VARCHAR2(50),
    constraint  "MM_ENTIDADES_PK" primary key ("ID")
)
/

CREATE sequence "MM_ENTIDADES_SEQ" 
/

CREATE or replace trigger "BI_MM_ENTIDADES"  
  before insert or update on "MM_ENTIDADES"              
  for each row 
begin  
  if :NEW."ID" is null and inserting then
    select "MM_ENTIDADES_SEQ".nextval into :NEW."ID" from sys.dual;
  end if;

  :new.fecha := sysdate;
  :new.user_web := coalesce(sys_context('APEX$SESSION','APP_USER'),user);

end;
/   

ALTER TABLE "MM_ENTIDADES" ADD CONSTRAINT "MM_ENTIDADES_ESTADO_FK" 
FOREIGN KEY ("ESTADO_ID")
REFERENCES "MM_ESTADOS" ("ID")

/
alter table "MM_ENTIDADES" add
constraint "MM_ENTIDADES_DESC_UK" 
unique ("DESCRIPCION")
/   
