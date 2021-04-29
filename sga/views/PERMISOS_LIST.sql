create or replace view PERMISOS_LIST as
  select r.ID,
       r.DESCRIPCION,
       (
        select listagg(p.descripcion, ', ') within group (order by 1) i
        from table( apex_string.split_numbers(PERMISOS_IDS, ':') ) ps
        inner join permisos p on (p.id = ps.column_value)
       ) permisos,
       r.USER_WEB,
       r.FECHA
  from ROLES r
  order by r.fecha desc 
