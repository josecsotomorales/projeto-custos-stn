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
    dag_id = 'dbt_calendario',
    start_date = airflow.utils.dates.days_ago(2),
    schedule_interval = '0 0 1 1 *',
    catchup=False,
    default_args = default_args
)

dbt_stg_debug = BashOperator(
    task_id='dbt_stg_debug',
    bash_command= 'cd /usr/app/dbt;dbt debug',
    dag=dag
)

dim_calendario = BashOperator(
    task_id='dim_calendario',
    bash_command= 'cd /usr/app/dbt;dbt run --m dim_calendario',
    dag=dag
)

dbt_stg_debug >> dim_calendario
