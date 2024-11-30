variable "ecr_repository_name" {
  description = "name of ecr repository"
  type        = string
  default     = "tetras-app"
}

variable "s3_bucket_name" {
  description = "name of s3 bucket"
  type        = string
  default     = "my-tetras-app-statefiles-bucket"

}