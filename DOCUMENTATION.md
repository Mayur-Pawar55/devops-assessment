--

DevOps Assessment Application
A simple "Hello World" full-stack application built with:
Backend: Django (REST API)
Frontend: React (Vite + TypeScript)
Infrastructure: AWS EC2 (Terraform)
Containerization: Docker & Docker Compose
CI/CD: GitHub Actions

This document explains the complete process from scratch, including local development, containerization, automation, and deployment.

---

📌 Project Overview
Backend: Django REST API
Frontend: React with Vite, TypeScript, Lucide Icons
Styling: Custom CSS with Dark / Light mode
Communication: REST API using Axios
Security: CORS enabled, non-root containers
Deployment: Automated on AWS EC2

---

⚙️ Prerequisites
Install these before starting:
Python 3.10+
Node.js 18+
npm 9+
Docker & Docker Compose
Terraform
Git

Check versions:
python --version
node --version
npm --version
docker --version
terraform --version

---

Step 1: Infrastructure Setup (Terraform)
Terraform is used to create an EC2 instance.
Commands
cd terraform
terraform init
terraform plan
terraform apply
Result
EC2 instance created
Public IP generated
Security Group allows:
22 (SSH)
80 (HTTP)
443 (HTTPS)

---

Step 2: Clone Repository (Local Machine)
git clone https://github.com/Mayur-Pawar55/devops-assessment.git
cd devops-assessment

---

Step 3: Backend Setup (Local - Without Docker)
cd backend
python3 -m venv venv
source venv/bin/activate     # Windows: venv\\Scripts\\activate
pip install django django-cors-headers psycopg2-binary
python manage.py migrate
python manage.py runserver
Backend runs at:
http://localhost:8000/api/hello/

---

 Step 4: Frontend Setup (Local - Without Docker)
cd frontend
npm install
npm run dev
Frontend runs at:
http://localhost:5173

---

 Step 5: Test Frontend ↔ Backend Integration
Backend running on 8000
Frontend running on 5173
Axios fetches data from Django API
CORS configured in Django

✅ Verified frontend successfully receives backend response

---

 Step 6: Dockerization
Dockerfiles created:
backend/Dockerfile
frontend/Dockerfile
Best practices used:
Multi-stage builds
Non-root users
Optimized image sizes

---

 Step 7: Build & Test Docker Images Separately
Build images
docker build -t backend-image ./backend
docker build -t frontend-image ./frontend
Run containers
docker run -d -p 8000:8000 backend-image
docker run -d -p 3000:3000 frontend-image
Verify
docker ps

---

 Step 8: Docker Compose Setup
Created docker-compose.yml to run frontend & backend together.
Commands
docker compose build
docker compose up -d
Access
http://localhost:3000

---

 Step 9: Issues Faced & Fixes
Issue 1: Frontend dependency error
Invalid npm alias npm:rolldown-vite@7.2.5

Solution
I replaced the invalid dependency with a stable Vite version that is fully supported by npm.
After fixing the dependency, I rebuilt the images without using cache.
docker compose build --no-cache

---

Issue 2: Docker Compose warning
the attribute `version` is obsolete
Fix
Removed version key from docker-compose.yml

 Step 10: GitHub Secrets Configuration
Added secrets in
GitHub → Settings → Secrets → Actions
DOCKER_USERNAME
DOCKER_TOKEN
EC2_PUBLIC_IP
EC2_USERNAME
EC2_PRIVATE_KEY

---

 Step 11: GitHub Actions CI/CD
Workflow file:
.github/workflows/action.yml
Pipeline does:
Build Docker images
Push to Docker Hub
SSH into EC2
Deploy using Docker Compose

Push pipeline
git add .
git commit -m "Add CI/CD pipeline"
git push origin main

---

 Step 12: First Pipeline Failure
Reason
Repository was not cloned on EC2
Deployment directory missing

---

🖥 Step 13: Fix on EC2
SSH into EC2
ssh -i nexgensis ubuntu@65.0.251.37
Install Docker
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
Clone repository
git clone https://github.com/Nexgensis/devops-assessment.git

---

✅ Step 14: Successful Deployment
Trigger pipeline again:
git commit --allow-empty -m "Trigger deployment"
git push origin main
Application accessible at:
http://65.0.251.37
🎉 Hello World page loads successfully.

---

✅ Final Outcome
Infrastructure automated with Terraform
Application tested locally
Dockerized using best practices
CI/CD fully automated
Deployed successfully on AWS EC2
