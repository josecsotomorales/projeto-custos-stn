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
    dag_id = 'dbt_dags_test_3',
    start_date = airflow.utils.dates.days_ago(2),
    default_args = default_args,
    schedule_interval = '* * * * *',
    catchup=False
)

dbt_run = BashOperator(
    task_id='dbt_debug',
    bash_command='dbt debug',
    dag=dag
)

dbt_test = BashOperator(
    task_id='dbt_compile',
    bash_command='dbt compile',
    dag=dag
)

dbt_run >> dbt_test