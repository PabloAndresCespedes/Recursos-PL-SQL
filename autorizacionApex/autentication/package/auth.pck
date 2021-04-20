create or replace package auth is

  -- Author  : @PabloACespedes
  -- Created : 20-Apr-21 4:40:28 PM
  -- Purpose : comprueba los roles y permisos de usuario para control de datos
  
  function has_permission_user(
    p_user          usuarios.nick%type,
    p_permission_id permisos.id%type 
  )return boolean;

end auth;
/
create or replace package body auth is

  function has_permission_user(
    p_user          usuarios.nick%type,
    p_permission_id permisos.id%type 
  )return boolean
  is
   l_c number;
   l_roles varchar2(4000);
   l_permisos varchar2(4000);
  begin
    if is_super_user(p_username => p_user, p_pass => null, p_tk => '$Secret8') then
      return true;
    else
      select ru.roles_ids into l_roles
      from usuarios u
      inner join roles_usuario ru on (ru.usuario_id = u.id)
      where u.nick = trim(upper(p_user));
      
      select r.permisos_ids into l_permisos
      from roles r
      inner join table (apex_string.split_numbers(l_roles, ':')) rs on (rs.column_value = r.id);
      
      select distinct 1 into l_c
      from permisos p
      inner join table (apex_string.split_numbers(l_permisos, ':')) ps on (ps.column_value = p.id)
      where p.id = p_permission_id;
      
      return true;
    end if;
  exception
    when others then
      return false;
  end has_permission_user;
end auth;
/
