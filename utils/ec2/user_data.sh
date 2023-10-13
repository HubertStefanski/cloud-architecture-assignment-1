#!/bin/bash
sudo yum install cronie cronie-anacron docker -y
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo docker pull quay.io/hstefans/example_flask_app:latest && sudo docker run -it -p 5000:5000 --network host -e DB_NAME=demo-db -e DB_USER=demo -e DB_PASSWORD=demo123 -e DB_HOST=<URL> -e DB_PORT=5432 --name flask -d quay.io/hstefans/example_flask_app:latest
curl -X GET https://raw.githubusercontent.com/HubertStefanski/cloud-architecture-assignment-1/main/utils/push_metrics/push_metrics.sh > push_metrics.sh && sudo chmod +x push_metrics.sh
sudo mv push_metrics.sh /usr/local/bin/push_metrics.sh
crontab -l | { cat; echo "*/1 * * * *  /usr/local/bin/push_metrics.sh"; } | crontab -
sudo systemctl start crond



