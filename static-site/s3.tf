data "aws_iam_policy_document" "website_policy" {
  provider = aws.main

  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.domain_name}/*"
    ]
  }
}

resource "aws_s3_bucket" "website_bucket" {
  provider = aws.main

  bucket = var.domain_name
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_policy.json

  tags = local.common_tags

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}


