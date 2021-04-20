CREATE OR REPLACE FUNCTION autenticacion_usuario
  (p_username  in varchar2,
   p_password   in varchar2)
return boolean
is
  l_c NUMBER;
  l_estado_activo number := 1; -- tabla ESTADOS
  l_user       varchar2(50) := replace(upper(trim(p_username)), ' ', '');
  l_pass       varchar2(255) := p_password;
begin
  
   if IS_SUPER_USER(p_username => l_user, p_pass => l_pass) then
     return true;
   else
     
   -- comprueba que tenga algun rol
     select distinct 1 into l_c
     from usuarios u
     inner join roles_usuario ru on (ru.usuario_id = u.id)
     where u.estado_id = l_estado_activo
     and   u.nick      = l_user
     and   u.pass      = encripta_password(p_user_name => l_user, p_password => l_pass)
     and   ru.roles_ids is not null;
     
     return true;
     
   end if;
exception
  when others then
    return false;   
end autenticacion_usuario;
/
