# 🚀 DevOps Project – Automated Flask Deployment on AWS

## 📌 Overview

This project demonstrates a fully automated CI/CD pipeline for deploying a containerized Python Flask application to AWS EC2 using Terraform and GitHub Actions.

A simple `git push` triggers:
- Docker image build
- Image push to DockerHub
- Automatic deployment to AWS EC2 via SSH

The entire infrastructure and deployment process is automated.

---

## 🏗 Architecture

Developer

↓ (git push)

GitHub Actions (CI/CD)

↓

DockerHub (Container Registry)

↓

AWS EC2 (Elastic IP)

↓

Docker Container

↓

Flask Application

---

## 🛠 Tech Stack

- Python (Flask)
- Docker
- AWS EC2
- Elastic IP
- Terraform (Infrastructure as Code)
- GitHub Actions (CI/CD)
- Ubuntu Linux

---

## ☁️ Infrastructure (Terraform)

Infrastructure is provisioned using Terraform and includes:

- EC2 instance (Ubuntu)
- Security Group (ports 22 and 80 open)
- Elastic IP (static public address)
- Elastic IP association

### Initialize Terraform

```bash
cd terraform
terraform init
```

### Preview Changes
```bash
terraform plan
```

### Deploy infrastructure
```bash
terraform apply
```
Elastic IP ensures a stable public address required for CI/CD deployments.

## 🐳 Docker

The Flask application is containerized using Docker.

### Build locally
```bash
docker build -t devops-app .
```
### Run locally
```bash
docker run -p 5000:5000 devops-app
```
## 🔄 CI/CD Pipeline
### Continuous Integration (CI)

Triggered on every push to the `main` branch:

-Checkout repository

-Build Docker image

-Tag image as `latest`

-Push image to DockerHub


### Continuous Deployment (CD)

After a successful image push:

-Connect to EC2 via SSH

-Pull the latest Docker image

-Stop and remove the running container

-Start a new container version

-Auto-restart enabled using Docker restart policy

Deployment is fully automated — no manual SSH access required.

### 🔐 Security

-SSH authentication using private key

-DockerHub credentials stored securely as GitHub Secrets

-Infrastructure defined as code (no manual cloud configuration)

-Public access restricted to required ports only (22, 80)

-Sensitive files excluded using `.gitignore`

### 🧠 DevOps Concepts Demonstrated

-Infrastructure as Code (Terraform)

-Cloud provisioning (AWS)

-Static IP management with Elastic IP

-Containerization (Docker)

-CI/CD automation

-Secure secrets management

-Automated remote deployment via SSH

-Immutable infrastructure principles

-Container lifecycle management

