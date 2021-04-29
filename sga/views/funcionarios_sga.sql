create or replace view funcionarios_sga as
select ID_FUNCIONARIO id,
       COD_FUNCIONARIO||'-'|| F.APELLIDO_F ||', '|| F.NOMBRE_F FUNCIONARIO,
       CEDULA_F ci,
       F.CCP,
       F.CARGO,
       F.RANGO,
       F.TIPO,
       F.NRO_BLOQUEO,
       F.NRO_ACC_REMOTO,
       F.PASS_REMOTO,
       F.TELEFONO,
       E.DESCRIPCION ESTADO,
       F.USUARIO,
       RF.ID ROLES_FUNC_ID,
       CASE WHEN RF.ID IS NULL THEN 'Agregar Rol' ELSE
         (
          select NVL(listagg(r.descripcion, ', ') within group (order by 1), 'Agregar Rol') x
          from table(apex_string.split_numbers(p_str => RF.ROLES_IDS, p_sep => ':')) rs
          inner join roles r on (r.id = rs.column_value)
         )
       END CREDENCIALES
  from FUNCIONARIO F
  INNER JOIN ESTADOS E ON (E.ID = F.ESTADO_ID)
  left JOIN ROLES_FUNCIONARIO RF ON (RF.FUNCIONARIO_ID = F.ID_FUNCIONARIO)
ORDER BY F.APELLIDO_F;