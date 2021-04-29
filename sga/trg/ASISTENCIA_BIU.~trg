CREATE OR REPLACE TRIGGER "ASISTENCIA_BIU"
    before insert or update 
    on ASISTENCIA
    for each row
declare 
v_dpto          number;
v_funcionario   number;
begin
    if  :new.id_asistencia is null then
        :new.id_asistencia := asistencia_SEQ.nextval;
    end if;
     
    select DEPTNO,id_funcionario
      into v_dpto,v_funcionario
    from funcionario
    where upper(usuario)= nvl(sys_context('APEX$SESSION','APP_USER'),user); 
   
    if inserting then
        :new.hora_inicio    := to_char(systimestamp,'HH24:MI');
		    :new.fecha_creado   := systimestamp;
        :new.creado_por     := nvl(sys_context('APEX$SESSION','APP_USER'),user);
        :new.usuario        := nvl(sys_context('APEX$SESSION','APP_USER'),user);
        :new.DEPTNO         := v_dpto;
        :new.id_funcionario := v_funcionario;
        
        -- 28-Apr-21 12:28:35 PM @PabloACespedes
        -- captura horario del funcionario
        -- agrega 15 min, es el plazo para marcar antes, ej: querer marcar 5:45am en un horario de calendario de 06:00am
        begin
          select fh.fecha_inicio,
                 fh.fecha_fin,
                 fh.id
          into   :new.func_hora_inicio,
                 :new.func_hora_fin,
                 :new.id_func_emp
          from funcionarios_empresa fh
          where ((sysdate+15/1440) between fh.fecha_inicio and fh.fecha_fin)
          and  ':'||fh.funcionario_ids||':' like '%'||v_funcionario||'%';
        exception
          when no_data_found then
            raise_application_Error(-20000, 'Sin fechas laborales para hoy');
        end;
        
    elsif updating then
        :new.hora_fin         := to_char(systimestamp,'HH24:MI');
        :new.fecha_modificado := systimestamp;
        :new.modificado_por   := nvl(sys_context('APEX$SESSION','APP_USER'),user);
        :new.usuario          := nvl(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    
end asistencia_biu;
/
