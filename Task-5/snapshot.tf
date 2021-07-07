resource "aws_ebs_snapshot" "snapshot" {
  depends_on = [null_resource.skills]
  volume_id = aws_ebs_volume.vol_task5.id

  tags = {
      Name = "Snapshot"
  }
}
