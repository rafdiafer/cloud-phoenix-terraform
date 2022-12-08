#!/bin/bash
yum update -y
yum install -y awslogs

echo '' > /etc/ecs/ecs.config

echo ECS_CLUSTER=${cluster_name} > /etc/ecs/ecs.config

cat > /etc/awslogs/awslogs.conf << EOF
[/var/log/messages]
file = /var/log/messages
log_group_name = /${cluster_name}/var/log/messages
datetime_format = %H: %M: %S%y%b%-d

[/var/log/docker]
file = /var/log/docker
log_group_name = /${cluster_name}/var/log/docker
datetime_format = %H: %M: %S%y%b%-d

[/var/log/ecs]
file = /var/log/ecs/ecs-agent.log.*
log_group_name = /${cluster_name}/var/log/ecs
datetime_format = %H: %M: %S%y%b%-d
EOF

service awslogs start
echo "Amazon Cloudwatch Agent is initiated"

start ecs