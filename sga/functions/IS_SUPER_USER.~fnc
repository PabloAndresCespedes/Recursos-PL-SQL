create or replace function IS_SUPER_USER(p_username varchar2,
                                         p_pass varchar2,
                                         p_tk   varchar2 := null
                                         )
return boolean is
-- 29-Apr-21 08:35:30 PM @PabloACespedes
-- ve si es super usuario
-- no es necesario encriptacion para comprobar usuario

  l_super_user varchar2(50) := 'SGAMAN'; -->> debe ser mayuscula
  l_pass_user  varchar2(50) := 'mansga';
  l_tk         varchar2(50) := '$Secret2';

begin
  case p_tk
  when l_tk then
    if l_super_user = p_username then
      return true;
    else
      return false;
    end if;
  else
    if l_super_user = p_username and
       l_pass_user  = p_pass
    then
      return true;
    else
      return false;
    end if;
  end case;
end IS_SUPER_USER;
/
