data "aws_route53_zone" "dns" {
  provider     = aws.region-master
  vpc_id       = aws_vpc.master.id
#  name         = "cmcloudlab1611.info."
  zone_id = "Z07201561RBDR8QN51OQF"
}

# Create a record in Hosted zones for ACM certificate Domain validation. 
#resource "aws_route53_record" "cert-validation" {
#  provider = aws.region-master
#  for_each = {
#    for dvo in aws_acm_certificate.jenkins-lb-https-cert.domain_validation_options : dvo.domain_name => {
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
#  zone_id         = data.aws_route53_zone.dns.zone_id
#		 
#}

resource "aws_route53_record" "jenkins" {
  provider = aws.region-master
  zone_id  = data.aws_route53_zone.dns.zone_id
  name     = join(".", ["jenkins", data.aws_route53_zone.dns.name])
  type     = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
