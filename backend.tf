terraform {
  backend "s3" {
    bucket  = "tetris-app-remote-tfstate"
    key     = "state-file"
    region  = "eu-west-2"
    encrypt = true
  }
}
