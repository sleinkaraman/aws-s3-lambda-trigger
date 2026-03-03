output "s3_bucket_name" {
  value       = aws_s3_bucket.trigger_bucket.bucket
  description = "The name of the S3 bucket"
}

output "lambda_function_arn" {
  value       = aws_lambda_function.s3_processor.arn
  description = "The ARN of the Lambda function"
}