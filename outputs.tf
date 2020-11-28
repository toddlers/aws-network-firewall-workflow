output "instace-ip" {
  value = format("http://%s/phpinfo.php", aws_instance.my-instance.public_ip)
}
