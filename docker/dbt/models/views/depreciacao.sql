select
  fato_depreciacao.id as depreciacao_id,
	fato_depreciacao.codigo_natureza_juridica,
	fato_depreciacao.codigo_organizacao_1,
	fato_depreciacao.codigo_organizacao_2,
	fato_depreciacao.codigo_organizacao_3,
	fato_depreciacao.codigo_conta_contabil,
  fato_depreciacao.valor_custo_depreciacao,
  dim_depreciacao.descricao_natureza_juridica,
  dim_depreciacao.descricao_organizacao_1,
  dim_depreciacao.descricao_organizacao_2,
  dim_depreciacao.descricao_organizacao_3,
  dim_depreciacao.descricao_conta_contabil,
	fato_depreciacao.ano_lancamento,
	fato_depreciacao.mes_lancamento,
	fato_depreciacao.mes_ano_lancamento
from {{ ref('dim_depreciacao') }} dim_depreciacao
inner join {{ ref('fato_depreciacao') }} fato_depreciacao on dim_depreciacao.id = fato_depreciacao.id