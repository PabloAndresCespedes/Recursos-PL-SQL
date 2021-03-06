CREATE TABLE  "SV_PRODUCTOS" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"DESCRIPCION" VARCHAR2(2000) NOT NULL ENABLE, 
	"PRECIO_VENTA" NUMBER NOT NULL ENABLE, 
	"DESCUENTO_PORCENTAJE" NUMBER, 
	"DESCUENTO_PRECIO" NUMBER, 
	"CODIGO_BARRA" VARCHAR2(2000), 
	"IVA_ID" NUMBER NOT NULL ENABLE, 
	"ESTADO_ID" NUMBER NOT NULL ENABLE, 
	"USER_WEB" VARCHAR2(50) NOT NULL ENABLE, 
	 CONSTRAINT "SV_PRODUCTOS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "SV_PRODUCTOS_DESC_UK" UNIQUE ("DESCRIPCION")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "SV_PRODUCTOS" ADD CONSTRAINT "SV_PRODUCTOS_IVA_FK" FOREIGN KEY ("IVA_ID")
	  REFERENCES  "SV_IVAS" ("ID") ENABLE
/
ALTER TABLE  "SV_PRODUCTOS" ADD CONSTRAINT "SV_PRODUCTOS_ESTADO_FK" FOREIGN KEY ("ESTADO_ID")
	  REFERENCES  "ESTADOS" ("ID") ENABLE
/

CREATE OR REPLACE EDITIONABLE TRIGGER  "BI_SV_PRODUCTOS" 
  before insert on "SV_PRODUCTOS"               
  for each row  
begin   
  if :NEW."ID" is null then 
    select "SV_PRODUCTOS_SEQ".nextval into :NEW."ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_SV_PRODUCTOS" ENABLE
/