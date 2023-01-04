resource "aws_acm_certificate" "cert" {
  provider = aws.cert_provider

  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "EMAIL" # could also be "DNS"

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.cert_provider

  certificate_arn = aws_acm_certificate.cert.arn

  # required for DNS validation, not email
  # validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}


