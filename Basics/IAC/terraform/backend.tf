terraform {
  backend "gcs" {
    bucket      = "tf-state-agris"
    prefix      = "terraform/state"
    credentials = "terraform.json"
  }
}

