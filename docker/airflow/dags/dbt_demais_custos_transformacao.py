from datetime import timedelta
import airflow
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.bash_operator import BashOperator

from datetime import timedelta
import datetime

default_args = {
    'owner' : 'airflow',
    'retries' : 0
}

dag = DAG(
    dag_id = 'dbt_demais_custos_transformacao',
    start_date = airflow.utils.dates.days_ago(2),
    schedule_interval = '0 */6 * * *',
    catchup=False,
    default_args = default_args
)

dbt_stg_debug = BashOperator(
    task_id='dbt_stg_debug',
    bash_command= 'cd /usr/app/dbt;dbt debug',
    dag=dag
)

stg_demais_custos = BashOperator(
    task_id='stg_demais_custos',
    bash_command= 'cd /usr/app/dbt;dbt run --m stg_demais_custos',
    dag=dag
)

dim_demais_custos = BashOperator(
    task_id='dim_demais_custos',
    bash_command= 'cd /usr/app/dbt;dbt run --m dim_demais_custos',
    dag=dag
)

fato_demais_custos = BashOperator(
    task_id='fato_demais_custos',
    bash_command= 'cd /usr/app/dbt;dbt run --m fato_demais_custos',
    dag=dag
)

stg_depreciacao = BashOperator(
    task_id='stg_depreciacao',
    bash_command= 'cd /usr/app/dbt;dbt run --m stg_depreciacao',
    dag=dag
)

dim_depreciacao = BashOperator(
    task_id='dim_depreciacao',
    bash_command= 'cd /usr/app/dbt;dbt run --m dim_depreciacao',
    dag=dag
)

fato_depreciacao = BashOperator(
    task_id='fato_depreciacao',
    bash_command= 'cd /usr/app/dbt;dbt run --m fato_depreciacao',
    dag=dag
)

stg_pensionistas = BashOperator(
    task_id='stg_pensionistas',
    bash_command= 'cd /usr/app/dbt;dbt run --m stg_pensionistas',
    dag=dag
)

dim_pensionistas = BashOperator(
    task_id='dim_pensionistas',
    bash_command= 'cd /usr/app/dbt;dbt run --m dim_pensionistas',
    dag=dag
)

fato_pensionistas = BashOperator(
    task_id='fato_pensionistas',
    bash_command= 'cd /usr/app/dbt;dbt run --m fato_pensionistas',
    dag=dag
)

stg_pessoal_ativo = BashOperator(
    task_id='stg_pessoal_ativo',
    bash_command= 'cd /usr/app/dbt;dbt run --m stg_pessoal_ativo',
    dag=dag
)

dim_pessoal_ativo = BashOperator(
    task_id='dim_pessoal_ativo',
    bash_command= 'cd /usr/app/dbt;dbt run --m dim_pessoal_ativo',
    dag=dag
)

fato_pessoal_ativo = BashOperator(
    task_id='fato_pessoal_ativo',
    bash_command= 'cd /usr/app/dbt;dbt run --m fato_pessoal_ativo',
    dag=dag
)

stg_pessoal_inativo = BashOperator(
    task_id='stg_pessoal_inativo',
    bash_command= 'cd /usr/app/dbt;dbt run --m stg_pessoal_inativo',
    dag=dag
)

dim_pessoal_inativo = BashOperator(
    task_id='dim_pessoal_inativo',
    bash_command= 'cd /usr/app/dbt;dbt run --m dim_pessoal_inativo',
    dag=dag
)

fato_pessoal_inativo = BashOperator(
    task_id='fato_pessoal_inativo',
    bash_command= 'cd /usr/app/dbt;dbt run --m fato_pessoal_inativo',
    dag=dag
)

stg_transferencias = BashOperator(
    task_id='dbt_stg_transferencias',
    bash_command= 'cd /usr/app/dbt;dbt run --m stg_transferencias',
    dag=dag
)

dim_transferencias = BashOperator(
    task_id='dim_transferencias',
    bash_command= 'cd /usr/app/dbt;dbt run --m dim_transferencias',
    dag=dag
)

fato_transferencias = BashOperator(
    task_id='fato_transferencias',
    bash_command= 'cd /usr/app/dbt;dbt run --m fato_transferencias',
    dag=dag
)



dbt_stg_debug >> stg_demais_custos >> [dim_demais_custos, fato_demais_custos]
dbt_stg_debug >> stg_depreciacao >> [dim_depreciacao, fato_depreciacao] 
dbt_stg_debug >> stg_pensionistas >> [dim_pensionistas, fato_pensionistas] 
dbt_stg_debug >> stg_pessoal_ativo >> [dim_pessoal_ativo, fato_pessoal_ativo] 
dbt_stg_debug >> stg_pessoal_inativo >> [dim_pessoal_inativo, fato_pessoal_inativo] 
dbt_stg_debug >> stg_transferencias >> [dim_transferencias, fato_transferencias]
