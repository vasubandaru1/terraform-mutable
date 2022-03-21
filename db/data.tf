data "terraform_remote_state" "VPC" {
  backend = "s3"
  config = {
    bucket = "vasudevops"
    key    = "terraform-mutable/dev/db/terraform.tfstate"
    region = "us-east-1"
}

}
