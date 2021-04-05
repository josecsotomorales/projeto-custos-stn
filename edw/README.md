# PostgreSQL e PgAdmin Docker Compose

## Requisitos:
* docker >= 17.12.0+
* docker-compose

## Guia de Usuario
* No terminal, vai no diretorio  `cd edw`
* Executar `docker-compose up -d`

## Variaveis de Ambiente
* `POSTGRES_USER` default **postgres**
* `POSTGRES_PASSWORD` default **postgres**
* `PGADMIN_PORT` default **5050**
* `PGADMIN_DEFAULT_EMAIL` default **pgadmin4@pgadmin.org**
* `PGADMIN_DEFAULT_PASSWORD` default **admin**

## Accessando ao Postgres: 
* `localhost:5432`
* **Usuario:** postgres (default)
* **Senha:** postgres (default)

## Accessando ao PgAdmin: 
* **URL:** `http://localhost:5050`
* **Usuario:** pgadmin4@pgadmin.org (default)
* **Senha:** admin (default)

## Add a new server in PgAdmin:
* **Host** `postgres`
* **Porta** `5432`
* **Usuario** as `POSTGRES_USER`, default: `postgres`
* **Senha** as `POSTGRES_PASSWORD`, default `postgres`