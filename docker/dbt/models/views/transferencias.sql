select
	fato_transferencias.id,
  fato_transferencias.codigo_natureza_juridica,
  fato_transferencias.codigo_organizacao_1,
  fato_transferencias.codigo_organizacao_2,
  fato_transferencias.codigo_organizacao_3,
  fato_transferencias.codigo_esfera_orcamentaria,
  fato_transferencias.codigo_modalidade_aplicacao,
  fato_transferencias.codigo_resultado_eof,
  fato_transferencias.valor_custo_de_transferencias,
	dim_transferencias.descricao_natureza_juridica,
	dim_transferencias.descricao_organizacao_1,
	dim_transferencias.descricao_organizacao_2,
	dim_transferencias.descricao_organizacao_3,
  dim_transferencias.descricao_esfera_orcamentaria,
	dim_transferencias.descricao_modalidade_aplicacao,
	dim_transferencias.descricao_resultado_eof,
  fato_transferencias.ano_lancamento,
  fato_transferencias.mes_lancamento,
  fato_transferencias.mes_ano_lancamento
from {{ ref('dim_transferencias') }} dim_transferencias
inner join {{ ref('fato_transferencias') }} fato_transferencias on dim_transferencias.id = fato_transferencias.id