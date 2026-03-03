variable "aws_region" {
  description = "The AWS region for local deployment"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket that triggers Lambda"
  default     = "selin-trigger-bucket"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  default     = "s3-event-processor"
}