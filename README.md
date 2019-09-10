# Create a `admin` account with full IAM permissino

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "iam:*",
            "Resource": "*"
        }
    ]
}
```

# Due to `admin` have to create a user with different policy, so aws need to use mfa to make sure you are the right person.

* You could add MFA from aws console manually.
* in ~/.aws/config

``` 
[profile titan-pri]
mfa_serial=arn:aws:iam::1234567890123456:mfa/architrave
```

# If we want to get the new account's secret key, we need a [keybase account](https://keybase.io/)
* So we setup the keyabse account over there.

```
resource "aws_iam_access_key" "ops" {
  user    = "${aws_iam_user.ops.name}"
  pgp_key = "keybase:titanarch"
}
```
