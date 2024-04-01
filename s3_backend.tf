terraform {
    backend "s3" {
        bucket = "tf-state-2024"
        key    = "terraform.tfstate"
        region = "ru-msk"

        skip_region_validation = true
        skip_s3_checksum = true
        skip_credentials_validation = true
        skip_requesting_account_id = true

        endpoints = {
            s3 = "https://hb.ru-msk.vkcs.cloud"
        }

        # Other credentials and params are read
        # from environment variables automatically
    }
}
