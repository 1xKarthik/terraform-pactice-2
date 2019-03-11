output "id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2-instance.id}"]
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = ["${module.ec2-instance.public_dns}"]
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = "${module.ec2-instance.id[0]}"
}

output "instance_public_dns" {
  description = "Public DNS name assigned to the EC2 instance"
  value       = "${module.ec2-instance.public_dns[0]}"
}

output "credit_specification" {
  description = "Credit specification of ec2-instance instance"
  value       = "${module.ec2-instance.credit_specification[0]}"
}
