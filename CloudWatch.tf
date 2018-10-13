resource "aws_cloudwatch_event_rule" "s3-events" {
  name = "S3-Events-Capture"
  description = "Capture S3 object puts"

  event_pattern = <<PATTERN
  {
  "source": [
    "aws.s3"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "s3.amazonaws.com"
    ],
    "eventName": [
      "PutObject"
    ],
    "requestParameters": {
      "bucketName": [
        "lambda-source-test-gova"
      ]
    }
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "Lambda-target" {
  arn = "${aws_lambda_function.test_lambda.arn}"
  rule = "${aws_cloudwatch_event_rule.s3-events.name}"
}
