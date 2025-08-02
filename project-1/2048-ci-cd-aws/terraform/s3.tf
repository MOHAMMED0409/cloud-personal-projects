resource "aws_s3_bucket" "pipeline_bucket" {
  bucket = "2048-pipeline-artifacts-${random_id.suffix.hex}"

  force_destroy = true

  tags = {
    Name        = "2048 CodePipeline Bucket"
    Environment = "Dev"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_public_access_block" "pipeline_block" {
  bucket = aws_s3_bucket.pipeline_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

