resource "null_resource" "wp-packer" {
  provisioner "local-exec" {
    command = <<EOF
packer build \
 -var 'priv-subnet=${var.subnet}' \
 -var 'project=${var.project}'\
 -var 'zone=${var.zone}'\
 -var 'username=${var.ssh-username}' \
 -var 'image-name=${var.app-name}-${var.app-name-sufix}-image' \
 -var 'source-image=${var.source-image}' \
 -var 'bastion-ip=${var.bastion-ip}' \
 -var 'ssh-private-key-path=${var.ssh-private-key-path}' \
 -var 'machine-type=${var.packer-machine-type}' \
 -var 'playbook=${var.playbook}' \
 -var 'ansible-extra-vars=${var.ansible-extra-vars}' \
 packer/packer.pkr.hcl
sleep 5
EOF
  }
}
