create or replace package auth is

  -- Author  : @PabloACespedes
  -- Created : 29-Apr-21 09:51:55 AM
  -- Purpose : comprueba los roles y permisos de usuario para control de datos

  /****VARIABLES GLOBALES****/
  -- tabla catalogo ESTADOS
  g_estado_activo constant estados.id%type := 1;

  -- comodin
  g_c number;

--1 valida que el usuario logueado tenga el permiso, debe ocurrir luego de funcion: AUTENTICACION_USUARIO
  function has_permission_user(
    p_user          funcionario.usuario%type,
    p_permission_id permisos.id%type
  )return boolean;


end auth;
/
