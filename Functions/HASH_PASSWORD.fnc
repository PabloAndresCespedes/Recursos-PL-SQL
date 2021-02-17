create or replace FUNCTION HASH_PASSWORD
  (p_user_name in varchar2,
   p_password  in varchar2)
return varchar2
is
  l_password varchar2(255);
  -- The following salt is an example. 
  -- Should probably be changed to another random string.
  l_salt  varchar2(255) := '[hdwHU#KaSh@Q:j>Hym.YJ#c%pnkY)(h.KZ?q';
begin
    --
    -- The following encryptes the password using a salt string and the 
    -- DBMS_OBFUSCATION_TOOLKIT. 
    -- This is a one-way encryption using MD5
    -- 
    l_password := utl_raw.cast_to_raw (
					dbms_obfuscation_toolkit.md5(
					  input_string => p_password ||
                                      substr(l_salt,8,7) ||
                                      p_user_name ||
                                      substr(l_salt,1,2)));
    return l_password;
end hash_password;