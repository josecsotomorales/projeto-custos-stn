{{
  config(
    unique_key = 'id'
  )
}}

select
	id,
	codigo_natureza_juridica,
	codigo_organizacao_1,
	codigo_organizacao_2,
	codigo_organizacao_3,
	codigo_organizacao_4,
	codigo_organizacao_5,
	codigo_organizacao_6,
	codigo_area_atuacao,
	codigo_escolaridade,
	codigo_faixa_etaria,
	codigo_forca_trabalho,
	valor_custo_pessoal_ativo,
	ano_lancamento,
	mes_lancamento,
	mes_ano_lancamento
from {{ ref('stg_pessoal_ativo') }} as pessoal_ativo