Engineer Onboarding: EC2 + IAM

  Based on a guided AWS project on tag-based IAM access control. Original walkthrough: 
  [https://github.com/brunda0211/AWS-Projects-Portfolio/blob/main/AWS_Projects_Basic/Engineer%20Onboarding%3A%20EC2%20%2B%20IAM%20Setup/IAM_EC2_Policy_Steps.md]

  I worked through this one to understand how IAM scopes permissions by tag rather than by resource ARN. 
  The steps below are the ones I actually ran, with notes on the parts the original glossed over and the one place I got stuck.

The scenario

  A new DevOps engineer needs access to the development EC2 instance but not production, so they can't stop or modify production while they're still learning the environment.
  The approach: two instances, identical except for a tag, and one IAM policy that keys off that tag. If the policy works, the same user can stop one instance and not the other.

What I built

  Two EC2 instances, tagged Env=production and Env=development
  One IAM policy scoping EC2 access to the development tag
  A user group with that policy attached, and a user in the group
  An account alias for the sign-in URL

Things worth knowing first

 Tags are passive. A tag is just a key/value pair sitting on a resource. 
 The instance has no idea a policy exists. The policy is what does the checking, and the tag is what it checks against. 
 Keys are case-sensitive, so ENV and Env are different keys, and a mismatch grants nothing without producing a useful error.



Steps

  1. Launch two instances

  Set the Region to us-east-1 first and stay in it for everything that follows.

  EC2 > Launch instance. For production:

  Name: xyz-prod-web-01
  Add additional tag, Key Env, Value production
  Free-tier AMI and instance type, proceed without a key pair

  Repeat for development with xyz-dev-web-01 and Env=development.

  

2. Create the policy

IAM > Policies > Create policy > JSON tab:

json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "ec2:ResourceTag/Env": "development"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Deny",
      "Action": [
        "ec2:DeleteTags",
        "ec2:CreateTags"
      ],
      "Resource": "*"
    }
  ]
}

Name it XYZDevEnvironmentPolicy.




