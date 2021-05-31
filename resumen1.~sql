/*** PRESTACION DE SERVICIOS **/
select nvl(sum((dfp.monto_exento  + dfp.monto_gravado  + dfp.monto_iva  - dfp.monto_descuento) * fp.venta), 0) factura_cuota 
from det_fact_prepaga dfp
inner join factura_prepaga fp on (fp.id_factura_prepaga = dfp.fact_prep_id_factura_prepaga)
inner join cliente c on (dfp.cliente_id_cliente = c.id_cliente and dfp.cliente_id_secuencia = c.id_secuencia)
inner join tarifa  t on (c.tarifa_id_tarifa = t.id_tarifa)
inner join plan p on (t.plan_id_plan = p.id_plan)
where fp.estado = 'ACTIVO'
and   fp.cpt_faid_concepto_fact_prepaga = 1
and   dfp.comision is null
and   p.id_plan <= 500 and p.id_plan != 5
and  (trunc(fp.fecha_grabacion) between to_date(&fecha_desde, 'dd/mm/yyyy') and to_date(&fecha_hasta, 'dd/mm/yyyy'));

select nvl(sum((dfp.monto_exento  + dfp.monto_gravado  + dfp.monto_iva  - dfp.monto_descuento) * fp.venta), 0) cuota_inclusion 
from det_fact_prepaga dfp
inner join factura_prepaga fp on (fp.id_factura_prepaga = dfp.fact_prep_id_factura_prepaga)
inner join cliente c on (dfp.cliente_id_cliente = c.id_cliente and dfp.cliente_id_secuencia = c.id_secuencia)
inner join tarifa  t on (c.tarifa_id_tarifa = t.id_tarifa)
inner join plan p on (t.plan_id_plan = p.id_plan)
where fp.estado = 'ACTIVO'
and   fp.cpt_faid_concepto_fact_prepaga = 2
and   p.id_plan <= 500 and p.id_plan != 5
and  (trunc(fp.fecha_grabacion) between to_date(&fecha_desde, 'dd/mm/yyyy') and to_date(&fecha_hasta, 'dd/mm/yyyy'));

select nvl(sum((dfp.monto_exento  + dfp.monto_gravado  + dfp.monto_iva  - dfp.monto_descuento) * fp.venta), 0) copago 
from det_fact_prepaga dfp
inner join factura_prepaga fp on (fp.id_factura_prepaga = dfp.fact_prep_id_factura_prepaga)
inner join cliente c on (dfp.cliente_id_cliente = c.id_cliente and dfp.cliente_id_secuencia = c.id_secuencia)
inner join tarifa  t on (c.tarifa_id_tarifa = t.id_tarifa)
inner join plan p on (t.plan_id_plan = p.id_plan)
where fp.estado = 'ACTIVO'
and   fp.cpt_faid_concepto_fact_prepaga = 3
and   p.id_plan <= 500 and p.id_plan != 5
and  (trunc(fp.fecha_grabacion) between to_date(&fecha_desde, 'dd/mm/yyyy') and to_date(&fecha_hasta, 'dd/mm/yyyy'));

select nvl(sum((dfp.monto_exento  + dfp.monto_gravado  + dfp.monto_iva  - dfp.monto_descuento) * fp.venta), 0) cuotas_anteriores
from det_fact_prepaga dfp
inner join factura_prepaga fp on (fp.id_factura_prepaga = dfp.fact_prep_id_factura_prepaga)
inner join cliente c on (dfp.cliente_id_cliente = c.id_cliente and dfp.cliente_id_secuencia = c.id_secuencia)
inner join tarifa  t on (c.tarifa_id_tarifa = t.id_tarifa)
inner join plan p on (t.plan_id_plan = p.id_plan)
where fp.estado = 'ACTIVO'
and   fp.cpt_faid_concepto_fact_prepaga = 11
and   p.id_plan <= 500 and p.id_plan != 5
and  (trunc(fp.fecha_grabacion) between to_date(&fecha_desde, 'dd/mm/yyyy') and to_date(&fecha_hasta, 'dd/mm/yyyy'));

select nvl(sum((dfp.monto_exento  + dfp.monto_gravado  + dfp.monto_iva  - dfp.monto_descuento) * fp.venta), 0) diferencia_cuotas 
from det_fact_prepaga dfp
inner join factura_prepaga fp on (fp.id_factura_prepaga = dfp.fact_prep_id_factura_prepaga)
inner join cliente c on (dfp.cliente_id_cliente = c.id_cliente and dfp.cliente_id_secuencia = c.id_secuencia)
inner join tarifa  t on (c.tarifa_id_tarifa = t.id_tarifa)
inner join plan p on (t.plan_id_plan = p.id_plan)
where fp.estado = 'ACTIVO'
and   fp.cpt_faid_concepto_fact_prepaga = 12
and   p.id_plan <= 500 and p.id_plan != 5
and  (trunc(fp.fecha_grabacion) between to_date(&fecha_desde, 'dd/mm/yyyy') and to_date(&fecha_hasta, 'dd/mm/yyyy'));

