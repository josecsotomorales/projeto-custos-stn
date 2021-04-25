select
	fato_pessoal_inativo.id as pessoal_inativo_id,
  fato_pessoal_inativo.codigo_natureza_juridica,
  fato_pessoal_inativo.codigo_organizacao_1,
  fato_pessoal_inativo.codigo_organizacao_2,
  fato_pessoal_inativo.codigo_organizacao_3,
  fato_pessoal_inativo.valor_custo_de_pessoal_inativo,
	dim_pessoal_inativo.descricao_natureza_juridica,
	dim_pessoal_inativo.descricao_organizacao_1,
	dim_pessoal_inativo.descricao_organizacao_2,
	dim_pessoal_inativo.descricao_organizacao_3,
  fato_pessoal_inativo.ano_lancamento,
  fato_pessoal_inativo.mes_lancamento,
  fato_pessoal_inativo.mes_ano_lancamento
from {{ ref('dim_pessoal_inativo') }} dim_pessoal_inativo
inner join {{ ref('fato_pessoal_inativo') }} fato_pessoal_inativo on dim_pessoal_inativo.id = fato_pessoal_inativo.id