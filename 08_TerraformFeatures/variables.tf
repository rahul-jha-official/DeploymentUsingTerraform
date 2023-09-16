#Variables in Terraform

# TYPE: string
variable "StringVar" {
  default = "Hello"
  type = string
  sensitive = false
  description = "This is of type string"

  validation {
    condition = length(var.StringVar) > 3 && substr(var.StringVar,0,0) == "rg-"
    #condition = can(regex("^rg-",var.StringVar))
    error_message = "The condition fails"
  }
}
variable "StringVar2" {
  default = "Hello"
  type = string
  sensitive = false
  description = "This is of type string"

  validation {
    condition = anytrue([for l in ["eu","wu"]: l == var.StringVar2])
    //condition = contains(["eu","wu"], lower(var.StringVar2))
    error_message = "Bert!!"
  }
}

# TYPE: number
variable "NumberVar" {
  default = 1
  type = number
  description = "This is of type number"
  sensitive = true
}

# TYPE: bool
variable "BoolVar" {
  default = true
  type = bool
  description = "This is of type bool"
}

# TYPE: list
variable "NumberListVar" {
  default = [1,2,3,4,5]
  type = list(number)
  description = "This is list of numbers"
}

variable "StringListVar" {
  default = ["Hello", "World"]
  type = list(string)
  description = "This is list of string"
}

# TYPE: map
variable "MapStringVar" {
  default = {
    "Key1": "Value1"
    "Key2": "Value2"
    "Key3": "Value3"
  }
  type = map(string)
  description = "This is map of keys/values"
}

# TYPE: object
variable "ObjectVar" {
  default = {
    name = "Some Name"
    add = "Some Address"
    phn = 1234
  }
  type = object({
    name = string
    add  = string
    phn = number
  })
}