# get the list of clusters in the account
import boto3
import datetime
import json
client = boto3.client('ecs')
cloudwatch = boto3.client('cloudwatch', region_name='us-east-1')

cluster_ls = client.list_clusters()
print cluster_ls
print cluster_ls['clusterArns']
for clust in cluster_ls['clusterArns']:
    service_ls = client.list_services(
        cluster=clust
    )
    print service_ls['serviceArns']
    for srvc in service_ls['serviceArns']:
        response = cloudwatch.get_metric_statistics(
            Namespace='AWS/ECS',
            Dimensions=[
                {
                    'Name': 'ClusterName',
                    'Value': clust
                },
                {
                    'Name': 'ServiceName',
                    'Value': srvc
                }
            ],
            # MetricName='MemoryUtilization',
            MetricName='CPUUtilization',
            StartTime=datetime.datetime.now() - datetime.timedelta(days=3),
            EndTime=datetime.datetime.now(),
            Period=300,
            Statistics=[
                'Average'
            ]
        )
        print(response)

# get the details for EC2 instances
# for clust in cluster_ls['clusterArns']:
#     instances_ls = client.list_container_instances(cluster=clust)
#     print instances_ls
#     print instances_ls['containerInstanceArns']
#     desc_instances = client.describe_container_instances(
#         cluster=clust,
#         containerInstances=instances_ls['containerInstanceArns']
#     )
#     # print json.dumps(desc_instances)
#     for inst in desc_instances['containerInstances']:
#         print inst['ec2InstanceId']
#         response = cloudwatch.get_metric_statistics(
#             Namespace='AWS/ECS',
#             Dimensions=[
#                 {
#                     'Name': 'InstanceId',
#                     'Value': inst['ec2InstanceId']
#                 }
#             ],
#             MetricName='CPUUtilization',
#             StartTime=datetime.datetime.now() - datetime.timedelta(hours=10),
#             EndTime=datetime.datetime.now() - datetime.timedelta(hours=9),
#             Period=60,
#             Statistics=[
#                 'Average'
#             ]
#         )
#         print(response)


# get the metrics of cluster
# for clust in cluster_ls['clusterArns']:
#



    # print '***************'
    # print type(desc_instances)
    # print desc_instances['containerInstances']
    # print desc_instances['containerInstances'][0]['ec2InstanceId']
