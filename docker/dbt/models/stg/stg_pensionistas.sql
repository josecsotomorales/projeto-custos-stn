with pensionistas as (
	select
		distinct
		{{ dbt_utils.surrogate_key(['co_organizacao_n3','me_lanc', 'va_custo_pensionistas']) }} as id,
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
		va_custo_pensionistas as valor_custo_pensionistas
	from {{source('custos_stn_fonte', 'pensionistas')}}
	where an_lanc < 2017
) 

select
	*,
	concat(mes_lancamento, ano_lancamento)::integer as mes_ano_lancamento
from pensionistas
