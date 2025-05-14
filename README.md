# GetMySaaS

A full-stack SaaS starter template designed to accelerate your product development. This project integrates modern backend and frontend tools, enabling a quick and scalable foundation for any SaaS application.

## Tech Stack

- Backend: FastAPI
- Frontend: Streamlit
- Database: Oracle DB, PostgreSQL
- Containerization: Docker
- Monitoring: Prometheus, Grafana
- Security: Trivy (Docker vulnerability scanning)
- Infrastructure: Terraform

## Features

- FastAPI backend with RESTful endpoints
- Prometheus metrics for observability
- Dockerized setup with production-ready configurations
- Trivy integration for container vulnerability scanning
- Infrastructure-as-Code using Terraform
- Linting, formatting, and structured logging

## Getting Started

### Prerequisites

- Python 3.9+
- Docker & Docker Compose
- Git

### Installation

git clone https://github.com/aklankdiwakar/getmysaas.git
cd getmysaas

### How to build Docker image

docker build -t rag-inference-api .
Run the Docker container
docker run -p 8000:8000 rag-inference-api

### How to scan Docker image for vulnerabilities

trivy image rag-inference-api --format table --output security/trivy-report.txt

