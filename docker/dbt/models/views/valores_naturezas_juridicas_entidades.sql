
select  
	codigo_organizacao,
	nome_organizacao,
	mes_lancamento,
	ano_lancamento,
	calendario.id,
	calendario.dia_do_trimestre,
	calendario.semana_do_mes,
	calendario.semana_do_ano,
	calendario.mes_nome,
	calendario.trimestre_nome,
	calendario.ano_atual,
	calendario.primeiro_dia_da_semana,
	calendario.ultimo_dia_da_semana,
	calendario.ultimo_dia_do_mes,
	calendario.primeiro_dia_do_trimestre,
	calendario.ultimo_dia_do_trimestre,
	sum(valor_custo),
	min(valor_custo),
	max(valor_custo)
from (
 select 
 	codigo_siorg_n05 as codigo_organizacao,
	descricao_siorg_n05 as nome_organizacao,
	mes_referencia as mes_lancamento,
	ano_referencia as ano_lancamento,
	mes_ano_referencia as mes_ano_lancamento,
	valor_custo
 from {{ ref('demais_custos') }} demais_custos
 
 union all
 
 select
  codigo_organizacao_1 as codigo_organizacao,
  descricao_organizacao_1 as nome_organizacao,
	mes_lancamento,
	ano_lancamento,
	mes_ano_lancamento,
	valor_custo_depreciacao as valor_custo
 from {{ ref('depreciacao') }} depreciacao
 
 union all
 
 select
  codigo_organizacao_1 as codigo_organizacao,
  descricao_organizacao_1 as nome_organizacao,
	mes_lancamento,
	ano_lancamento,
	mes_ano_lancamento,
	valor_custo_pensionistas as valor_custo
 from {{ ref('pensionistas') }} pensionistas
 
 union all
 
 select 
  codigo_organizacao_1 as codigo_organizacao,
  descricao_organizacao_1 as nome_organizacao,
	mes_lancamento,
	ano_lancamento,
	mes_ano_lancamento,
	valor_custo_pessoal_ativo as valor_custo
 from {{ ref('pessoal_ativo') }} pessoal_ativo
 
 union all
 
 select
  codigo_organizacao_1 as codigo_organizacao,
  descricao_organizacao_1 as nome_organizacao,
	mes_lancamento,
	ano_lancamento,
	mes_ano_lancamento,
	valor_custo_de_pessoal_inativo as valor_custo
 from {{ ref('pessoal_inativo') }} pessoal_inativo
 
 union all
 
 select
  codigo_organizacao_1 as codigo_organizacao,
  descricao_organizacao_1 as nome_organizacao,
	mes_lancamento,
	ano_lancamento,
	mes_ano_lancamento,
	valor_custo_de_transferencias as valor_custo
 from {{ ref('transferencias') }} transferencias
 ) as uniao 
 inner join {{ ref('dim_calendario') }} calendario on calendario.mes_ano = uniao.mes_ano_lancamento
                                                      and calendario.eh_ultimo_dia is true
 group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16