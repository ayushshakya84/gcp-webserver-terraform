terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project = "lexical-drake-423604-d4"
  region  = "us-west1"

}

# provider "vault" {
#   address          = "http://34.16.221.189:8200"
#   skip_child_token = true

#   auth_login {
#     path = "auth/approle/login"

#     parameters = {
#       role_id   = "4189aa57-dddf-735f-00af-31b381498f29"
#       secret_id = "2b09d50c-aa56-4558-e648-54cbe1c925db"
#     }
#   }
# }