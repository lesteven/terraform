provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

resource "aws_db_instance" "postgres" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "postgres"
  engine_version = "11"
  instance_class = "db.t2.micro"
  name = "postgres"
  username = "${var.username}"
  password = "${var.password}"
  skip_final_snapshot = true
  //final_snapshot_identifier = "pgBackup"
  //multi_az = true
}
