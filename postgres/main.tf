provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

data "aws_security_group" "pg" {
  filter {
    name = "group-name"
    values = ["${var.security_name}"]
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "postgres"
  engine_version = "11"
  instance_class = "db.t2.micro"
  name = "nutrition"
  username = "${var.username}"
  password = "${var.password}"
  skip_final_snapshot = true
  //final_snapshot_identifier = "pgBackup"
  //multi_az = true
  vpc_security_group_ids = ["${data.aws_security_group.pg.id}"]
  publicly_accessible = true
}

output "name" {
  value = "${aws_db_instance.postgres.name}"
}
output "address" {
  value = "${aws_db_instance.postgres.address}"
}
output "port" {
  value = "${aws_db_instance.postgres.port}"
}
output "username" {
  value = "${aws_db_instance.postgres.username}"

}
