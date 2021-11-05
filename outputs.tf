output "sg_id" {
  description = "Outputs the security group ID"
  value = aws_security_group.sg_minecraft.id
}
