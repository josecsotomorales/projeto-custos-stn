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
	descricao_organizacao_3
from {{ ref('stg_pensionistas') }} as depreciacao