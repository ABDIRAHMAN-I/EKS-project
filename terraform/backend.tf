terraform {
  backend "s3" {
    bucket         = "tetras-app-statefiles-bucket"
    key            = "state-file"
    region         = "eu-west-2"
    dynamodb_table = "dydb-state-locking-eks"
    encrypt        = true
  }
}
