#!/bin/bash
apt update -y
apt install docker.io -y

systemctl enable docker
systemctl start docker

sleep 10
sudo usermod -aG docker ec2-user
docker run -d -p 80:5000 mikew02/devops-app:1.0
