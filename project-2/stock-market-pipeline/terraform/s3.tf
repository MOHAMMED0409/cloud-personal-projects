resource "aws_s3_bucket" "raw" {
  bucket        = "${var.bucket_name}-raw"
  force_destroy = true
}

resource "aws_s3_bucket" "athena_results" {
  bucket        = "${var.bucket_name}-athena"
  force_destroy = true
}
