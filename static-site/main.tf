variable "domain_name" {}
variable "route53_zone_id" {}

locals {
  bucket_name = var.domain_name
}
output "website_bucket" {
  value = aws_s3_bucket.website_bucket.bucket
}

output "domain_name" {
  value = var.domain_name
}


