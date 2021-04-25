with demais_custos as (
	select
		distinct
  	{{ dbt_utils.surrogate_key(['id_in_resultado_eof','co_siorg_n05','id_elemento_despesa_nade','id_subitem_nade','co_natureza_despesa_deta','va_custo','co_siorg_n06','co_situacao_icc','no_situacao_icc','id_natureza_juridica_siorg','id_esfera_orcamentaria','me_referencia','an_referencia']) }} as id,
		co_siorg_n05 as codigo_sirog_n05,
		ds_siorg_n05 as descricao_sirog_n05,
		co_siorg_n06 as codigo_siorg_n06,
		ds_siorg_n06 as descricao_siorg_n06,
		co_siorg_n07  as codigo_siorg_n07,
		ds_siorg_n07 as descricao_sirog_n07,
		me_referencia as mes_referencia,
		an_referencia as ano_referencia,
		sg_mes_completo as mes_ano,
		case when me_emissao = '' then
 				null
 			else (me_emissao::double precision)::integer
 		end as mes_emissao,
 		case when an_emissao = '' then
 				null
 			else (an_emissao::double precision)::integer
		end as ano_emissao,
		co_situacao_icc as codigo_situacao_icc,
		no_situacao_icc as descricao_situacao_icc,
		id_natureza_juridica_siorg as id_natureza_juridica_siorg,
		ds_natureza_juridica_siorg as descricao_natureza_juridica_siorg,
		id_categoria_economica_nade as id_categoria_economica_nade,
		id_grupo_despesa_nade as id_grupo_despesa_nade,
		id_moap_nade as id_moap_nade,
		id_elemento_despesa_nade as id_elemento_despesa_nade,
		id_subitem_nade as id_subitem_nade,
		co_natureza_despesa_deta as codigo_natureza_despesa_deta,
		no_natureza_despesa_deta as descricao_natureza_despesa_deta,
		id_esfera_orcamentaria as id_esfera_orcamentaria,
		no_esfera_orcamentaria as descricao_esfera_orcamentaria,
		id_in_resultado_eof as id_in_resultado_eof,
		no_in_resultado_eof as descricao_in_resultado_eof,
		va_custo as valor_custo
	from {{source('custos_stn_fonte', 'demais_custos')}}
	where an_referencia < 2017
)

select
	*,
	case when concat(mes_referencia, ano_referencia) = '' then 
			null
		else concat(mes_referencia, ano_referencia)::integer 
	end as mes_ano_referencia,
	case when concat(mes_emissao,ano_emissao) = '' then
			null
		else concat(mes_emissao,ano_emissao)::integer 
	end as mes_ano_emissao
from demais_custos
