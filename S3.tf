
resource "aws_s3_bucket" "source" {
  bucket = "${var.source-buck}"
  acl = "private"
  tags {
    Name = "Source-Gova"
  }
}

resource "aws_s3_bucket" "dest" {
  bucket = "${var.dest-buck}"
  acl = "private"
  tags {
    Name = "Destination-Gova"
  }
}

resource "aws_s3_bucket" "logs-cloudtrail" {
  bucket = "${var.function-name}"
  acl = "private"

  policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Sid": "AWSCloudTrailAclCheck",
           "Effect": "Allow",
           "Principal": {
             "Service": "cloudtrail.amazonaws.com"
           },
           "Action": "s3:GetBucketAcl",
           "Resource": "arn:aws:s3:::cloudtrail-s3-logs-gova1"
       },
       {
           "Sid": "AWSCloudTrailWrite",
           "Effect": "Allow",
           "Principal": {
             "Service": "cloudtrail.amazonaws.com"
           },
           "Action": "s3:PutObject",
           "Resource": "arn:aws:s3:::cloudtrail-s3-logs-gova1/*",
           "Condition": {
               "StringEquals": {
                   "s3:x-amz-acl": "bucket-owner-full-control"
               }
           }
       }
   ]
}
POLICY

tags {
  Name = "logs_Bucket"
}
}

