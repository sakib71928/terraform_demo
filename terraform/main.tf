terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"  # Change this to your preferred region
}

resource "aws_s3_bucket" "static_site" {
  bucket = "sakib-terraform-bucket"  # Replace with a unique bucket name
  acl    = "public-read"
  website {
    index_document = "index.html"
  }

  tags = {
    Name        = "static-site-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "website/index.html"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "coffee_image" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "coffee.jpg"
  source = "website/coffee.jpg"
  acl    = "public-read"
}

output "website_url" {
  value = "http://${aws_s3_bucket.static_site.bucket}.s3-website-${var.region}.amazonaws.com"
}
