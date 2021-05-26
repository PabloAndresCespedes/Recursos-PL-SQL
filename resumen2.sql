SELECT ID_PLAN
      ,DESCRIPCION
      ,(SELECT COUNT(DISTINCT LPAD(C.ID_CLIENTE,6,'0')||'-'||LPAD(C.ID_SECUENCIA,2,'0') )
  FROM DET_FACT_PREPAGA DFP
      ,FACTURA_PREPAGA FP
      ,CLIENTE C
      ,TARIFA  T
  WHERE FP.ID_FACTURA_PREPAGA = DFP.FACT_PREP_ID_FACTURA_PREPAGA
    AND DFP.CLIENTE_ID_CLIENTE = C.ID_CLIENTE
    AND DFP.CLIENTE_ID_SECUENCIA = C.ID_SECUENCIA
    AND C.TARIFA_ID_TARIFA = T.ID_TARIFA
    AND T.PLAN_ID_PLAN = P.ID_PLAN
    AND T.CAT_CLIE_ID_CATEGORIA_CLIENTE = 81
    AND FP.ESTADO = 'ACTIVO'
&P_WHERE_DET
) CANT_TITULAR
      ,(SELECT COUNT(DISTINCT LPAD(C.ID_CLIENTE,6,'0')||'-'||LPAD(C.ID_SECUENCIA,2,'0') )
  FROM DET_FACT_PREPAGA DFP
      ,FACTURA_PREPAGA FP
      ,CLIENTE C
      ,TARIFA  T
  WHERE FP.ID_FACTURA_PREPAGA = DFP.FACT_PREP_ID_FACTURA_PREPAGA
    AND DFP.CLIENTE_ID_CLIENTE = C.ID_CLIENTE
    AND DFP.CLIENTE_ID_SECUENCIA = C.ID_SECUENCIA
    AND C.TARIFA_ID_TARIFA = T.ID_TARIFA
    AND T.PLAN_ID_PLAN = P.ID_PLAN
    AND T.CAT_CLIE_ID_CATEGORIA_CLIENTE != 81
    AND FP.ESTADO = 'ACTIVO'
&P_WHERE_DET
) CANT_ADHERENTES
      ,(SELECT Sum((DFP.MONTO_EXENTO   
+DFP.MONTO_GRAVADO  
+DFP.MONTO_IVA      
-DFP.MONTO_DESCUENTO)*FP.VENTA)
  FROM DET_FACT_PREPAGA DFP
      ,FACTURA_PREPAGA FP
      ,CLIENTE C
      ,TARIFA  T
  WHERE FP.ID_FACTURA_PREPAGA = DFP.FACT_PREP_ID_FACTURA_PREPAGA
    AND DFP.CLIENTE_ID_CLIENTE = C.ID_CLIENTE
    AND DFP.CLIENTE_ID_SECUENCIA = C.ID_SECUENCIA
    AND C.TARIFA_ID_TARIFA = T.ID_TARIFA
    AND T.PLAN_ID_PLAN = P.ID_PLAN
    AND FP.ESTADO = 'ACTIVO'
&P_WHERE_DET
) SUMA
      ,(SELECT Sum((DFP.MONTO_EXENTO   
+DFP.MONTO_GRAVADO  
+DFP.MONTO_IVA      
-DFP.MONTO_DESCUENTO)*FP.VENTA)
  FROM DET_FACT_PREPAGA DFP
      ,FACTURA_PREPAGA FP
      ,CLIENTE C
      ,TARIFA  T
  WHERE FP.ID_FACTURA_PREPAGA = DFP.FACT_PREP_ID_FACTURA_PREPAGA
    AND DFP.CLIENTE_ID_CLIENTE = C.ID_CLIENTE
    AND DFP.CLIENTE_ID_SECUENCIA = C.ID_SECUENCIA
    AND C.TARIFA_ID_TARIFA = T.ID_TARIFA
    AND T.PLAN_ID_PLAN = P.ID_PLAN
    AND T.CAT_CLIE_ID_CATEGORIA_CLIENTE = 81
    AND FP.ESTADO = 'ACTIVO'
&P_WHERE_DET
) SUMA_TITULAR
      ,(SELECT Sum((DFP.MONTO_EXENTO   
+DFP.MONTO_GRAVADO  
+DFP.MONTO_IVA      
-DFP.MONTO_DESCUENTO)*FP.VENTA)
  FROM DET_FACT_PREPAGA DFP
      ,FACTURA_PREPAGA FP
      ,CLIENTE C
      ,TARIFA  T
  WHERE FP.ID_FACTURA_PREPAGA = DFP.FACT_PREP_ID_FACTURA_PREPAGA
    AND DFP.CLIENTE_ID_CLIENTE = C.ID_CLIENTE
    AND DFP.CLIENTE_ID_SECUENCIA = C.ID_SECUENCIA
    AND C.TARIFA_ID_TARIFA = T.ID_TARIFA
    AND T.PLAN_ID_PLAN = P.ID_PLAN
    AND T.CAT_CLIE_ID_CATEGORIA_CLIENTE != 81
    AND FP.ESTADO = 'ACTIVO'
&P_WHERE_DET
) SUMA_ADHERENTES
  FROM PLAN P 
