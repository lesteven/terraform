
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.cred_file}"
}

# elastic ip
resource "aws_eip" "elip" {
    tags = {
      name = "droneServer"
    }
}
