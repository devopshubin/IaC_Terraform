terraform {
    backend "s3" {
        bucket = "terrabucket20082023"
        key = "terraform/backend"
        region = "us-east-1"
    }
}
