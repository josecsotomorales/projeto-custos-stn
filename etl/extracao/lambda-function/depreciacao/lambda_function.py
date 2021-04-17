from decouple import config
from datetime import datetime
from depreciacao_api import depreciacao_api
import json
import boto3
import pandas as pd
from time import sleep
# AWS Credentials
BUCKET = config('BUCKET')
AWS_REGION = config('AWS_REGION')
BUCKET_AWS_ACCESS_KEY_ID = config('BUCKET_AWS_ACCESS_KEY_ID')
BUCKET_AWS_SECRET_ACCESS_KEY = config('BUCKET_AWS_SECRET_ACCESS_KEY')
CUSTO_STN_SOURCES_STATES = 'custos_stn_sources_states.json'
CUSTO_STN_DEPRECIACAO_PATH = 'depreciacao'
custos_stn_state = {}
STOP_CONDITION_TEST = 100000000
S3 = boto3.resource(
    's3',
    region_name = AWS_REGION,
    aws_access_key_id = BUCKET_AWS_ACCESS_KEY_ID,
    aws_secret_access_key = BUCKET_AWS_SECRET_ACCESS_KEY
)

def load_s3_file_content_json(s3_path, s3_file_content):
    # Initializes the bucket object
    bucket = S3.Bucket(BUCKET)
    # Write to file
    bucket.put_object(Key=s3_path, Body=s3_file_content)

def load_s3_file_content(s3_path, s3_file_content):

    bucket = S3.Bucket(BUCKET)
    
    df = pd.read_json(s3_file_content)

    bucket.put_object(Key=s3_path, Body=df.to_csv(index = None, header=True))

def is_s3_file_exists(s3_path):
    """
        Verifies if the file in the s3_path in the bucket exists
    """
    bucket = S3.Bucket(BUCKET)

    if len(list(bucket.objects.filter(Prefix=s3_path))) > 0:
        return True
    
    return False

def get_s3_file_content(s3_path):
    
    if not is_s3_file_exists(s3_path):
        if s3_path == CUSTO_STN_SOURCES_STATES:
            content = get_initial_state(s3_path)
            if content:
                load_s3_file_content_json(s3_path, json.dumps(content,indent = 2) )
            else:
                raise ValueError('It was not able to initialize the state ')
        else:
            load_s3_file_content(s3_path, '')
    
    obj = S3.Object(BUCKET, s3_path)

    # Get content
    return obj.get()['Body'].read().decode('utf-8')


def get_initial_state(s3_path):

    custos_stn_sources_states_file = open('custos_stn_sources_states.json',)
    if custos_stn_sources_states_file:
        return json.load(custos_stn_sources_states_file)
    
    return None

def consume_api(custos_stn_state,depreciacao):
    # carregar o arquivo de estado
    if depreciacao.initial_offset <= STOP_CONDITION_TEST:
        depreciacao_items = depreciacao.get_items_from_api()

        if len(depreciacao_items['items']) > 0:

            depreciacao.initial_offset = depreciacao_items['initial_offset']
            depreciacao.file_number = depreciacao_items['file_number']
            custos_stn_state['sources']['depreciacao']['initial_offset'] = depreciacao_items['initial_offset']
            custos_stn_state['sources']['file_number'] = depreciacao_items['file_number']
            
            load_s3_file_content_json(CUSTO_STN_SOURCES_STATES, json.dumps(custos_stn_state, indent= 2))
            load_s3_file_content(f'{CUSTO_STN_DEPRECIACAO_PATH}/depreciacao_{depreciacao.file_number}.csv', json.dumps(depreciacao_items['items'], indent= 2))

            while depreciacao_items['hasMore'] and depreciacao_items['initial_offset'] <= STOP_CONDITION_TEST:
                sleep(5)
                depreciacao_items = depreciacao.get_items_from_api()
                
                depreciacao.initial_offset = depreciacao_items['initial_offset']
                depreciacao.file_number = depreciacao_items['file_number'] + 1
                depreciacao.is_full_load = False
                custos_stn_state['sources']['depreciacao']['initial_offset'] = depreciacao.initial_offset
                custos_stn_state['sources']['depreciacao']['file_number'] =  depreciacao.file_number
                custos_stn_state['sources']['depreciacao']['is_full_load'] = depreciacao.is_full_load
                load_s3_file_content_json(CUSTO_STN_SOURCES_STATES, json.dumps(custos_stn_state, indent= 2))
                load_s3_file_content(f'{CUSTO_STN_DEPRECIACAO_PATH}/depreciacao_{depreciacao.file_number}.csv', json.dumps(depreciacao_items['items'], indent= 2))
        


def reset_state(depreciacao,custos_stn_state):
    depreciacao.initial_offset = 0
    depreciacao.file_number = 0
    custos_stn_state['sources']['depreciacao']['initial_offset'] = depreciacao.initial_offset
    custos_stn_state['sources']['file_number'] = depreciacao.file_number
    
    load_s3_file_content_json(CUSTO_STN_SOURCES_STATES, json.dumps(custos_stn_state, indent= 2))

def handle_data_with_s3():
    custos_stn_state = json.loads(get_s3_file_content(CUSTO_STN_SOURCES_STATES))
    depreciacao = depreciacao_api(custos_stn_state['sources']['depreciacao'])
    
    if depreciacao.is_full_load:
        reset_state(depreciacao,custos_stn_state)
        consume_api(custos_stn_state,depreciacao)
    elif not depreciacao.is_full_load:
        consume_api(custos_stn_state,depreciacao)

def lambda_handler(event, context):
    
    handle_data_with_s3()
    
    return {"state": {}}

if __name__ == '__main__':
    lambda_handler({"state": {}}, None)