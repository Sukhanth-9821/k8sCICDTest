
data "aws_vpc" "vpcfetch" {
    tags = {
        Name = "sukiVPC"
    }
}

data "aws_subnet" "subnet"{
    tags = {
    Name = "publicSubnet"
  }
}

data "aws_subnet" "subnet2"{
    tags = {
    Name = "publicSubnet2"
  }
}

data "aws_iam_role" "sukieksrole" {
  name = "Suki-EksClusterRole"
}


resource "aws_eks_cluster" "example" {
  name     = "suki-tf-cluster"
  role_arn = data.aws_iam_role.sukieksrole.arn

  vpc_config {
    subnet_ids = [data.aws_subnet.subnet.id,data.aws_subnet.subnet2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
 
}
