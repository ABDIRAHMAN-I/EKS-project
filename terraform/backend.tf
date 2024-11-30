terraform {
  backend "s3" {
    bucket  = "my-tetras-app-statefiles-bucket"
    key     = "state-file"
    region  = "eu-west-2"
    encrypt = true
  }
}
