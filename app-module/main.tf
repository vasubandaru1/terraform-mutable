resource "null_resource" "nothing" {
  provisioner "local-exec" {
    command = "echo hello world"
  }
}