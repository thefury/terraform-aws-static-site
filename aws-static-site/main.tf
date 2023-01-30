variable "domain_name" {}
variable "route53_zone" {}

terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 2.7.0"
      configuration_aliases = [aws.main, aws.cert_provider]
    }
  }
}

locals {
  bucket_name = var.domain_name
  common_tags = {
    Service = "static-site-${var.domain_name}"
  }
}

output "route53_record" {
  value = aws_route53_record.primary
}

output "name_servers" {
  value = var.route53_zone.name_servers
}

output "website_bucket" {
  value = aws_s3_bucket.website_bucket.bucket
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}

output "domain_name" {
  value = var.domain_name
}


output "cloudfront_distribution" {
  value = aws_cloudfront_distribution.website_distribution
}
