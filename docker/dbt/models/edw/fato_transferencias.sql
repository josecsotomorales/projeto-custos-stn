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
  codigo_esfera_orcamentaria,
  codigo_modalidade_aplicacao,
  codigo_resultado_eof,
  valor_custo_de_transferencias
from {{ ref('stg_transferencias') }} as transferencias