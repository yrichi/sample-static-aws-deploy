output "website_url" {
  description = "URL du site web statique"
  value       = aws_s3_bucket_website_configuration.website
}