/******** DEDUCCIONES DE VENTAS ********/
select sum(n.monto_exento + n.monto_gravado + n.monto_iva) notas_credito
from nota_cr_fact_prepaga n
where n.estado_nota = 'ACTIVO'
and  (trunc(n.fecha_nota) between to_date(&fecha_desde, 'dd/mm/yyyy') and to_date(&fecha_hasta, 'dd/mm/yyyy'));

/**COSTO DE VENTAS**/
select nvl(sum(s.monto_prepaga) ,0) coberturas_ambulatorias
from srv_prepaga s
where (trunc(s.fecha_inicio_srv) between to_date(&fecha_desde,'dd/mm/yyyy') and to_date(&fecha_hasta,'dd/mm/yyyy'))
and   s.estado_srv = 'ACTIVO'
and   s.id_internado is null;

select nvl(sum(s.monto_prepaga) ,0) coberturas_internaciones
from srv_prepaga s
where (trunc(s.fecha_inicio_srv) between to_date(&fecha_desde,'dd/mm/yyyy') and to_date(&fecha_hasta,'dd/mm/yyyy'))
and   s.estado_srv = 'ACTIVO'
and   s.id_internado is not null;

select sum(t) saa_reintegros 
from(
  select sum(t) t from(
  select nvl(sum(f.monto_gravado + f.monto_exento + f.monto_iva - f.desc_monto_exento - f.desc_monto_gravado), 0) t
    from fact_prov f
    inner join det_factura_prov d on (d.fact_id_factura = f.id_factura)
    inner join articulo a on (a.id_articulo = d.art_id_articulo)
    where f.prov_id_proveedor = 716 -- 
    and   f.estado = 'ACTIVO'
    and   (trunc(f.fecha_factura) between to_date(&fecha_desde,'dd/mm/yyyy') and to_date(&fecha_hasta,'dd/mm/yyyy'))
    and   a.sub_grupo_grupo_id_grupo = 18  -- GASTOS GENERALES - OPERATIVOS
    and   a.sub_grupo_grupo_linea_id_linea = 8 -- GASTOS DE CONVENIOS
  group by f.id_factura)
  union all
  select nvl(sum(t.monto), 0) t
  from trans t
  where t.concepto_id_concepto_orig in (select distinct c.concepto_id from concepto_plan_prepaga c)
  and   t.estado_trans = 'ACTIVO'
  and   (trunc(t.fecha_transaccion) between to_date(&fecha_desde,'dd/mm/yyyy') and to_date(&fecha_hasta,'dd/mm/yyyy'))
);

/**OTROS INGRESOS OPERATIVOS**/
select nvl(sum((dfp.monto_exento  + dfp.monto_gravado  + dfp.monto_iva  - dfp.monto_descuento) * fp.venta), 0) servicio_cobranzas 
from det_fact_prepaga dfp
inner join factura_prepaga fp on (fp.id_factura_prepaga = dfp.fact_prep_id_factura_prepaga)
inner join cliente c on (dfp.cliente_id_cliente = c.id_cliente and dfp.cliente_id_secuencia = c.id_secuencia)
inner join tarifa  t on (c.tarifa_id_tarifa = t.id_tarifa)
inner join plan p on (t.plan_id_plan = p.id_plan)
where fp.estado = 'ACTIVO'
and   fp.cpt_faid_concepto_fact_prepaga = 18
and   dfp.comision = 'SI'
and   p.id_plan <= 500 and p.id_plan != 5
and  (trunc(fp.fecha_grabacion) between to_date(&fecha_desde, 'dd/mm/yyyy') and to_date(&fecha_hasta, 'dd/mm/yyyy'));

/** ADMINISTRATIVAS Y GENERALES **/
select nvl(sum(a.precio_ponderado), 0) salida_deposito
from solicitud_articulo x
inner join det_sol_art y on (x.id_solicitud_art = y.sol_art_id_solicitud_art)
inner join personal_sanatorio p on (p.id_personal = x.per_san_id_personal)
inner join articulo a on (a.id_articulo = y.art_id_articulo)
where y.estado='CONCRETADO' 
and (trunc(x.fecha) between to_date(&fecha_desde,'dd/mm/yyyy') and to_date(&fecha_hasta,'dd/mm/yyyy'))
and x.d_suc_dep_id_departamento = 58;
