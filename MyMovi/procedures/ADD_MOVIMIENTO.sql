create or replace procedure "ADD_MOVIMIENTO"
(p_concepto_id IN NUMBER,
 p_concepto_desc IN VARCHAR2,
 p_tipo_mov_id IN NUMBER,
 p_monto IN NUMBER,
 p_fecha in date
 )
is
lv_conc_id_new number;
lv_estado_activo number := 1; --tabla MM_ESTADOS
begin
    if p_concepto_id is null and p_concepto_desc is not null then
        insert into MM_CONCEPTOS(DESCRIPCION, ESTADO_ID)
        values(upper(trim(p_concepto_desc)), lv_estado_activo)
        returning id into lv_conc_id_new;
    elsif p_concepto_id is null and p_concepto_desc is null then
        raise_application_error(-20000, 'Complete la descripción del concepto');
    end if;

    if p_monto <= 0 then
        raise_application_error(-20000, 'Monto debe ser mayor a 0');
    end if;

    insert into MM_MOVIMIENTOS(CONCEPTO_ID, TIPO_MOVIMIENTO_ID, MONTO, fecha)
    values(nvl(p_concepto_id, lv_conc_id_new), p_tipo_mov_id, p_monto, p_fecha);
    
end;