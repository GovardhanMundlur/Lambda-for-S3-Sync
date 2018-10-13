provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudtrail" "logs-S3" {
  name = "s3-put-gova"
  s3_bucket_name = "${aws_s3_bucket.logs-cloudtrail.id}"
  include_global_service_events = false

  event_selector {
    read_write_type = "All"
    include_management_events = "true"
    

    data_resource {
      type = "AWS::S3::Object"
      values = [
        "${aws_s3_bucket.source.arn}/"]
    }
  }
  tags {
    Name = "S3-CloudTrail-logs"
  }
}

