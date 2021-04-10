#http://airflow.apache.org/docs/stable/_modules/airflow/contrib/sensors/sftp_sensor.html
#https://stackoverflow.com/questions/59639285/how-to-define-operations-of-an-stfp-operator-on-airflow
from decouple import config
import airflow
from airflow import DAG

from airflow.operators.dummy_operator import DummyOperator
from custom_operators.aws_operators import LambdaOperator

from datetime import timedelta
import datetime

default_args = {
    'owner' : 'airflow',
    'retries' : 0
}

dag = DAG(
    dag_id = 'custos_stn_pessoal_ativo',
    start_date = airflow.utils.dates.days_ago(2),
    default_args = default_args,
    schedule_interval = '0 0 * * *',
    catchup=False
)

# Dummy start
start = DummyOperator(task_id = 'start',
                        dag = dag)
REGION_NAME = config('AWS_REGION')
AWS_ACCESS_KEY_ID = config('BUCKET_AWS_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = config('BUCKET_AWS_SECRET_ACCESS_KEY')

custos_stn_pessoal_ativo = LambdaOperator(task_id = 'custos_stn_pessoal_ativo',
                                    arn = 'arn:aws:lambda:us-east-2:005703965888:function:custos-stn-pessoal-ativo',
                                    region_name = REGION_NAME,
                                    aws_access_key_id = AWS_ACCESS_KEY_ID,
                                    aws_secret_access_key = AWS_SECRET_ACCESS_KEY)

custos_stn_depreciacao = LambdaOperator(task_id = 'custos_stn_depreciacao',
                                    arn = 'arn:aws:lambda:us-east-2:005703965888:function:custos-stn-depreciacao',
                                    region_name = REGION_NAME,
                                    aws_access_key_id = AWS_ACCESS_KEY_ID,
                                    aws_secret_access_key = AWS_SECRET_ACCESS_KEY)

custos_stn_transferencia = LambdaOperator(task_id = 'custos_stn_transferencia',
                                    arn = 'arn:aws:lambda:us-east-2:005703965888:function:custos-stn-transferencia',
                                    region_name = REGION_NAME,
                                    aws_access_key_id = AWS_ACCESS_KEY_ID,
                                    aws_secret_access_key = AWS_SECRET_ACCESS_KEY)

custos_stn_pessoal_inativo = LambdaOperator(task_id = 'custos_stn_pessoal_inativo',
                                    arn = 'arn:aws:lambda:us-east-2:005703965888:function:custos-stn-pessoal-inativo',
                                    region_name = REGION_NAME,
                                    aws_access_key_id = AWS_ACCESS_KEY_ID,
                                    aws_secret_access_key = AWS_SECRET_ACCESS_KEY)

custos_stn_pensionista = LambdaOperator(task_id = 'custos_stn_pensionista',
                                    arn = 'arn:aws:lambda:us-east-2:005703965888:function:custos-stn-pensionista',
                                    region_name = REGION_NAME,
                                    aws_access_key_id = AWS_ACCESS_KEY_ID,
                                    aws_secret_access_key = AWS_SECRET_ACCESS_KEY)

custos_stn_demais_custos = LambdaOperator(task_id = 'custos_stn_demais_custos',
                                    arn = 'arn:aws:lambda:us-east-2:005703965888:function:custos-stn-demais-custos',
                                    region_name = REGION_NAME,
                                    aws_access_key_id = AWS_ACCESS_KEY_ID,
                                    aws_secret_access_key = AWS_SECRET_ACCESS_KEY)


# Define graph connections
start >> custos_stn_pessoal_ativo >> custos_stn_depreciacao >> custos_stn_transferencia >> custos_stn_pessoal_inativo >> custos_stn_pensionista >> custos_stn_demais_custos 