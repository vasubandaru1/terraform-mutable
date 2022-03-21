data "terraform_remote_state" "VPC" {
  backend = "s3"
  config = {
    bucket = "vasudevops"
    key    = "terraform-mutable/db/dev/terraform.tfstate"
    region = "us-east-1"
}

}
