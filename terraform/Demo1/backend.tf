terraform {
    backend "s3" {
        bucket = "deabakraja"
        key = "terraform"
        region = "ap-south-1"
    }
}