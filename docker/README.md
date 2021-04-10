# PostgreSQL e PgAdmin Docker Compose

## Requisitos:
* docker >= 17.12.0+
* docker-compose

## Guia de Usuario
* No terminal vá no diretorio `cd edw`
* É necessário criar um arquivo .env dentro de `airflow/` com as variáveis `AWS_REGION, BUCKET_AWS_ACCESS_KEY_ID ,BUCKET_AWS_SECRET_ACCESS_KEY`
* Executar `docker-compose up`
* Verificar o log do jupyter_notebook para acessar com o token

## Variaveis de Ambiente
* `POSTGRES_USER` default **postgres**
* `POSTGRES_PASSWORD` default **postgres**
* `PGADMIN_PORT` default **5050**
* `PGADMIN_DEFAULT_EMAIL` default **pgadmin4@pgadmin.org**
* `PGADMIN_DEFAULT_PASSWORD` default **admin**
* `ENV AIRFLOW__CORE__EXECUTOR` LocalExecutor`
* `AIRFLOW__CORE__SQL_ALCHEMY_CONN` postgresql+psycopg2://${POSTGRES_HOST}:${POSTGRES_USER}@${POSTGRES_PASSWORD}:5432/${POSTGRES_DATABASE} 
* `AIRFLOW__CORE__LOAD_EXAMPLES` False
* `AIRFLOW__CORE__LOAD_DEFAULT_CONNECTIONS` False
* `AIRFLOW__CORE__FERNET_KEY` ${generate_fernet_key.py}
* `AWS_REGION`  **regiao-aws**
* `BUCKET_AWS_ACCESS_KEY_ID` **s3-aws-access-key-id**
* `BUCKET_AWS_SECRET_ACCESS_KEY` **s3-aws-secret-access-key**
## Acessar ao Postgres: 
* `localhost:5432`
* **Usuario:** postgres (default)
* **Senha:** postgres (default)

## Acessar ao PgAdmin: 
* **URL:** `http://localhost:5050`
* **Usuario:** pgadmin4@pgadmin.org (default)
* **Senha:** admin (default)

## Acessar ao Airflow: 
* **URL:** `http://localhost:8080`
* **Usuario:** airflow (default)
* **Senha:** airflow (default)

## Adicionar servidor no PgAdmin:
* **Host** `postgres`
* **Porta** `5432`
* **Usuario** `POSTGRES_USER`, default: `postgres`
* **Senha** `POSTGRES_PASSWORD`, default `postgres`