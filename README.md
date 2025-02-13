# Three-Tier Architecture using Terraform

## Overview
This project implements a **Three-Tier Architecture** using **Terraform** on AWS. The architecture consists of the following layers:

1. **Presentation Layer (Frontend)** - Public-facing tier, typically hosting a web application.
2. **Application Layer (Backend)** - Business logic and processing.
3. **Database Layer** - Data storage and management.

## Architecture Components
- **VPC** with public and private subnets across multiple Availability Zones.
- **Load Balancer** (ALB) for distributing traffic.
- **EC2 instances** for the application and web tiers.
- **RDS (Relational Database Service)** for the database tier.
- **Security Groups** to control access between tiers.
- **Auto Scaling Groups** for high availability.

## Prerequisites
- AWS CLI configured with necessary permissions.
- Terraform installed on your local machine.
- A valid AWS account.

## Deployment Steps
1. **Clone the Repository**
   ```sh
   git clone https://github.com/arun037/three-tier-architecture.git
   cd three-tier-architecture
   ```

2. **Initialize Terraform**
   ```sh
   terraform init
   ```

3. **Plan the Deployment**
   ```sh
   terraform plan
   ```

4. **Apply Terraform Configuration**
   ```sh
   terraform apply -auto-approve
   ```

5. **Access the Application**
   - Retrieve the ALB DNS Name and open it in a browser:
     ```sh
     terraform output alb_dns_name
     ```

## Cleanup
To destroy all created resources, run:
```sh
terraform destroy -auto-approve
```

## Technologies Used
- **Terraform** for infrastructure as code.
- **AWS EC2, RDS, VPC, ALB, Auto Scaling Groups**.
- **Security Groups & IAM Roles** for access control.

## Future Enhancements
- Implementing **CI/CD Pipelines** for automated deployments.
- Adding **Monitoring & Logging** using AWS CloudWatch and Prometheus.
- Introducing **Terraform Modules** for better scalability.

---

### Author
**Arun M** 🚀 | DevOps Engineer
