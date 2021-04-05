# Projeto Custos Secretaria do Tesouro Nacional (STN)

Projeto final da pós-graduação em Análise de Dados com BI e Big Data da Universidade Católica de Brasília

## Ferramentas Utilizadas no projeto

  ### Agrupamento de informações e pré-documentaçáo
   - [Notion](https://www.notion.so/) 

  ### Consultar a API e Analisar os dados
   - [Insomnia](https://insomnia.rest/)

  ### DataWarehouse
   - [PostgreSQL](https://www.postgresql.org/)  

  ### DataLake
   - [Amazon S3](https://aws.amazon.com/pt/s3/)  

  ### Análise dos dados no DataLake
   - [Spark](http://spark.apache.org/)
   - [Jupyther Notebook](https://jupyter.org/)

  ### Transformaçāo dos dados *T do ELT*
   - [Data Build Tool](https://www.getdbt.com/)

  ### Conteinerização das ferramentas
   - [Docker](https://www.docker.com/)


## API Dados Abertos de Custos da Secretaria do Tesouro Nacional

   O Tesouro Nacional disponibilizou uma Application Programming Interface (API) de dados abertos para atender à demanda por dados de custos do Governo Federal. Por meio dessa ferramenta será possível ao usuário obter desde pequenas frações até grandes volumes de dados de custos advindos do Sistema de Informações de Custos do Governo Federal - SIC.

| Endpoints | Link API |
| ------ | ------ |
| Pessoal Ativo | [http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_ativo]() |
| Depreciaçāo | [http://apidatalake.tesouro.gov.br/ords/custos/tt/depreciacao]() |
| Transferência | [http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_inativo]() |
| Pessoal Inativo | [http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_inativo]() |
| Pensionista | [http://apidatalake.tesouro.gov.br/ords/custos/tt/pensionistas]()|
| Demais Custos | [http://apidatalake.tesouro.gov.br/ords/custos/tt/demais?offset=2363900]() |
 
### Estrutura do retorno da API `JSON`
```json
{
"items": [
        {
           ...,
           *chave:valor*,
           *chave:valor*,
           *chave:valor*,
           *chave:valor*,
           ...
        },
       ...
    ],
    "hasMore": true,
    "limit": 250,
    "offset": 0,
    "count": 250,
    "links": [
        {
            "rel": "self",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/nome_endpoint"
        },
        {
            "rel": "describedby",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/metadata-catalog/tt/item"
        },
        {
            "rel": "first",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/nome_endpoint"
        },
        {
            "rel": "next",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/nome_endpoint?offset=250"
        }
    ]
}
   
```

## Modelagem Pessoal Ativo

### Último offset da página `JSON`
```json
   {
     ...
  "hasMore": false,
  "limit": 250,
  "offset": 6598750,
  "count": 26,
  "links": [
    {
      "rel": "self",
      "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_ativo"
    },
    {
      "rel": "describedby",
      "href": "http://apidatalake.tesouro.gov.br/ords/custos/metadata-catalog/tt/item"
    },
    {
      "rel": "first",
      "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_ativo"
    },
    {
      "rel": "prev",
      "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_ativo?offset=6598500"
    }
  ]
   }
```

### Amostra de um resultado de items `JSON`
```json
{
  "co_natureza_juridica": 3,
  "ds_natureza_juridica": "ADMINISTRACAO DIRETA",
  "co_organizacao_n1": "235876",
  "ds_organizacao_n1": "MINISTERIO DA ECONOMIA",
  "co_organizacao_n2": "003236",
  "ds_organizacao_n2": "SECRETARIA-EXECUTIVA",
  "co_organizacao_n3": "237327",
  "ds_organizacao_n3": "SECRETARIA DE GESTAO CORPORATIVA",
  "co_organizacao_n4": "237352",
  "ds_organizacao_n4": "DIRETORIA DE ADMINISTRACAO E LOGISTICA",
  "co_organizacao_n5": "002734",
  "ds_organizacao_n5": "COORDENACAO-GERAL DE TERCEIRIZACAO, TRANSPORTE, INFORMACAO E PATRIMONIO",
  "co_organizacao_n6": "220996",
  "ds_organizacao_n6": "COORDENACAO DE GESTAO DE TERCEIRIZACAO E TRANSPORTE",
  "an_lanc": 2021,
  "me_lanc": 1,
  "in_area_atuacao": 1,
  "ds_area_atuacao": "SUPORTE",
  "in_escolaridade": "6",
  "ds_escolaridade": "1O GR COMPL - 8A SER COMPL",
  "in_faixa_etaria": "10",
  "ds_faixa_etaria": "56 A 60 ANOS",
  "in_sexo": "M",
  "in_forca_trabalho": 2,
  "va_custo_de_pessoal": 12924.17
}
```
### [Metadados](https://www.tesourotransparente.gov.br/ckan/dataset/a57fe0f5-08b2-4a54-9acb-a0fddd8350ac/resource/b092c317-856b-41dc-8cca-082960e948a7/download/Pessoal-Ativo.pdf)
| Atributos | Descrição |
| ------ | ------ |
|co_organização_n1 | Código numérico correspondente a Unidade organizacional a nível dos Ministérios e da AGU,conforme codificação SIORG.|
|ds_organização_n1 | Descrição da Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|co_organização_n2 | Código numérico correspondente a Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n2 | Descrição da Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n3 | Código numérico correspondente a Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n3 | Descrição da Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n4 | Código numérico correspondente a Unidade organizacional a três níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n4 | Descrição da Unidade organizacional a três níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n5 | Código numérico correspondente a Unidade organizacional a quatro níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n5 | Descrição da Unidade organizacional a quatro níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n6 | Código numérico correspondente a Unidade organizacional a cinco níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n6 | Descrição da Unidade organizacional a cinco níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_natureza_juridica | Código numérico que corresponde a natureza jurídica do Órgão|
|ds_natureza_juridica | Descrição da natureza jurídica: Empresa Pública; Fundação Pública; Administração Direta; Autarquia; ou Sociedade de Economia Mista |
|in_area_atuacao | Código numérico que corresponde a área de atuação da unidade|
|ds_area_atuacao | Descrição da área de atuação da unidade: Finalísta ou Suporte.|
|in_escolaridade | Código numérico que representa a escolaridade do servidor|
|ds_escolaridade | Descrição da escolaridade do servidor|
|in_faixa_etaria | Código que representa a faixa etária do servidor|
|ds_faixa_etaria | Descrição da faixa etária do servidor in_sexo Letra de que identifica o sexo do servidor: M ou F|
|an_lanc | Número corresponde ao ano do lançamento contábil (aaaa).|
|me_lanc | Número corresponde ao mês do lançamento contábil (mm)|
|in_forca_trabalho | Métrica física da quantidade de servidor|
|va_custo_de_pessoal | Métrica financeira do custo de pessoal ativo|


### Modelagem da Stage Area `SQL` 
```sql
select
    -- definir-chave-primaria,
  co_natureza_juridica as codigo_natureza_juridica,
  ds_natureza_juridica as descricao_natureza_juridica,
  co_organizacao_n1 as codigo_organizacao_1,
  ds_organizacao_n1 as descricao_organizacao_1,
  co_organizacao_n2 as codigo_organizacao_2,
  ds_organizacao_n2 as descricao_organizacao_2,
  co_organizacao_n3 as codigo_organizacao_3,
  ds_organizacao_n3 as descricao_organizacao_3,
  co_organizacao_n4 as codigo_organizacao_4,
  ds_organizacao_n4 as descricao_organizacao_4,
  co_organizacao_n5 as codigo_organizacao_5,
  ds_organizacao_n5 as descricao_organizacao_5,
  co_organizacao_n6 as codigo_organizacao_6,
  ds_organizacao_n6 as descricao_organizacao_6,
  an_lanc as ano_lancamento,
  me_lanc as mes_lancamento,
  in_area_atuacao as codigo_area_atuacao,
  ds_area_atuacao as descricao_area_atuacao,
  in_escolaridade as codigo_escolaridade,
  ds_escolaridade as descricao_escolaridade,
  in_faixa_etaria as codigo_faixa_etaria,
  ds_faixa_etaria as descricao_faixa_etaria,
  in_sexo as codigo_sexo,
  in_forca_trabalho as codigo_forca_trabalho,
  va_custo_de_pessoal as valor_custo_pessoal
from source_pessoal_ativo
```

### Modelagem Dimensāo
```sql
select
  -- definir-chave-primaria,
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
from stg_pessoal_ativo
```

### Modelagem Fato
```sql
select
  -- definir-chave-primaria,
  codigo_natureza_juridica,
  codigo_organizacao_1,
  codigo_organizacao_2,
  codigo_organizacao_3,
  codigo_organizacao_4,
  codigo_organizacao_5,
  codigo_organizacao_6,
  ano_lancamento,
  mes_lancamento,
  codigo_area_atuacao,
  codigo_escolaridade,
  codigo_faixa_etaria,
  codigo_forca_trabalho,
  valor_custo_pessoal
from stg_pessoal_ativo
```

## Modelagem Depreciação

### Último offset da página `JSON`
```json
   {
        ...
        "hasMore": false,
        "limit": 250,
        "offset": 123999,
        "count": 144,
        links": [
          {
            "rel": "self",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/depreciacao"
          },
          {
            "rel": "describedby",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/metadata-catalog/tt/item"
          },
          {
            "rel": "first",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/depreciacao"
          },
          {
            "rel": "prev",
            "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/depreciacao?offset=123749"
          }
        ]
    }
```

### Amostra de um resultado de items `JSON`
```json
{
  "co_natureza_juridica": 1,
  "ds_natureza_juridica": "EMPRESA PUBLICA",
  "co_organizacao_n1": "000244",
  "ds_organizacao_n1": "MINISTERIO DA EDUCACAO",
  "co_organizacao_n2": "117267",
  "ds_organizacao_n2": "EMPRESA BRASILEIRA DE SERVICOS HOSPITALARES",
  "co_organizacao_n3": "222400",
  "ds_organizacao_n3": "EBSERH - FILIAL HOSPITAL UNIVERSITARIO MONSENHOR JOAO BATISTA DE CARVALHO DALTRO",
  "an_lanc": 2020,
  "me_lanc": 9,
  "id_conta_contabil": 333110100,
  "no_conta_contabil": "DEPRECIACAO DE BENS MOVEIS",
  "va_custo_depreciacao": 72237.88
}
```
### [Metadados](https://www.tesourotransparente.gov.br/ckan/dataset/f6e65eb2-00b4-4a1d-9a81-6fe694210fea/resource/a544e031-f772-4491-ba20-b528783a01a8/download/Depreciacao.pdf)
| Atributos | Descrição |
| ------ | ------ |
|co_organização_n1 | Código numérico correspondente a Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|ds_organização_n1 | Descrição da Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|co_organização_n2 | Código numérico correspondente a Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n2 | Descrição da Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n3 | Código numérico correspondente a Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n3 | Descrição da Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_natureza_juridica | Código numérico correspondente a natureza jurídica do Órgão|
|ds_natureza_juridica | Descrição da natureza jurídica: Empresa Pública; Fundação Pública; Administração Direta; Autarquia; ou Sociedade de Economia Mista|
|id_conta_contábil | Código numérico correspondente a conta contábil do custo|
|no_conta_contábil | Descrição da conta contábil do custo|
|an_lanc | Número corresponde ao ano do lançamento contábil (aaaa).|
|me_lanc | Número corresponde ao mês do lançamento contábil (mm)|
|va_custo_depreciacao | Métrica financeira do custo com deprecição.|


### Modelagem da Stage Area `SQL` 
```sql
select
    -- definir-chave-primaria,
  co_natureza_juridica as codigo_natureza_juridica,
  ds_natureza_juridica as descricao_natureza_juridica,
    co_organizacao_n1 as codigo_organizacao_1
    ds_organizacao_n1 as descricao_organizacao_1,
    co_organizacao_n2 as codigo_organizacao_2,
    ds_organizacao_n2 as descricao_organizacao_2,
    co_organizacao_n3 as codigo_organizacao_3,
    ds_organizacao_n3 as descricao_organizacao_3,
  an_lanc as ano_lancamento,
    me_lanc as mes_lancamento,
    id_conta_contabil as codigo_conta_contabil,
    no_conta_contabil as descricao_conta_contabil,
    va_custo_depreciacao as valor_custo_depreciacao
from source_depreciacao
```

### Modelagem Dimensāo
```sql
select
    -- definir-chave-primaria,
    descricao_natureza_juridica,
    descricao_organizacao_1,
    descricao_organizacao_2,
    descricao_organizacao_3
    descricao_conta_contabil
from stg_depreciacao
```

### Modelagem Fato
```sql
select
  -- definir-chave-primaria,
    descricao_natureza_juridica,
    descricao_organizacao_1,
    descricao_organizacao_2,
    descricao_organizacao_3
    descricao_conta_contabil
from stg_depreciacao
```


## Modelagem Transferência

### Último offset da página `JSON`
```json
   {
        ...
        "hasMore": false,
      "limit": 250,
      "offset": 25325,
      "count": 103,
      "links": [
        {
          "rel": "self",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/transferencias"
        },
        {
          "rel": "describedby",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/metadata-catalog/tt/item"
        },
        {
          "rel": "first",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/transferencias"
        },
        {
          "rel": "prev",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/transferencias?offset=25075"
        }
      ]
    }
```

### Amostra de um resultado de items `JSON`
```json
{
  "co_natureza_juridica": 4,
  "ds_natureza_juridica": "AUTARQUIA",
  "co_organizacao_n1": "000304",
  "ds_organizacao_n1": "MINISTERIO DA SAUDE",
  "co_organizacao_n2": "036687",
  "ds_organizacao_n2": "AGENCIA NACIONAL DE VIGILANCIA SANITARIA",
  "co_organizacao_n3": "-9",
  "ds_organizacao_n3": "NAO SE APLICA",
  "an_lanc": 2019,
  "me_lanc": 5,
  "co_esfera_orcamentaria": 2,
  "ds_esfera_orcamentaria": "ORCAMENTO DE SEGURIDADE SOCIAL",
  "co_modalidade_aplicacao": "80",
  "ds_modalidade_aplicacao": "TRANSFERENCIAS AO EXTERIOR",
  "co_resultado_eof": 2,
  "ds_resultado_eof": "PRIMARIO DISCRICIONARIO",
  "va_custo_transferencias": 0
}
```
### [Metadados](https://www.tesourotransparente.gov.br/ckan/dataset/f8f5685a-f336-4070-9782-590a05921712/resource/608ea4cc-2490-49b8-8e7a-b9bd1d224de8/download/Transferencias.pdf)
| Atributos | Descrição |
| ------ | ------ |
|co_organização_n1 | Código numérico correspondente a Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|ds_organização_n1 | Descrição da Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|co_organização_n2 | Código numérico correspondente a Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n2 | Descrição da Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n3 | Código numérico correspondente a Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n3 | Descrição da Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_natureza_juridica | Código numérico correspondente a natureza jurídica do Órgão|
|ds_natureza_juridica | Descrição da natureza jurídica: Empresa Pública; Fundação Pública; Administração Direta; Autarquia; ou Sociedade de Economia Mista|
|co_esfera_orcamentaria | Código numérico que representa a esfera orçamentária do custo|
|ds_esfera_orcamentaria | Descrição da esfera orçamentária (qual orçamento pertence o custo)|
|co_modalidade_aplicacao | Código numérico que representa a classificação da despesa orçamentária por modalidade de aplicação|
|ds_modalidade_aplicacao | Descrição da modalidade de aplicação (forma como os custos foram aplicados - visão orçamentária)|
|co_resultado_eof | Código numérico que representa a classificação da despesa orçamentária por indicador de resultado primário|
|ds_resultado_eof | Descrição da classificação da despesa orçamentária por indicador de resultado primário|
|an_lanc Número | corresponde ao ano do lançamento contábil (aaaa).|
|me_lanc Número | corresponde ao mês do lançamento contábil (mm)|
|va_custo_transferencias | Métrica financeira do custo com transferências.


### Modelagem da Stage Area `SQL` 
```sql
select
    -- definir-chave-primaria,
    co_natureza_juridica as codigo_natureza_juridica,
    ds_natureza_juridica as descricao_natureza_juridica,
    co_organizacao_n1 as codigo_organizacao_1,
    ds_organizacao_n1 as descricao_organizacao_1,
    co_organizacao_n2 as codigo_organizacao_2,
    ds_organizacao_n2 as descricao_organizacao_2,
    co_organizacao_n3 as codigo_organizacao_3,
    ds_organizacao_n3 as descricao_organizacao_3,
    an_lanc as ano_lancamento,
    me_lanc as mes_lancamento,
    co_esfera_orcamentaria as codigo_esfera_orcamentaria,
    ds_esfera_orcamentaria as descricao_esfera_orcamentaria,
    co_modalidade_aplicacao as codigo_modalidade_aplicacao,
    ds_modalidade_aplicacao as descricao_modalidade_aplicacao,
    co_resultado_eof as codigo_resultado_eof,
    ds_resultado_eof as descricao_resultado_eof,
    va_custo_de_pessoal as valor_custo_pessoal
from source_transferencias
```

### Modelagem Dimensāo
```sql
select
    -- definir-chave-primaria,
    descricao_natureza_juridica,
    descricao_organizacao_1,
    descricao_organizacao_2,
    descricao_organizacao_3,
    descricao_esfera_orcamentaria,
    descricao_modalidade_aplicacao,
    descricao_resultado_eof
from stg_transferencias
```

### Modelagem Fato
```sql
select
    -- definir-chave-primaria,
    descricao_natureza_juridica,
    descricao_organizacao_1,
    descricao_organizacao_2,
    descricao_organizacao_3,
    descricao_esfera_orcamentaria,
    descricao_modalidade_aplicacao,
    descricao_resultado_eof
from stg_transferencias
```

## Modelagem Pessoal Inativo

### Último offset da página `JSON`
```json
   {
        ...
        "hasMore": false,
      "limit": 250,
      "offset": 61250,
      "count": 74,
      "links": [
        {
          "rel": "self",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_inativo"
        },
        {
          "rel": "describedby",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/metadata-catalog/tt/item"
        },
        {
          "rel": "first",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_inativo"
        },
        {
          "rel": "prev",
          "href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pessoal_inativo?offset=61000"
        }
      ]
    }
```

### Amostra de um resultado de items `JSON`
```json
{
  "co_natureza_juridica": 4,
  "ds_natureza_juridica": "AUTARQUIA",
  "co_organizacao_n1": "000244",
  "ds_organizacao_n1": "MINISTERIO DA EDUCACAO",
  "co_organizacao_n2": "000448",
  "ds_organizacao_n2": "CENTRO FEDERAL DE EDUCACAO TECNOLOGICA - CELSO SUCKOW DA FONSECA -",
  "co_organizacao_n3": "015584",
  "ds_organizacao_n3": "DIRETORIA DE ENSINO",
  "an_lanc": 2020,
  "me_lanc": 1,
  "va_custo_pessoal_inativo": 16356.47
}
```
### [Metadados](https://www.tesourotransparente.gov.br/ckan/dataset/ff5ef6ca-4767-4a28-a985-2d3e7651d66e/resource/423334c6-28b8-4ccf-b0e9-b0e92e1f5e18/download/Pessoal-Inativo.pdf)
| Atributos | Descrição |
| ------ | ------ |
|co_organização_n1 | Código numérico correspondente a Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|ds_organização_n1 | Descrição da Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|co_organização_n2 | Código numérico correspondente a Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n2 | Descrição da Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n3 | Código numérico correspondente a Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n3 | Descrição da Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_natureza_juridica | Código numérico correspondente a natureza jurídica do Órgão|
|ds_natureza_juridica | Descrição da natureza jurídica: Empresa Pública; Fundação Pública; Administração Direta; Autarquia; ou Sociedade de Economia Mista|
|co_esfera_orcamentaria | Código numérico que representa a esfera orçamentária do custo|
|ds_esfera_orcamentaria | Descrição da esfera orçamentária (qual orçamento pertence o custo)|
|co_modalidade_aplicacao | Código numérico que representa a classificação da despesa orçamentária por modalidade de aplicação|
|ds_modalidade_aplicacao | Descrição da modalidade de aplicação (forma como os custos foram aplicados - visão orçamentária)|
|co_resultado_eof | Código numérico que representa a classificação da despesa orçamentária por indicador de resultado primário|
|ds_resultado_eof | Descrição da classificação da despesa orçamentária por indicador de resultado primário|
|an_lanc Número | corresponde ao ano do lançamento contábil (aaaa).|
|me_lanc Número | corresponde ao mês do lançamento contábil (mm)|
|va_custo_transferencias | Métrica financeira do custo com transferências.|

### Modelagem da Stage Area `SQL` 
```sql
select
    -- definir-chave-primaria,
    co_natureza_juridica as codigo_natureza_juridica,
    ds_natureza_juridica as descricao_natureza_juridica,
    co_organizacao_n1 as codigo_organizacao_1,
    ds_organizacao_n1 as descricao_organizacao_1,
    co_organizacao_n2 as codigo_organizacao_2,
    ds_organizacao_n2 as descricao_organizacao_2,
    co_organizacao_n3 as codigo_organizacao_3,
    ds_organizacao_n3 as descricao_organizacao_3,
    an_lanc as ano_lancamento,
    me_lanc as mes_lancamento,
    va_custo_de_pessoal as valor_custo_pessoal
from source_pessoal_inativo
```

### Modelagem Dimensāo
```sql
select
    -- definir-chave-primaria,
    descricao_natureza_juridica,
    descricao_organizacao_1,
    descricao_organizacao_2,
    descricao_organizacao_3
from stg_pessoal_inativo
```

### Modelagem Fato
```sql
select
    -- definir-chave-primaria,
    codigo_natureza_juridica,
    codigo_organizacao_1,
    codigo_organizacao_2,
    codigo_organizacao_3,
    ano_lancamento,
    mes_lancamento,
    valor_custo_pessoal
from stg_pessoal_inativo
```

## Modelagem Pensionista

### Último offset da página `JSON`
```json
   {
     ...
	"hasMore": false,
	"limit": 250,
	"offset": 20200,
	"count": 233,
	"links": [
		{
			"rel": "self",
			"href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pensionistas"
		},
		{
			"rel": "describedby",
			"href": "http://apidatalake.tesouro.gov.br/ords/custos/metadata-catalog/tt/item"
		},
		{
			"rel": "first",
			"href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pensionistas"
		},
		{
			"rel": "prev",
			"href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/pensionistas?offset=19950"
		}
	]
}
```

### Amostra de um resultado de items `JSON`
```json
{
	"co_natureza_juridica": 4,
	"ds_natureza_juridica": "AUTARQUIA",
	"co_organizacao_n1": "000244",
	"ds_organizacao_n1": "MINISTERIO DA EDUCACAO",
	"co_organizacao_n2": "049103",
	"ds_organizacao_n2": "INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO PARANA",
	"co_organizacao_n3": "-9",
	"ds_organizacao_n3": "NAO SE APLICA",
	"an_lanc": 2018,
	"me_lanc": 5,
	"va_custo_pensionistas": 26490.24
}
```
### [Metadados](https://www.tesourotransparente.gov.br/ckan/dataset/f8f5685a-f336-4070-9782-590a05921712/resource/608ea4cc-2490-49b8-8e7a-b9bd1d224de8/download/Transferencias.pdf)
| Atributos | Descrição |
| ------ | ------ |
|co_organização_n1 | Código numérico correspondente a Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|ds_organização_n1 | Descrição da Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|co_organização_n2 | Código numérico correspondente a Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n2 | Descrição da Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_organização_n3 | Código numérico correspondente a Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_organização_n3 | Descrição da Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_natureza_juridica | Código numérico correspondente a natureza jurídica do Órgão|
|ds_natureza_juridica | Descrição da natureza jurídica: Empresa Pública; Fundação Pública; Administração Direta; Autarquia; ou Sociedade de Economia Mista|
|an_lanc | Número corresponde ao ano do lançamento contábil (aaaa).|
|me_lanc | Número corresponde ao mês do lançamento contábil (mm)|
|va_custo_pensionistas | Métrica financeira do custo com pensionistas.|

### Modelagem da Stage Area `SQL` 
```sql
select
  -- definir-chave-primaria,
	co_natureza_juridica as codigo_natureza_juridica,
  ds_natureza_juridica as descricao_natureza_juridica,
  co_organizacao_n1 as codigo_organizacao_1,
	ds_organizacao_n1 as descricao_organizacao_1,
	co_organizacao_n2 as codigo_organizacao_2,
	ds_organizacao_n2 as descricao_organizacao_2,
	co_organizacao_n3 as codigo_organizacao_3,
	ds_organizacao_n3 as descricao_organizacao_3,
	an_lanc as ano_lancamento,
	me_lanc as mes_lancamento
	va_custo_pensionistas as valor_custo_pensionistas
from source_pensionistas
```

### Modelagem Dimensāo
```sql
select
	-- definir-chave-primaria,
    descricao_natureza_juridica,
	descricao_organizacao_1,
	descricao_organizacao_2,
	descricao_organizacao_3
from stg_pensionistas
```

### Modelagem Fato
```sql
select
	-- definir-chave-primaria,
	codigo_natureza_juridica,
	codigo_organizacao_1,
	codigo_organizacao_2,
	codigo_organizacao_3,
	ano_lancamento,
	mes_lancamento,
	valor_custo_pensionistas
from stg_pensionistas
```

## Modelagem Demais Custos

### Último offset da página `JSON`
```json
   {
        ...
        "hasMore": false,
		"limit": 250,
		"offset": 2363900,
		"count": 96,
		"links": [
			{
				"rel": "self",
				"href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/demais"
			},
			{
				"rel": "describedby",
				"href": "http://apidatalake.tesouro.gov.br/ords/custos/metadata-catalog/tt/item"
			},
			{
				"rel": "first",
				"href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/demais"
			},
			{
				"rel": "prev",
				"href": "http://apidatalake.tesouro.gov.br/ords/custos/tt/demais?offset=2363650"
			}
		]
	}
```

### Amostra de um resultado de items `JSON`
```json
{
	"co_siorg_n05": "002846",
	"ds_siorg_n05": "MINISTERIO DA INFRAESTRUTURA",
	"co_siorg_n06": "054844",
	"ds_siorg_n06": "DEPARTAMENTO NACIONAL DE INFRAESTRUTURA DE TRANSPORTES",
	"co_siorg_n07": "-9",
	"ds_siorg_n07": "NAO SE APLICA",
	"me_referencia": 3,
	"an_referencia": 2021,
	"sg_mes_completo": "MAR/2021",
	"me_emissao": 3,
	"an_emissao": 2021,
	"co_situacao_icc": "DSP001",
	"no_situacao_icc": "AQUISICAO DE SERVICOS - PESSOAS JURIDICAS",
	"id_natureza_juridica_siorg": 4,
	"ds_natureza_juridica_siorg": "AUTARQUIA",
	"id_categoria_economica_nade": "3",
	"id_grupo_despesa_nade": "3",
	"id_moap_nade": "90",
	"id_elemento_despesa_nade": "39",
	"id_subitem_nade": "58",
	"co_natureza_despesa_deta": "33903958",
	"no_natureza_despesa_deta": "SERVICOS DE TELECOMUNICACOES",
	"id_esfera_orcamentaria": 1,
	"no_esfera_orcamentaria": "ORCAMENTO FISCAL",
	"id_in_resultado_eof": "2",
	"no_in_resultado_eof": "PRIMARIO DISCRICIONARIO",
	"va_custo": 478.57
}
```
### [Metadados](https://www.tesourotransparente.gov.br/ckan/dataset/4bfbe254-5eb1-41a2-88d8-8c7d8d46158f/resource/b9e76864-4921-4b0f-be74-bd80e1adcadc/download/Demais-Itens.pdf)
| Atributos | Descrição |
| ------ | ------ |
|co_siorg_n05 | Código numérico correspondente a Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|ds_siorg_n05 | Descrição da Unidade organizacional a nível dos Ministérios e da AGU, conforme codificação SIORG.|
|co_siorg_n06 | Código numérico correspondente a Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_siorg_n06 | Descrição da Unidade organizacional a um nível abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|co_siorg_n07 | Código numérico correspondente a Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|ds_siorg_n07 | Descrição da Unidade organizacional a dois níveis abaixo dos Ministérios e da AGU, conforme codificação SIORG|
|id_natureza_juridica_siorg | Código numérico correspondente a natureza jurídica do Órgão|
|ds_natureza_juridica_siorg | Descrição da natureza jurídica: Empresa Pública; Fundação Pública; Administração Direta; Autarquia; ou Sociedade de Economia Mista|
|me_referencia | Número corresponde ao mês de referência do custo, independente do mês de emissão (mm)|
|an_referencia | Número corresponde ao ano de referência do custo, independente do ano de emissão (aaaa)|
|me_emissao | Número corresponde ao mês de emissão do lançamento contábil (mm).|
|an_emissao | Número corresponde ao ano de emissão do lançamento contábil (aaaa).|
|sg_mes_completo | Código alfanumérico que representa o período completeto da emissão do lançamento contábil, mês e ano (mmm/aaaa)|
|co_situacao_icc | Código alfanumérico que representa a situação contábil do lançamento.|
|no_situacao_icc | Descrição da situação contábil do lançamento.|
|id_categoria_economica_nade | Código numérico que representa a classificação da despesa orçamentária por categoria economica|
|id_grupo_despesa_nade | Código numérico que representa a classificação da despesa orçamentária por grupo da despesa|
|id_moap_nade | Código numérico que representa a classificação da despesa orçamentária por modalidade de aplicação|
|id_elemento_despesa_nade | Código numérico que representa a classificação da despesa orçamentária por elemento|
|id_subitem_nade | Código numérico que representa a classificação da despesa orçamentária por subelemento (subitem)|
|co_natureza_despesa_deta | Código numérico que representa a classificação da despesa orçamentária por natureza da despesa detalhada (categoria economica até subelemento)|
|no_natureza_despesa_deta | Descrição da natureza da despesa detalhada|
|id_esfera_orcamentaria | Código numérico que representa a esfera orçamentária do custo|
|no_esfera_orcamentaria | Descrição da esfera orçamentária (qual orçamento pertence o custo)|
|id_in_resultado_eof | Código numérico que representa a classificação da despesa orçamentária por indicador de resultado primário|
|no_in_resultado_eof | Descrição da classificação da despesa orçamentária por indicador de resultado primário|
|va_custo Métrica | financeiro do custo|


### Modelagem da Stage Area `SQL` 
```sql
select
  -- definir-chave-primaria,
	co_natureza_juridica as codigo_natureza_juridica,
  ds_natureza_juridica as descricao_natureza_juridica,
  co_organizacao_n1 as codigo_organizacao_1,
	ds_organizacao_n1 as descricao_organizacao_1,
	co_organizacao_n2 as codigo_organizacao_2,
	ds_organizacao_n2 as descricao_organizacao_2,
	co_organizacao_n3 as codigo_organizacao_3,
	ds_organizacao_n3 as descricao_organizacao_3,
	an_lanc as ano_lancamento,
	me_lanc as mes_lancamento
	va_custo_pensionistas as valor_custo_pensionistas
from source_pensionistas
```

### Modelagem Dimensāo
```sql
select
	-- definir-chave-primaria,
    descricao_natureza_juridica,
	descricao_organizacao_1,
	descricao_organizacao_2,
	descricao_organizacao_3
from stg_pensionistas
```

### Modelagem Fato
```sql
select
	-- definir-chave-primaria,
	codigo_natureza_juridica,
	codigo_organizacao_1,
	codigo_organizacao_2,
	codigo_organizacao_3,
	ano_lancamento,
	mes_lancamento,
	valor_custo_pensionistas
from stg_pensionistas
```
