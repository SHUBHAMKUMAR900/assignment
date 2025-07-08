# Example resource, replace with your desired resources.
resource "aws_instance" "example" {
 ami           = "ami-0c94855ba95c574c8" # Replace with your desired AMI
 instance_type = "t2.micro"
}