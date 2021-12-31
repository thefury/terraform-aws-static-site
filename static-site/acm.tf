# NOTE: Note sure if this is required or not...
#
#resource "aws_route53_record" "cert_validation" {
#  for_each = {
#    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
#      name   = dvo.resource_record_name
#      record = dvo.resource_record_value
#      type   = dvo.resource_record_type
#    }
#  }
#
#  allow_overwrite = true
#  name            = each.value.name
#  records         = [each.value.record]
#  ttl             = 60
#  type            = each.value.type
#  zone_id         = aws_route53_zone.primary.zone_id
#
#}
#

resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "EMAIL" # could also be "DNS"

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  
  # required for DNS validation, not email
  # validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}


