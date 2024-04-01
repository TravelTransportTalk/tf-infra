terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "~> 0.1.12" 
        }
    }
}

provider "vkcs" {
    username = var.auth.username
    password = var.auth.password
    project_id = var.auth.project_id

    region = var.auth.region
    auth_url = var.auth.url
}
