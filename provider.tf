terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  project = "skilful-ethos-429115-u8"
  region  = "us-central1"

}