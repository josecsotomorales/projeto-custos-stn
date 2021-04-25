select
  fato_demais_custos.id as demais_custos_id,
	fato_demais_custos.codigo_sirog_n05,
	fato_demais_custos.codigo_siorg_n06,
	fato_demais_custos.codigo_siorg_n07,
	fato_demais_custos.codigo_situacao_icc,
	fato_demais_custos.id_natureza_juridica_siorg,
	fato_demais_custos.id_categoria_economica_nade,
	fato_demais_custos.id_grupo_despesa_nade,
	fato_demais_custos.id_moap_nade,
	fato_demais_custos.id_elemento_despesa_nade,
	fato_demais_custos.id_subitem_nade,
	fato_demais_custos.codigo_natureza_despesa_deta,
	fato_demais_custos.id_esfera_orcamentaria,
	fato_demais_custos.id_in_resultado_eof,
	fato_demais_custos.valor_custo,
  dim_demais_custos.descricao_sirog_n05,
	dim_demais_custos.descricao_siorg_n06,
	dim_demais_custos.descricao_sirog_n07,
	dim_demais_custos.descricao_situacao_icc,
	dim_demais_custos.descricao_natureza_juridica_siorg,
	dim_demais_custos.descricao_natureza_despesa_deta,
	dim_demais_custos.descricao_esfera_orcamentaria,
	dim_demais_custos.descricao_in_resultado_eof,
	fato_demais_custos.mes_referencia,
	fato_demais_custos.ano_referencia,
	fato_demais_custos.mes_ano,
	fato_demais_custos.mes_emissao,
	fato_demais_custos.ano_emissao,
	fato_demais_custos.mes_ano_emissao,
	fato_demais_custos.mes_ano_referencia
from {{ ref('dim_demais_custos') }} dim_demais_custos
inner join {{ ref('fato_demais_custos') }} fato_demais_custos on dim_demais_custos.id = fato_demais_custos.id