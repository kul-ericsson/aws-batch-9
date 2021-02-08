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