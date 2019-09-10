provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_user" "ops" {
  name = "ops"
}

resource "aws_iam_role" "deploy" {
  name = "deploy"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_group" "dev" {
  name = "dev"
}

resource "aws_iam_policy" "ec2" {
  name        = "ec2"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "dev" {
  name       = "dev-attachment"
  users      = ["${aws_iam_user.ops.name}"]
  roles      = ["${aws_iam_role.deploy.name}"]
  groups     = ["${aws_iam_group.dev.name}"]
  policy_arn = "${aws_iam_policy.ec2.arn}"
}

resource "aws_iam_access_key" "ops" {
  user    = "${aws_iam_user.ops.name}"
  pgp_key = "keybase:titanarch"
}

output "secret" {
  value = "${aws_iam_access_key.ops.encrypted_secret}"
}
