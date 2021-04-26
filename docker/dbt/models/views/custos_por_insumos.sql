{{
  config(
    materialized = 'table'
  )
}}

select  
	custos_stn_por_insumos.id,
	custos_stn_por_insumos.organizacao, 
	custos_stn_por_insumos.descricao_conta_contabil as itens_de_custo,
	custos_stn_por_insumos.valor_custo,
	custos_stn_por_insumos.mes_lancamento,
	custos_stn_por_insumos.ano_lancamento,
	custos_stn_por_insumos.mes_ano_lancamento,
	sum(custos_stn_por_insumos.valor_custo) as valor_total,
	min(custos_stn_por_insumos.valor_custo) as valor_minimo,
	max(custos_stn_por_insumos.valor_custo) as valor_maximo,
	calendario.id as calendario_id,
	calendario.dia_do_trimestre,
	calendario.semana_do_mes,
	calendario.semana_do_ano,
	calendario.mes_atual|| '-' || calendario.mes_nome as mes_atual,
	calendario.trimestre_nome,
	calendario.ano_atual,
	calendario.primeiro_dia_da_semana,
	calendario.ultimo_dia_da_semana,
	calendario.ultimo_dia_do_mes,
	calendario.primeiro_dia_do_trimestre,
	calendario.ultimo_dia_do_trimestre
from (
	(
		select 
			demais_custos.demais_custos_id as id,
			demais_custos.descricao_siorg_n05 as organizacao, -- (organizacao)
			'Demais Custos' as descricao_conta_contabil, --(item de custo)
			demais_custos.valor_custo,
			demais_custos.mes_referencia as mes_lancamento,
			demais_custos.ano_referencia as ano_lancamento,
			demais_custos.mes_ano_referencia as mes_ano_lancamento
		from {{ ref('demais_custos') }} demais_custos
		union
		select 
			demais_custos.demais_custos_id as id,
			demais_custos.descricao_siorg_n06 as organizacao, -- (organizacao)
			'Demais Custos' as descricao_conta_contabil, --(item de custo)
			demais_custos.valor_custo,
			demais_custos.mes_referencia as mes_lancamento,
			demais_custos.ano_referencia as ano_lancamento,
			demais_custos.mes_ano_referencia as mes_ano_lancamento
		from {{ ref('demais_custos') }} demais_custos
	)
	
	union all
	
	(
		select
			depreciacao.depreciacao_id as id,
			depreciacao.descricao_organizacao_1 as organizacao,
			depreciacao.descricao_conta_contabil, --(item de custo)
			depreciacao.valor_custo_depreciacao  as valor_custo,
			depreciacao.mes_lancamento,
			depreciacao.ano_lancamento,
			depreciacao.mes_ano_lancamento
		from {{ ref('depreciacao') }} depreciacao
		union
		select
			depreciacao.depreciacao_id as id,
			depreciacao.descricao_organizacao_2 as organizacao, --(organizacao)
			depreciacao.descricao_conta_contabil, --(item de custo)
			depreciacao.valor_custo_depreciacao  as valor_custo,
			depreciacao.mes_lancamento,
			depreciacao.ano_lancamento,
			depreciacao.mes_ano_lancamento
		from {{ ref('depreciacao') }} depreciacao
	)
	
	union all
	(
		select
			pensionistas.pensionistas_id as id,
			pensionistas.descricao_organizacao_1 as organizacao,
			'Pessoal Inativo / Pensionistas' as descricao_conta_contabil, --(item de custo)
			pensionistas.valor_custo_pensionistas  as valor_custo,
			pensionistas.mes_lancamento,
			pensionistas.ano_lancamento,
			pensionistas.mes_ano_lancamento
		from {{ ref('pensionistas') }} pensionistas
		union
		select
			pensionistas.pensionistas_id as id,
			pensionistas.descricao_organizacao_2 as organizacao,
			'Pessoal Inativo / Pensionistas' as descricao_conta_contabil, --(item de custo)
			pensionistas.valor_custo_pensionistas  as valor_custo,
			pensionistas.mes_lancamento,
			pensionistas.ano_lancamento,
			pensionistas.mes_ano_lancamento
		from {{ ref('pensionistas') }} pensionistas
	)
	
	
	union all
	(
		select 
			pessoal_ativo.pessoal_ativo_id as id,
			pessoal_ativo.descricao_organizacao_1 as organizacao, --(organizacao)
			'Pessoal Ativo' as descricao_conta_contabil,
			pessoal_ativo.valor_custo_pessoal_ativo as valor_custo,
			pessoal_ativo.mes_lancamento,
			pessoal_ativo.ano_lancamento,
			pessoal_ativo.mes_ano_lancamento
		from {{ ref('pessoal_ativo') }} pessoal_ativo
		union 
		select 
			pessoal_ativo.pessoal_ativo_id as id,
			pessoal_ativo.descricao_organizacao_2 as organizacao, --(organizacao)
			'Pessoal Ativo' as descricao_conta_contabil,
			pessoal_ativo.valor_custo_pessoal_ativo as valor_custo,
			pessoal_ativo.mes_lancamento,
			pessoal_ativo.ano_lancamento,
			pessoal_ativo.mes_ano_lancamento
		from {{ ref('pessoal_ativo') }} pessoal_ativo
	)
	union all
	( 
	select
		pessoal_inativo.pessoal_inativo_id as id,
		pessoal_inativo.descricao_organizacao_1 as organizacao,
		'Pessoal Inativo / Pensionistas' as descricao_conta_contabil, --(item de custo)
		pessoal_inativo.valor_custo_de_pessoal_inativo as valor_custo,
		pessoal_inativo.mes_lancamento,
		pessoal_inativo.ano_lancamento,
		pessoal_inativo.mes_ano_lancamento
	from {{ ref('pessoal_inativo') }} pessoal_inativo
	union
	select
		pessoal_inativo.pessoal_inativo_id as id,
		pessoal_inativo.descricao_organizacao_2 as organizacao,
		'Pessoal Inativo / Pensionistas' as descricao_conta_contabil, --(item de custo)
		pessoal_inativo.valor_custo_de_pessoal_inativo as valor_custo,
		pessoal_inativo.mes_lancamento,
		pessoal_inativo.ano_lancamento,
		pessoal_inativo.mes_ano_lancamento
	from {{ ref('pessoal_inativo') }} pessoal_inativo
	)
	union all
	(
		select
			transferencias.transferencias_id as id,
			transferencias.descricao_organizacao_1 as organizacao,
			'Transferencias' as descricao_conta_contabil,
			transferencias.valor_custo_de_transferencias,
			transferencias.mes_lancamento,
			transferencias.ano_lancamento,
			transferencias.mes_ano_lancamento
		from {{ ref('transferencias') }} transferencias
		union
		select
			transferencias.transferencias_id as id,
			transferencias.descricao_organizacao_2 as organizacao,
			'Transferencias' as descricao_conta_contabil,
			transferencias.valor_custo_de_transferencias,
			transferencias.mes_lancamento,
			transferencias.ano_lancamento,
			transferencias.mes_ano_lancamento
		from {{ ref('transferencias') }} transferencias
	)
) as custos_stn_por_insumos 
inner join {{ ref('dim_calendario') }} calendario on calendario.mes_ano = custos_stn_por_insumos.mes_ano_lancamento
                                                      and calendario.eh_ultimo_dia is true
 group by 1,2,3,4,5,6,7,11,12,13,14,15,16,17,18,19,20,21,22