# variables.tf
variable "image_url" {
  type        = string
  description = "docker image url"
}

variable "tag" {
  type        = string
  description = "holds the tag of the image"
}

variable "name" {
  type        = string
  description = "holds the image of the render service"
}

variable "region" {
  type        = string
  description = "holds the region where the service needs to be deployed"
}

variable "plan" {
  type        = string
  description = "holds the plan needs to be used for the service"
}

variable "RENDER_API_KEY" {
  type        = string
  description = "Used to hold the api key for connecting render cloud"
  sensitive   = true # Prevents the password from printing in logs
}
