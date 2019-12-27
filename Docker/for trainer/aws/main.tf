provider "aws" {
  region = var.region
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "docker-training-vm"
  instance_count         = 15

  ami                    = "ami-0dd655843c87b6930"
  instance_type          = "t2.micro"
  key_name               = "dev-key"
  monitoring             = true
  vpc_security_group_ids = ["sg-58bb2926"]
  subnet_id              = "subnet-00a2465a"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "dev-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBRQkbSbyTUp8/wrQCvBj59wXd3MFncLgVAzZmgSSouwnlQvzNvGxKWxQoia6LMs2MERbY8itF+5Aj2uRTUP9QOoF74P8crippyHDOcGcL96a3CIwMubcSWGFNCmPW39VYfcX3nR553/ebtTMOQa6vQspveJYCsHt3/RPRE6due8kXkcH9vJUKTCV3e30a0ViJVhv+A35rPe0i4JF5ly7mMnyqv4+7QOFRtebD8g8EF63AnFJsMQxAQQf58F5aYXuPUde0JgBVCShoUaTjVoadCSDfNxPjSmp1AFvhh177sW5RyxY8Vr37hE2URk+PZy7acyXXwWDLbhTCdzMmoIiP anton.grishko@Antons-MacBook.local"
}
