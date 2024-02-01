variable "service_account_key_file" {
  description = "Service account key file"
  type        = string
  default     = "/home/user/sa_key.json"
}

variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "ID of the folder"
  type        = string
}

variable "image_id" {
  description = "Image ID"
  type        = string
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "yc-tf"
  validation {
    condition     = length(var.name) <= 32
    error_message = "Must be a 32 or less character long string."
  }
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}
