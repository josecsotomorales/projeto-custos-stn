# Written:
# Maile Cupo
# maile.cupo@calix.com 
# 10/14/2020
#
import boto3
import botocore
from airflow.models import BaseOperator
from airflow.utils.decorators import apply_defaults
import logging
import json

class LambdaOperator(BaseOperator):
    """
    Manually force-syncs a fivetran job
    """

    ui_color = '0000FF'

    @apply_defaults
    def __init__(self,
                arn,
                region_name,
                aws_access_key_id,
                aws_secret_access_key,
                *args,
                **kwargs):
        super(LambdaOperator, self).__init__(
            *args,
            **kwargs)

        self.aws_access_key_id = aws_access_key_id
        self.aws_secret_access_key = aws_secret_access_key
        self.region_name = region_name
        self.arn = arn

    def execute(self, context):
        self.log.info(f'Initializing boto connection')

        config = botocore.config.Config(
            read_timeout=900,
            connect_timeout=900,
            retries={"max_attempts": 0}
        )

        self.lambda_client = boto3.client('lambda',
                                    region_name = self.region_name,
                                    aws_access_key_id=self.aws_access_key_id,
                                    aws_secret_access_key=self.aws_secret_access_key,
                                    config = config)

        self.log.info(f'Invoking {self.arn}')
        r = self.lambda_client.invoke(FunctionName=self.arn,
                            InvocationType='RequestResponse')

        payload = json.loads(r['Payload'].read())

        if payload and 'errorMessage' in payload:
            raise(Exception(payload['errorMessage']))