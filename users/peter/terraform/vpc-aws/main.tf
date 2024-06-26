// This adds Amazon as a provider.  Use the creds filename in KAOPS IAC form.
provider "aws" {
  shared_credentials_files = ["aws-creds.ini"]
  region = "us-west-1"
}

// Modules _must_ use remote state. The provider does not persist state.
terraform {
  backend "kubernetes" {
    secret_suffix     = "providerconfig-default"
    namespace         = "default"
    in_cluster_config = true
  }
}
// Terraform uses this block to create an Amazon VPC
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "Terraform Provider VPC for Peter Piper"
 }
}
