#!/bin/bash
yum update -yum
yum install -y amazon-cloudwatch-agent

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << EOF
"logs":
   {
       "logs_collected": {
           "files": {
               "collect_list": [
                   {
                       "file_path": "/var/log/messages",
                       "log_group_name": "${messages_log_group}",
                       "timestamp_format": "%H: %M: %S%y%b%-d"
                   },
                   {
                       "file_path": "/var/log/ecs",
                       "log_group_name": "${ecs_log_group}",
                       "timestamp_format": "%H: %M: %S%y%b%-d"
                   },
                   {
                       "file_path": "/var/log/docker",
                       "log_group_name": "${docker_log_group}",
                       "timestamp_format": "%H: %M: %S%y%b%-d"
                   }
               ]
           }
       }
   }
EOF

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

echo "Amazon Cloudwatch Agent is initiated"