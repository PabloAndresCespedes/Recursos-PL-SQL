create or replace package auth is

  -- Author  : @PabloACespedes
  -- Created : 20-Apr-21 4:40:28 PM
  -- Purpose : comprueba los roles y permisos de usuario para control de datos
   
  /****VARIABLES GLOBALES****/
  -- tabla catalogo ESTADOS
  g_estado_activo constant estados.id%type := 1;
  
  -- comodin
  g_c number;

--1 valida que el usuario logueado tenga el permiso, debe ocurrir luego de funcion: AUTENTICACION_USUARIO  
  function has_permission_user(
    p_user          usuarios.nick%type,
    p_permission_id permisos.id%type 
  )return boolean;

--2 captura id del usuario
   function get_id_user(
     p_user usuarios.nick%type  
   ) return usuarios.id%type;
 
--3 valida contrasenha actual
   function is_pass_current(
     p_user     varchar2,
     p_old_pass varchar2  
   ) return boolean;

--4 actualiza password usuario, no administrador
   procedure upd_pass_user(
     p_user      varchar2,
     p_pass_old  varchar2,
     p_pass_new  varchar2,
     p_pass_comp varchar2  
   );
      
end auth;
/
