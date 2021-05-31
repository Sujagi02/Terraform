#Crearing a bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "s3-website-test.myhashicorp.com"

  website {
    index_document = "myweb.html"
   }
}

#Uploading files
resource "aws_s3_bucket_object" "object" {
  bucket = "s3-website-test.myhashicorp.com"
  key    = "webpage.html"
  source = "C:/Users/sujag/Desktop/Terraform/dynamic_iaas/web.html"
}
