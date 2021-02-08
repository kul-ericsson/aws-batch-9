resource "aws_efs_file_system" "efs" {
  creation_token = "thinknyx-${var.tagName}"
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  }
}

# Fetching List of Subnet IDs to be used to create Mount Targets for EFS
data "aws_subnet_ids" "sn-ids" {
  vpc_id = data.aws_vpc.vpc.id
}

output "SubnetIDS" {
  value = data.aws_subnet_ids.sn-ids.ids
}

resource "aws_efs_mount_target" "efs_mts" {
  file_system_id = aws_efs_file_system.efs.id
  for_each = data.aws_subnet_ids.sn-ids.ids
  subnet_id = each.value
  security_groups = [ aws_security_group.sg.id ]
}