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
  codigo_esfera_orcamentaria,
  codigo_modalidade_aplicacao,
  codigo_resultado_eof,
  valor_custo_de_transferencias,
  ano_lancamento,
  mes_lancamento,
  mes_ano_lancamento
from {{ ref('stg_transferencias') }} as transferencias