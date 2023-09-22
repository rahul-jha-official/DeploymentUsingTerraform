provider "http" {
}

terraform {
  required_providers {
    http = {
        source = "hashicorp/http"
        version = "=3.4.0 "
    }
  }
}


data "http" "ex_call" {
  url = "http://localhost:5126/blog"
  request_headers = {
    Accept = "application/json"
  }
}

output "vals" {
  value = jsondecode(data.http.ex_call.body)
}