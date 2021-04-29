create or replace function get_mes_letra(p_mes number)
return varchar2
is
begin
  case p_mes
    when 1 then return 'Enero';
    when 2 then return 'Febrero';
    when 3 then return 'Marzo';
    when 4 then return 'Abril';
    when 5 then return 'Mayo';
    when 6 then return 'Junio';
    when 7 then return 'Julio';
    when 8 then return 'Agosto';
    when 9 then return 'Septiembre';
    when 10 then return 'Octubre';
    when 11 then return 'Noviembre';
    when 12 then return 'Diciembre';
  end case;
exception
  when others then return null;
end get_mes_letra;
/
