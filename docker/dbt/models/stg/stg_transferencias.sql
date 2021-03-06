with transferencias as (
	select
		distinct
		{{ dbt_utils.surrogate_key(['co_natureza_juridica','co_organizacao_n1', 'co_organizacao_n2','co_organizacao_n3','va_custo_transferencias','an_lanc','me_lanc','co_esfera_orcamentaria','co_modalidade_aplicacao','co_resultado_eof']) }} as id,
		co_natureza_juridica as codigo_natureza_juridica,
		ds_natureza_juridica as descricao_natureza_juridica,
		co_organizacao_n1 as codigo_organizacao_1,
		ds_organizacao_n1 as descricao_organizacao_1,
		co_organizacao_n2 as codigo_organizacao_2,
		ds_organizacao_n2 as descricao_organizacao_2,
		co_organizacao_n3 as codigo_organizacao_3,
		ds_organizacao_n3 as descricao_organizacao_3,
		me_lanc as mes_lancamento,
		an_lanc as ano_lancamento,
		co_esfera_orcamentaria as codigo_esfera_orcamentaria,
		ds_esfera_orcamentaria as descricao_esfera_orcamentaria,
		co_modalidade_aplicacao as codigo_modalidade_aplicacao,
		ds_modalidade_aplicacao as descricao_modalidade_aplicacao,
		co_resultado_eof as codigo_resultado_eof,
		ds_resultado_eof as descricao_resultado_eof,
		va_custo_transferencias as valor_custo_de_transferencias
	from {{source('custos_stn_fonte', 'transferencias')}}
	where an_lanc < 2017
)

select
	*,
	concat(mes_lancamento, ano_lancamento)::integer as mes_ano_lancamento
from transferencias
