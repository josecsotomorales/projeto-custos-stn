SELECT TO_CHAR(datum, 'yyyymmdd')::INT AS id,
       datum AS data_atual,
       EXTRACT(EPOCH FROM datum) AS epoca,
       TO_CHAR(datum, 'fmDDth') AS dia_sufixo,
       TO_CHAR(datum, 'Day') AS dia_nome,
       EXTRACT(ISODOW FROM datum) AS dia_da_semana,
       EXTRACT(DAY FROM datum) AS dia_do_mes,
       datum - DATE_TRUNC('quarter', datum)::DATE + 1 AS dia_do_trimestre,
       EXTRACT(DOY FROM datum) AS dia_do_ano,
       TO_CHAR(datum, 'W')::INT AS semana_do_mes,
       EXTRACT(WEEK FROM datum) AS semana_do_ano,
       EXTRACT(ISOYEAR FROM datum) || TO_CHAR(datum, '"-W"IW-') || EXTRACT(ISODOW FROM datum) AS semana_do_ano_iso,
       EXTRACT(MONTH FROM datum) AS mes_atual,
       TO_CHAR(datum, 'Month') AS mes_nome,
       TO_CHAR(datum, 'Mon') AS mes_nome_abreviado,
       EXTRACT(QUARTER FROM datum) AS trimestre_atual,
       CASE
           WHEN EXTRACT(QUARTER FROM datum) = 1 THEN 'Primeiro'
           WHEN EXTRACT(QUARTER FROM datum) = 2 THEN 'Segundo'
           WHEN EXTRACT(QUARTER FROM datum) = 3 THEN 'Terceiro'
           WHEN EXTRACT(QUARTER FROM datum) = 4 THEN 'Quarto'
           END AS trimestre_nome,
       EXTRACT(ISOYEAR FROM datum) AS ano_atual,
       datum + (1 - EXTRACT(ISODOW FROM datum))::INT AS primeiro_dia_da_semana,
       datum + (7 - EXTRACT(ISODOW FROM datum))::INT AS ultimo_dia_da_semana,
       datum + (1 - EXTRACT(DAY FROM datum))::INT AS primeiro_dia_do_mes,
       (DATE_TRUNC('MONTH', datum) + INTERVAL '1 MONTH - 1 day')::DATE AS ultimo_dia_do_mes,
       CASE WHEN EXTRACT(DAY FROM DATUM) = EXTRACT(DAY FROM (DATE_TRUNC('MONTH', DATUM) + INTERVAL '1 MONTH - 1 DAY')::DATE)
	   				THEN TRUE
				ELSE FALSE 
	   END AS EH_ULTIMO_DIA,
       DATE_TRUNC('quarter', datum)::DATE AS primeiro_dia_do_trimestre,
       (DATE_TRUNC('quarter', datum) + INTERVAL '3 MONTH - 1 day')::DATE AS ultimo_dia_do_trimestre,
       TO_DATE(EXTRACT(YEAR FROM datum) || '-01-01', 'YYYY-MM-DD') AS primeiro_dia_do_ano,
       TO_DATE(EXTRACT(YEAR FROM datum) || '-12-31', 'YYYY-MM-DD') AS ultimo_dia_do_ano,
       TO_CHAR(datum, 'mmyyyy')::INT AS mes_ano,
       TO_CHAR(datum, 'mmddyyyy') AS mes_dia_ano,
       CASE
           WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE
           ELSE FALSE
           END AS semana_decrementado
FROM (SELECT '2014-01-01'::DATE + SEQUENCE.DAY AS datum
      FROM GENERATE_SERIES(0, 29219) AS SEQUENCE (DAY)
      GROUP BY SEQUENCE.DAY) DQ
ORDER BY 1