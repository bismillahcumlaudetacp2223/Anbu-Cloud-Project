variable "vm_project" {
    type = string
    description = "name of VM instance"
    default = "app-instance"
}

variable "machine_type" {
    type = string
    description = "name of machine type"
    default = "f1-micro"
}

variable "zone" {
    type = string
    description = "name of VM zones"
    default = "us-central1-a"
}

variable "image" {
    type = string
    description = "image VM"
    default = "debian-cloud/debian-9"  
}