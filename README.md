# Encora
Technical Questions**
1.if u using git stash where will it save data? what is the difference between index and staging area?**
When you use git stash, the data is saved in a temporary memory in the local repository. 
The index and staging area are two different names for the same thing in Git. 
The staging area is where you prepare changes for a commit. When you make changes to your files, Git sees them as “unstaged”. You can stage these changes by using the git add command. Once you have staged your changes, they are ready to be committed.
2.when would individuals use git rebase, git fast -forward, or a gitfetch then push?
git rebase: It is going to apply the multiple commits sequentially one after the other the commits happened to particular branch.
It is useful when you want to keep your commit history linear and avoid merge commits. You can use it to update your feature branch with the latest changes from the main branch before merging it back into the main branch.
git fast-forward: This command is used to update your local branch with the latest changes from the remote branch. 
It is useful when you are working on a feature branch and want to keep it up-to-date with the main branch. If there are no new changes in the main branch, this command will simply move your local branch pointer forward to match the remote branch.
git fetch followed by git push: This command sequence is used when we want to update your remote repository with the latest changes from our local repository. 
We can use it when we have made changes to your local repository and want to push them to the remote repository. 
The git fetch command downloads the latest changes from the remote repository, while the git push command uploads our local changes to the remote repository.
3.How to revert already pushed changes?
To revert already pushed changes, we can use the git revert command. This command creates a new commit that undoes the changes made by a previous commit. The original commit remains in the repository’s history, but the changes it made are undone.
For example, git revert <commit-ID>
4.what is the difference between git cherry-picking and trying a hard reset. what is the final outcome of the head reference?
git cherry-pick and git reset are two different Git commands that serve different purposes.
git cherry-pick: This command is used to apply a specific commit from one branch to another. It is useful when you want to apply a bug fix or feature from one branch to another without merging the entire branch. The final outcome of the HEAD reference will be the new commit that you just cherry-picked.
git reset: This command is used to undo changes made to your repository. It is useful when you want to discard changes that you have made and start over. There are three types of git reset commands: --soft, --mixed, and --hard. The final outcome of the HEAD reference will be different depending on which type of reset you use.
--soft: This option only resets the HEAD pointer to the specified commit, leaving your changes in the staging area. The final outcome of the HEAD reference will be the specified commit.

--mixed: This option resets the HEAD pointer and unstages your changes, but leaves your changes in your working directory. The final outcome of the HEAD reference will be the specified commit.
--hard: This option resets the HEAD pointer, unstages your changes, and discards all changes in your working directory. The final outcome of the HEAD reference will be the specified commit.
5.Explain the difference between git remote and git clone?
git remote: This command is used to manage the set of repositories that your Git repository tracks. 
It will be useful when you want to add, remove, or view the remote repositories that your local repository is connected to. we can use it to push and pull changes between your local repository and the remote repository.
git clone: This command is used to create a copy of a remote repository on your local machine. It is useful when you want to start working on a project that already exists in a remote repository. When you clone a repository, Git creates a local copy of the entire repository on your machine, including all branches and commit history.

------Terraform---
1. What is the difference between terraform count and for_each meta data function? and give me a scenario-based example to use them?
count: This meta-argument is used to create multiple VM/instances of a resource based on a numeric value. It is useful when you want to create a fixed number of resources that are identical in configuration. For example, if you want to create 3 Virtual machines or EC2 instances with the same configuration, you can use count = 3

for_each: This meta-argument is used to create multiple instances of a resource based on a map or set of strings. It is useful when you want to create multiple resources with different configurations. 
For example, if you want to create multiple VMs or EC2 instances with different configurations, you can use for_each with a map that defines the instance configurations.
Suppose you are creating an Azure Vnet  or AWS VPC with multiple subnets. You want to create 3 subnets in total: one public subnet and two private subnets. The public subnet should have a route table that routes traffic to the internet gateway, while the private subnets should have route tables that route traffic to a NAT gateway.
To achieve this, you can use count to create the two private subnets and one public subnet. You can then use for_each to create the three route tables with different configurations.

