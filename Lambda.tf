
resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function_s3.zip"
  function_name    = "${var.function-name}"
  role             = "${aws_iam_role.lambda-s3.arn}"
  handler          = "source.lambda_handler"
  source_code_hash = "${base64sha256(file("lambda_function_s3.zip"))}"
  runtime          = "python3.6"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.test_lambda.arn}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.s3-events.arn}"
}
