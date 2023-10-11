# Encora
Technical Questions**
1.if u using git stash where will it save data? what is the difference between index and staging area?**

2.when would individuals use git rebase, git fast -forward, or a gitfetch then push?

3.How to revert already pushed changes?

4.what is the difference between git cherry-picking and trying a hard reset. what is the final outcome of the head reference?

5.Explain the difference between git remote and git clone?

------Terraform---
1. What is the difference between terraform count and for_each meta data function? and give me a scenario-based example to use them?


2.What is terraform taint? when to use it? When would you use terraform state rm vs terraform taint?

3.How would you show a diagram of all terraform resources in the state file when is this useful?

4.Solve this expresssion
count =
var.run_remote_environment ? var.TFC_RUN_ID !=
["yes"] ;null

5. How do you apply terraform to multiple accounts simultaneously? We want to ensure this follows security best practices.

AWS 

1.You have an EC2 instance that has an unencryted volume. You want to create another Encrypted volume form this unencrypted volume .which of the following steps can achieve this ? How would you share this encrypted volume to another account?
what must you ensure to make sure thus cross-account encryption is shared?

2. How will you implement service control policy and in which area are you using it?

3.How can you convert a public subnet to private subnet?

4.What is the default route for any newly created route table?

Programing Execrcise
Terraform Code to create the below Infrastructure:

1.VPC in us-east-1 region. This should be flexible based on region. If no region is provided, this should be built in us -east-1.

2.Subnet with high availablity supported in 2 zones 


1. Route table not including the default one. Routes should not be routed using the local route.

. Autoscaling group with a flexible cool down, deregistartion delay, instance warm up.

.2 EC2 instances created from the autoscaling group

. ALB to load-balance the app servers. Ensure the port is flexible based on the application
. IAM roles should be only be used by account owner.

