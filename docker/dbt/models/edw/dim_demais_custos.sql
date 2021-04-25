{{
  config(
    unique_key = 'id'
  )
}}

select
	id,
	descricao_siorg_n05,
	descricao_siorg_n06,
	descricao_siorg_n07,
	descricao_situacao_icc,
	descricao_natureza_juridica_siorg,
	descricao_natureza_despesa_deta,
	descricao_esfera_orcamentaria,
	descricao_in_resultado_eof
from {{ ref('stg_demais_custos') }} as demais_custos