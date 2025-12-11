terraform {
  backend "s3" {
    bucket         = "maksim-terraform-state-bucket-001"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
