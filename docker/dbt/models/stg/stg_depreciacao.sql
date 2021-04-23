select
  {{ dbt_utils.surrogate_key(['co_natureza_juridica','ds_natureza_juridica', 'co_organizacao_n1', 'ds_organizacao_n1','co_organizacao_n2','ds_organizacao_n2','co_organizacao_n3','ds_organizacao_n3','me_lanc','an_lanc','va_custo_depreciacao','no_conta_contabil']) }} as id,
	co_natureza_juridica as codigo_natureza_juridica,
	ds_natureza_juridica as descricao_natureza_juridica,
  co_organizacao_n1 as codigo_organizacao_1,
  ds_organizacao_n1 as descricao_organizacao_1,
  co_organizacao_n2 as codigo_organizacao_2,
  ds_organizacao_n2 as descricao_organizacao_2,
  co_organizacao_n3 as codigo_organizacao_3,
  ds_organizacao_n3 as descricao_organizacao_3,
	an_lanc as ano_lancamento,
  me_lanc as mes_lancamento,
  id_conta_contabil as codigo_conta_contabil,
  no_conta_contabil as descricao_conta_contabil,
  va_custo_depreciacao as valor_custo_depreciacao
from {{source('custos_stn_fonte', 'depreciacao')}}