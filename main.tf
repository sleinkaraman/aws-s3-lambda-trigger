data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "src/index.py"
  output_path = "lambda_function.zip"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_lambda_function" "s3_processor" {
  filename      = "lambda_function.zip"
  function_name = "s3-event-processor"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler" 
  runtime       = "python3.11"
}

resource "aws_s3_bucket" "trigger_bucket" {
  bucket = "selin-trigger-bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.trigger_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_processor.arn
    events              = ["s3:ObjectCreated:*"] 
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.trigger_bucket.arn
}

resource "aws_s3_object" "autodeploy_test_file" {
  bucket = aws_s3_bucket.trigger_bucket.id
  key    = "initial-test-file.txt"
  
  content = "This file should trigger the Lambda"
  
  depends_on = [
    aws_s3_bucket_notification.bucket_notification,
    aws_lambda_permission.allow_bucket
  ]
}