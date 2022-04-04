resource "null_resource" "app-deploy" {
  count = length(local.PRIVATE_IPS)
  triggers = {
    private_ip = element(local.PRIVATE_IPS,count.index )
  }
  provisioner "remote-exec" {
    connection {
      host     = element(local.PRIVATE_IPS, count.index )
      user     = local.ssh_user
      password = local.ssh_pass
    }
    inline = [
      "ansible-pull -U https://github.com/vasubandaru1/ANSIBLE2.git roboshop-pull.yml -e ENV=${var.ENV} -e COMPONENT=${var.COMPONENT}"
    ]
  }
}