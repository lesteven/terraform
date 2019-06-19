AWS Infrastructure for Drone CI (https://drone.io/)

Elastic IP is created in a different terraform, in order to prevent 
terraform from creating a new Elastic IP each time this infrastructure 
is created. Same for the security group.