2.What is terraform taint? when to use it? When would you use terraform state rm vs terraform taint?
terraform taint is a command that is used to marks a resource instance as “tainted” or misconfigured. 
This means that the next terraform apply phase, terraform will destroy the existing resource instance and create a new one in its place. 
We can use this command when you want to force a resource to be recreated.
Terraform state rm is a command that removes a resource instance from your Terraform state file. This means that Terraform will no longer manage the resource. 
We can use this command when you want to delete a resource that was created outside of Terraform.
3.How would you show a diagram of all terraform resources in the state file when is this useful?
We can use the terraform graph command to generate a visual representation of all the resources in our Terraform state file. This command generates a DOT file that can be used to create a diagram of your infrastructure.
terraform graph | dot -Tsvg > graph.svg
This command is useful when you want to visualize the dependencies between your resources and understand how they are connected. It can also help you identify any circular dependencies or other issues in your infrastructure.
4.Solve this expresssion
count =
var.run_remote_environment ? var.TFC_RUN_ID !=
["yes"] ;null

5. How do you apply terraform to multiple accounts simultaneously? We want to ensure this follows security best practices.
Create a separate Terraform configuration for each account that we want to manage.
Use remote state to store the state files for each configuration in a centralized location such as an Blob storage /S3 bucket or a Terraform Cloud workspace.
Use Terraform workspaces to manage the state files for each account separately. This allows you to keep the state files isolated and avoid conflicts between different accounts.
We can also use Terraform modules to share common infrastructure code between different configurations. This allows you to reuse code and ensure consistency across different accounts.
---------------------------------------------------------------------
AWS 

1.You have an EC2 instance that has an unencryted volume. You want to create another Encrypted volume form this unencrypted volume .which of the following steps can achieve this ? How would you share this encrypted volume to another account?
what must you ensure to make sure thus cross-account encryption is shared?
 To create an encrypted volume from an unencrypted volume, we can follow these steps:
•	Stop the EC2 instance that has the unencrypted volume.
•	Create a snapshot of the unencrypted volume.
•	Copy the snapshot and encrypt it using an available key.
•	Create a new EBS volume from the encrypted snapshot.
To share this encrypted volume with another account, we can use the following steps:
•	In the source account, create an EBS snapshot of the encrypted volume.
•	Share the snapshot with the target account.
•	In the target account, create a new EBS volume from the shared snapshot.
To ensure that cross-account encryption is shared, you must ensure that the KMS key used to encrypt the snapshot is shared with the target account. You can share a KMS key by creating a key policy that grants permissions to the target account’s IAM user or role.
 
2. How will you implement service control policy and in which area are you using it?
Service Control Policies (SCPs) are a type of organization policy that you can use to manage permissions in your AWS organization. SCPs offer central control over the maximum available permissions for all accounts in your organization . SCPs are used to ensure that your accounts stay within your organization’s access control guidelines and help you to manage permissions in your organization .
We can implement SCPs by creating a separate Terraform configuration for each account that we want to manage. 
To create an SCP, we can use the AWS Management Console, AWS CLI, or AWS SDKs. You can define an SCP by specifying a policy that lists the actions that are allowed or denied for a set of AWS services. You can then attach the SCP to an organizational unit (OU) or an account in our organization .

3.How can you convert a public subnet to private subnet?
To convert a public subnet to a private subnet
•	Create a new route table for the private subnet.
•	Associate the new route table with the private subnet.
•	Remove the default route from the new route table.
•	Add a new route to the new route table that points to a NAT gateway or an instance in your VPC that has access to the internet.
•	Update the security group rules for your instances in the private subnet to allow outbound traffic.

4.What is the default route for any newly created route table?
By default, a newly created route table has a local route for communication within the VPC. This means that the route table can be used to route traffic between resources in the same VPC. However, it does not have a default route that can be used to route traffic to the internet or other VPCs 
5. How would you ensure routes in the route table DO NOT use the local routes?
To ensure that routes in a route table do not use the local routes, we can remove the default local route from the route table. By default, every route table contains a local route for communication within the VPC . We can remove this route by creating a new route table and adding only the routes that you want to use. You can then associate the new route table with your subnets.
Programing Execrcise
Terraform Code to create the below Infrastructure:

