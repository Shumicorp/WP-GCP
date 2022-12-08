resource "null_resource" "wp-packer" {
  provisioner "local-exec" {
    command = <<EOF
packer build \
 -var 'priv-subnet=${var.subnet}' \
 -var 'project=${var.project}'\
 -var 'zone=${var.zone}'\
 -var 'username=${var.ssh_username}' \
 -var 'image-name=${var.app_name}-${var.prefix}-image' \
 -var 'source-image=${var.source_image}' \
 -var 'bastion-ip=${var.bastion_ip}' \
 -var 'ssh-private-key-path=${var.ssh_private_key_path}' \
 -var 'machine-type=${var.packer_machine_type}' \
 -var 'playbook=${var.playbook}' \
 -var 'ansible-extra-vars=${var.ansible_extra_vars}' \
 packer/packer.pkr.hcl
sleep 5
EOF
  }
}

resource "null_resource" "wp-packer-destroy" {
  triggers = {
    image = "${var.app_name}-${var.prefix}-image"
  }
  provisioner "local-exec" {
    when       = destroy
    command    = <<EOF
gcloud compute images delete ${self.triggers.image} -q \
EOF
  }
}