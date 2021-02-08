resource "null_resource" "mount_efs" {
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("C:/training/ericsson/aws/kul-ericsson-thinknyx.pem")
      host = aws_instance.kul.public_ip
    }
    inline = [
      "sudo apt-get update -y && sudo apt-get install -y nfs-common",
      "sudo mkdir /data",
      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/ /data",
      "sudo chown ubuntu:ubuntu /data"
    ]
  }
}

resource "null_resource" "setup_terraform" {
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("C:/training/ericsson/aws/kul-ericsson-thinknyx.pem")
      host = aws_instance.kul.public_ip
    }
    inline = [
      "sudo apt-get install -y unzip",
      "wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip && unzip terraform_0.14.6_linux_amd64.zip",
      "sudo cp terraform /usr/bin && sudo chmod 755 /usr/bin/terraform",
      "terraform --version"
    ]
  }
}