resource "aws_s3_bucket" "tugub1" {
    bucket = "web-bucket"
}

resource "aws_s3_bucket_public_access_block" "tugub1" {
    bucket = aws_s3_bucket.tugub1.id

    block_public_acls =  false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.tugub1.id  # Reference your bucket by name
  key    = "index.html"
  source = "error.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.tugub1.id  # Reference your bucket by name
  key    = "index.html"
  source = "error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "tugub1" {
  bucket = aws_s3_bucket.tugub1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }


}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.tugub1.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.tugub1.arn}",
        "${aws_s3_bucket.tugub1.arn}/*"
      ]
    }
  ]
}
EOF
}
