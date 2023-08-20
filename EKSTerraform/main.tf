
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


module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    cluster_name = "suki-tf-cluster"
    cluster_version = "1.24"

    cluster_endpoint_public_access  = true

    vpc_id = data.aws_vpc.vpcfetch.id
    subnet_ids = [data.aws_subnet.subnet.id,data.aws_subnet.subnet2.id]

    tags = {
        environment = "development"
        application = "myapp"
    }

    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 3
            desired_size = 1

            instance_types = ["t2.micro"]
        }
    }
}