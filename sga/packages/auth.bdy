create or replace package body auth is

--1:
  function has_permission_user(
    p_user          funcionario.usuario%type,
    p_permission_id permisos.id%type
  )return boolean
  is
   l_roles varchar2(4000);
   l_permisos varchar2(4000);
  begin
    if is_super_user(p_username => p_user, p_pass => null, p_tk => '$Secret2') then
      return true;
    else
      select ru.roles_ids into l_roles
      from funcionario u
      inner join roles_funcionario ru on (ru.funcionario_id = u.id_funcionario)
      where u.usuario = trim(upper(p_user));

      select listagg(r.permisos_ids, ':') within group (order by 1) into l_permisos
      from roles r
      inner join table (apex_string.split_numbers(l_roles, ':')) rs on (rs.column_value = r.id);

      select distinct 1 into g_c
      from permisos p
      inner join table (apex_string.split_numbers(l_permisos, ':')) ps on (ps.column_value = p.id)
      where p.id = p_permission_id;

      return true;
    end if;
  exception
    when others then
      return false;
  end has_permission_user;

--2
function has_permission_user_number(
    p_user          funcionario.usuario%type,
    p_permission_id permisos.id%type
  )return number
  is 
begin  
    if has_permission_user(p_user => p_user, p_permission_id => p_permission_id) then
      return 1;
    else 
      return 0;
    end if;
end has_permission_user_number;
end auth;
/
