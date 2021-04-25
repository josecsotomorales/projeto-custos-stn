select
	distinct
	codigo_natureza_juridica,
	descricao_natureza_juridica,
	sum(valor_custo_pessoal_ativo) as valor_custo_total,
	min(valor_custo_pessoal_ativo) as valor_custo_minimo,
	max(valor_custo_pessoal_ativo) as valor_custo_maximo,
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
	calendario.ultimo_dia_do_trimestre
from {{ ref('dim_pessoal_ativo') }} dim_pessoal_ativo
inner join {{ ref('fato_pessoal_ativo') }} fato_pessoal_ativo on dim_pessoal_ativo.id = fato_pessoal_ativo.id
inner join {{ ref('dim_calendario') }} calendario on calendario.mes_ano = fato_pessoal_ativo.mes_ano_lancamento 
														and calendario.eh_ultimo_dia is true
group by 1,2,6,7,8,9,10,11,12,13,14,15,16,17
order by 2 asc,3 desc, 7 asc