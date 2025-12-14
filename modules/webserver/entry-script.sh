#!/bin/bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user   # Pour permettre à ec2-user d’exécuter des commandes Docker sans sudo
docker run -p 8080:80 nginx