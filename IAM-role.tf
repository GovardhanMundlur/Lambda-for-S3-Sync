resource "aws_iam_role_policy" "s3-lambda-policy" {
  name = "S3-bucketpolicy"
  role = "${aws_iam_role.lambda-s3.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::lambda-source-test-gova",
                "arn:aws:s3:::lambda-source-test-gova/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::lambda-dest-test-gova/*"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_role" "lambda-s3" {
  name = "lambdatos3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
