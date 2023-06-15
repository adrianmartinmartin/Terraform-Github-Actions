module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.prefix}-kubernetes"
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      preserve    = true
      most_recent = true
      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
  subnet_ids         = [ 
                        "${data.terraform_remote_state.vpc.outputs.public-subnet0-id}",
                        "${data.terraform_remote_state.vpc.outputs.public-subnet1-id}",
                        "${data.terraform_remote_state.vpc.outputs.public-subnet2-id}"
                       ]
  cluster_security_group_id = "${data.terraform_remote_state.vpc.outputs.sg_default_id}"

  eks_managed_node_group_defaults = {
    instance_type                          = "${var.instance_type}"
    capacity_type                          = "SPOT"
    timeouts = {
        create = "15m"
        delete = "15m"
      }
  }

  eks_managed_node_groups = {
    one = {
      name         = "${var.prefix}-nodegoup"
      min_size     = 1
      max_size     = 2
      desired_size = 1
     }
  }

 create_kms_key = false
 cluster_encryption_config = {}
}

resource "null_resource" "kubectl" {
       depends_on = [module.eks]
       provisioner "local-exec" {
          command = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_name}"
       }
}
