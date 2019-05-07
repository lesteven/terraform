provider "aws" {
  region = "${var.region[0]}"
  shared_credentials_file = "${var.cred_file}"
}

resource "aws_dynamodb_table" "tab0" {
  hash_key = "quote"
  name = "myTable"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity = 1
  write_capacity = 1
  
  attribute {
    name = "quote"
    type = "S"
  }
}

