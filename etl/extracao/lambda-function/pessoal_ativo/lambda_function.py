from decouple import config
from datetime import datetime
from pessoal_ativo_api import pa_api
import json
import boto3

# AWS Credentials
BUCKET = config('BUCKET')
AWS_REGION = config('AWS_REGION')
BUCKET_AWS_ACCESS_KEY_ID = config('BUCKET_AWS_ACCESS_KEY_ID')
BUCKET_AWS_SECRET_ACCESS_KEY = config('BUCKET_AWS_SECRET_ACCESS_KEY')

S3 = boto3.resource(
    's3',
    region_name = AWS_REGION,
    aws_access_key_id = BUCKET_AWS_ACCESS_KEY_ID,
    aws_secret_access_key = BUCKET_AWS_SECRET_ACCESS_KEY
)

print('S3 Resource created')

def handle_data_with_s3():
    
    bucket = S3.Bucket(BUCKET)
    obj = bucket.Object('custo-stn-sources.json')
    data = obj.get()['Body'].read()
    custo_stn_sources = json.loads(data)
    print(custo_stn_sources)
    
    source_name = 'pessoal_ativo'
    pessoal_ativo_state = custo_stn_sources['sources'][source_name]
    
    # write
    # bucket = S3.Bucket(BUCKET)
    # obj = bucket.Object('custo-stn-sources.json')
    # data = obj.get()['Body'].read()
    # custo_stn_sources = json.loads(data)
    # pessoal_ativo = custo_stn_sources['sources']['pessoal_ativo']
    # pessoal_ativo['initial_offset'] = 0
    # obj.put(Body=json.dumps(custo_stn_sources))
     
    pessoal_ativo = pa_api()

    pessoal_ativo.get_files_by_endpoint(pessoal_ativo_state, bucket, BUCKET)

def lambda_handler(event, context):
    handle_data_with_s3()
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

if __name__ == '__main__':
    lambda_handler({"state": {}}, None)