create or replace trigger novedad_biu
    before insert or update 
    on novedad
    for each row
declare 
v_dpto number;

begin
    if  :new.id_novedad is null then
        :new.id_novedad := NOVEDAD_SEQ.nextval;
    end if;
     
    begin
      select a.deptno,
             f.id_funcionario
        into v_dpto,
             :new.id_funcionario
      from funcionario f
      inner join asistencia a on (a.id_funcionario = f.id_funcionario)
      where upper(f.usuario)= nvl(sys_context('APEX$SESSION','APP_USER'),user)
      and   a.hora_inicio is not null
      and   a.hora_fin is null; 
    exception
      when no_data_found then
        raise_application_error(-20000, 'Necesita marcar asistencia para generar novedades');  
    end;
    
    if inserting then
        :new.fecha := systimestamp;
        :new.hora  := systimestamp;
        :new.fecha_creado := systimestamp;
        :new.creado_por := nvl(sys_context('APEX$SESSION','APP_USER'),user);
        :new.usuario    := nvl(sys_context('APEX$SESSION','APP_USER'),user);
        :new.DEPTNO     := v_dpto;
        
    end if;
    :new.fecha_ult_modif := systimestamp;
    :new.modif_por := nvl(sys_context('APEX$SESSION','APP_USER'),user);
end novedad_biu;
/
