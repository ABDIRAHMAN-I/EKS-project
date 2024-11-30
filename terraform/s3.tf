resource "aws_s3_bucket" "tetras-bucket" {
  bucket = "my-tetras-app-statefiles-bucket"

  lifecycle {
    prevent_destroy = false
  }

}



