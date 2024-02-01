
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

variable "subnets" {
  description = "Subnets in folder"
  type = list(object({
    name           = optional(string)
    zone           = optional(string, "ru-central1-a")
    v4_cidr_blocks = list(string)
  }))
}
