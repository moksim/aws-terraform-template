output "public_ip" {
  value = aws_instance.vm.public_ip
}

output "ssh" {
  value = "ssh -i ${var.existing_key_name} ${var.ssh_user}@${aws_instance.vm.public_ip}"
}

output "security_group" {
  value = aws_security_group.sg.id
}
