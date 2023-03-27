output "aws_lb_target_group_arn" {
    value = aws_lb_target_group.alb_target_group.arn
}

output "aws_lb_app_load_balancer_dns_name" {
    value = aws_lb.app_load_balancer.dns_name
}
output "app_load_balancer_zone_id" {
    value = aws_lb.app_load_balancer.zone_id
}