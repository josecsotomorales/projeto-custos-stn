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
	codigo_conta_contabil
	ano_lancamento,
	mes_lancamento,
	valor_custo_depreciacao
from {{ ref('stg_depreciacao') }} as depreciacao