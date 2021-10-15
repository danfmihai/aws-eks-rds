# EKS with Terraform

Creates EKS cluster from scratch.

Note: You need to create your own backend for the tfstate file.
Repalce the `backend.tf` file with yours.

Also make sure your aws cli credentials have the permissions to create the EKS cluster. (IAM create user and Role)

```
git clone https://github.com/danfmihai/aws-terraform-eks.git
cd aws-terraform-eks

terraform init
terraform apply

```

## Summary
This creates:
- VPC
- internet-gateway
- 2 public subnets (for the workers)
- 2 private subnets (RDS)
- (2 nat gateways for the private subnets to access the internet)
- (elastic IPs for each NAT gateways)
- 3 routing tables (1 for public, 2 for private)
- EKS cluster 
- EKS node(s)
- the AMI used are the latest Amazon Linux images
- Auto Scaling Group with mixed instance types (on demand and spot)
- adds label to the node(s) "role" = "nodes-general"


To be able to connect to the Cluster issue the following command:

`aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster --profile <yourprofilename>`

it will change the context to the new EKS cluster.


## Troubleshooting
- If you get the error: "error: You must be logged in to the server (Unauthorized)":

    You need to use the same user credentials to access th cluster when you created it with Terraform or have the user who created the cluster add you as a user with permissions.

    Find more details here:
    https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/

- If you get the "Error syncing load balancer: failed to ensure load balancer: could not find any suitable subnets for creating the ELB"  you should check if your labels in subnets are correct. Make sure you cluster name is correct in the labels. 
    ex: "kubernetes.io/cluster/my-eks-cluster" = "shared"


