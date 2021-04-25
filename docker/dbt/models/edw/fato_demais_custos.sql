{{
  config(
    unique_key = 'id'
  )
}}

select
	id,
	codigo_sirog_n05,
	codigo_siorg_n06,
	codigo_siorg_n07,
	codigo_situacao_icc,
	id_natureza_juridica_siorg,
	id_categoria_economica_nade,
	id_grupo_despesa_nade,
	id_moap_nade,
	id_elemento_despesa_nade,
	id_subitem_nade,
	codigo_natureza_despesa_deta,
	id_esfera_orcamentaria,
	id_in_resultado_eof,
	valor_custo,
	mes_referencia,
	ano_referencia,
	mes_ano,
	mes_emissao,
	ano_emissao,
	mes_ano_emissao,
	mes_ano_referencia
from {{ ref('stg_demais_custos') }} as demais_custos