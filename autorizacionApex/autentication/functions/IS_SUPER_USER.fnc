create or replace function IS_SUPER_USER(p_username varchar2,
                                         p_pass varchar2) 
return boolean is
-- 20-Apr-21 12:35:30 PM @PabloACespedes
-- ve si es super usuario
-- no es necesario encriptacion para comprobar usuario

  l_super_user varchar2(50) := 'pacruser';
  l_pass_user  varchar2(50) := 'userpacr';
  
begin
  
  if l_super_user = p_username and
     l_pass_user  = p_pass
  then
    return true;
  else
    return false;
  end if;

end IS_SUPER_USER;
/
