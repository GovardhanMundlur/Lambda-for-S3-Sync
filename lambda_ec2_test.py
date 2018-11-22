import boto3


REGION = 'us-east-1'
AMI = 'ami-009d6802948d06e52'
INSTANCE_TYPE = 't2.micro'

EC2 = boto3.client('ec2', region_name=REGION)


def lambda_handler(event, context):
    instance = EC2.run_instances(
        ImageId=AMI,
        InstanceType=INSTANCE_TYPE,
        MinCount=1,
        MaxCount=1,
        InstanceInitiatedShutdownBehavior='terminate'
    )
