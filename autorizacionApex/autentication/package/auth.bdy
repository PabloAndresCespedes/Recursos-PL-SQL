create or replace package body auth is

--1:
  function has_permission_user(
    p_user          usuarios.nick%type,
    p_permission_id permisos.id%type 
  )return boolean
  is
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
  
--2:
   function get_id_user(
     p_user usuarios.nick%type  
   ) return usuarios.id%type
   is
   begin
     select u.id
     into g_c
     from usuarios u
     where u.nick = trim(upper(p_user))
     and   u.estado_id = g_estado_activo;
     
     return g_c;
   exception
     when no_data_found then
       raise_application_Error(-20000, 'No se encuentra el usuario activo');
   end get_id_user;
   
--3:
   function is_pass_current(
     p_user     varchar2,
     p_old_pass varchar2  
   ) return boolean
   is
   begin
     select distinct 1 into g_c
     from usuarios u
     where u.pass = encripta_password(p_user_name => p_user, p_password => p_old_pass)
     and   u.estado_id = g_estado_activo;
     
     return true;
   exception
     when others then
       return false;
   end is_pass_current;

--4:
   procedure upd_pass_user(
     p_user      varchar2,
     p_pass_old  varchar2,
     p_pass_new  varchar2,
     p_pass_comp varchar2  
   )as
   begin
     if p_pass_old is null or p_pass_new is null or p_pass_comp is null then
       raise_application_Error(-20000, 'Complete todos los campos');
       
     elsif not is_pass_current(p_user => p_user, p_old_pass => p_pass_old) then
         raise_application_Error(-20000, 'Credencial actual no valida');
         
     elsif length(p_pass_new) < 6 then
       raise_application_error(-20000, 'Credenciales debe ser >= 5 caracteres');
       
     elsif p_pass_new <> p_pass_comp then
         raise_application_error(-20000, 'Credencial Nueva y Comprobacion no coinciden');
         
     end if;
     
     update usuarios u
     set    u.pass = encripta_password(p_user_name => p_user, p_password => p_pass_comp),
            u.user_web = p_user
     where  u.nick = p_user;
     
   end upd_pass_user;
     
end auth;
/