1.VPC in us-east-1 region. This should be flexible based on region. If no region is provided, this should be built in us -east-1.

provider "aws" {
  region = var.region
}

resource "aws_vpc" "govin-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "govin-vpc"
  }
}

In this , we use the aws provider to specify the region where we want to create the VPC. We also create a new aws_vpc resource with the specified CIDR block and tags.
If no region is provided, the aws provider will default to the us-east-1 region.
2.Subnet with high availablity supported in 2 zones 
resource "aws_subnet" "govin-subnet" {
  vpc_id     = aws_vpc.govin-vpc.id
  cidr_block = var.cidr_block

  availability_zone = "${var.region}a"
  tags = {
    Name = "main-a"
  }
}

resource "aws_subnet" "replica" {
  vpc_id     = aws_vpc.govin-vpc.id
  cidr_block = var.cidr_block

  availability_zone = "${var.region}b"
  tags = {
    Name = "main-b"
  }
}

In this, we create two new aws_subnet resources for the main and replica subnets. We specify the VPC ID and CIDR block for each subnet, as well as the availability zone for each subnet. We also add tags to each subnet to identify them.

1. Route table not including the default one. Routes should not be routed using the local route.

. Autoscaling group with a flexible cool down, deregistartion delay, instance warm up.
To create an autoscaling group with a flexible cool down, deregistration delay, and instance warm-up, we can use the following Terraform code 

resource "aws_autoscaling_group" "aws-asg" {
  name                 = "aws-asg"
  launch_configuration = aws_launch_configuration.aws-asg.id
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  health_check_grace_period = var.health_check_grace_period
  default_cooldown     = var.default_cooldown
  termination_policies = ["OldestInstance"]
  vpc_zone_identifier  = [aws_subnet.example.id]
}

resource "aws_launch_configuration" "govin" {
  name_prefix                 = "govin"
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.example.id]
  user_data                   = var.user_data
  associate_public_ip_address = false
}

resource "aws_security_group" "govin-asg" {
  name_prefix = "govin-asg"
}

resource "aws_subnet" "govin-subnet" {
  cidr_block = var.cidr_block
}

In this example, we create a new aws_autoscaling_group resource for the autoscaling group and specify the launch configuration, minimum size, maximum size, desired capacity, health check grace period, default cooldown, termination policies, and VPC zone identifier. 
We also create a new aws_launch_configuration resource for the launch configuration and specify the image ID, instance type, security groups, user data, and public IP address association. We also create a new aws_security_group resource for the security group and specify the name prefix. Finally, we create a new aws_subnet resource for the subnet and specify the CIDR block.

.2 EC2 instances created from the autoscaling group

. ALB to load-balance the app servers. Ensure the port is flexible based on the application
. IAM roles should be only be used by account owner.

resource "aws_launch_configuration" "govin-alc" {
  name_prefix                 = "govin-alc"
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.govin-sg.id]
  user_data                   = var.user_data
  associate_public_ip_address = false
}

resource "aws_security_group" "govin-sg" {
  name_prefix = "govin-aws-sg"
}

resource "aws_autoscaling_group" " aws-asg " {
  name                 = "aws-asg"
  launch_configuration = aws_launch_configuration.govin-alc.id
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  health_check_grace_period = var.health_check_grace_period
  default_cooldown     = var.default_cooldown
  termination_policies = ["OldestInstance"]
  vpc_zone_identifier  = [aws_subnet.example.id]
}

resource "aws_lb" "govin-lb" {
  name               = "govin-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.govin-subnet.id]
}

resource "aws_lb_listener" "govin-aws-listener" {
  load_balancer_arn = aws_lb.govin-lb.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = aws_lb_target_group.govin-lb.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "govin-lb-target" {
  name_prefix      = "govin-lb-target"
  port             = var.port
  protocol         = var.protocol
  vpc_id           = aws_vpc.govin-vpc.id

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    interval            = var.interval
    path                = var.path
    port                = var.port
    protocol            = var.protocol
    timeout             = var.timeout
    matcher             = var.matcher
  }
}

