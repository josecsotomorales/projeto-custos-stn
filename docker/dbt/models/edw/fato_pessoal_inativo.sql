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
  valor_custo_de_pessoal_inativo,
  ano_lancamento,
  mes_lancamento,
  mes_ano_lancamento
from {{ ref('stg_pessoal_inativo') }} as pessoal_inativo