variable "ext_port" {
    type = list
    sensitive = true
    
    validation {
    # ... is termed as spread operator applied on list
        condition = max(var.ext_port...) <= 65535 && min(var.ext_port...) > 0
        error_message = "The external port must be in valid port range 0 - 65535."
    }
}

variable "int_port" {
    type = number
    default = 1880
    
    validation {
        condition = var.int_port == 1880
        error_message = "The internal port must be 1880"
    }
}

# variable "container_count" {
#     type = number
#     default = 4
# }

# BELOW IS ALTERNATIVE TO ABOVE ^^^^ 

# locals allow using function but variable doesn't allows
locals {
    container_count = length(var.ext_port) 
}