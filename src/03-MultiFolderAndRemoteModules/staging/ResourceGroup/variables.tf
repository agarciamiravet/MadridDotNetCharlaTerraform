variable "tags" {
  type        = map
  description = "Default tags for all resources"

  default = {
    Created_Modified_By = "terraform",
    Environment = "Staging",
    Version = "0.0.1"
  }
}