# 🚀 DevOps Pipeline — Flask Web App

A minimal but production-ready DevOps pipeline built around a Python Flask application.

---

## 📁 Project Structure

```
devops-project/
├── app/
│   ├── app.py              # Flask application
│   ├── requirements.txt    # Python dependencies
│   └── test_app.py         # Pytest unit tests
├── .github/
│   └── workflows/
│       └── ci-cd.yml       # GitHub Actions pipeline
├── terraform/
│   ├── main.tf             # VPC, EC2, S3 resources
│   ├── variables.tf        # Input variables
│   └── outputs.tf          # Output values
├── monitoring/
│   └── prometheus.yml      # Prometheus scrape config
├── Dockerfile              # Multi-stage Docker build
├── docker-compose.yml      # App + Prometheus + Grafana
└── README.md
```

---

## ⚙️ CI/CD Pipeline (GitHub Actions)

The pipeline runs on every push to `main` or `develop`, and on pull requests to `main`.

| Stage  | Tool        | What it does                                |
|--------|-------------|---------------------------------------------|
| Lint   | flake8      | Checks Python code style                    |
| Test   | pytest      | Runs unit tests                             |
| Build  | Docker      | Builds and pushes image to GHCR             |
| Deploy | SSH Action  | Pulls latest image and restarts containers  |

### Required GitHub Secrets

| Secret            | Description                        |
|-------------------|------------------------------------|
| `DEPLOY_HOST`     | Production server IP/hostname      |
| `DEPLOY_USER`     | SSH username (e.g. `ubuntu`)       |
| `DEPLOY_SSH_KEY`  | Private SSH key for server access  |

---

## 🐳 Docker Setup

### Build and run locally

```bash
# Build the image
docker build -t flask-devops-app .

# Run single container
docker run -p 5000:5000 flask-devops-app

# Or use docker compose (includes Prometheus + Grafana)
docker compose up -d
```

### Services

| Service    | URL                        | Credentials         |
|------------|----------------------------|---------------------|
| Flask App  | http://localhost:5000      | —                   |
| Prometheus | http://localhost:9090      | —                   |
| Grafana    | http://localhost:3000      | admin / admin123    |

---

## 🏗️ Infrastructure as Code (Terraform)

Provisions on AWS:
- **VPC** with public subnet, internet gateway, and route table
- **EC2** (t3.micro, Ubuntu 22.04) — auto-installs Docker and clones repo
- **Security Group** — allows HTTP (80), app port (5000), SSH (22)
- **S3 Bucket** — versioned and encrypted, for app assets

### Usage

```bash
cd terraform

# Initialise providers
terraform init

# Preview changes
terraform plan -var="key_pair_name=my-key" -var="my_ip=YOUR.IP.HERE/32"

# Apply
terraform apply -var="key_pair_name=my-key" -var="my_ip=YOUR.IP.HERE/32"

# Destroy when done
terraform destroy
```

---

## 📊 Monitoring (Prometheus + Grafana)

The Flask app exposes metrics at `/metrics` via `prometheus-flask-exporter`.

**Prometheus** scrapes the app every 10 seconds. **Grafana** connects to Prometheus for dashboards.

### Recommended Grafana Dashboards
- Import dashboard ID **11378** (Flask Prometheus Exporter)
- Import dashboard ID **1860** (Node Exporter Full) for system metrics

### Key Metrics Available
- `flask_http_request_total` — total requests by endpoint and status code
- `flask_http_request_duration_seconds` — response time histograms
- `flask_http_request_exceptions_total` — error counts

---

## 🧪 Running Tests Locally

```bash
cd app
pip install -r requirements.txt
pytest test_app.py -v
```

---

## 🔐 Security Notes

- Docker image runs as a **non-root user**
- S3 bucket has **server-side encryption** enabled
- SSH access restricted to **your IP only** via security group
- Grafana sign-up disabled; change `admin123` in production
