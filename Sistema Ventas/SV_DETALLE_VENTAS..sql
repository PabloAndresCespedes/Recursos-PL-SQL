CREATE TABLE  "SV_DETALLE_VENTAS" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"VENTA_ID" NUMBER NOT NULL ENABLE, 
	"PRODUCTO_ID" NUMBER NOT NULL ENABLE, 
	"IVA_ID" NUMBER NOT NULL ENABLE, 
	"MONTO_TOTAL" NUMBER NOT NULL ENABLE, 
	"MONTO_SIN_IVA" NUMBER NOT NULL ENABLE, 
	"MONTO_IVA" NUMBER NOT NULL ENABLE, 
	"CANTIDAD" NUMBER NOT NULL ENABLE, 
	"USER_WEB" VARCHAR2(50) NOT NULL ENABLE, 
	 CONSTRAINT "SV_DETALLE_VENTAS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "SV_DETALLE_VENTAS_PROD_VENT_UK" UNIQUE ("PRODUCTO_ID", "VENTA_ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "SV_DETALLE_VENTAS" ADD CONSTRAINT "SV_DETALLE_VENTAS_PROD_FK" FOREIGN KEY ("PRODUCTO_ID")
	  REFERENCES  "SV_PRODUCTOS" ("ID") ENABLE
/
ALTER TABLE  "SV_DETALLE_VENTAS" ADD CONSTRAINT "SV_DETALLE_VENTAS_VENT_FK" FOREIGN KEY ("VENTA_ID")
	  REFERENCES  "SV_VENTAS" ("ID") ENABLE
/
ALTER TABLE  "SV_DETALLE_VENTAS" ADD CONSTRAINT "SV_DETALLE_VENTAS_IVA_FK" FOREIGN KEY ("IVA_ID")
	  REFERENCES  "SV_IVAS" ("ID") ENABLE
/

CREATE OR REPLACE EDITIONABLE TRIGGER  "BI_SV_DETALLE_VENTAS" 
  before insert on "SV_DETALLE_VENTAS"               
  for each row  
begin   
  if :NEW."ID" is null then 
    select "SV_DETALLE_VENTAS_SEQ".nextval into :NEW."ID" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_SV_DETALLE_VENTAS" ENABLE
/