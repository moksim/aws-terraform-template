# Terraform AWS Infrastructure

This repository contains a small, modular Terraform setup used to provision a VPC and an EC2 instance on AWS.  
The goal is to keep the structure simple and readable, and show how to organize infrastructure-as-code (IaC):  
modules for reusable components and environment folders for configuration.

## Structure

```
terraform-aws-infrastructure/
├── modules/
│   ├── vpc/
│   └── ec2/
└── envs/
    └── dev/
```

- `modules/` — independent, reusable building blocks.
- `envs/` — environment-specific configuration (backend, variables, composition of modules).

## Components

### VPC Module
Creates:
- a VPC  
- a public subnet (used for EC2)  
- a private subnet  
- an internet gateway  
- a route table for outbound access  

Outputs: `vpc_id`, `public_subnet_id`, `private_subnet_id`.

### EC2 Module
Creates:
- an SSH key pair  
- a security group allowing SSH from a specific IP  
- an EC2 instance in the public subnet  

Outputs:
- public IP  
- a ready-to-use SSH command  

The EC2 module is parameterized so it can work with different AMIs, users, and key paths.

## Remote State

The project uses:
- S3 bucket for storing Terraform state  
- DynamoDB table for state locking  

Configured in `envs/dev/backend.tf`.  

## Usage

```
cd envs/dev
terraform init
terraform plan
terraform apply
```

After apply completes, Terraform prints an SSH command, e.g.:

```
ssh -i ~/.ssh/maksim-key ubuntu@<public-ip>
```

## Variables (dev environment)

Defaults are stored in `envs/dev/variables.tf`:

- `region` – AWS region  
- `ami` – Ubuntu AMI for that region  
- `instance_type` – EC2 instance type  
- `my_ip` – CIDR of the client machine allowed to SSH  

## Diagram (text version)

```
VPC (10.10.0.0/16)
├── Public Subnet (10.10.1.0/24)
│   ├── EC2 Instance (Ubuntu)
│   └── Security Group (SSH only from MY_IP)
└── Private Subnet (10.10.2.0/24)

Internet Gateway
Route Table (0.0.0.0/0 → IGW)

Remote state:
S3 bucket + DynamoDB table for locking
```

## Notes

- The repository is intentionally minimal and can be extended with NAT, ALB, RDS, EKS, etc.
- The VPC and EC2 modules are written to be reusable in additional environments (`stage`, `prod`, etc.).
- The layout follows typical patterns used in Terraform-based AWS projects.
