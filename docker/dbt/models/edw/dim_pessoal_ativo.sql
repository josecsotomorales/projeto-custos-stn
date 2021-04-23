{{
  config(
    unique_key = 'id'
  )
}}

select
	id,
	descricao_natureza_juridica,
	descricao_organizacao_1,
	descricao_organizacao_2,
	descricao_organizacao_3,
	descricao_organizacao_4,
	descricao_organizacao_5,
	descricao_organizacao_6,
	descricao_area_atuacao,
	descricao_escolaridade,
	descricao_faixa_etaria,
	codigo_sexo
from {{ ref('stg_pessoal_ativo') }} as depreciacao