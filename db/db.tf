resource "aws_db_subnet_group" "db_sub_gp" {
  name        = "db_sub_gp"
  subnet_ids  = [var.subnetPrivateA,var.subnetPrivateB]
}

resource "aws_db_instance" "DBBack" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "DBBack"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = "${aws_db_subnet_group.db_sub_gp.id}"
  vpc_security_group_ids = [var.DBSecGP]
  identifier           = "dbback"

}