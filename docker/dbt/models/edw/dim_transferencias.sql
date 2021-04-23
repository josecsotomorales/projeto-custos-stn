{{
  config(
    unique_key = 'id'
  )
}}

select
	id,
	descricao_natureza_juridica,
	descricao_organizacao_1,
	descricao_organizacao_2,
	descricao_organizacao_3,
  descricao_esfera_orcamentaria,
	descricao_modalidade_aplicacao,
	descricao_resultado_eof
from {{ ref('stg_transferencias') }} as transferencias