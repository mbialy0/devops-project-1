#!/bin/bash
set -e

# Logowanie outputu (do debugowania)
exec > /var/log/user-data.log 2>&1

echo "=== Aktualizacja systemu ==="
apt-get update -y
apt-get upgrade -y

echo "=== Instalacja Dockera ==="
apt-get install -y docker.io

systemctl start docker
systemctl enable docker

echo "=== Dodanie użytkownika ubuntu do grupy docker ==="
usermod -aG docker ubuntu

echo "=== Czekam aż docker będzie gotowy ==="
sleep 10

echo "=== Pull obrazu z DockerHub ==="
docker pull mikew02/devops-app:latest

echo "=== Usuwam stary kontener jeśli istnieje ==="
docker rm -f flask-app || true

echo "=== Uruchamiam kontener ==="
docker run -d \
  --name flask-app \
  -p 80:5000 \
  --restart unless-stopped \
  mikew02/devops-app:latest

echo "=== Koniec konfiguracji ==="
