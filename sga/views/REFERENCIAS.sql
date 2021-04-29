create or replace view REFERENCIAS as
  select r.descripcion||':' rol, 
         (
          select listagg(p.descripcion, ', ') within group (order by 1) x
          from table( apex_string.split_numbers(p_str => r.permisos_ids, p_sep => ':') ) ps
          inner join permisos p on (p.id = ps.column_value)
         ) permisos
  from roles r
  order by 1 asc
   
