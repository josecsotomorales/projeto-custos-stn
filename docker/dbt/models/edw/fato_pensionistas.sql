{{
  config(
    unique_key = 'id'
  )
}}

select
	id,
	codigo_natureza_juridica,
	codigo_organizacao_1,
	codigo_organizacao_2,
	codigo_organizacao_3,
	ano_lancamento,
	mes_lancamento,
	valor_custo_pensionistas,
	mes_ano_lancamento
from {{ ref('stg_pensionistas') }} as pensionistas