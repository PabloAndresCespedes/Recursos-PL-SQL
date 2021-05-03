CREATE OR REPLACE TRIGGER funcionario_seq_tr
 BEFORE INSERT ON funcionario FOR EACH ROW 
 WHEN (NEW.id_Funcionario IS NULL) 
BEGIN 
 SELECT funcionario_seq.NEXTVAL INTO :NEW.id_Funcionario FROM DUAL; 
END; 
/
