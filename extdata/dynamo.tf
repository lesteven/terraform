
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

resource "aws_dynamodb_table" "tab1" {
  provider = "aws.${var.region[1]}"

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

resource "aws_dynamodb_global_table" "myTable" {
  depends_on = ["aws_dynamodb_table.tab0", "aws_dynamodb_table.tab1"]

  name = "myTable"

  replica {
    region_name = "${var.region[0]}"
  }
  replica {
    region_name = "${var.region[1]}"
  }

}
