 DROP VIEW PLAN_AMORTIZACION;

 create view PLAN_AMORTIZACION
        as
        
            SELECT numero_cuota,abono_capital,abono_interes,saldo,sum(abono_interes) over (partition by 1) total_interes
            FROM amortizacion;