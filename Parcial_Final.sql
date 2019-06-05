 DROP TABLE amortizacion CASCADE CONSTRAINTS;

      
     create table amortizacion (
          numero_cuota integer,
          cuota_mensual decimal(15,2),
          abono_capital decimal(15,2),
          abono_interes decimal(15,2),
          saldo decimal(15,2)
        );
        
CREATE OR REPLACE PROCEDURE CALCULAR_SIMULACION(tasa_efectiva decimal,cuotas  integer,prestamo decimal ) as
    valor_cuota decimal(30,5):=0;
    tasa_mensual decimal(30,5):=0;
    abono_interes decimal(30,5):=0;
    abono_capital decimal(30,5):=0;
    saldo_prestamo decimal(30,5):=prestamo;
    cien decimal(30,5):=100.00;
BEGIN
    tasa_mensual:=tasa_efectiva/cien;
    tasa_mensual:=(POWER((1+tasa_mensual),30/360)) -1;
    valor_cuota:=(prestamo*((tasa_mensual*(POWER(1+tasa_mensual,cuotas)))))/(power(1+tasa_mensual,cuotas)-1);
   
    
    INSERT INTO amortizacion (numero_cuota,cuota_mensual,abono_capital,abono_interes,saldo)
    VALUES (0,valor_cuota,0,0,prestamo);
    
    FOR i IN 1..cuotas
    LOOP
        abono_interes:=tasa_mensual*saldo_prestamo;
        abono_capital:=valor_cuota-abono_interes;
        saldo_prestamo:=saldo_prestamo-abono_capital;
        INSERT INTO amortizacion (numero_cuota,cuota_mensual,abono_capital,abono_interes,saldo)
        VALUES (i,valor_cuota,abono_capital,abono_interes,saldo_prestamo);
    END LOOP;
    
END;





