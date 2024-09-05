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
  region = "us-east-1" 
}

# Define the S3 bucket
resource "aws_s3_bucket" "static_site" {
  bucket = "sakib-terraform-bucket-new" 

  website {
    index_document = "index.html"
  }

  tags = {
    Name        = "static-site-bucket"
    Environment = "Dev"
  }
}

# Define the index.html object
resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "index.html"
content_type = "text/html"
}

# Define the coffee.jpg object
resource "aws_s3_bucket_object" "coffee_image" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "coffee.jpg"
  source = "coffee.jpg"
content_type = "image/jpeg"
}
output "website_endpoint" {
  value = aws_s3_bucket.static_site.website_endpoint
}
