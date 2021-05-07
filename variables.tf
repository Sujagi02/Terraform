variable "x" {
     type = string
     default = "sujagi"
     }

output "my_name_is" {
     value = "Hi there ! ${var.x}"
    }
