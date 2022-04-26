variable "region" {}
variable "profile" {}
variable "account_alias" {}

variable "namespace" {
  type        = string
  default     = null
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}

variable "stage" {
  type        = string
  default     = null
  description = "ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'"
}

variable "name" {
  type        = string
  default     = null
  description = <<-EOT
    ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.
    This is the only ID element not also included as a `tag`.
    The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.
    EOT
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = <<-EOT
    ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,
    in the order they appear in the list. New attributes are appended to the
    end of the list. The elements of the list are joined by the `delimiter`
    and treated as a single ID element.
    EOT
}

variable "delimiter" {
  type        = string
  default     = null
  description = <<-EOT
    Delimiter to be used between ID elements.
    Defaults to `-` (hyphen). Set to `""` to use no delimiter at all.
  EOT
}
