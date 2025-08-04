resource "aws_s3_bucket" "raw_stock" {
  bucket = "stock-raw-data-store"
}

resource "aws_s3_object" "prefix_raw" {
  bucket = aws_s3_bucket.raw_stock.bucket
  key    = "raw/"
  source = "/dev/null"
}

resource "aws_s3_object" "prefix_cleaned" {
  bucket = aws_s3_bucket.raw_stock.bucket
  key    = "cleaned/"
  source = "/dev/null"
}
