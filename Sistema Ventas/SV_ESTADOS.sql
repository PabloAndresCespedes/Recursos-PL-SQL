CREATE TABLE  "SV_ESTADOS" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"DESCRIPCION" VARCHAR2(45) NOT NULL ENABLE, 
	 CONSTRAINT "SV_ESTADOS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "SV_ESTADOS_DESC_UK" UNIQUE ("DESCRIPCION")
  USING INDEX  ENABLE
   )
/