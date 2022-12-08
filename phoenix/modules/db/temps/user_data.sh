#!/bin/bash
echo '' > /etc/ecs/ecs.config

echo ECS_CLUSTER=${cluster_name} > /etc/ecs/ecs.config

sed -i '/After=cloud-final.service/d' /usr/lib/systemd/system/ecs.service
systemctl daemon-reload

#install the Docker volume plugin
docker plugin install rexray/ebs REXRAY_PREEMPT=true EBS_REGION=${aws_region} --grant-all-permissions

service restart docker
start ecs