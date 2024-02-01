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

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}
