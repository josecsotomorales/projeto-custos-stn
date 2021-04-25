select
	fato_pensionistas.id as pensionistas_id,
	fato_pensionistas.codigo_natureza_juridica,
	fato_pensionistas.codigo_organizacao_1,
	fato_pensionistas.codigo_organizacao_2,
	fato_pensionistas.codigo_organizacao_3,
	fato_pensionistas.valor_custo_pensionistas,
  dim_pensionistas.descricao_natureza_juridica,
	dim_pensionistas.descricao_organizacao_1,
	dim_pensionistas.descricao_organizacao_2,
	dim_pensionistas.descricao_organizacao_3,
	fato_pensionistas.ano_lancamento,
	fato_pensionistas.mes_lancamento,
	fato_pensionistas.mes_ano_lancamento
from {{ ref('dim_pensionistas') }} dim_pensionistas
inner join {{ ref('fato_pensionistas') }} fato_pensionistas on dim_pensionistas.id = fato_pensionistas.id