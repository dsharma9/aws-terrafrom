resource "aws_acm_certificate" "jenkins-lb-https-cert" {
  provider          = aws.region-master
  domain_name       = join(".", ["jenkins", data.aws_route53_zone.dns.name])
  validation_method = "DNS"

  tags = {
    Environment = "test"
    Name        = "Jenkins-ACM"
  }

}


#resource "aws_acm_certificate_validation" "example" {
#  provider                = aws.region-master
#  certificate_arn         = aws_acm_certificate.jenkins-lb-https-cert.arn
#  for_each                = aws_route53_record.cert-validation
#  validation_record_fqdns = [aws_route53_record.cert-validation[each.key].fqdn]
#}

