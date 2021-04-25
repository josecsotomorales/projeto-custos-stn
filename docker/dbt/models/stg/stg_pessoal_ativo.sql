with pessoal_ativo as(
	select
		{{ dbt_utils.surrogate_key(['me_lanc','an_lanc', 'in_faixa_etaria','in_sexo','in_forca_trabalho','va_custo_de_pessoal']) }} as id,
		co_natureza_juridica as codigo_natureza_juridica,
		ds_natureza_juridica as descricao_natureza_juridica,
		co_organizacao_n1 as codigo_organizacao_1,
		ds_organizacao_n1 as descricao_organizacao_1,
		co_organizacao_n2 as codigo_organizacao_2,
		ds_organizacao_n2 as descricao_organizacao_2,
		co_organizacao_n3 as codigo_organizacao_3,
		ds_organizacao_n3 as descricao_organizacao_3,
		co_organizacao_n4 as codigo_organizacao_4,
		ds_organizacao_n4 as descricao_organizacao_4,
		co_organizacao_n5 as codigo_organizacao_5,
		ds_organizacao_n5 as descricao_organizacao_5,
		co_organizacao_n6 as codigo_organizacao_6,
		ds_organizacao_n6 as descricao_organizacao_6,
		me_lanc as mes_lancamento,
		an_lanc as ano_lancamento,
		in_area_atuacao as codigo_area_atuacao,
		ds_area_atuacao as descricao_area_atuacao,
		in_escolaridade as codigo_escolaridade,
		ds_escolaridade as descricao_escolaridade,
		in_faixa_etaria as codigo_faixa_etaria,
		ds_faixa_etaria as descricao_faixa_etaria,
		in_sexo as codigo_sexo,
		in_forca_trabalho as codigo_forca_trabalho,
		va_custo_de_pessoal as valor_custo_pessoal_ativo
	from {{source('custos_stn_fonte', 'pessoal_ativo')}}
) 

select
	*,
	concat(mes_lancamento, ano_lancamento)::integer as mes_ano_lancamento
from pessoal_ativo
where ano_lancamento < 2017