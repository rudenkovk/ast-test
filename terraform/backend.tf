
terraform {
  backend "s3" {
    bucket                      = "terraform"
    key                         = "main/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "https://s3-devops.foundation.local"
    skip_credentials_validation = true
    force_path_style            = true
    access_key                  = "5M06KSXXnMzdeAHu"
    secret_key                  = "T3kdvm4aZncm4Gp15FzIItsHnP8aSxVU"
  }
}
