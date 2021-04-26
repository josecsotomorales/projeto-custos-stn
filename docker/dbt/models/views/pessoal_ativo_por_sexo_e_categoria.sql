{{
  config(
    materialized = 'table'
  )
}}

select
  codigo_organizacao_1 as codigo_organizacao,
  descricao_organizacao_1 as nome_organizacao,
  descricao_organizacao_2 as subnome_organizacao,
  descricao_escolaridade,
  descricao_faixa_etaria,
  codigo_forca_trabalho,
  codigo_sexo,
  mes_ano_lancamento,
  valor_custo_pessoal_ativo,
  calendario.id as calendario_id,
	calendario.dia_do_trimestre,
	calendario.semana_do_mes,
	calendario.semana_do_ano,
	calendario.mes_atual|| '-' || calendario.mes_nome as mes_atual,
  calendario.mes_ano,
	calendario.trimestre_nome,
	calendario.ano_atual,
	calendario.primeiro_dia_da_semana,
	calendario.ultimo_dia_da_semana,
	calendario.ultimo_dia_do_mes,
	calendario.primeiro_dia_do_trimestre,
	calendario.ultimo_dia_do_trimestre
from {{ ref('pessoal_ativo') }} pessoal_ativo
inner join {{ ref('dim_calendario') }} calendario on calendario.mes_ano = pessoal_ativo.mes_ano_lancamento
                                                      and calendario.eh_ultimo_dia is true