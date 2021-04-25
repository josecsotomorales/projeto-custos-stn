select
  codigo_organizacao_1 as codigo_organizacao,
  descricao_organizacao_1 as nome_organizacao,
  descricao_escolaridade,
  descricao_faixa_etaria,
  codigo_sexo,
  mes_ano_lancamento,
  valor_custo_pessoal_ativo,
  sum(valor_custo_pessoal_ativo)
from {{ ref('pessoal_ativo') }} pessoal_ativo
group by 1,2,3,4,5,6,7