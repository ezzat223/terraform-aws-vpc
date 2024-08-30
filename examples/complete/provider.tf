# ------ AWS Configurations -------- #
provider "aws" {
  profile = "default"
  region = var.region
}