where id_plan <= 500  AND ID_PLAN != 5
&P_WHERE
order by id_plan



function BeforePForm return boolean is
begin
  IF NOT VERIFICA_PROGRAMA(USER, BUSCAR_CODIGO_PRG(:REPORTE)) THEN
    srw.MESSAGE(00001, 'Este programa no corresponde para su rol'); 
    RETURN(FALSE);
  ELSE
    :P_WHERE := ' ' ;
    :P_WHERE_DET := ' ' ;
    IF :P_ID_PLAN IS NOT NULL THEN
      :P_WHERE := :P_WHERE||' AND ID_PLAN = '||:P_ID_PLAN;
    END IF;
    IF :P_FECHA_DESDE IS NOT NULL THEN
      :P_WHERE_DET := :P_WHERE_DET||' AND TRUNC(FP.FECHA_GRABACION) >= TO_DATE('''||:P_FECHA_DESDE||''',''DD-MM-RR'')';
    END IF;
    IF :P_FECHA_HASTA IS NOT NULL THEN
      :P_WHERE_DET := :P_WHERE_DET||' AND TRUNC(FP.FECHA_GRABACION) <= TO_DATE('''||:P_FECHA_HASTA||''',''DD-MM-RR'')';
    END IF;
    
    IF :P_ID_CONCEPTO IS NOT NULL THEN
      if :P_ID_CONCEPTO = 16 OR :P_ID_CONCEPTO = 17 THEN
        :P_WHERE_DET := :P_WHERE_DET||' AND (FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 16  OR  FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 17)';
      ELSIF   :p_ID_CONCEPTO = 18 OR :p_ID_CONCEPTO = 19 THEN -- COMISIONES
      --  :P_WHERE_DET := :P_WHERE_DET||' AND (FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 18  OR  FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 19)';
        :P_WHERE_DET := :P_WHERE_DET||' AND DFP.COMISION = ''SI'' ';
      ELSIF   :p_ID_CONCEPTO = 21 OR :p_ID_CONCEPTO = 20 THEN -- MORA
      --  :P_WHERE_DET := :P_WHERE_DET||' AND (FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 21  OR  FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 20)';
        :P_WHERE_DET := :P_WHERE_DET||' AND DFP.COMISION = ''MO'' ';
      ELSIF   :p_ID_CONCEPTO = 22 OR :p_ID_CONCEPTO = 23 THEN --DESCUENTOS
      --  :P_WHERE_DET := :P_WHERE_DET||' AND (FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 22  OR  FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 23)';
        :P_WHERE_DET := :P_WHERE_DET||' AND DFP.COMISION = ''DE'' ';
      ELSIF   :p_ID_CONCEPTO = 26 OR :p_ID_CONCEPTO = 27 THEN
        :P_WHERE_DET := :P_WHERE_DET||' AND (FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 26  OR  FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 27)';
      ELSIF   :p_ID_CONCEPTO = 24 OR :p_ID_CONCEPTO = 13 THEN
        :P_WHERE_DET := :P_WHERE_DET||' AND (FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 24  OR  FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = 13)';
      ELSIF   :p_ID_CONCEPTO = 1 OR :p_ID_CONCEPTO = 4  OR :p_ID_CONCEPTO = 8 THEN
        :P_WHERE_DET := :P_WHERE_DET||' AND FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = '||:P_ID_CONCEPTO||' ';
        :P_WHERE_DET := :P_WHERE_DET||' AND DFP.COMISION IS NULL ';
      ELSE
        :P_WHERE_DET := :P_WHERE_DET||' AND FP.CPT_FAID_CONCEPTO_FACT_PREPAGA = '||:P_ID_CONCEPTO||' ';
      END IF;
    END IF;
    
    IF :P_FECHA_PERIODO IS NOT NULL THEN
      :P_WHERE_DET := :P_WHERE_DET||' AND TRUNC(DFP.FECHA_PERIODO) = TO_DATE('''||:P_FECHA_PERIODO||''',''DD-MM-RR'')';
    END IF;
    --  SRW.MESSAGE(2000,(:P_WHERE_FACT));
    --  SRW.MESSAGE(2000,VER_PARAM_REPORTE(:P_WHERE_FACT));    return (TRUE);
    return true;
  END IF;
end;
